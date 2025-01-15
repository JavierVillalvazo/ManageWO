using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ManageWO
{
    public partial class SearchAlternsWO : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CancelBtn.Visible = false;
                BindGridView();
                Thread.Sleep(3000);
                filterText.Enabled = true;
                filterText.Text = Session["Workorder"].ToString();
                QueryBtn.Visible = false;
                SearchBtn.Visible = true;
                SearchBtn.Enabled = true;
                SearchBtn_Click(this, null);
            }
            //datafilter();
        }

        protected void CancelBtn_Click(object sender, EventArgs e)
        {
            filterText.BackColor = System.Drawing.Color.White;
            filterText.Enabled = false;
            SearchBtn.Visible = false;
            RefreshBtn.Visible = true;
            QueryBtn.Visible = true;
            CancelBtn.Visible = false;
            alert.Visible = true;
            AlertIcon.Attributes.Add("class", "bi bi-exclamation-diamond");
            alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
            alertText.Text = "Query cancelled";
            ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",3000)</script>");
        }

        protected void QueryBtn_Click(object sender, EventArgs e)
        {
            filterText.BackColor = System.Drawing.Color.LightYellow;
            filterText.Enabled = true;
            filterText.Focus();
            SearchBtn.Visible = true;
            RefreshBtn.Visible = false;
            QueryBtn.Visible = false;
            CancelBtn.Visible = true;
            alert.Visible = true;
            alert.Visible = true;

            AlertIcon.Attributes.Add("class", "bi bi-database-fill");
            alert.Attributes.Add("class", " alert alert-info  alert-dismissible ");
            alertText.Text = "Query enabled: Search by work order or model";
            ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",3000)</script>");
        }

        protected void filterText_TextChanged(object sender, EventArgs e)
        {
            DataFilter();
        }

        protected void SearchBtn_Click(object sender, EventArgs e)
        {
            DataFilter();
        }

        protected void RefreshBtn_Click(object sender, EventArgs e)
        {
            filterText.Enabled = false;
            SearchBtn.Visible = false;
            RefreshBtn.Visible = true;
            QueryBtn.Visible = true;

            BindGridView();
            alert.Visible = true;
            AlertIcon.Attributes.Add("class", "bi bi-list-check");
            alert.Attributes.Add("class", " alert alert-primary  alert-dismissible ");
            alertText.Text = "Updated succesfully";
            ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",3000)</script>");
        }

        protected void myTable_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.Cells[0].Text = "ID";
                e.Row.Cells[1].Text = "Work Order";
                e.Row.Cells[2].Text = "Kitting Note";
                e.Row.Cells[3].Text = "Model";
                e.Row.Cells[4].Text = "Original ";
                e.Row.Cells[5].Text = "Altern";
                e.Row.Cells[6].Text = "ECN";

            }
        }

        protected void myTable_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            myTable.PageIndex = e.NewPageIndex;
            BindGridView();
            alert.Visible = true;
            AlertIcon.Attributes.Add("class", " bi bi-info-circle-fill");
            alert.Attributes.Add("class", " alert alert-info  alert-dismissible ");
            alertText.Text = "Selected succesfully";
            ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",2000)</script>");
        }

        protected void btnExcel_Click(object sender, EventArgs e)
        {

        }


        private void BindGridView()
        {

            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["smt"].ConnectionString))
            {
                SqlCommand sqlCommand = new SqlCommand("GetWOAlterns", connection);
                sqlCommand.CommandType = CommandType.StoredProcedure;
                connection.Open();
                SqlDataAdapter adapter = new SqlDataAdapter(sqlCommand);
                DataSet data = new DataSet();
                adapter.Fill(data);
                if (data.Tables.Count > 0)
                {
                    myTable.DataSource = data.Tables[0];
                    myTable.AllowPaging = true;
                    myTable.DataBind();
                    connection.Close();
                    //AlertIcon.Attributes.Add("class", "bi bi-clipboard2-data");
                    //alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
                    //alertText.Text = "Query Executed Succesfully ";
                    //ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",2500)</script>");
                }
                else
                {
                    alert.Visible = true;
                    AlertIcon.Attributes.Add("class", " bi bi-exclamation-octagon");
                    alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
                    alertText.Text = "Data Not Found";
                    ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",5000)</script>");
                }

            }

            SearchBtn.Visible = false;
            QueryBtn.Visible = true;
            CancelBtn.Visible = false;
            filterText.Enabled = false;

            //footer.Text = Convert.ToString(DateTime.Now);

        }

        public void DataFilter()
        {
            using (SqlConnection connection1 = new SqlConnection(ConfigurationManager.ConnectionStrings["smt"].ConnectionString))
            {
                SqlCommand sqlCommand1 = new SqlCommand("GetWOAlternsLike", connection1);
                sqlCommand1.CommandType = CommandType.StoredProcedure;
                connection1.Open();
                sqlCommand1.Parameters.Add("@data", SqlDbType.VarChar, 100).Value = filterText.Text;
                SqlDataAdapter adapter1 = new SqlDataAdapter(sqlCommand1);
                DataSet data1 = new DataSet();
                adapter1.Fill(data1);
                if (data1.Tables.Count > 0)
                {
                    myTable.DataSource = data1.Tables[0];
                    myTable.AllowPaging = true;
                    myTable.DataBind();
                    connection1.Close();
                    /*IF DATA IS AVAILABLE*/
                    QueryBtn.Visible = false;
                    RefreshBtn.Visible = false;
                    SearchBtn.Visible = true;
                    CancelBtn.Visible = true;
                    AlertIcon.Attributes.Add("class", "bi bi-clipboard2-data");
                    alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
                    alertText.Text = "Query executed succesfully ";
                    ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",2500)</script>");
                }
                else
                {
                    alert.Visible = true;
                    AlertIcon.Attributes.Add("class", " bi bi-exclamation-octagon");
                    alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
                    alertText.Text = "Data not found, try again";
                    ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",5000)</script>");
                }

            }
        }
    }
}