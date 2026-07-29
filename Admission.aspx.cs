using System;
using System.IO;
using System.Web;
using System.Web.UI;
using AfterSchoolAdmission.DAL;

namespace AfterSchoolAdmission
{
    public partial class Admission : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
            }
        }

        protected void btnSubmitAdmission_Click(object sender, EventArgs e)
        {
            try
            {
                // Photo upload helper
                string saveFolder = Server.MapPath("~/Images/Students/");
                if (!Directory.Exists(saveFolder))
                {
                    Directory.CreateDirectory(saveFolder);
                }

                string studentPhoto = SaveUploadedPhoto(filePhoto, saveFolder, "student");
                string fatherPhoto = SaveUploadedPhoto(fileFatherPhoto, saveFolder, "father");
                string motherPhoto = SaveUploadedPhoto(fileMotherPhoto, saveFolder, "mother");
                string g1Photo = SaveUploadedPhoto(fileGuardian1Photo, saveFolder, "g1");
                string g2Photo = SaveUploadedPhoto(fileGuardian2Photo, saveFolder, "g2");

                // Data extraction
                string fullName = txtFullName.Text.Trim();
                string gender = ddlGender.SelectedValue;
                DateTime dob = Convert.ToDateTime(txtDOB.Text);
                string bloodGroup = ddlBloodGroup.SelectedValue;
                string schoolName = txtSchoolName.Text.Trim();
                string standard = txtStandard.Text.Trim();
                string comingFrom = txtComingFrom.Text.Trim();
                string address = txtAddress.Text.Trim();

                string fatherName = txtFatherName.Text.Trim();
                string fatherAadhaar = txtFatherAadhaar.Text.Trim();
                string fatherMobile = txtFatherMobile.Text.Trim();
                string fatherWhatsApp = txtFatherWhatsApp.Text.Trim();
                string fatherEmail = txtFatherEmail.Text.Trim();
                string fatherOcc = txtFatherOccupation.Text.Trim();
                string fatherOffice = txtFatherOfficeAddress.Text.Trim();

                string motherName = txtMotherName.Text.Trim();
                string motherAadhaar = txtMotherAadhaar.Text.Trim();
                string motherMobile = txtMotherMobile.Text.Trim();
                string motherWhatsApp = txtMotherWhatsApp.Text.Trim();
                string motherEmail = txtMotherEmail.Text.Trim();
                string motherOcc = txtMotherOccupation.Text.Trim();
                string motherOffice = txtMotherOfficeAddress.Text.Trim();

                // Guardian 1 & Guardian 2
                string g1Name = txtGuardian1Name.Text.Trim();
                string g1Aadhaar = txtGuardian1Aadhaar.Text.Trim();
                string g1Rel = txtGuardian1Rel.Text.Trim();
                string g1Mobile = txtGuardian1Mobile.Text.Trim();

                string g2Name = txtGuardian2Name.Text.Trim();
                string g2Aadhaar = txtGuardian2Aadhaar.Text.Trim();
                string g2Rel = txtGuardian2Rel.Text.Trim();
                string g2Mobile = txtGuardian2Mobile.Text.Trim();

                string parentSig = fatherName;
                string staffSig = "Authorized Staff Member";

                // Server Auto Generated Admission & Fee Defaults
                StudentDAL dal = new StudentDAL();
                string admissionNo = dal.GenerateAdmissionNumber();
                string receiptNo = "REC-" + DateTime.Now.Year + "-" + new Random().Next(10000, 99999);
                string academicYear = "2026-2027";
                string programType = "Play School";

                decimal admissionFee = 1500.00m;
                decimal monthlyFee = 2500.00m;
                decimal discount = 0.00m;
                decimal totalAmount = 4000.00m;
                decimal amountPaid = 4000.00m;

                int newStudentId, newAdmissionId;

                bool success = dal.SaveAdmission(
                    admissionNo, fullName, gender, dob, bloodGroup, schoolName, standard, address, studentPhoto,
                    fatherName, fatherMobile, fatherWhatsApp, fatherEmail, fatherOcc, fatherOffice,
                    motherName, motherMobile, motherWhatsApp, motherEmail, motherOcc, motherOffice,
                    g1Name, g1Rel, g1Mobile, address,
                    fatherName, "Father", fatherMobile, "Doctor", "108", "None", "None",
                    fatherName, "4:30 PM", motherName, "ID12345",
                    academicYear, programType, parentSig, staffSig,
                    admissionFee, monthlyFee, discount, totalAmount, amountPaid, "Direct", receiptNo,
                    out newStudentId, out newAdmissionId
                );

                // Build clean redirect URL with full student and parent parameters
                string redirectUrl = "PublicReceipt.aspx?rec=" + HttpUtility.UrlEncode(receiptNo)
                    + "&sName=" + HttpUtility.UrlEncode(fullName)
                    + "&admNo=" + HttpUtility.UrlEncode(admissionNo)
                    + "&gender=" + HttpUtility.UrlEncode(gender)
                    + "&dob=" + HttpUtility.UrlEncode(dob.ToString("yyyy-MM-dd"))
                    + "&bg=" + HttpUtility.UrlEncode(bloodGroup)
                    + "&school=" + HttpUtility.UrlEncode(schoolName)
                    + "&std=" + HttpUtility.UrlEncode(standard)
                    + "&route=" + HttpUtility.UrlEncode(comingFrom)
                    + "&addr=" + HttpUtility.UrlEncode(address)
                    + "&fName=" + HttpUtility.UrlEncode(fatherName)
                    + "&fAadhaar=" + HttpUtility.UrlEncode(fatherAadhaar)
                    + "&fMobile=" + HttpUtility.UrlEncode(fatherMobile)
                    + "&fWA=" + HttpUtility.UrlEncode(fatherWhatsApp)
                    + "&fEmail=" + HttpUtility.UrlEncode(fatherEmail)
                    + "&mName=" + HttpUtility.UrlEncode(motherName)
                    + "&mAadhaar=" + HttpUtility.UrlEncode(motherAadhaar)
                    + "&mMobile=" + HttpUtility.UrlEncode(motherMobile)
                    + "&mWA=" + HttpUtility.UrlEncode(motherWhatsApp)
                    + "&mEmail=" + HttpUtility.UrlEncode(motherEmail)
                    + "&g1Name=" + HttpUtility.UrlEncode(g1Name)
                    + "&g1Rel=" + HttpUtility.UrlEncode(g1Rel)
                    + "&g1Aadhaar=" + HttpUtility.UrlEncode(g1Aadhaar)
                    + "&g1Mobile=" + HttpUtility.UrlEncode(g1Mobile)
                    + "&g2Name=" + HttpUtility.UrlEncode(g2Name)
                    + "&g2Rel=" + HttpUtility.UrlEncode(g2Rel)
                    + "&g2Aadhaar=" + HttpUtility.UrlEncode(g2Aadhaar)
                    + "&g2Mobile=" + HttpUtility.UrlEncode(g2Mobile);

                Response.Redirect(redirectUrl);
            }
            catch (Exception ex)
            {
                pnlSuccess.Visible = false;
                litAlertMsg.Text = "An error occurred: " + ex.Message;
                pnlAlert.Visible = true;
            }
        }

        private string SaveUploadedPhoto(global::System.Web.UI.WebControls.FileUpload fileUpload, string folderPath, string prefix)
        {
            if (fileUpload != null && fileUpload.HasFile)
            {
                string extension = Path.GetExtension(fileUpload.FileName).ToLower();
                if (extension == ".jpg" || extension == ".jpeg" || extension == ".png" || extension == ".webp")
                {
                    string fileName = prefix + "_" + DateTime.Now.Ticks + extension;
                    string fullPath = Path.Combine(folderPath, fileName);
                    fileUpload.SaveAs(fullPath);
                    return "/Images/Students/" + fileName;
                }
            }
            return "/Images/Students/default-avatar.png";
        }
    }
}
