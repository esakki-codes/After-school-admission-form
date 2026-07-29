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
                    <asp:TextBox ID="txtDOB" runat="server" ClientIDMode="Static" TextMode="Date" CssClass="form-control-custom" required="true"></asp:TextBox>
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
                            <img id="imgPhotoPreview" src="Images/Students/default-avatar.png" alt="Student Preview" style="object-fit: cover; width: 100%; height: 100%; border-radius: 0.9rem;" />
                        </div>
                        <div class="flex-grow-1">
                            <asp:FileUpload ID="filePhoto" runat="server" ClientIDMode="Static" CssClass="form-control-custom" accept="image/*" />
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
                            <label class="form-label-custom mb-2">Father Photo Upload</label>
                            <div class="d-flex align-items-center gap-3">
                                <div style="width: 80px; height: 80px; border-radius: 0.75rem; overflow: hidden; background: #1c2541;">
                                    <img id="imgFatherPhotoPreview" src="Images/Students/default-avatar.png" alt="Father Preview" style="object-fit: cover; width: 100%; height: 100%;" />
                                </div>
                                <div class="flex-grow-1">
                                    <asp:FileUpload ID="fileFatherPhoto" runat="server" ClientIDMode="Static" CssClass="form-control-custom" accept="image/*" />
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
                            <label class="form-label-custom mb-2">Mother Photo Upload</label>
                            <div class="d-flex align-items-center gap-3">
                                <div style="width: 80px; height: 80px; border-radius: 0.75rem; overflow: hidden; background: #1c2541;">
                                    <img id="imgMotherPhotoPreview" src="Images/Students/default-avatar.png" alt="Mother Preview" style="object-fit: cover; width: 100%; height: 100%;" />
                                </div>
                                <div class="flex-grow-1">
                                    <asp:FileUpload ID="fileMotherPhoto" runat="server" ClientIDMode="Static" CssClass="form-control-custom" accept="image/*" />
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
                <h5 class="fw-bold text-info mb-3"><i class="fa-solid fa-shield-halved me-2"></i>Guardian 1 Information</h5>
                <div class="row g-4">
                    <div class="col-md-12">
                        <div class="p-3 rounded mb-2" style="background: #0b132b; border: 1px dashed #38bdf8;">
                            <label class="form-label-custom mb-2">Guardian 1 Photo Upload</label>
                            <div class="d-flex align-items-center gap-3">
                                <div style="width: 80px; height: 80px; border-radius: 0.75rem; overflow: hidden; background: #1c2541;">
                                    <img id="imgGuardian1PhotoPreview" src="Images/Students/default-avatar.png" alt="Guardian 1 Preview" style="object-fit: cover; width: 100%; height: 100%;" />
                                </div>
                                <div class="flex-grow-1">
                                    <asp:FileUpload ID="fileGuardian1Photo" runat="server" ClientIDMode="Static" CssClass="form-control-custom" accept="image/*" />
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
                            <label class="form-label-custom mb-2">Guardian 2 Photo Upload</label>
                            <div class="d-flex align-items-center gap-3">
                                <div style="width: 80px; height: 80px; border-radius: 0.75rem; overflow: hidden; background: #1c2541;">
                                    <img id="imgGuardian2PhotoPreview" src="Images/Students/default-avatar.png" alt="Guardian 2 Preview" style="object-fit: cover; width: 100%; height: 100%;" />
                                </div>
                                <div class="flex-grow-1">
                                    <asp:FileUpload ID="fileGuardian2Photo" runat="server" ClientIDMode="Static" CssClass="form-control-custom" accept="image/*" />
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

            <!-- SUBMIT BUTTON -->
            <div class="d-flex justify-content-end gap-3 border-top border-secondary pt-4 mt-4">
                <asp:Button ID="btnSubmitAdmission" runat="server" Text="Submit Application & Generate Receipt" OnClick="btnSubmitAdmission_Click" CssClass="btn btn-primary-blue" />
            </div>
        </div>

    </div>
</asp:Content>
