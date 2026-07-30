#!/usr/bin/env python3
"""
Standalone Public Online Admission Portal Web Server.
Serves the public TN Happy Kids School admission form with instant photo preview support,
dynamic receipt data rendering from submitted form inputs, and dark blue UI theme.
"""

import http.server
import socketserver
import os
import re
import urllib.parse
from datetime import datetime

PORT = 8080

class StandaloneAdmissionHandler(http.server.SimpleHTTPRequestHandler):

    def do_POST(self):
        path = self.path.split('?')[0].lstrip('/')
        content_length = int(self.headers.get('Content-Length', 0))
        content_type = self.headers.get('Content-Type', '')

        post_data = {}
        raw_body = self.rfile.read(content_length)

        if 'multipart/form-data' in content_type and 'boundary=' in content_type:
            import base64
            boundary_str = content_type.split('boundary=')[1].split(';')[0].strip()
            boundary = boundary_str.encode('utf-8')
            parts = raw_body.split(b'--' + boundary)
            for part in parts:
                if not part or part == b'--\r\n' or part.strip() == b'--':
                    continue
                if b'\r\n\r\n' in part:
                    h_bytes, b_bytes = part.split(b'\r\n\r\n', 1)
                    header_str = h_bytes.decode('utf-8', errors='ignore')
                    body_val = b_bytes.rstrip(b'\r\n')

                    name_m = re.search(r'name="([^"]+)"', header_str)
                    fname_m = re.search(r'filename="([^"]*)"', header_str)
                    if name_m:
                        field_name = name_m.group(1)
                        if fname_m and fname_m.group(1) and body_val:
                            # It's a file upload - convert to base64 data URI
                            fn = fname_m.group(1).lower()
                            mime = 'image/png'
                            if fn.endswith('.jpg') or fn.endswith('.jpeg'): mime = 'image/jpeg'
                            elif fn.endswith('.gif'): mime = 'image/gif'
                            elif fn.endswith('.webp'): mime = 'image/webp'
                            b64 = f"data:{mime};base64," + base64.b64encode(body_val).decode('utf-8')
                            post_data[field_name] = [b64]
                            print(f"[UPLOAD] {field_name} = file:{fname_m.group(1)} ({len(body_val)} bytes)")
                        else:
                            # Plain text field
                            text_val = body_val.decode('utf-8', errors='ignore')
                            post_data[field_name] = [text_val]
                            if 'hid' in field_name.lower() and 'photo' in field_name.lower():
                                print(f"[HIDDEN] {field_name} = {text_val[:60]}...")
        else:
            post_body = raw_body.decode('utf-8', errors='ignore')
            post_data = urllib.parse.parse_qs(post_body)

        # Exact key lookup first, then suffix match for ASP.NET control prefixes
        def get_post_val(key):
            # Exact match
            if key in post_data and post_data[key] and str(post_data[key][0]).strip():
                return str(post_data[key][0]).strip()
            # ASP.NET suffix match: ctl00$MainContent$key
            for k, v in post_data.items():
                if (k.endswith('$' + key) or k.endswith(':' + key)) and v and str(v[0]).strip():
                    return str(v[0]).strip()
            return ''

        # Get photo data - check hidden field first (base64 from JS), then file upload
        def get_photo_data(hidden_key, file_key):
            # Try hidden field (holds base64 set by JavaScript)
            v = get_post_val(hidden_key)
            if v and 'data:image' in v:
                return v
            # Try file upload field (multipart binary → converted to base64)
            v = get_post_val(file_key)
            if v and 'data:image' in v:
                return v
            # Try any key containing the file_key name
            for k, vals in post_data.items():
                if file_key in k and vals and 'data:image' in str(vals[0]):
                    return str(vals[0])
            return ''

        s_name = get_post_val('txtFullName') or get_post_val('sName')
        std = get_post_val('txtStandard') or get_post_val('std')
        f_name = get_post_val('txtFatherName') or get_post_val('fName')
        f_mobile = get_post_val('txtFatherMobile') or get_post_val('fMobile')

        print(f"[POST] s_name={s_name}, std={std}, f_name={f_name}, f_mobile={f_mobile}")
        print(f"[POST] Keys: {list(post_data.keys())[:20]}")

        if path == 'Admission.aspx' or path == 'index.html' or not path or path == '/':
            if not s_name or not std or not f_name or not f_mobile:
                self.send_response(303)
                self.send_header('Location', '/Admission.aspx?error=missing_compulsory')
                self.end_headers()
            else:
                adm_no = f"ADM-2026-{os.urandom(2).hex().upper()}"
                import random
                base1 = random.randint(4000, 9999)
                base2 = random.randint(1000, 9999)
                rfid_father = f"{base1} {base2} 1041"
                rfid_mother = f"{base1} {base2} 1042"
                rfid_g1     = f"{base1} {base2} 1043"
                rfid_g2     = f"{base1} {base2} 1044"

                uploads_dir = os.path.join(os.path.dirname(__file__), 'Uploads')
                os.makedirs(uploads_dir, exist_ok=True)

                def save_photo(hidden_key, file_key, prefix):
                    import base64 as b64mod
                    data = get_photo_data(hidden_key, file_key)
                    if data and 'data:image' in data:
                        try:
                            header, b64str = data.split(',', 1)
                            ext = 'jpg' if ('jpeg' in header or 'jpg' in header) else ('webp' if 'webp' in header else 'png')
                            raw = b64mod.b64decode(b64str)
                            fname = f"{prefix}_{adm_no.replace('-','_')}.{ext}"
                            fpath = os.path.join(uploads_dir, fname)
                            with open(fpath, 'wb') as f:
                                f.write(raw)
                            print(f"[SAVED] {fpath}")
                            return f"/Uploads/{fname}"
                        except Exception as ex:
                            print(f"[ERROR] saving {prefix} photo: {ex}")
                    return ''

                photo_father = save_photo('hidFatherPhotoData', 'fileFatherPhoto', 'father')
                photo_mother = save_photo('hidMotherPhotoData', 'fileMotherPhoto', 'mother')
                photo_g1     = save_photo('hidGuardian1PhotoData', 'fileGuardian1Photo', 'g1')
                photo_g2     = save_photo('hidGuardian2PhotoData', 'fileGuardian2Photo', 'g2')

                print(f"[PHOTOS] father={photo_father}, mother={photo_mother}, g1={photo_g1}, g2={photo_g2}")

                query_dict = {
                    'admNo': adm_no,
                    'rfidFather': rfid_father,
                    'rfidMother': rfid_mother,
                    'rfidG1': rfid_g1,
                    'rfidG2': rfid_g2
                }
                if photo_father: query_dict['rfidPhotoFather'] = photo_father
                if photo_mother: query_dict['rfidPhotoMother'] = photo_mother
                if photo_g1:     query_dict['rfidPhotoG1']     = photo_g1
                if photo_g2:     query_dict['rfidPhotoG2']     = photo_g2

                # Copy text form fields, skip hidden photo data
                skip_keys = {'hidFatherPhotoData','hidMotherPhotoData','hidGuardian1PhotoData','hidGuardian2PhotoData',
                             'fileFatherPhoto','fileMotherPhoto','fileGuardian1Photo','fileGuardian2Photo','filePhoto'}
                for k, v in post_data.items():
                    short_k = k.split('$')[-1]  # strip ASP.NET prefix
                    if short_k in skip_keys or not v or not str(v[0]).strip():
                        continue
                    if 'data:image' in str(v[0]):
                        continue
                    query_dict[short_k] = str(v[0]).strip()

                qs = urllib.parse.urlencode(query_dict)
                self.send_response(303)
                self.send_header('Location', f'/PublicReceipt.aspx?{qs}')
                self.end_headers()
        else:
            self.send_response(303)
            self.send_header('Location', '/Admission.aspx')
            self.end_headers()

    def do_GET(self):
        parsed = urllib.parse.urlparse(self.path)
        path = parsed.path.lstrip('/')
        if not path or path == '/' or path == 'Default.aspx' or path == 'Login.aspx':
            path = 'Admission.aspx'

        filePath = os.path.join(os.getcwd(), path)
        if os.path.exists(filePath) and path.endswith('.aspx'):
            self.render_aspx_page(filePath, path, parsed.query)
        else:
            super().do_GET()

    def render_aspx_page(self, aspx_file, current_path, query_str):
        with open(aspx_file, 'r', encoding='utf-8') as f:
            content = f.read()

        params = urllib.parse.parse_qs(query_str)
        def get_p(key1, key2=None, default='-'):
            val = params.get(key1, [None])[0]
            if not val and key2:
                val = params.get(key2, [None])[0]
            if val and val.strip() and val.strip() != '-':
                return val.strip()
            return default

        # Check master page wrapper
        if 'PublicSite.Master' in content:
            master_path = 'PublicSite.Master'
        elif 'MasterPageFile' in content:
            master_path = 'Site.Master'
        else:
            master_path = None

        if master_path and os.path.exists(master_path):
            with open(os.path.join(os.getcwd(), master_path), 'r', encoding='utf-8') as mf:
                master = mf.read()

            main_match = re.search(r'<asp:Content[^>]*ID="MainContent"[^>]*>(.*?)</asp:Content>', content, re.DOTALL)
            main_html = main_match.group(1) if main_match else ""

            rendered = re.sub(r'<asp:ContentPlaceHolder[^>]*ID="MainContent"[^>]*>.*?</asp:ContentPlaceHolder>', lambda m: main_html, master, flags=re.DOTALL)
            rendered = re.sub(r'<%: Page.Title %>', 'TN Happy Kids School - After School Admission Form', rendered)
            rendered = re.sub(r'<%: Page.Title == "[^"]*" \? "active" : "" %>', '', rendered)
            rendered = re.sub(r'<asp:Literal[^>]*Text="([^"]*)"[^>]*></asp:Literal>', r'\1', rendered)
            rendered = re.sub(r'<asp:ContentPlaceHolder[^>]*ID="HeadContent"[^>]*>.*?</asp:ContentPlaceHolder>', '', rendered, flags=re.DOTALL)
        else:
            rendered = content

        # Clean ASP Directives
        rendered = re.sub(r'<%@ Page[^>]*%>', '', rendered)
        rendered = re.sub(r'<%@ Master[^>]*%>', '', rendered)
        rendered = re.sub(r'<!DOCTYPE.*?>', '<!DOCTYPE html>', rendered, flags=re.DOTALL | re.IGNORECASE)

        # Form tag
        if current_path == 'Admission.aspx':
            rendered = re.sub(r'<form[^>]*id="formPublic"[^>]*>', '<form id="formPublic" action="Admission.aspx" method="POST">', rendered)
            rendered = re.sub(r'<form[^>]*id="form1"[^>]*>', '<form id="formPublic" action="Admission.aspx" method="POST">', rendered)
            if 'error=missing_compulsory' in query_str:
                err_banner = '''<div class="alert alert-danger shadow-lg rounded-4 p-3 mb-4" style="background: #450a0a; border: 2px solid #ef4444 !important; color: #ffffff;">
                    <h5 class="fw-bold text-white mb-1"><i class="fa-solid fa-triangle-exclamation me-2 text-danger"></i>Form Submission Blocked!</h5>
                    <span>Compulsory information was not provided. Please fill out all required fields (marked with *) to submit and generate your receipt.</span>
                </div>'''
                rendered = re.sub(r'<asp:Panel ID="pnlAlert"[^>]*>.*?</asp:Panel>', err_banner, rendered, flags=re.DOTALL)
                rendered = re.sub(r'<div class="stepper-container', err_banner + '<div class="stepper-container', rendered, count=1)
        else:
            rendered = re.sub(r'<form[^>]*runat="server"[^>]*>', '<form method="GET">', rendered)

        rendered = re.sub(r'<asp:Panel[^>]*Visible="false"[^>]*>.*?</asp:Panel>', '', rendered, flags=re.DOTALL)
        rendered = re.sub(r'<asp:Panel[^>]*>(.*?)</asp:Panel>', r'<div>\1</div>', rendered, flags=re.DOTALL)

        # Handle PublicReceipt.aspx Literal Replacements from incoming URL query parameters!
        if current_path == 'PublicReceipt.aspx':
            s_name = get_p('txtFullName', 'sName', None)
            adm_no = get_p('admNo', 'rec', f'ADM-2026-{os.urandom(2).hex().upper()}')
            gender = get_p('ddlGender', 'gender', 'Male')
            std = get_p('txtStandard', 'std', None)
            school = get_p('txtSchoolName', 'school', '-')
            route = get_p('txtComingFrom', 'route', '-')

            f_name = get_p('txtFatherName', 'fName', None)
            f_aadhaar = get_p('txtFatherAadhaar', 'fAadhaar', '-')
            f_mobile = get_p('txtFatherMobile', 'fMobile', None)

            m_name = get_p('txtMotherName', 'mName', '-')
            m_aadhaar = get_p('txtMotherAadhaar', 'mAadhaar', '-')
            m_mobile = get_p('txtMotherMobile', 'mMobile', '-')

            g1_name = get_p('txtGuardian1Name', 'g1Name', '-')
            g1_rel = get_p('txtGuardian1Rel', 'g1Rel', '-')
            g1_mobile = get_p('txtGuardian1Mobile', 'g1Mobile', '-')

            g2_name = get_p('txtGuardian2Name', 'g2Name', '-')
            g2_rel = get_p('txtGuardian2Rel', 'g2Rel', '-')
            g2_mobile = get_p('txtGuardian2Mobile', 'g2Mobile', '-')

            # If compulsory parameters are missing, render compulsory information warning
            if not s_name or not std or not f_name or not f_mobile:
                warning_html = """<div class="py-5 text-center">
                    <div class="card border-0 shadow-lg rounded-4 overflow-hidden p-5" style="background: #1c2541; border: 2px solid #ef4444 !important; color: #ffffff;">
                        <div class="d-inline-flex align-items-center justify-content-center bg-danger text-white rounded-circle mb-3 mx-auto" style="width: 85px; height: 85px; box-shadow: 0 0 25px rgba(239,68,68,0.5);">
                            <i class="fa-solid fa-triangle-exclamation fa-3x"></i>
                        </div>
                        <h2 class="fw-bold text-white mb-2">Compulsory Information Required!</h2>
                        <p class="text-muted fs-5 mb-4" style="max-width: 650px; margin: 0 auto 1.5rem auto;">
                            Official receipt will only be generated after all compulsory student and parent details (marked with *) are submitted in the Admission Form.
                        </p>
                        <div>
                            <a href="Admission.aspx" class="btn btn-primary-blue btn-lg px-5 rounded-pill fw-bold">
                                <i class="fa-solid fa-pen-to-square me-2"></i> Fill Compulsory Information Now
                            </a>
                        </div>
                    </div>
                </div>"""
                main_match = re.search(r'<asp:Content[^>]*ID="MainContent"[^>]*>(.*?)</asp:Content>', content, re.DOTALL)
                main_html = warning_html
                if master_path and os.path.exists(master_path):
                    with open(os.path.join(os.getcwd(), master_path), 'r', encoding='utf-8') as mf:
                        master = mf.read()
                    rendered = re.sub(r'<asp:ContentPlaceHolder[^>]*ID="MainContent"[^>]*>.*?</asp:ContentPlaceHolder>', main_html, master, flags=re.DOTALL)
                    rendered = re.sub(r'<%: Page.Title %>', 'Compulsory Information Required - TN Happy Kids', rendered)
                    rendered = re.sub(r'<%@ Page[^>]*%>', '', rendered)
                    rendered = re.sub(r'<%@ Master[^>]*%>', '', rendered)
                    rendered = re.sub(r'<!DOCTYPE.*?>', '<!DOCTYPE html>', rendered, flags=re.DOTALL | re.IGNORECASE)
                    self.send_response(200)
                    self.send_header('Content-Type', 'text/html; charset=utf-8')
                    self.end_headers()
                    self.wfile.write(rendered.encode('utf-8'))
                    return
            else:
                today_date = datetime.now().strftime('%Y-%m-%d %H:%M')

                import random
                b1 = random.randint(4000, 9999)
                b2 = random.randint(1000, 9999)
                rfid_father = get_p('rfidFather', None, f"{b1} {b2} 1041")
                rfid_mother = get_p('rfidMother', None, f"{b1} {b2} 1042")
                rfid_g1     = get_p('rfidG1', None, f"{b1} {b2} 1043")
                rfid_g2     = get_p('rfidG2', None, f"{b1} {b2} 1044")

                # Inject actual user values into receipt literals
                rendered = re.sub(r'<asp:Literal[^>]*ID="litAdmissionNo"[^>]*>.*?</asp:Literal>', adm_no, rendered)
                rendered = re.sub(r'<asp:Literal[^>]*ID="litDate"[^>]*>.*?</asp:Literal>', today_date, rendered)
                rendered = re.sub(r'<asp:Literal[^>]*ID="litStudentName"[^>]*>.*?</asp:Literal>', s_name, rendered)
                rendered = re.sub(r'<asp:Literal[^>]*ID="litGender"[^>]*>.*?</asp:Literal>', gender, rendered)
                rendered = re.sub(r'<asp:Literal[^>]*ID="litStandard"[^>]*>.*?</asp:Literal>', std, rendered)
                rendered = re.sub(r'<asp:Literal[^>]*ID="litSchoolName"[^>]*>.*?</asp:Literal>', school, rendered)
                rendered = re.sub(r'<asp:Literal[^>]*ID="litRouteComingFrom"[^>]*>.*?</asp:Literal>', route, rendered)

                rendered = re.sub(r'<asp:Literal[^>]*ID="litFatherName"[^>]*>.*?</asp:Literal>', f_name, rendered)
                rendered = re.sub(r'<asp:Literal[^>]*ID="litFatherAadhaar"[^>]*>.*?</asp:Literal>', f_aadhaar, rendered)
                rendered = re.sub(r'<asp:Literal[^>]*ID="litFatherMobile"[^>]*>.*?</asp:Literal>', f_mobile, rendered)

                rendered = re.sub(r'<asp:Literal[^>]*ID="litMotherName"[^>]*>.*?</asp:Literal>', m_name, rendered)
                rendered = re.sub(r'<asp:Literal[^>]*ID="litMotherAadhaar"[^>]*>.*?</asp:Literal>', m_aadhaar, rendered)
                rendered = re.sub(r'<asp:Literal[^>]*ID="litMotherMobile"[^>]*>.*?</asp:Literal>', m_mobile, rendered)

                rendered = re.sub(r'<asp:Literal[^>]*ID="litGuardian1Name"[^>]*>.*?</asp:Literal>', g1_name, rendered)
                rendered = re.sub(r'<asp:Literal[^>]*ID="litGuardian1Rel"[^>]*>.*?</asp:Literal>', g1_rel, rendered)
                rendered = re.sub(r'<asp:Literal[^>]*ID="litGuardian1Mobile"[^>]*>.*?</asp:Literal>', g1_mobile, rendered)

                rendered = re.sub(r'<asp:Literal[^>]*ID="litGuardian2Name"[^>]*>.*?</asp:Literal>', g2_name, rendered)
                rendered = re.sub(r'<asp:Literal[^>]*ID="litGuardian2Rel"[^>]*>.*?</asp:Literal>', g2_rel, rendered)
                rendered = re.sub(r'<asp:Literal[^>]*ID="litGuardian2Mobile"[^>]*>.*?</asp:Literal>', g2_mobile, rendered)

                # RFID Card Literals
                rendered = re.sub(r'<asp:Literal[^>]*ID="litRfidFatherName"[^>]*>.*?</asp:Literal>', f_name, rendered)
                rendered = re.sub(r'<asp:Literal[^>]*ID="litRfidFatherNo"[^>]*>.*?</asp:Literal>', rfid_father, rendered)

                rendered = re.sub(r'<asp:Literal[^>]*ID="litRfidMotherName"[^>]*>.*?</asp:Literal>', m_name, rendered)
                rendered = re.sub(r'<asp:Literal[^>]*ID="litRfidMotherNo"[^>]*>.*?</asp:Literal>', rfid_mother, rendered)

                rendered = re.sub(r'<asp:Literal[^>]*ID="litRfidG1Name"[^>]*>.*?</asp:Literal>', g1_name, rendered)
                rendered = re.sub(r'<asp:Literal[^>]*ID="litRfidG1RelTag"[^>]*>.*?</asp:Literal>', g1_rel, rendered)
                rendered = re.sub(r'<asp:Literal[^>]*ID="litRfidG1No"[^>]*>.*?</asp:Literal>', rfid_g1, rendered)

                rendered = re.sub(r'<asp:Literal[^>]*ID="litRfidG2Name"[^>]*>.*?</asp:Literal>', g2_name, rendered)
                rendered = re.sub(r'<asp:Literal[^>]*ID="litRfidG2RelTag"[^>]*>.*?</asp:Literal>', g2_rel, rendered)
                rendered = re.sub(r'<asp:Literal[^>]*ID="litRfidG2No"[^>]*>.*?</asp:Literal>', rfid_g2, rendered)

                for i in range(1, 5):
                    rendered = re.sub(rf'<asp:Literal[^>]*ID="litRfidStudentName{i}"[^>]*>.*?</asp:Literal>', s_name, rendered)
                    rendered = re.sub(rf'<asp:Literal[^>]*ID="litRfidStudentReg{i}"[^>]*>.*?</asp:Literal>', adm_no, rendered)

                # Photo Data URIs or Uploaded File URLs from POST/GET parameters
                f_photo_val = get_p('rfidPhotoFather', None, '') or get_p('hidFatherPhotoData', None, '') or get_p('fileFatherPhoto', None, '')
                m_photo_val = get_p('rfidPhotoMother', None, '') or get_p('hidMotherPhotoData', None, '') or get_p('fileMotherPhoto', None, '')
                g1_photo_val = get_p('rfidPhotoG1', None, '') or get_p('hidGuardian1PhotoData', None, '') or get_p('fileGuardian1Photo', None, '')
                g2_photo_val = get_p('rfidPhotoG2', None, '') or get_p('hidGuardian2PhotoData', None, '') or get_p('fileGuardian2Photo', None, '')

                def get_human_portrait_photo(role, bg_color):
                    if role == 'Father':
                        hair = '<path d="M30 42 C30 18 70 18 70 42 C75 32 65 14 50 14 C35 14 25 32 30 42 Z" fill="#1e293b"/>'
                        clothes = '<path d="M15 100 C15 75 35 65 50 65 C65 65 85 75 85 100 Z" fill="#2563eb"/><path d="M42 65 L50 82 L58 65 Z" fill="#ffffff"/><path d="M48 70 L52 70 L51 90 L49 90 Z" fill="#dc2626"/>'
                    elif role == 'Mother':
                        hair = '<path d="M20 52 C16 28 28 8 50 8 C72 8 84 28 80 52 C84 75 76 85 76 85 C76 85 68 58 68 52 C68 32 32 32 32 52 C32 58 24 85 24 85 C24 85 16 75 20 52 Z" fill="#334155"/>'
                        clothes = '<path d="M15 100 C15 75 35 65 50 65 C65 65 85 75 85 100 Z" fill="#db2777"/><path d="M38 65 Q50 78 62 65 Z" fill="#f472b6"/>'
                    elif role == 'Guardian1':
                        hair = '<path d="M28 40 C28 18 72 18 72 40 C75 30 65 12 50 12 C35 12 25 30 28 40 Z" fill="#1e293b"/>'
                        clothes = '<path d="M15 100 C15 75 35 65 50 65 C65 65 85 75 85 100 Z" fill="#059669"/><path d="M42 65 L50 80 L58 65 Z" fill="#ffffff"/>'
                    else:
                        hair = '<path d="M24 48 C22 26 32 10 50 10 C68 10 78 26 76 48 C78 62 72 75 72 75 C72 78 66 52 66 48 C66 30 34 30 34 48 C34 52 28 75 28 75 Z" fill="#1e293b"/>'
                        clothes = '<path d="M15 100 C15 75 35 65 50 65 C65 65 85 75 85 100 Z" fill="#7c3aed"/><path d="M40 65 Q50 75 60 65 Z" fill="#c4b5fd"/>'

                    svg = f'''<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 100 100">
                        <rect width="100%" height="100%" fill="{bg_color}"/>
                        {clothes}
                        <circle cx="50" cy="44" r="20" fill="#fde047"/>
                        {hair}
                        <circle cx="43" cy="42" r="2.5" fill="#1e293b"/>
                        <circle cx="57" cy="42" r="2.5" fill="#1e293b"/>
                        <path d="M44 53 Q50 58 56 53" stroke="#1e293b" stroke-width="2" fill="none"/>
                    </svg>'''
                    return f"data:image/svg+xml;utf8,{urllib.parse.quote(svg)}"

                def resolve_photo_src(val, role, bg):
                    if val and val.strip():
                        val = val.strip()
                        if val.startswith('data:image') or val.startswith('/Uploads/') or val.startswith('Uploads/') or val.startswith('http'):
                            return val
                    return get_human_portrait_photo(role, bg)

                f_src  = resolve_photo_src(f_photo_val,  'Father',    '#1e40af')
                m_src  = resolve_photo_src(m_photo_val,  'Mother',    '#be185d')
                g1_src = resolve_photo_src(g1_photo_val, 'Guardian1', '#047857')
                g2_src = resolve_photo_src(g2_photo_val, 'Guardian2', '#6d28d9')

                rendered = re.sub(r'id="imgRfidFatherPhoto"[^>]*src="[^"]*"', f'id="imgRfidFatherPhoto" src="{f_src}"', rendered)
                rendered = re.sub(r'id="imgRfidMotherPhoto"[^>]*src="[^"]*"', f'id="imgRfidMotherPhoto" src="{m_src}"', rendered)
                rendered = re.sub(r'id="imgRfidG1Photo"[^>]*src="[^"]*"', f'id="imgRfidG1Photo" src="{g1_src}"', rendered)
                rendered = re.sub(r'id="imgRfidG2Photo"[^>]*src="[^"]*"', f'id="imgRfidG2Photo" src="{g2_src}"', rendered)

                # Full Information QR Codes
                def make_qr_url(pname, rel, mobile, rfid_no):
                    info = f"TN HAPPY KIDS SCHOOL - AUTHORIZED PICKUP PASS\n---------------------------------------------\nCard Holder: {pname}\nRelationship: {rel}\nStudent Name: {s_name}\nClass: {std}\nMobile: {mobile}\nStudent Reg No: {adm_no}\nRFID Card No: {rfid_no}\nStatus: VERIFIED & AUTHORIZED"
                    return f"https://api.qrserver.com/v1/create-qr-code/?size=250x250&data={urllib.parse.quote(info)}"

                rendered = re.sub(r'id="imgQrFather"[^>]*src="[^"]*"', f'id="imgQrFather" src="{make_qr_url(f_name, "Father", f_mobile, rfid_father)}"', rendered)
                rendered = re.sub(r'id="imgQrMother"[^>]*src="[^"]*"', f'id="imgQrMother" src="{make_qr_url(m_name, "Mother", m_mobile, rfid_mother)}"', rendered)
                rendered = re.sub(r'id="imgQrG1"[^>]*src="[^"]*"', f'id="imgQrG1" src="{make_qr_url(g1_name, g1_rel, g1_mobile, rfid_g1)}"', rendered)
                rendered = re.sub(r'id="imgQrG2"[^>]*src="[^"]*"', f'id="imgQrG2" src="{make_qr_url(g2_name, g2_rel, g2_mobile, rfid_g2)}"', rendered)

        # Controls conversion
        def replace_textbox(match):
            tag = match.group(0)
            id_m = re.search(r'ID="([^"]*)"', tag)
            ctrl_id = id_m.group(1) if id_m else ''
            
            is_req = 'required="true"' in tag or ' required' in tag
            req_str = ' required' if is_req else ''

            onch_m = re.search(r'onchange="([^"]*)"', tag)
            onch = f' onchange="{onch_m.group(1)}"' if onch_m else ''

            oninp_m = re.search(r'oninput="([^"]*)"', tag)
            oninp = f' oninput="{oninp_m.group(1)}"' if oninp_m else ''
            
            if 'TextMode="Date"' in tag:
                return f'<input type="date" class="form-control-custom" id="{ctrl_id}" name="{ctrl_id}"{onch}{oninp}{req_str} />'
            elif 'TextMode="Password"' in tag:
                return f'<input type="password" class="form-control-custom" id="{ctrl_id}" name="{ctrl_id}" placeholder="••••••••"{onch}{oninp}{req_str} />'
            elif 'TextMode="MultiLine"' in tag:
                return f'<textarea class="form-control-custom" id="{ctrl_id}" name="{ctrl_id}"{onch}{oninp}{req_str}></textarea>'
            else:
                ph_m = re.search(r'placeholder="([^"]*)"', tag)
                ph = f' placeholder="{ph_m.group(1)}"' if ph_m else ''
                txt_m = re.search(r'Text="([^"]*)"', tag)
                txt = f' value="{txt_m.group(1)}"' if txt_m else ''
                return f'<input type="text" class="form-control-custom" id="{ctrl_id}" name="{ctrl_id}"{ph}{txt}{onch}{oninp}{req_str} />'

        rendered = re.sub(r'<asp:TextBox[^>]*/>', replace_textbox, rendered)
        rendered = re.sub(r'<asp:TextBox[^>]*>.*?</asp:TextBox>', replace_textbox, rendered, flags=re.DOTALL)

        rendered = re.sub(r'<asp:DropDownList[^>]*ID="([^"]*)"[^>]*>(.*?)</asp:DropDownList>', r'<select class="form-select form-control-custom" id="\1" name="\1">\2</select>', rendered, flags=re.DOTALL)
        rendered = re.sub(r'<asp:ListItem[^>]*Value="([^"]*)"[^>]*>(.*?)</asp:ListItem>', r'<option value="\1">\2</option>', rendered)

        # Buttons conversion
        rendered = re.sub(r'<asp:Button[^>]*ID="btnSubmitAdmission"[^>]*Text="([^"]*)"[^>]*CssClass="([^"]*)"[^>]*/>', r'<button type="submit" class="\2">\1</button>', rendered)
        rendered = re.sub(r'<asp:Button[^>]*Text="([^"]*)"[^>]*CssClass="([^"]*)"[^>]*/>', r'<button type="submit" class="\2">\1</button>', rendered)

        # Labels, Literals, Checkboxes, FileUpload
        rendered = re.sub(r'<asp:CheckBox[^>]*ID="([^"]*)"[^>]*/>', r'<input type="checkbox" id="\1" class="form-check-input" />', rendered)
        rendered = re.sub(r'<asp:Literal[^>]*ID="([^"]*)"[^>]*Text="([^"]*)"[^>]*></asp:Literal>', r'\2', rendered)
        rendered = re.sub(r'<asp:Literal[^>]*ID="([^"]*)"[^>]*>([^<]*)</asp:Literal>', r'\2', rendered)
        rendered = re.sub(r'<asp:Literal[^>]*></asp:Literal>', r'', rendered)
        rendered = re.sub(r'<asp:Image[^>]*ID="([^"]*)"[^>]*CssClass="([^"]*)"[^>]*/>', r'<img class="\2" src="Images/Students/default-avatar.png" />', rendered)
        def replace_fileupload(match):
            tag = match.group(0)
            id_m = re.search(r'ID="([^"]*)"', tag)
            ctrl_id = id_m.group(1) if id_m else "file"
            onch_m = re.search(r'onchange="([^"]*)"', tag)
            onch = f' onchange="{onch_m.group(1)}"' if onch_m else ''
            return f'<input type="file" class="form-control-custom" id="{ctrl_id}" name="{ctrl_id}" accept="image/*"{onch} />'

        rendered = re.sub(r'<asp:FileUpload[^>]*/>', replace_fileupload, rendered)
        rendered = re.sub(r'<asp:FileUpload[^>]*>.*?</asp:FileUpload>', replace_fileupload, rendered, flags=re.DOTALL)

        self.send_response(200)
        self.send_header('Content-Type', 'text/html; charset=utf-8')
        self.end_headers()
        self.wfile.write(rendered.encode('utf-8'))

if __name__ == '__main__':
    print(f"Starting Standalone Public Admission Portal on http://localhost:{PORT}")
    socketserver.TCPServer.allow_reuse_address = True
    with socketserver.TCPServer(("", PORT), StandaloneAdmissionHandler) as httpd:
        httpd.serve_forever()
