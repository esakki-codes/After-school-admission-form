using System;
using System.Data;
using System.IO;
using System.Web.UI;
using AfterSchoolAdmission.DAL;

namespace AfterSchoolAdmission
{
    public partial class EditStudent : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    int studentId = Convert.ToInt32(Request.QueryString["id"]);
                    hfStudentID.Value = studentId.ToString();
                    LoadStudent(studentId);
                }
                else
                {
                    Response.Redirect("StudentList.aspx");
                }
            }
        }

        private void LoadStudent(int studentId)
        {
            StudentDAL dal = new StudentDAL();
            DataTable dt = dal.GetStudentDetails(studentId);

            if (dt != null && dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                txtAdmissionNo.Text = dr["AdmissionNo"].ToString();
                txtFullName.Text = dr["FullName"].ToString();
                ddlGender.SelectedValue = dr["Gender"].ToString();
                txtDOB.Text = Convert.ToDateTime(dr["DateOfBirth"]).ToString("yyyy-MM-dd");
                if (ddlBloodGroup.Items.FindByValue(dr["BloodGroup"].ToString()) != null)
                {
                    ddlBloodGroup.SelectedValue = dr["BloodGroup"].ToString();
                }
                txtSchoolName.Text = dr["SchoolName"].ToString();
                txtStandard.Text = dr["Standard"].ToString();
                txtAddress.Text = dr["Address"].ToString();
                imgStudentPhoto.ImageUrl = dr["PhotoPath"].ToString();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                int studentId = Convert.ToInt32(hfStudentID.Value);
                string newPhotoPath = null;

                if (filePhoto.HasFile)
                {
                    string extension = Path.GetExtension(filePhoto.FileName).ToLower();
                    string fileName = "student_" + DateTime.Now.Ticks + extension;
                    string saveFolder = Server.MapPath("~/Images/Students/");
                    if (!Directory.Exists(saveFolder))
                    {
                        Directory.CreateDirectory(saveFolder);
                    }
                    filePhoto.SaveAs(Path.Combine(saveFolder, fileName));
                    newPhotoPath = "/Images/Students/" + fileName;
                }

                string fullName = txtFullName.Text.Trim();
                string gender = ddlGender.SelectedValue;
                DateTime dob = Convert.ToDateTime(txtDOB.Text);
                string bloodGroup = ddlBloodGroup.SelectedValue;
                string schoolName = txtSchoolName.Text.Trim();
                string standard = txtStandard.Text.Trim();
                string address = txtAddress.Text.Trim();

                StudentDAL dal = new StudentDAL();
                bool success = dal.UpdateStudent(studentId, fullName, gender, dob, bloodGroup, schoolName, standard, address, newPhotoPath);

                if (success)
                {
                    pnlAlert.Visible = false;
                    litSuccessMsg.Text = "Student details updated successfully!";
                    pnlSuccess.Visible = true;
                    LoadStudent(studentId);
                }
                else
                {
                    pnlSuccess.Visible = false;
                    litAlertMsg.Text = "Failed to update student details.";
                    pnlAlert.Visible = true;
                }
            }
            catch (Exception ex)
            {
                pnlSuccess.Visible = false;
                litAlertMsg.Text = "Error: " + ex.Message;
                pnlAlert.Visible = true;
            }
        }
    }
}
