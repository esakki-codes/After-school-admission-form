using System;
using System.Data;
using System.Web.UI;
using AfterSchoolAdmission.DAL;

namespace AfterSchoolAdmission
{
    public partial class Reports : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStudentListReport();
            }
        }

        private void LoadStudentListReport()
        {
            litReportTitle.Text = "Master Student Enrollment List";
            ReportDAL dal = new ReportDAL();
            DataTable dt = dal.GetStudentListReport();
            gvReportData.DataSource = dt;
            gvReportData.DataBind();
        }

        protected void btnRptStudentList_Click(object sender, EventArgs e)
        {
            LoadStudentListReport();
        }

        protected void btnRptAdmission_Click(object sender, EventArgs e)
        {
            litReportTitle.Text = "Comprehensive Admission Audit Report";
            ReportDAL dal = new ReportDAL();
            DataTable dt = dal.GetAdmissionReport();
            gvReportData.DataSource = dt;
            gvReportData.DataBind();
        }

        protected void btnRptFee_Click(object sender, EventArgs e)
        {
            litReportTitle.Text = "Fee Collection & Transactions Audit";
            ReportDAL dal = new ReportDAL();
            DataTable dt = dal.GetFeeCollectionReport();
            gvReportData.DataSource = dt;
            gvReportData.DataBind();
        }

        protected void btnRptParent_Click(object sender, EventArgs e)
        {
            litReportTitle.Text = "Parent & Emergency Contact Directory";
            ReportDAL dal = new ReportDAL();
            DataTable dt = dal.GetParentContactReport();
            gvReportData.DataSource = dt;
            gvReportData.DataBind();
        }

        protected void btnRptAttendance_Click(object sender, EventArgs e)
        {
            litReportTitle.Text = "Monthly Attendance Aggregate Summary";
            AttendanceDAL dal = new AttendanceDAL();
            DataTable dt = dal.GetMonthlyAttendanceReport(DateTime.Now.Month, DateTime.Now.Year);
            gvReportData.DataSource = dt;
            gvReportData.DataBind();
        }

        protected void btnRptDaily_Click(object sender, EventArgs e)
        {
            litReportTitle.Text = "Today's New Admissions Summary (" + DateTime.Now.ToString("yyyy-MM-dd") + ")";
            ReportDAL dal = new ReportDAL();
            DataTable dt = dal.GetAdmissionReport(DateTime.Today, DateTime.Today);
            gvReportData.DataSource = dt;
            gvReportData.DataBind();
        }
    }
}
