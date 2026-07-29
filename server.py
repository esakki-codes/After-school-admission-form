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
        if path == 'Admission.aspx' or not path or path == '/':
            self.send_response(303)
            self.send_header('Location', '/PublicReceipt.aspx?rec=REC-2026-00001')
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

            rendered = re.sub(r'<asp:ContentPlaceHolder[^>]*ID="MainContent"[^>]*>.*?</asp:ContentPlaceHolder>', main_html, master, flags=re.DOTALL)
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
            rendered = re.sub(r'<form[^>]*id="formPublic"[^>]*>', '<form id="formPublic" action="PublicReceipt.aspx" method="GET">', rendered)
            rendered = re.sub(r'<form[^>]*id="form1"[^>]*>', '<form id="formPublic" action="PublicReceipt.aspx" method="GET">', rendered)
        else:
            rendered = re.sub(r'<form[^>]*runat="server"[^>]*>', '<form method="GET">', rendered)

        rendered = re.sub(r'<asp:Panel[^>]*Visible="false"[^>]*>.*?</asp:Panel>', '', rendered, flags=re.DOTALL)
        rendered = re.sub(r'<asp:Panel[^>]*>(.*?)</asp:Panel>', r'<div>\1</div>', rendered, flags=re.DOTALL)

        # Handle PublicReceipt.aspx Literal Replacements from incoming URL query parameters!
        if current_path == 'PublicReceipt.aspx':
            s_name = get_p('txtFullName', 'sName', 'Student Application')
            adm_no = get_p('admNo', 'rec', f'ADM-2026-{os.urandom(2).hex().upper()}')
            gender = get_p('ddlGender', 'gender', 'Male')
            std = get_p('txtStandard', 'std', 'LKG')
            school = get_p('txtSchoolName', 'school', '-')
            route = get_p('txtComingFrom', 'route', '-')

            f_name = get_p('txtFatherName', 'fName', '-')
            f_aadhaar = get_p('txtFatherAadhaar', 'fAadhaar', '-')
            f_mobile = get_p('txtFatherMobile', 'fMobile', '-')

            m_name = get_p('txtMotherName', 'mName', '-')
            m_aadhaar = get_p('txtMotherAadhaar', 'mAadhaar', '-')
            m_mobile = get_p('txtMotherMobile', 'mMobile', '-')

            g1_name = get_p('txtGuardian1Name', 'g1Name', '-')
            g1_rel = get_p('txtGuardian1Rel', 'g1Rel', '-')
            g1_mobile = get_p('txtGuardian1Mobile', 'g1Mobile', '-')

            g2_name = get_p('txtGuardian2Name', 'g2Name', '-')
            g2_rel = get_p('txtGuardian2Rel', 'g2Rel', '-')
            g2_mobile = get_p('txtGuardian2Mobile', 'g2Mobile', '-')

            today_date = datetime.now().strftime('%yyyy-%m-%d %H:%M')

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

        # Controls conversion
        rendered = re.sub(r'<asp:TextBox[^>]*ID="([^"]*)"[^>]*TextMode="Date"[^>]*></asp:TextBox>', r'<input type="date" class="form-control-custom" id="\1" name="\1" />', rendered)
        rendered = re.sub(r'<asp:TextBox[^>]*ID="([^"]*)"[^>]*TextMode="Password"[^>]*></asp:TextBox>', r'<input type="password" class="form-control-custom" id="\1" name="\1" placeholder="••••••••" />', rendered)
        rendered = re.sub(r'<asp:TextBox[^>]*ID="([^"]*)"[^>]*TextMode="MultiLine"[^>]*></asp:TextBox>', r'<textarea class="form-control-custom" id="\1" name="\1"></textarea>', rendered)
        rendered = re.sub(r'<asp:TextBox[^>]*ID="([^"]*)"[^>]*Text="([^"]*)"[^>]*></asp:TextBox>', r'<input type="text" class="form-control-custom" id="\1" name="\1" value="\2" />', rendered)
        rendered = re.sub(r'<asp:TextBox[^>]*ID="([^"]*)"[^>]*placeholder="([^"]*)"[^>]*></asp:TextBox>', r'<input type="text" class="form-control-custom" id="\1" name="\1" placeholder="\2" />', rendered)
        rendered = re.sub(r'<asp:TextBox[^>]*ID="([^"]*)"[^>]*></asp:TextBox>', r'<input type="text" class="form-control-custom" id="\1" name="\1" />', rendered)

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
        rendered = re.sub(r'<asp:FileUpload[^>]*ID="([^"]*)"[^>]*/>', r'<input type="file" class="form-control-custom" id="\1" name="\1" accept="image/*" />', rendered)
        rendered = re.sub(r'<asp:FileUpload[^>]*/>', r'<input type="file" class="form-control-custom" accept="image/*" />', rendered)

        self.send_response(200)
        self.send_header('Content-Type', 'text/html; charset=utf-8')
        self.end_headers()
        self.wfile.write(rendered.encode('utf-8'))

if __name__ == '__main__':
    print(f"Starting Standalone Public Admission Portal on http://localhost:{PORT}")
    socketserver.TCPServer.allow_reuse_address = True
    with socketserver.TCPServer(("", PORT), StandaloneAdmissionHandler) as httpd:
        httpd.serve_forever()
