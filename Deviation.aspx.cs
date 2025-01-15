using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ManageWO
{
    public partial class Deviation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SearchBtn.Visible = false;
            //SaveBtn.Visible = false;
            CancelBtn.Visible = false;
            QueryBtn.Visible = true;
            RefreshBtn.Visible = true;
            //UpdateBtn.Visible = false;
            BindGridView();
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
            filterText.Text = string.Empty;

        }

        protected void QueryBtn_Click(object sender, EventArgs e)
        {
            filterText.Text = string.Empty;

            filterText.BackColor = System.Drawing.Color.LightYellow;
            filterText.Enabled = true;
            filterText.Focus();
            SearchBtn.Visible = true;
            RefreshBtn.Visible = false;
            QueryBtn.Visible = false;
            CancelBtn.Visible = true;
            //SaveBtn.Visible = false;
            alert.Visible = true;
            //UpdateBtn.Visible = false;
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



        protected void DownloadFile(object sender, EventArgs e)
        {
            try
            {

                int id = int.Parse((sender as LinkButton).CommandArgument);
                byte[] bytes;
                string fileName, contentType;
                string query = "SELECT filename, Data, ContentType FROM deviationSMT WHERE Id=@Id";
                string constr = ConfigurationManager.ConnectionStrings["dbFiles"].ConnectionString;
                using (SqlConnection con = new SqlConnection(constr))
                {
                    using (SqlCommand cmd = new SqlCommand(query))
                    {
                        cmd.Parameters.AddWithValue("@Id", id);
                        cmd.Connection = con;
                        con.Open();
                        using (SqlDataReader sdr = cmd.ExecuteReader())
                        {
                            sdr.Read();
                            bytes = (byte[])sdr["Data"];
                            contentType = sdr["ContentType"].ToString();
                            fileName = sdr["filename"].ToString();
                        }
                        con.Close();
                    }
                }
                Response.Clear();
                Response.Buffer = true;
                Response.Charset = "";
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.ContentType = contentType;
                Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName);
                Response.BinaryWrite(bytes);
                Response.Flush();
                Response.End();
            }
            catch (Exception _e)
            {
                alert.Visible = true;
                AlertIcon.Attributes.Add("class", " bi bi-info-circle-fill");
                alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
                alertText.Text = "Something went wrong: " + _e.Message;
                ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",4000)</script>");
            }
        }
        protected void RefreshBtn_Click(object sender, EventArgs e)
        {
            filterText.Enabled = false;
            //SaveBtn.Visible = false;
            SearchBtn.Visible = false;
            RefreshBtn.Visible = true;
            QueryBtn.Visible = true;
            //UpdateBtn.Visible = false;
            filterText.Text = string.Empty;

            BindGridView();
            alert.Visible = true;
            AlertIcon.Attributes.Add("class", "bi bi-list-check");
            alert.Attributes.Add("class", " alert alert-primary  alert-dismissible ");
            alertText.Text = "Updated succesfully";
            ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",3000)</script>");

        }

        protected void myTable_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

        }

        protected void myTable_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.Cells[0].Text = "ID";
                e.Row.Cells[1].Text = "WorkOrder";
                e.Row.Cells[2].Text = "Model";
                e.Row.Cells[3].Text = "Quantity";
                e.Row.Cells[4].Text = "File Name";
                e.Row.Cells[5].Text = "Uploaded at";
                e.Row.Cells[6].Text = "Download PDF";
            }
        }

        protected void myTable_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }


        private void BindGridView()
        {
            string query = "SELECT top(30) Id, WorkOrder,model, quantity, uploadedDate,filename FROM deviationSMT order by WorkOrder desc";
            string constr = ConfigurationManager.ConnectionStrings["dbFiles"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    cmd.Connection = con;
                    con.Open();
                    myTable.DataSource = cmd.ExecuteReader();
                    myTable.DataBind();
                    con.Close();
                }
            }
        }



        public void DataFilter()
        {
            using (SqlConnection connection1 = new SqlConnection(ConfigurationManager.ConnectionStrings["dbFiles"].ConnectionString))
            {
                SqlCommand sqlCommand1 = new SqlCommand("GetdeviationFilter", connection1);
                sqlCommand1.CommandType = CommandType.StoredProcedure;
                connection1.Open();
                sqlCommand1.Parameters.Add("@data", SqlDbType.VarChar, 100).Value = filterText.Text;
                SqlDataAdapter adapter1 = new SqlDataAdapter(sqlCommand1);
                DataSet data1 = new DataSet();
                adapter1.Fill(data1);
                if (data1.Tables.Count > 0)
                {
                    myTable.DataSource = data1.Tables[0];
                    myTable.DataBind();
                    connection1.Close();
                    /*IF DATA IS AVAILABLE*/
                    //SaveBtn.Visible = false;
                    QueryBtn.Visible = false;
                    RefreshBtn.Visible = false;
                    SearchBtn.Visible = true;
                    CancelBtn.Visible = true;
                    //UpdateBtn.Visible = false;

                    AlertIcon.Attributes.Add("class", "bi bi-clipboard2-data");
                    alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
                    alertText.Text = "Query executed succesfully ";
                    ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",2500)</script>");
                    filterText.Text = string.Empty;
                }
                else
                {
                    alert.Visible = true;
                    AlertIcon.Attributes.Add("class", " bi bi-exclamation-octagon");
                    alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
                    alertText.Text = "Data not found, try again";
                    ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",5000)</script>");
                    filterText.Text = string.Empty;

                }

            }
        }
    }
}