<%@ Page Title="After School Admission Form" Language="C#" MasterPageFile="~/PublicSite.Master" AutoEventWireup="true" CodeBehind="Admission.aspx.cs" Inherits="AfterSchoolAdmission.Admission" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div>

        <!-- Top Header Card with Official Logo -->
        <div class="brand-header-card text-center py-4">
            <div class="logo-container mx-auto mb-3" style="width: 130px; height: 130px; border-radius: 50%; padding: 6px;">
                <img src="Images/logo.png" alt="TN Happy Kids Logo" style="width: 100%; height: 100%; object-fit: contain;" />
            </div>
            <div>
                <h1 class="school-title" style="font-size: 2.3rem;">TN Happy Kids</h1>
                <div class="form-subtitle" style="font-size: 1.1rem; color: var(--primary-blue); font-weight: 700;">(An Unit of MAAS Group of Companies)</div>
                <div class="form-subtitle mt-1" style="font-size: 1.25rem;"><i class="fa-solid fa-graduation-cap me-2"></i>After School Admission Form</div>
            </div>
        </div>

        <!-- INTERACTIVE STEPPER WIZARD -->
        <div class="stepper-container mb-4">
            <div class="stepper-item active" id="stepIndicator1">
                <div class="stepper-circle">01</div>
                <div class="stepper-label">
                    <span class="stepper-step-no">Step 01</span>
                    <span class="stepper-title">Student Info</span>
                </div>
            </div>
            <div class="stepper-connector" id="stepConnector"></div>
            <div class="stepper-item" id="stepIndicator2">
                <div class="stepper-circle">02</div>
                <div class="stepper-label">
                    <span class="stepper-step-no">Step 02</span>
                    <span class="stepper-title">Parents & Guardians</span>
                </div>
            </div>
        </div>

        <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="alert alert-danger alert-dismissible fade show" role="alert">
            <asp:Literal ID="litAlertMsg" runat="server"></asp:Literal>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </asp:Panel>

        <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show" role="alert">
            <asp:Literal ID="litSuccessMsg" runat="server"></asp:Literal>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </asp:Panel>

        <!-- STEP 1: STUDENT INFORMATION -->
        <div class="form-step-card" id="step1">
            <div class="step-title-header">
                <div class="step-icon-badge">
                    <i class="fa-regular fa-user"></i>
                </div>
                <span>1. Student Information</span>
            </div>

            <div class="row g-4 mb-3">
                <div class="col-md-12">
                    <label for="txtFullName" class="form-label-custom">Student Full Name <span class="required-star">*</span></label>
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control-custom" placeholder="Enter student's full name (Minimum 3 characters)" required="true"></asp:TextBox>
                </div>

                <div class="col-md-6">
                    <label for="txtDOB" class="form-label-custom">Date of Birth <span class="required-star">*</span></label>
                    <asp:TextBox ID="txtDOB" runat="server" ClientIDMode="Static" TextMode="Date" CssClass="form-control-custom" onchange="calculateAge();" oninput="calculateAge();" required="true"></asp:TextBox>
                </div>

                <div class="col-md-6">
                    <label for="txtAge" class="form-label-custom">Age (Auto Calculated)</label>
                    <asp:TextBox ID="txtAge" runat="server" ClientIDMode="Static" CssClass="form-control-custom bg-dark" ReadOnly="true" placeholder="Select date of birth"></asp:TextBox>
                </div>

                <div class="col-md-6">
                    <label class="form-label-custom">Gender <span class="required-star">*</span></label>
                    <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-select form-control-custom" required="true">
                        <asp:ListItem Value="Male">Male</asp:ListItem>
                        <asp:ListItem Value="Female">Female</asp:ListItem>
                        <asp:ListItem Value="Other">Other</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="col-md-6">
                    <label for="ddlBloodGroup" class="form-label-custom">Blood Group</label>
                    <asp:DropDownList ID="ddlBloodGroup" runat="server" CssClass="form-select form-control-custom">
                        <asp:ListItem Value="A+">A+</asp:ListItem>
                        <asp:ListItem Value="A-">A-</asp:ListItem>
                        <asp:ListItem Value="B+">B+</asp:ListItem>
                        <asp:ListItem Value="B-">B-</asp:ListItem>
                        <asp:ListItem Value="O+">O+</asp:ListItem>
                        <asp:ListItem Value="O-">O-</asp:ListItem>
                        <asp:ListItem Value="AB+">AB+</asp:ListItem>
                        <asp:ListItem Value="AB-">AB-</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <!-- ADDED: CURRENT SCHOOL NAME & CLASS / STANDARD -->
                <div class="col-md-6">
                    <label for="txtSchoolName" class="form-label-custom">Current School Name</label>
                    <asp:TextBox ID="txtSchoolName" runat="server" CssClass="form-control-custom" placeholder="Enter school name"></asp:TextBox>
                </div>

                <div class="col-md-6">
                    <label for="txtStandard" class="form-label-custom">Class / Standard <span class="required-star">*</span></label>
                    <asp:TextBox ID="txtStandard" runat="server" CssClass="form-control-custom" placeholder="e.g. LKG, UKG, Class 4" required="true"></asp:TextBox>
                </div>

                <!-- WHICH ROUTE ARE YOU COMING FROM? -->
                <div class="col-md-12">
                    <label for="txtComingFrom" class="form-label-custom">Which route are you coming from?</label>
                    <asp:TextBox ID="txtComingFrom" runat="server" CssClass="form-control-custom" placeholder="Enter route / travel route / area location"></asp:TextBox>
                </div>

                <div class="col-md-12">
                    <label for="txtAddress" class="form-label-custom">Residential Address <span class="required-star">*</span></label>
                    <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control-custom" placeholder="Enter residential address" required="true"></asp:TextBox>
                </div>

                <div class="col-md-12">
                    <label class="form-label-custom">Student Photo Upload</label>
                    <div class="d-flex align-items-center gap-3">
                        <div class="photo-preview-container" style="width: 100px; height: 100px; border-radius: 1rem; border: 2px dashed #38bdf8;">
                            <img id="imgPhotoPreview" src="data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='100' height='100' viewBox='0 0 24 24' fill='%2338bdf8'><path d='M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 4c1.93 0 3.5 1.57 3.5 3.5S13.93 13 12 13s-3.5-1.57-3.5-3.5S10.07 6 12 6zm0 14c-2.03 0-3.8-1.04-4.83-2.61.03-1.6 3.22-2.47 4.83-2.47s4.8 0.87 4.83 2.47C15.8 18.96 14.03 20 12 20z'/></svg>" alt="Student Preview" style="object-fit: cover; width: 100%; height: 100%; border-radius: 0.9rem;" />
                        </div>
                        <div class="flex-grow-1">
                            <asp:FileUpload ID="filePhoto" runat="server" ClientIDMode="Static" CssClass="form-control-custom" onchange="previewPhoto(this, 'imgPhotoPreview');" accept="image/*" />
                            <small class="text-muted d-block mt-1">Accepts JPG, PNG, WEBP images</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- STEP 2: PARENTS & GUARDIANS DETAILS (STACKED IN SEPARATE FULL-WIDTH LINES) -->
        <div class="form-step-card" id="step2">
            <div class="step-title-header">
                <div class="step-icon-badge">
                    <i class="fa-solid fa-users"></i>
                </div>
                <span>2. Parent & Guardian Details</span>
            </div>

            <!-- LINE 1: FATHER DETAILS -->
            <div class="guardian-card-box border-primary mb-4">
                <h5 class="fw-bold text-primary mb-3"><i class="fa-solid fa-user me-2"></i>Father Information</h5>
                <div class="row g-4">
                    <div class="col-md-12">
                        <div class="p-3 rounded mb-2" style="background: #0b132b; border: 1px dashed #38bdf8;">
                            <label class="form-label-custom mb-2 d-flex justify-content-between align-items-center">
                                <span>Father Photo Upload / Camera Capture</span>
                                <span class="badge bg-info text-dark">Photo Compulsory for ID Card</span>
                            </label>
                            <div class="d-flex align-items-center gap-3">
                                <div style="width: 80px; height: 80px; border-radius: 0.75rem; overflow: hidden; background: #1c2541; border: 2px solid #38bdf8; flex-shrink: 0;">
                                    <img id="imgFatherPhotoPreview" src="data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='100' height='100' viewBox='0 0 24 24' fill='%2338bdf8'><path d='M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 4c1.93 0 3.5 1.57 3.5 3.5S13.93 13 12 13s-3.5-1.57-3.5-3.5S10.07 6 12 6zm0 14c-2.03 0-3.8-1.04-4.83-2.61.03-1.6 3.22-2.47 4.83-2.47s4.8 0.87 4.83 2.47C15.8 18.96 14.03 20 12 20z'/></svg>" alt="Father Preview" style="object-fit: cover; width: 100%; height: 100%;" />
                                </div>
                                <div class="flex-grow-1">
                                    <asp:FileUpload ID="fileFatherPhoto" runat="server" ClientIDMode="Static" CssClass="form-control-custom mb-2" onchange="previewPhoto(this, 'imgFatherPhotoPreview');" accept="image/*" />
                                    <div class="d-flex gap-2">
                                        <button type="button" class="btn btn-outline-info btn-sm" onclick="openCameraModal('imgFatherPhotoPreview', 'hidFatherPhotoData', 'rfidPhotoFather')"><i class="fa-solid fa-camera me-1"></i>Take Photo (Camera)</button>
                                        <button type="button" class="btn btn-outline-warning btn-sm" onclick="loadSamplePhoto('imgFatherPhotoPreview', 'hidFatherPhotoData', 'rfidPhotoFather', 'Father')"><i class="fa-solid fa-image me-1"></i>Sample Photo</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label for="txtFatherName" class="form-label-custom">Father Full Name <span class="required-star">*</span></label>
                        <asp:TextBox ID="txtFatherName" runat="server" CssClass="form-control-custom" placeholder="Enter father name" required="true"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label for="txtFatherAadhaar" class="form-label-custom">Father Aadhaar Number <span class="required-star">*</span></label>
                        <asp:TextBox ID="txtFatherAadhaar" runat="server" CssClass="form-control-custom" placeholder="12-digit Aadhaar number" required="true"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label for="txtFatherMobile" class="form-label-custom">Mobile Number <span class="required-star">*</span></label>
                        <asp:TextBox ID="txtFatherMobile" runat="server" CssClass="form-control-custom" placeholder="10-digit mobile number" required="true"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label for="txtFatherWhatsApp" class="form-label-custom">WhatsApp Number</label>
                        <asp:TextBox ID="txtFatherWhatsApp" runat="server" CssClass="form-control-custom" placeholder="WhatsApp contact"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label for="txtFatherEmail" class="form-label-custom">Email Address</label>
                        <asp:TextBox ID="txtFatherEmail" runat="server" TextMode="Email" CssClass="form-control-custom" placeholder="email@domain.com"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label for="txtFatherOccupation" class="form-label-custom">Occupation</label>
                        <asp:TextBox ID="txtFatherOccupation" runat="server" CssClass="form-control-custom" placeholder="Occupation"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label for="txtFatherOfficeAddress" class="form-label-custom">Office Address</label>
                        <asp:TextBox ID="txtFatherOfficeAddress" runat="server" CssClass="form-control-custom" placeholder="Office location"></asp:TextBox>
                    </div>
                </div>
            </div>

            <!-- LINE 2: MOTHER DETAILS -->
            <div class="guardian-card-box border-primary mb-4">
                <h5 class="fw-bold text-primary mb-3"><i class="fa-solid fa-user-nurse me-2"></i>Mother Information</h5>
                <div class="row g-4">
                    <div class="col-md-12">
                        <div class="p-3 rounded mb-2" style="background: #0b132b; border: 1px dashed #38bdf8;">
                            <label class="form-label-custom mb-2 d-flex justify-content-between align-items-center">
                                <span>Mother Photo Upload / Camera Capture</span>
                                <span class="badge bg-info text-dark">Photo Compulsory for ID Card</span>
                            </label>
                            <div class="d-flex align-items-center gap-3">
                                <div style="width: 80px; height: 80px; border-radius: 0.75rem; overflow: hidden; background: #1c2541; border: 2px solid #38bdf8; flex-shrink: 0;">
                                    <img id="imgMotherPhotoPreview" src="data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='100' height='100' viewBox='0 0 24 24' fill='%2338bdf8'><path d='M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 4c1.93 0 3.5 1.57 3.5 3.5S13.93 13 12 13s-3.5-1.57-3.5-3.5S10.07 6 12 6zm0 14c-2.03 0-3.8-1.04-4.83-2.61.03-1.6 3.22-2.47 4.83-2.47s4.8 0.87 4.83 2.47C15.8 18.96 14.03 20 12 20z'/></svg>" alt="Mother Preview" style="object-fit: cover; width: 100%; height: 100%;" />
                                </div>
                                <div class="flex-grow-1">
                                    <asp:FileUpload ID="fileMotherPhoto" runat="server" ClientIDMode="Static" CssClass="form-control-custom mb-2" onchange="previewPhoto(this, 'imgMotherPhotoPreview');" accept="image/*" />
                                    <div class="d-flex gap-2">
                                        <button type="button" class="btn btn-outline-info btn-sm" onclick="openCameraModal('imgMotherPhotoPreview', 'hidMotherPhotoData', 'rfidPhotoMother')"><i class="fa-solid fa-camera me-1"></i>Take Photo (Camera)</button>
                                        <button type="button" class="btn btn-outline-warning btn-sm" onclick="loadSamplePhoto('imgMotherPhotoPreview', 'hidMotherPhotoData', 'rfidPhotoMother', 'Mother')"><i class="fa-solid fa-image me-1"></i>Sample Photo</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label for="txtMotherName" class="form-label-custom">Mother Full Name <span class="required-star">*</span></label>
                        <asp:TextBox ID="txtMotherName" runat="server" CssClass="form-control-custom" placeholder="Enter mother name" required="true"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label for="txtMotherAadhaar" class="form-label-custom">Mother Aadhaar Number <span class="required-star">*</span></label>
                        <asp:TextBox ID="txtMotherAadhaar" runat="server" CssClass="form-control-custom" placeholder="12-digit Aadhaar number" required="true"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label for="txtMotherMobile" class="form-label-custom">Mobile Number <span class="required-star">*</span></label>
                        <asp:TextBox ID="txtMotherMobile" runat="server" CssClass="form-control-custom" placeholder="10-digit mobile number" required="true"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label for="txtMotherWhatsApp" class="form-label-custom">WhatsApp Number</label>
                        <asp:TextBox ID="txtMotherWhatsApp" runat="server" CssClass="form-control-custom" placeholder="WhatsApp contact"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label for="txtMotherEmail" class="form-label-custom">Email Address</label>
                        <asp:TextBox ID="txtMotherEmail" runat="server" TextMode="Email" CssClass="form-control-custom" placeholder="email@domain.com"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label for="txtMotherOccupation" class="form-label-custom">Occupation</label>
                        <asp:TextBox ID="txtMotherOccupation" runat="server" CssClass="form-control-custom" placeholder="Occupation"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label for="txtMotherOfficeAddress" class="form-label-custom">Office Address</label>
                        <asp:TextBox ID="txtMotherOfficeAddress" runat="server" CssClass="form-control-custom" placeholder="Office location"></asp:TextBox>
                    </div>
                </div>
            </div>

            <!-- LINE 3: GUARDIAN 1 DETAILS -->
            <div class="guardian-card-box border-info mb-4">
                <h5 class="fw-bold text-info mb-3"><i class="fa-solid fa-user-shield me-2"></i>Guardian 1 Information</h5>
                <div class="row g-4">
                    <div class="col-md-12">
                        <div class="p-3 rounded mb-2" style="background: #0b132b; border: 1px dashed #38bdf8;">
                            <label class="form-label-custom mb-2 d-flex justify-content-between align-items-center">
                                <span>Guardian 1 Photo Upload / Camera Capture</span>
                                <span class="badge bg-info text-dark">Photo Compulsory for ID Card</span>
                            </label>
                            <div class="d-flex align-items-center gap-3">
                                <div style="width: 80px; height: 80px; border-radius: 0.75rem; overflow: hidden; background: #1c2541; border: 2px solid #38bdf8; flex-shrink: 0;">
                                    <img id="imgGuardian1PhotoPreview" src="data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='100' height='100' viewBox='0 0 24 24' fill='%2338bdf8'><path d='M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 4c1.93 0 3.5 1.57 3.5 3.5S13.93 13 12 13s-3.5-1.57-3.5-3.5S10.07 6 12 6zm0 14c-2.03 0-3.8-1.04-4.83-2.61.03-1.6 3.22-2.47 4.83-2.47s4.8 0.87 4.83 2.47C15.8 18.96 14.03 20 12 20z'/></svg>" alt="Guardian 1 Preview" style="object-fit: cover; width: 100%; height: 100%;" />
                                </div>
                                <div class="flex-grow-1">
                                    <asp:FileUpload ID="fileGuardian1Photo" runat="server" ClientIDMode="Static" CssClass="form-control-custom mb-2" onchange="previewPhoto(this, 'imgGuardian1PhotoPreview');" accept="image/*" />
                                    <div class="d-flex gap-2">
                                        <button type="button" class="btn btn-outline-info btn-sm" onclick="openCameraModal('imgGuardian1PhotoPreview', 'hidGuardian1PhotoData', 'rfidPhotoG1')"><i class="fa-solid fa-camera me-1"></i>Take Photo (Camera)</button>
                                        <button type="button" class="btn btn-outline-warning btn-sm" onclick="loadSamplePhoto('imgGuardian1PhotoPreview', 'hidGuardian1PhotoData', 'rfidPhotoG1', 'Guardian1')"><i class="fa-solid fa-image me-1"></i>Sample Photo</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <label for="txtGuardian1Name" class="form-label-custom">Guardian 1 Full Name <span class="required-star">*</span></label>
                        <asp:TextBox ID="txtGuardian1Name" runat="server" CssClass="form-control-custom" placeholder="Enter Guardian 1 name" required="true"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label for="txtGuardian1Aadhaar" class="form-label-custom">Guardian 1 Aadhaar Number</label>
                        <asp:TextBox ID="txtGuardian1Aadhaar" runat="server" CssClass="form-control-custom" placeholder="12-digit Aadhaar number"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label for="txtGuardian1Rel" class="form-label-custom">Relationship <span class="required-star">*</span></label>
                        <asp:TextBox ID="txtGuardian1Rel" runat="server" CssClass="form-control-custom" placeholder="e.g. Grandfather, Uncle" required="true"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label for="txtGuardian1Mobile" class="form-label-custom">Mobile Number <span class="required-star">*</span></label>
                        <asp:TextBox ID="txtGuardian1Mobile" runat="server" CssClass="form-control-custom" placeholder="10-digit mobile number" required="true"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label for="txtGuardian1WhatsApp" class="form-label-custom">WhatsApp Number</label>
                        <asp:TextBox ID="txtGuardian1WhatsApp" runat="server" CssClass="form-control-custom" placeholder="WhatsApp contact"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label for="txtGuardian1Email" class="form-label-custom">Email Address</label>
                        <asp:TextBox ID="txtGuardian1Email" runat="server" TextMode="Email" CssClass="form-control-custom" placeholder="email@domain.com"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label for="txtGuardian1Occupation" class="form-label-custom">Occupation</label>
                        <asp:TextBox ID="txtGuardian1Occupation" runat="server" CssClass="form-control-custom" placeholder="Occupation"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label for="txtGuardian1Address" class="form-label-custom">Residential Address</label>
                        <asp:TextBox ID="txtGuardian1Address" runat="server" CssClass="form-control-custom" placeholder="Residential address"></asp:TextBox>
                    </div>
                </div>
            </div>

            <!-- LINE 4: GUARDIAN 2 DETAILS -->
            <div class="guardian-card-box border-info mb-4">
                <h5 class="fw-bold text-info mb-3"><i class="fa-solid fa-shield-halved me-2"></i>Guardian 2 Information</h5>
                <div class="row g-4">
                    <div class="col-md-12">
                        <div class="p-3 rounded mb-2" style="background: #0b132b; border: 1px dashed #38bdf8;">
                            <label class="form-label-custom mb-2 d-flex justify-content-between align-items-center">
                                <span>Guardian 2 Photo Upload / Camera Capture</span>
                                <span class="badge bg-info text-dark">Photo Compulsory for ID Card</span>
                            </label>
                            <div class="d-flex align-items-center gap-3">
                                <div style="width: 80px; height: 80px; border-radius: 0.75rem; overflow: hidden; background: #1c2541; border: 2px solid #38bdf8; flex-shrink: 0;">
                                    <img id="imgGuardian2PhotoPreview" src="data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='100' height='100' viewBox='0 0 24 24' fill='%2338bdf8'><path d='M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 4c1.93 0 3.5 1.57 3.5 3.5S13.93 13 12 13s-3.5-1.57-3.5-3.5S10.07 6 12 6zm0 14c-2.03 0-3.8-1.04-4.83-2.61.03-1.6 3.22-2.47 4.83-2.47s4.8 0.87 4.83 2.47C15.8 18.96 14.03 20 12 20z'/></svg>" alt="Guardian 2 Preview" style="object-fit: cover; width: 100%; height: 100%;" />
                                </div>
                                <div class="flex-grow-1">
                                    <asp:FileUpload ID="fileGuardian2Photo" runat="server" ClientIDMode="Static" CssClass="form-control-custom mb-2" onchange="previewPhoto(this, 'imgGuardian2PhotoPreview');" accept="image/*" />
                                    <div class="d-flex gap-2">
                                        <button type="button" class="btn btn-outline-info btn-sm" onclick="openCameraModal('imgGuardian2PhotoPreview', 'hidGuardian2PhotoData', 'rfidPhotoG2')"><i class="fa-solid fa-camera me-1"></i>Take Photo (Camera)</button>
                                        <button type="button" class="btn btn-outline-warning btn-sm" onclick="loadSamplePhoto('imgGuardian2PhotoPreview', 'hidGuardian2PhotoData', 'rfidPhotoG2', 'Guardian2')"><i class="fa-solid fa-image me-1"></i>Sample Photo</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <label for="txtGuardian2Name" class="form-label-custom">Guardian 2 Full Name</label>
                        <asp:TextBox ID="txtGuardian2Name" runat="server" CssClass="form-control-custom" placeholder="Enter Guardian 2 name"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label for="txtGuardian2Aadhaar" class="form-label-custom">Guardian 2 Aadhaar Number</label>
                        <asp:TextBox ID="txtGuardian2Aadhaar" runat="server" CssClass="form-control-custom" placeholder="12-digit Aadhaar number"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label for="txtGuardian2Rel" class="form-label-custom">Relationship</label>
                        <asp:TextBox ID="txtGuardian2Rel" runat="server" CssClass="form-control-custom" placeholder="e.g. Grandmother, Aunt"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label for="txtGuardian2Mobile" class="form-label-custom">Mobile Number</label>
                        <asp:TextBox ID="txtGuardian2Mobile" runat="server" CssClass="form-control-custom" placeholder="10-digit mobile number"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label for="txtGuardian2WhatsApp" class="form-label-custom">WhatsApp Number</label>
                        <asp:TextBox ID="txtGuardian2WhatsApp" runat="server" CssClass="form-control-custom" placeholder="WhatsApp contact"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label for="txtGuardian2Email" class="form-label-custom">Email Address</label>
                        <asp:TextBox ID="txtGuardian2Email" runat="server" TextMode="Email" CssClass="form-control-custom" placeholder="email@domain.com"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label for="txtGuardian2Occupation" class="form-label-custom">Occupation</label>
                        <asp:TextBox ID="txtGuardian2Occupation" runat="server" CssClass="form-control-custom" placeholder="Occupation"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label for="txtGuardian2Address" class="form-label-custom">Residential Address</label>
                        <asp:TextBox ID="txtGuardian2Address" runat="server" CssClass="form-control-custom" placeholder="Residential address"></asp:TextBox>
                    </div>
                </div>
            </div>

            <!-- HIDDEN FIELDS FOR UPLOADED BASE64 PHOTO PERSISTENCE -->
            <input type="hidden" id="hidFatherPhotoData" name="hidFatherPhotoData" value="" />
            <input type="hidden" id="hidMotherPhotoData" name="hidMotherPhotoData" value="" />
            <input type="hidden" id="hidGuardian1PhotoData" name="hidGuardian1PhotoData" value="" />
            <input type="hidden" id="hidGuardian2PhotoData" name="hidGuardian2PhotoData" value="" />

            <!-- SUBMIT BUTTON -->
            <div class="d-flex justify-content-end gap-3 border-top border-secondary pt-4 mt-4">
                <asp:Button ID="btnSubmitAdmission" runat="server" Text="Submit Application & Generate Receipt" OnClick="btnSubmitAdmission_Click" CssClass="btn btn-primary-blue" />
            </div>
        </div>

    </div>

    <!-- LIVE WEBCAM CAMERA CAPTURE MODAL -->
    <div class="modal fade" id="cameraModal" tabindex="-1" aria-labelledby="cameraModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content" style="background: #1c2541; border: 2px solid #38bdf8; border-radius: 16px; color: #ffffff;">
                <div class="modal-header border-secondary">
                    <h5 class="modal-title fw-bold text-info" id="cameraModalLabel"><i class="fa-solid fa-camera me-2"></i>Take Live Photo with Camera</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" onclick="stopCamera()"></button>
                </div>
                <div class="modal-body text-center">
                    <video id="webcamVideo" autoplay playsinline style="width: 100%; max-height: 280px; border-radius: 12px; background: #0b132b; border: 2px solid #38bdf8; object-fit: cover;"></video>
                    <canvas id="webcamCanvas" style="display: none;"></canvas>
                </div>
                <div class="modal-footer border-secondary justify-content-between">
                    <button type="button" class="btn btn-outline-secondary text-white" data-bs-dismiss="modal" onclick="stopCamera()">Cancel</button>
                    <button type="button" class="btn btn-success fw-bold px-4" onclick="snapCameraPhoto()"><i class="fa-solid fa-circle-dot me-2"></i>Snap & Use Photo</button>
                </div>
            </div>
        </div>
    </div>

    <!-- INLINE GUARANTEED REAL-TIME AGE CALCULATOR SCRIPT -->
    <script>
        (function () {
            function getDob() {
                return document.getElementById('txtDOB') || document.querySelector('input[type="date"]') || document.querySelector('input[name*="DOB"]');
            }
            function getAge() {
                return document.getElementById('txtAge') || document.querySelector('input[name*="Age"]');
            }
            function doCalc() {
                var dobEl = getDob();
                var ageEl = getAge();
                if (!dobEl || !ageEl) return;
                var val = (dobEl.value || '').trim();
                if (!val) {
                    ageEl.value = '';
                    return;
                }
                var nums = val.match(/\d+/g);
                if (!nums || nums.length < 3) return;
                var n0 = parseInt(nums[0], 10);
                var n1 = parseInt(nums[1], 10);
                var n2 = parseInt(nums[2], 10);
                var y, m, d;
                if (n0 > 1000) {
                    y = n0; m = n1; d = n2;
                } else if (n2 > 1000) {
                    y = n2;
                    if (n0 > 12) { d = n0; m = n1; }
                    else if (n1 > 12) { d = n1; m = n0; }
                    else { d = n0; m = n1; }
                } else {
                    return;
                }
                if (isNaN(y) || isNaN(m) || isNaN(d) || y < 1900) return;
                var today = new Date();
                var years = today.getFullYear() - y;
                var months = (today.getMonth() + 1) - m;
                var days = today.getDate() - d;
                if (days < 0) months--;
                if (months < 0) { years--; months += 12; }

                var res = '';
                if (years < 0) res = 'Invalid Date';
                else if (years === 0) res = months > 0 ? (months + (months === 1 ? ' Month' : ' Months')) : 'Under 1 Month';
                else if (months > 0) res = years + (years === 1 ? ' Year ' : ' Years ') + months + (months === 1 ? ' Month' : ' Months');
                else res = years + (years === 1 ? ' Year' : ' Years');

                if (ageEl.value !== res) {
                    ageEl.value = res;
                    ageEl.setAttribute('value', res);
                }
            }

            window.calculateAge = doCalc;

            window.previewPhoto = function (input, imgPreviewId) {
                if (input && input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        var img = document.getElementById(imgPreviewId);
                        if (img) {
                            img.src = e.target.result;
                            img.style.display = 'block';
                        }
                        function setHidden(idKey, val) {
                            var h = document.getElementById(idKey) || document.querySelector('input[id*="' + idKey + '"]');
                            if (h) h.value = val;
                        }

                        if (imgPreviewId.includes('Father')) {
                            sessionStorage.setItem('rfidPhotoFather', e.target.result);
                            setHidden('hidFatherPhotoData', e.target.result);
                        }
                        if (imgPreviewId.includes('Mother')) {
                            sessionStorage.setItem('rfidPhotoMother', e.target.result);
                            setHidden('hidMotherPhotoData', e.target.result);
                        }
                        if (imgPreviewId.includes('Guardian1')) {
                            sessionStorage.setItem('rfidPhotoG1', e.target.result);
                            setHidden('hidGuardian1PhotoData', e.target.result);
                        }
                        if (imgPreviewId.includes('Guardian2')) {
                            sessionStorage.setItem('rfidPhotoG2', e.target.result);
                            setHidden('hidGuardian2PhotoData', e.target.result);
                        }
                        if (imgPreviewId.includes('PhotoPreview') && !imgPreviewId.includes('Father') && !imgPreviewId.includes('Mother') && !imgPreviewId.includes('Guardian')) {
                            sessionStorage.setItem('rfidPhotoStudent', e.target.result);
                        }
                    };
                    reader.readAsDataURL(input.files[0]);
                }
            };

            document.addEventListener('change', function (e) {
                if (e.target && e.target.type === 'file' && e.target.files && e.target.files[0]) {
                    var id = e.target.id || '';
                    var name = e.target.name || '';
                    var targetImgId = null;
                    if (id.includes('filePhoto') || name.includes('filePhoto')) targetImgId = 'imgPhotoPreview';
                    if (id.includes('Father') || name.includes('Father')) targetImgId = 'imgFatherPhotoPreview';
                    if (id.includes('Mother') || name.includes('Mother')) targetImgId = 'imgMotherPhotoPreview';
                    if (id.includes('Guardian1') || name.includes('Guardian1')) targetImgId = 'imgGuardian1PhotoPreview';
                    if (id.includes('Guardian2') || name.includes('Guardian2')) targetImgId = 'imgGuardian2PhotoPreview';
                    if (targetImgId) {
                        window.previewPhoto(e.target, targetImgId);
                    }
                }
            });

            // Populate hidden photo fields before ANY submit (document submit + button click)
            function populatePhotoHiddenFields() {
                var fImg = document.getElementById('imgFatherPhotoPreview');
                var mImg = document.getElementById('imgMotherPhotoPreview');
                var g1Img = document.getElementById('imgGuardian1PhotoPreview');
                var g2Img = document.getElementById('imgGuardian2PhotoPreview');

                function isRealPhoto(src) {
                    return src && src.indexOf('data:image') === 0;
                }

                if (isRealPhoto(fImg && fImg.src)) {
                    sessionStorage.setItem('rfidPhotoFather', fImg.src);
                    var h = document.getElementById('hidFatherPhotoData'); if (h) h.value = fImg.src;
                }
                if (isRealPhoto(mImg && mImg.src)) {
                    sessionStorage.setItem('rfidPhotoMother', mImg.src);
                    var h = document.getElementById('hidMotherPhotoData'); if (h) h.value = mImg.src;
                }
                if (isRealPhoto(g1Img && g1Img.src)) {
                    sessionStorage.setItem('rfidPhotoG1', g1Img.src);
                    var h = document.getElementById('hidGuardian1PhotoData'); if (h) h.value = g1Img.src;
                }
                if (isRealPhoto(g2Img && g2Img.src)) {
                    sessionStorage.setItem('rfidPhotoG2', g2Img.src);
                    var h = document.getElementById('hidGuardian2PhotoData'); if (h) h.value = g2Img.src;
                }
            }

            // Fire on document submit
            document.addEventListener('submit', populatePhotoHiddenFields);

            // Also fire on submit button click (ASP.NET postback fires before submit event)
            var submitBtn = document.getElementById('btnSubmitAdmission');
            if (!submitBtn) submitBtn = document.querySelector('input[type="submit"], button[type="submit"]');
            if (submitBtn) {
                submitBtn.addEventListener('click', populatePhotoHiddenFields);
            }

            var activeTargetImgId = null;
            var activeTargetHidId = null;
            var activeStorageKey = null;
            var webcamStream = null;

            window.openCameraModal = function (imgId, hidId, storageKey) {
                activeTargetImgId = imgId;
                activeTargetHidId = hidId;
                activeStorageKey = storageKey;

                var modalEl = document.getElementById('cameraModal');
                if (modalEl && typeof bootstrap !== 'undefined') {
                    var modal = new bootstrap.Modal(modalEl);
                    modal.show();
                }

                if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
                    navigator.mediaDevices.getUserMedia({ video: { width: 300, height: 300, facingMode: 'user' } })
                        .then(function (stream) {
                            webcamStream = stream;
                            var video = document.getElementById('webcamVideo');
                            if (video) video.srcObject = stream;
                        })
                        .catch(function (err) {
                            alert('Unable to access camera: ' + (err.message || err) + '\nPlease check camera permissions or upload an image file.');
                        });
                } else {
                    alert('Camera capture is not supported in this browser version. Please upload an image file.');
                }
            };

            window.stopCamera = function () {
                if (webcamStream) {
                    webcamStream.getTracks().forEach(function (track) { track.stop(); });
                    webcamStream = null;
                }
            };

            window.snapCameraPhoto = function () {
                var video = document.getElementById('webcamVideo');
                var canvas = document.getElementById('webcamCanvas');
                if (!video || !canvas) return;

                canvas.width = 240;
                canvas.height = 240;
                var ctx = canvas.getContext('2d');
                ctx.drawImage(video, 0, 0, canvas.width, canvas.height);

                var dataUrl = canvas.toDataURL('image/jpeg', 0.85);

                if (activeTargetImgId) {
                    var img = document.getElementById(activeTargetImgId);
                    if (img) { img.src = dataUrl; img.style.display = 'block'; }
                }
                if (activeTargetHidId) {
                    var hid = document.getElementById(activeTargetHidId);
                    if (hid) hid.value = dataUrl;
                }
                if (activeStorageKey) {
                    sessionStorage.setItem(activeStorageKey, dataUrl);
                }

                window.stopCamera();
                var modalEl = document.getElementById('cameraModal');
                if (modalEl && typeof bootstrap !== 'undefined') {
                    var modal = bootstrap.Modal.getInstance(modalEl);
                    if (modal) modal.hide();
                }
            };

            window.loadSamplePhoto = function (imgId, hidId, storageKey, role) {
                var colors = {
                    'Father': '#1e40af',
                    'Mother': '#be185d',
                    'Guardian1': '#047857',
                    'Guardian2': '#6d28d9'
                };
                var bg = colors[role] || '#2563eb';
                var svg = `<svg xmlns="http://www.w3.org/2000/svg" width="200" height="200" viewBox="0 0 200 200">
                    <rect width="100%" height="100%" fill="${bg}"/>
                    <circle cx="100" cy="70" r="42" fill="#ffffff" opacity="0.9"/>
                    <path d="M25,195 C25,135 60,115 100,115 C140,115 175,135 175,195 Z" fill="#ffffff" opacity="0.9"/>
                    <text x="100" y="190" font-family="Arial, sans-serif" font-size="14" font-weight="bold" fill="${bg}" text-anchor="middle">${role.toUpperCase()} PHOTO</text>
                </svg>`;
                var dataUrl = 'data:image/svg+xml;utf8,' + encodeURIComponent(svg);

                var img = document.getElementById(imgId);
                if (img) { img.src = dataUrl; img.style.display = 'block'; }
                var hid = document.getElementById(hidId);
                if (hid) hid.value = dataUrl;
                sessionStorage.setItem(storageKey, dataUrl);
            };

            if (document.readyState === 'loading') {
                document.addEventListener('DOMContentLoaded', doCalc);
            } else {
                doCalc();
            }

            setInterval(doCalc, 100);
        })();
    </script>
</asp:Content>
