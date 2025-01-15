using DocumentFormat.OpenXml.Drawing.Diagrams;
using DocumentFormat.OpenXml.Office.Word;
using DocumentFormat.OpenXml.VariantTypes;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace ManageWO
{
    public partial class OpenOrders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                NewBtn.Visible = true;
                SaveBtn.Visible = false;
                UpdateBtn.Visible = false;
                AbortBtn.Visible = false;
                btnRefresh.Visible = false;
                DisableFields();
                table.DataBind();

            }
        }


        protected void RegresarBtn_Click(object sender, EventArgs e)
        {
        }

        protected void logoutBtn_Click(object sender, EventArgs e)
        {
        }


        protected void txtPastDue_TextChanged(object sender, EventArgs e)
        {
        }

        protected void NewBtn_Click(object sender, EventArgs e)
        {
            SaveBtn.Visible = true;
            EnableFields();
            AbortBtn.Visible = true;
            txtDate.Focus();
            NewBtn.Visible = false;
            UpdateBtn.Visible = false;
            table.DataBind();
            alert.Visible = true;
            AlertIcon.Attributes.Add("class", "bi bi-file-earmark-plus");
            alert.Attributes.Add("class", " alert alert-info  alert-dismissible");
            alertText.Text = "Create a new open order";
            ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",4000)</script>");


        }
        private void EnableFields()
        {
            txtDate.Enabled = true;
            txtOntime.Enabled = true;
            txtPastDue.Enabled = true;
            txtWeekNo.Enabled = true;
            txtWrongDate.Enabled = true;
            //txtBalanceToBuild.Enabled = true;
        }
        private void DisableFields()
        {
            txtDate.Enabled = false;
            txtOntime.Enabled = false;
            txtPastDue.Enabled = false;
            txtWeekNo.Enabled = false;
            txtWrongDate.Enabled = false;
            txtBalanceToBuild.Enabled = false;
        }

        private void CleanFields()
        {
            txtDate.Text = string.Empty;
            txtOntime.Text = string.Empty;
            txtPastDue.Text = string.Empty;
            txtWeekNo.Text = string.Empty;
            txtWrongDate.Text = string.Empty;
            txtBalanceToBuild.Text = string.Empty;
            inputID.Text = string.Empty;
        }
        protected void SaveBtn_Click(object sender, EventArgs e)
        {
            string con = ConfigurationManager.ConnectionStrings["mmc"].ConnectionString;
            string date = txtDate.Text;
            int weekNo = Convert.ToInt32(txtWeekNo.Text);
            int onTime = Convert.ToInt32(txtOntime.Text);
            int wrongDate = Convert.ToInt32(txtWrongDate.Text);
            int pastDue = Convert.ToInt32(txtPastDue.Text);

            //int wrongDate = Convert.ToInt32(txtWrongDate.Text);
            SqlConnection conn = new SqlConnection(con);
            SqlCommand cmd = new SqlCommand("AddOpenOrder", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            conn.Open();
            cmd.Parameters.Add("@Date", SqlDbType.Date).Value = date;
            cmd.Parameters.Add("@onTime", SqlDbType.Int).Value = onTime;
            cmd.Parameters.Add("@wrongDate", SqlDbType.Int).Value = wrongDate;
            cmd.Parameters.Add("@pastDue", SqlDbType.Int).Value = pastDue;
            cmd.Parameters.Add("@weekNo", SqlDbType.Int).Value = weekNo;
            cmd.Parameters.Add("@balanceToBuild", SqlDbType.Int).Value = onTime + wrongDate + pastDue;
            SqlDataReader sqlDataReader = cmd.ExecuteReader();
            sqlDataReader.Read();
            int result = sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("rowAffected"));
            conn.Close();
            if (result == 1)
            {

                alert.Visible = true;
                AlertIcon.Attributes.Add("class", " bi bi-database-check");
                alert.Attributes.Add("class", " alert alert-success  alert-dismissible");
                alertText.Text = "Saved Succesfully";
                ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",4000)</script>");
                DisableFields();
            }
            else
            {
                alert.Visible = true;
                AlertIcon.Attributes.Add("class", " bi bi-database-x");
                alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
                alertText.Text = "Something went wrong; it was not possible to save this order... please ask for support";
                ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",4000)</script>");



            }
            SaveBtn.Visible = false;
            NewBtn.Visible = true;
            UpdateBtn.Visible = false;
            AbortBtn.Visible = false;
            btnRefresh.Visible = false;
            table.DataBind();
            CleanFields();
        }

        protected void DeleteBtn_Click(object sender, EventArgs e)
        {
        }

        protected void ClearBtn_Click(object sender, EventArgs e)
        {
        }

        protected void EditBtn_Click(object sender, EventArgs e)
        {

        }

        protected void UpdateBtn_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["mmc"].ConnectionString;
            int ID = Convert.ToInt32(inputID.Text);
            string date = txtDate.Text;
            int weekNo = Convert.ToInt32(txtWeekNo.Text);
            int onTime = Convert.ToInt32(txtOntime.Text);
            int wrongDate = Convert.ToInt32(txtWrongDate.Text);
            int pastDue = Convert.ToInt32(txtPastDue.Text);
            SqlConnection connection = new SqlConnection(connectionString);
            SqlCommand sqlCommand4 = new SqlCommand("EditOpenOrder", connection);
            sqlCommand4.CommandType = CommandType.StoredProcedure;
            connection.Open();
            sqlCommand4.Parameters.Add("@ID", SqlDbType.Int).Value = ID;
            sqlCommand4.Parameters.Add("@Date", SqlDbType.Date).Value = date;
            sqlCommand4.Parameters.Add("@onTime", SqlDbType.Int).Value = onTime;
            sqlCommand4.Parameters.Add("@wrongDate", SqlDbType.Int).Value = wrongDate;
            sqlCommand4.Parameters.Add("@pastDue", SqlDbType.Int).Value = pastDue;
            sqlCommand4.Parameters.Add("@weekNo", SqlDbType.Int).Value = weekNo;
            sqlCommand4.Parameters.Add("@balanceToBuild", SqlDbType.Int).Value = onTime + wrongDate + pastDue;
            SqlDataReader reader = sqlCommand4.ExecuteReader();
            reader.Read();
            int row = reader.GetInt32(reader.GetOrdinal("rowAffected"));
            connection.Close();
            if (row == 1)
            {
                alert.Visible = true;
                AlertIcon.Attributes.Add("class", "bi bi-check2-circle");
                alert.Attributes.Add("class", " alert alert-success  alert-dismissible ");
                alertText.Text = "Open Order updated Succesfully";
                ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",4000)</script>");
            }
            else
            {
                alert.Visible = true;
                AlertIcon.Attributes.Add("class", "bi bi-bug-fill");
                alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
                alertText.Text = "Something went wrong, please contact IT dept";
                ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",4000)</script>");
            }
            CleanFields();
            DisableFields();
            AbortBtn.Visible = false;
            SaveBtn.Visible = false;
            UpdateBtn.Visible = false;
            NewBtn.Visible = true;
            btnRefresh.Visible = false;
            table.DataBind();
        }

        protected void AbortBtn_Click(object sender, EventArgs e)
        {
            txtDate.Text = String.Empty;
            txtOntime.Text = String.Empty;
            txtBalanceToBuild.Text = String.Empty;
            txtWeekNo.Text = String.Empty;
            txtWrongDate.Text = String.Empty;
            txtPastDue.Text = String.Empty;
            DisableFields();
            UpdateBtn.Visible = false;
            AbortBtn.Visible = false;
            NewBtn.Visible = true;
            SaveBtn.Visible = false;
            btnRefresh.Visible = false;

        }

        protected void table_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.Cells[0].Text = "Edit";
                e.Row.Cells[1].Text = "ID";
                e.Row.Cells[2].Text = "Date";
                e.Row.Cells[3].Text = "Week Number";
                e.Row.Cells[4].Text = "On Time";
                e.Row.Cells[5].Text = "Wrong Date";
                e.Row.Cells[6].Text = "Past Due";
                e.Row.Cells[7].Text = "Balance To Build";
                e.Row.Cells[8].Text = "Delete";
            }
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    e.Row.Cells[0].ToolTip = "Edit Details";
                    e.Row.Cells[8].ToolTip = "Delete Open Order";

                    //if (e.Row.RowState == DataControlRowState.Edit || e.Row.RowState.ToString() == "Alternate, Edit")
                    //{
                    //    int i = 0;
                    //    foreach (TableCell cell in e.Row.Cells)
                    //    {
                    //        if (e.Row.Cells.GetCellIndex(cell) == 4)
                    //        {
                    //            ((System.Web.UI.WebControls.ImageButton)(e.Row.Cells[0].Controls[0])).ToolTip = "Edit Details";
                    //            ((System.Web.UI.LiteralControl)(e.Row.Cells[4].Controls[1])).Text = "&nbsp;";
                    //            ((System.Web.UI.WebControls.ImageButton)(e.Row.Cells[8].Controls[0])).ToolTip = "Delete Open Order";
                    //        }
                    //        i++;
                    //    }
                    //}
                }
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

        protected void ExportBtn_Click(object sender, EventArgs e)
        {
            ExportGridToExcel();
        }

        private void ExportGridToExcel()
        {
            Response.Clear();
            Response.Buffer = true;
            Response.Charset = "";
            string FileName = "Open Orders " + DateTime.Now + ".xls";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            string attachment = "attachment; filename=" + FileName;
            Response.ClearHeaders();
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            // Create a form to contain the grid
            HtmlForm frm = new HtmlForm();
            table.GridLines = GridLines.Both;
            table.HeaderStyle.Font.Bold = true;
            table.HeaderStyle.ForeColor = System.Drawing.Color.Black;
            table.Parent.Controls.Add(frm);
            table.Columns[0].Visible = false;
            table.Columns[8].Visible = false;
            table.Columns[1].Visible = false;
            frm.Attributes["runat"] = "server";
            frm.Controls.Add(table);
            frm.RenderControl(htw);
            Response.Write(sw.ToString());
            Response.End();
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
               server control at run time. */
        }

        protected void table_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ComDelete")
            {
                try
                {
                    int index2 = Convert.ToInt32(e.CommandArgument);
                    GridViewRow row2 = table.Rows[index2];
                    string conString3 = ConfigurationManager.ConnectionStrings["mmc"].ConnectionString;
                    SqlConnection sqlConnection001 = new SqlConnection(conString3);
                    SqlCommand sqlCommand001 = new SqlCommand("DeleteOpenOrder", sqlConnection001)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    sqlConnection001.Open();
                    sqlCommand001.Parameters.Add("@ID", SqlDbType.Int).Value = row2.Cells[1].Text.ToString();
                    sqlCommand001.ExecuteReader();
                    sqlConnection001.Close();
                    alert.Visible = true;
                    AlertIcon.Attributes.Add("class", " bi bi-trash-fill");
                    alert.Attributes.Add("class", " alert alert-warning  alert-dismissible ");
                    alertText.Text = "Deleted Successfully";
                    ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",4000)</script>");
                    table.DataBind();
                }
                catch (Exception ex)
                {
                    alert.Visible = true;
                    AlertIcon.Attributes.Add("class", " bi bi-info-circle-fill");
                    alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
                    alertText.Text = "Something went wrong: " + ex.Message;
                    ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",4000)</script>");
                    table.DataBind();
                }
                CleanFields();
                DisableFields();
                AbortBtn.Visible = false;
                UpdateBtn.Visible = false;
                NewBtn.Visible = true;
                btnRefresh.Visible = false;
                SaveBtn.Visible = false;
            }
            else if (e.CommandName == "Editar")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = table.Rows[index];
                alert.Visible = true;
                AlertIcon.Attributes.Add("class", "bi bi-database-fill");
                alert.Attributes.Add("class", " alert alert-info  alert-dismissible ");
                alertText.Text = "Week Number: " + row.Cells[3].Text; ;
                ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",3000)</script>");
                CleanFields();
                EnableFields();
                inputID.Text = row.Cells[1].Text;
                txtDate.Text = row.Cells[2].Text;
                txtWeekNo.Text = row.Cells[3].Text;
                txtOntime.Text = row.Cells[4].Text.Replace(",", string.Empty);
                txtPastDue.Text = row.Cells[6].Text.Replace(",", string.Empty);
                txtWrongDate.Text = row.Cells[5].Text.Replace(",", string.Empty);
                txtBalanceToBuild.Text = row.Cells[7].Text.Replace(",", string.Empty);
                NewBtn.Visible = false;
                AbortBtn.Visible = true;
                UpdateBtn.Visible = true;
                SaveBtn.Visible = false;
                btnRefresh.Visible = false;
            }
        }

        protected void table_SelectedIndexChanged(object sender, EventArgs e)
        {

        }



        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            NewBtn.Visible = true;
            AbortBtn.Visible = false;
            UpdateBtn.Visible = false;
            SaveBtn.Visible = false;
            btnRefresh.Visible = false;
        }
    }
}