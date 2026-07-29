namespace AfterSchoolAdmission
{
    public partial class Admission
    {
        protected global::System.Web.UI.WebControls.Panel pnlAlert;
        protected global::System.Web.UI.WebControls.Literal litAlertMsg;
        protected global::System.Web.UI.WebControls.Panel pnlSuccess;
        protected global::System.Web.UI.WebControls.Literal litSuccessMsg;

        // Student Info & Photo (School Name, Standard & Where Coming From Added)
        protected global::System.Web.UI.WebControls.FileUpload filePhoto;
        protected global::System.Web.UI.WebControls.TextBox txtFullName;
        protected global::System.Web.UI.WebControls.DropDownList ddlGender;
        protected global::System.Web.UI.WebControls.TextBox txtDOB;
        protected global::System.Web.UI.WebControls.TextBox txtAge;
        protected global::System.Web.UI.WebControls.DropDownList ddlBloodGroup;
        protected global::System.Web.UI.WebControls.TextBox txtSchoolName;
        protected global::System.Web.UI.WebControls.TextBox txtStandard;
        protected global::System.Web.UI.WebControls.TextBox txtComingFrom;
        protected global::System.Web.UI.WebControls.TextBox txtAddress;

        // Father Details, Photo & Aadhaar
        protected global::System.Web.UI.WebControls.FileUpload fileFatherPhoto;
        protected global::System.Web.UI.WebControls.TextBox txtFatherName;
        protected global::System.Web.UI.WebControls.TextBox txtFatherAadhaar;
        protected global::System.Web.UI.WebControls.TextBox txtFatherMobile;
        protected global::System.Web.UI.WebControls.TextBox txtFatherWhatsApp;
        protected global::System.Web.UI.WebControls.TextBox txtFatherEmail;
        protected global::System.Web.UI.WebControls.TextBox txtFatherOccupation;
        protected global::System.Web.UI.WebControls.TextBox txtFatherOfficeAddress;

        // Mother Details, Photo & Aadhaar
        protected global::System.Web.UI.WebControls.FileUpload fileMotherPhoto;
        protected global::System.Web.UI.WebControls.TextBox txtMotherName;
        protected global::System.Web.UI.WebControls.TextBox txtMotherAadhaar;
        protected global::System.Web.UI.WebControls.TextBox txtMotherMobile;
        protected global::System.Web.UI.WebControls.TextBox txtMotherWhatsApp;
        protected global::System.Web.UI.WebControls.TextBox txtMotherEmail;
        protected global::System.Web.UI.WebControls.TextBox txtMotherOccupation;
        protected global::System.Web.UI.WebControls.TextBox txtMotherOfficeAddress;

        // Guardian 1 Details, Photo & Aadhaar
        protected global::System.Web.UI.WebControls.FileUpload fileGuardian1Photo;
        protected global::System.Web.UI.WebControls.TextBox txtGuardian1Name;
        protected global::System.Web.UI.WebControls.TextBox txtGuardian1Aadhaar;
        protected global::System.Web.UI.WebControls.TextBox txtGuardian1Rel;
        protected global::System.Web.UI.WebControls.TextBox txtGuardian1Mobile;
        protected global::System.Web.UI.WebControls.TextBox txtGuardian1WhatsApp;
        protected global::System.Web.UI.WebControls.TextBox txtGuardian1Email;
        protected global::System.Web.UI.WebControls.TextBox txtGuardian1Occupation;
        protected global::System.Web.UI.WebControls.TextBox txtGuardian1Address;

        // Guardian 2 Details, Photo & Aadhaar
        protected global::System.Web.UI.WebControls.FileUpload fileGuardian2Photo;
        protected global::System.Web.UI.WebControls.TextBox txtGuardian2Name;
        protected global::System.Web.UI.WebControls.TextBox txtGuardian2Aadhaar;
        protected global::System.Web.UI.WebControls.TextBox txtGuardian2Rel;
        protected global::System.Web.UI.WebControls.TextBox txtGuardian2Mobile;
        protected global::System.Web.UI.WebControls.TextBox txtGuardian2WhatsApp;
        protected global::System.Web.UI.WebControls.TextBox txtGuardian2Email;
        protected global::System.Web.UI.WebControls.TextBox txtGuardian2Occupation;
        protected global::System.Web.UI.WebControls.TextBox txtGuardian2Address;

        // Submit Button
        protected global::System.Web.UI.WebControls.Button btnSubmitAdmission;
    }
}
