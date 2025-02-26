﻿using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using System.Text.RegularExpressions;

namespace ManageWO
{
    public partial class smtWO : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                NewBtn.Visible = true;
                SearchBtn.Visible = false;
                SaveBtn.Visible = false;
                CancelBtn.Visible = false;
                QueryBtn.Visible = false;
                ClearBtn.Visible = false;
                RefreshBtn.Visible = true;
                UpdateBtn.Visible = false;
                DisableFields();
                BindGridView();
                //OriginalStateButton();
            }
        }

        protected void myTable_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.Cells[0].Text = "Edit";
                e.Row.Cells[1].Text = "ID";
                e.Row.Cells[2].Text = "Work Order";
                e.Row.Cells[3].Text = "Model";
                e.Row.Cells[4].Text = "Quantity";
                e.Row.Cells[5].Text = "InitialSN";
                e.Row.Cells[6].Text = "FinalSN";
                e.Row.Cells[7].Text = "Delete";
            }
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    e.Row.Cells[0].ToolTip = "click here to select work order info to modify";
                    e.Row.Cells[7].ToolTip = "Delete work order from database";
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
        static string IDTable;
        protected void myTable_SelectedIndexChanged(object sender, EventArgs e)
        {
            SaveBtn.Visible = false;
            NewBtn.Visible = true;
            ClearBtn.Visible = true;
            CancelBtn.Visible = false;
            QueryBtn.Visible = true;
            RefreshBtn.Visible = true;
            SearchBtn.Visible = false;
            filterText.Enabled = false;
            UpdateBtn.Visible = false;

            IDTable = myTable.SelectedRow.Cells[1].Text.ToString();
            inputID.Text = IDTable.ToString();
            inputWorkorder.Text = myTable.SelectedRow.Cells[2].Text.ToString();
            inputModel.Text = myTable.SelectedRow.Cells[3].Text.ToString();
            inputQty.Text = myTable.SelectedRow.Cells[4].Text.ToString();
            inputFirstQR.Text = myTable.SelectedRow.Cells[5].Text.Replace("&nbsp;", "");
            inputLastQR.Text = myTable.SelectedRow.Cells[6].Text.Replace("&nbsp;", "");

            alert.Visible = true;
            AlertIcon.Attributes.Add("class", " bi bi-info-circle-fill");
            alert.Attributes.Add("class", " alert alert-info  alert-dismissible ");
            alertText.Text = "Selected succesfully";
            ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",2000)</script>");
        }


        protected void NewBtn_Click(object sender, EventArgs e)
        {
            inputID.Text = null;
            inputWorkorder.Text = null;
            inputModel.Text = null;
            inputQty.Text = null;
            inputFirstQR.Text = null;
            inputLastQR.Text = null;
            inputWorkorder.Focus();
            ClearBtn.Visible = true;
            SaveBtn.Visible = true;
            NewBtn.Visible = false;
            SearchBtn.Visible = false;
            QueryBtn.Visible = true;
            CancelBtn.Visible = false;
            RefreshBtn.Visible = true;
            filterText.Enabled = false;
            UpdateBtn.Visible = false;
            alert.Visible = true;
            AlertIcon.Attributes.Add("class", " bi bi-info-circle-fill");
            alert.Attributes.Add("class", " alert alert-info  alert-dismissible ");
            alertText.Text = "Create new work order";
            ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",2000)</script>");
            //SaveBtn.Visible = true;
            EnableFields();

        }

        protected void SaveBtn_Click(object sender, EventArgs e)
        {
            string conDBsmt = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
            string WO = inputWorkorder.Text;
            string Model = inputModel.Text;
            int Qty = int.Parse(inputQty.Text);
            string InitialSN = inputFirstQR.Text;
            string FinalSN = inputLastQR.Text;
            SqlConnection connectionDBsmt = new SqlConnection(conDBsmt);
            SqlCommand cmdSP = new SqlCommand("AddInfoWOSMT", connectionDBsmt);
            cmdSP.CommandType = CommandType.StoredProcedure;
            connectionDBsmt.Open();
            cmdSP.Parameters.Add("@WorkOrder", SqlDbType.VarChar, 30).Value = WO;
            cmdSP.Parameters.Add("@Model", SqlDbType.VarChar, 50).Value = Model;
            cmdSP.Parameters.Add("@Quantity", SqlDbType.Int).Value = Qty;
            cmdSP.Parameters.Add("@InitialSN", SqlDbType.VarChar, 100).Value = InitialSN;
            cmdSP.Parameters.Add("@FinalSN", SqlDbType.VarChar, 100).Value = FinalSN;
            SqlDataReader sqlDataReader = cmdSP.ExecuteReader();
            sqlDataReader.Read();
            int int32 = sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("rowAffected"));
            connectionDBsmt.Close();
            if (int32 == 1)
            {
                alert.Visible = true;
                AlertIcon.Attributes.Add("class", " bi bi-database-check");
                alert.Attributes.Add("class", " alert alert-success  alert-dismissible");
                alertText.Text = "WorkOrder created succesfully";
                ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",4000)</script>");
            }
            else
            {
                alert.Visible = true;
                AlertIcon.Attributes.Add("class", " bi bi-database-x");
                alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
                alertText.Text = "WorkOrder duplicated or something is missing";
                ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",4000)</script>");

                DisableFields();

            }
            SaveBtn.Visible = false;
            ClearBtn.Visible = false;
            NewBtn.Visible = true;
            SearchBtn.Visible = false;
            CancelBtn.Visible = false;
            QueryBtn.Visible = true;
            RefreshBtn.Visible = true;
            filterText.Enabled = false;
            UpdateBtn.Visible = false;

            clearFields();
            DisableFields();
            BindGridView();

        }

        protected void DeleteBtn_Click(object sender, EventArgs e)
        {
           
        }

        protected void ClearBtn_Click(object sender, EventArgs e)
        {
            SaveBtn.Visible = false;
            NewBtn.Visible = true;
            ClearBtn.Visible = false;
            CancelBtn.Visible = false;
            QueryBtn.Visible = true;
            SearchBtn.Visible = false;
            UpdateBtn.Visible = false;

            alert.Visible = true;
            AlertIcon.Attributes.Add("class", " bi bi-exclamation-diamond");
            alert.Attributes.Add("class", " alert alert-warning  alert-dismissible ");
            alertText.Text = "Action cancelled";
            ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",1500)</script>");

            //OriginalStateButton();
            clearFields();
            BindGridView();
            DisableFields();
            filterText.Enabled = false;


        }

        protected void EditBtn_Click(object sender, EventArgs e)
        {
            NewBtn.Visible = false;
            SaveBtn.Visible = false;
            ClearBtn.Visible = true;
            SearchBtn.Visible = false;
            QueryBtn.Visible = true;
            CancelBtn.Visible = false;
            RefreshBtn.Visible = true;
            UpdateBtn.Visible = true;
            //icono.Attributes.Add("class", "bi bi-x-circle-fill");
            EnableFields();
            filterText.Enabled = false;

        }

        protected void SearchBtn_Click(object sender, EventArgs e)
        {
            DataFilter();
        }

        protected void inputWorkorder_TextChanged(object sender, EventArgs e)
        {
            //SearchBtn.Visible = true;
            //EditBtn.Visible = false;
            //SaveBtn.Visible = false;
            //DeleteBtn.Visible = false;
            //EditBtn.Visible = false;
            //NewBtn.Visible = true;
            //ClearBtn.Visible = true;
        }

        private void BindGridView()
        {

            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ConnectionString))
            {
                SqlCommand sqlCommand = new SqlCommand("GetLast100WOSMT", connection);
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
            SaveBtn.Visible = false;
            ClearBtn.Visible = false;
            NewBtn.Visible = true;
            SearchBtn.Visible = false;
            QueryBtn.Visible = true;
            CancelBtn.Visible = false;
            filterText.Enabled = false;
            UpdateBtn.Visible = false;
            //footer.Text = Convert.ToString(DateTime.Now);
            RefreshBtn.Visible = true;
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

        protected void RefreshBtn_Click(object sender, EventArgs e)
        {
            filterText.Enabled = false;
            DisableFields();
            clearFields();
            ClearBtn.Visible = false;
            SaveBtn.Visible = false;
            NewBtn.Visible = true;
            SearchBtn.Visible = false;
            RefreshBtn.Visible = true;
            QueryBtn.Visible = true;
            UpdateBtn.Visible = false;

            BindGridView();
            alert.Visible = true;
            AlertIcon.Attributes.Add("class", "bi bi-list-check");
            alert.Attributes.Add("class", " alert alert-primary  alert-dismissible ");
            alertText.Text = "Updated succesfully";
            ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",3000)</script>");

        }
        public void clearFields()
        {
            inputID.Text = null;
            inputWorkorder.Text = null;
            inputModel.Text = null;
            inputQty.Text = null;
            inputFirstQR.Text = null;
            inputLastQR.Text = null;
            filterText.Text = null;

        }

        protected void filterText_TextChanged(object sender, EventArgs e)
        {
            DataFilter();
        }

        protected void QueryBtn_Click(object sender, EventArgs e)
        {
            clearFields();
            filterText.BackColor = System.Drawing.Color.LightYellow;
            filterText.Enabled = true;
            filterText.Focus();
            SearchBtn.Visible = true;
            RefreshBtn.Visible = false;
            QueryBtn.Visible = false;
            CancelBtn.Visible = true;
            ClearBtn.Visible = false;
            SaveBtn.Visible = false;
            NewBtn.Visible = true;
            alert.Visible = true;
            UpdateBtn.Visible = false;
            alert.Visible = true;

            AlertIcon.Attributes.Add("class", "bi bi-database-fill");
            alert.Attributes.Add("class", " alert alert-info  alert-dismissible ");
            alertText.Text = "Query enabled: Search by work order or model";
            ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",3000)</script>");
            DisableFields();
        }

        protected void CancelBtn_Click(object sender, EventArgs e)
        {
            filterText.BackColor = System.Drawing.Color.White;
            filterText.Enabled = false;
            SearchBtn.Visible = false;
            RefreshBtn.Visible = true;
            QueryBtn.Visible = true;
            CancelBtn.Visible = false;
            SaveBtn.Visible = false;
            ClearBtn.Visible = false;
            NewBtn.Visible = true;
            UpdateBtn.Visible = false;

            clearFields();
            inputWorkorder.Focus();
            alert.Visible = true;
            AlertIcon.Attributes.Add("class", "bi bi-exclamation-diamond");
            alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
            alertText.Text = "Query cancelled";
            ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",3000)</script>");
            DisableFields();

        }

        public void EnableFields()
        {
            inputWorkorder.Enabled = true;
            inputQty.Enabled = true;
            inputLastQR.Enabled = true;
            inputFirstQR.Enabled = true;
            inputLastQR.Enabled = true;
            inputModel.Enabled = true;
        }

        public void DisableFields()
        {
            inputWorkorder.Enabled=false;
            inputQty.Enabled = false;
            inputLastQR.Enabled = false;
            inputFirstQR.Enabled = false;
            inputLastQR.Enabled = false;
            inputModel.Enabled = false;

        }
        public void OriginalStateButton()
        {
            ClearBtn.Attributes.Add("class", "boton btn btn-secondary");
            //icono.Attributes.Add("class", "bi bi-eraser-fill");
        }

        public void ModifyStateButton()
        {
            ClearBtn.Attributes.Add("class", "boton  fw-bold btn btn-secondary ");
            //icono.Attributes.Add("class", "bi bi-x-circle-fill");
        }

        protected void UpdateBtn_Click(object sender, EventArgs e)
        {

            string connectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
            string WO = inputWorkorder.Text;
            string Model = inputModel.Text;
            int Qty = int.Parse(inputQty.Text);
            string InitialSN = inputFirstQR.Text;
            string FinalSN = inputLastQR.Text;
            SqlConnection connection = new SqlConnection(connectionString);
            SqlCommand sqlCommand4 = new SqlCommand("UpdateInfoWOSMT2", connection);
            sqlCommand4.CommandType = CommandType.StoredProcedure;
            connection.Open();
            sqlCommand4.Parameters.Add("@WorkOrder", SqlDbType.VarChar, 30).Value = WO;
            sqlCommand4.Parameters.Add("@Model", SqlDbType.VarChar, 50).Value = Model;
            sqlCommand4.Parameters.Add("@Quantity", SqlDbType.Int).Value = Qty;
            sqlCommand4.Parameters.Add("@InitialSN", SqlDbType.VarChar, 100).Value = InitialSN;
            sqlCommand4.Parameters.Add("@FinalSN", SqlDbType.VarChar, 100).Value = FinalSN;
            SqlDataReader reader = sqlCommand4.ExecuteReader();
            reader.Read();
            int row = reader.GetInt32(reader.GetOrdinal("RowUpdated"));
            //sqlCommand4.ExecuteReader().Read();
            connection.Close();
            if (row == 1)
            {
                alert.Visible = true;
                AlertIcon.Attributes.Add("class", "bi bi-check2-circle");
                alert.Attributes.Add("class", " alert alert-success  alert-dismissible ");
                alertText.Text = "WorkOrder updated succesfully";
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
            UpdateBtn.Visible = false;
            SearchBtn.Visible = false;
            RefreshBtn.Visible = true;
            QueryBtn.Visible = true;
            CancelBtn.Visible = false;
            SaveBtn.Visible = false;
            ClearBtn.Visible = false;
            NewBtn.Visible = true;
            clearFields();
            DisableFields();
            BindGridView();

        }


        protected void ExportBtn_Click(object sender, EventArgs e)
        {
            //ExportGridToExcel();
            Excel();
        }


        private void ExportGridToExcel()
        {

            //Response.Clear();
            //Response.Buffer = true;
            //Response.ClearContent();
            //Response.ClearHeaders();
            //Response.Charset = "";
            //string FileName = "WO SMT Query" + "_" + DateTime.Now + ".xls";
            //StringWriter strwritter = new StringWriter();
            //HtmlTextWriter htmltextwrtter = new HtmlTextWriter(strwritter);
            //Response.Cache.SetCacheability(HttpCacheability.NoCache);
            //Response.ContentType = "application/vnd.ms-excel";
            //Response.AddHeader("Content-Disposition", "attachment;filename=" + FileName);
            //myTable.GridLines = GridLines.Both;
            //myTable.HeaderStyle.Font.Bold = true;
            //myTable.RenderControl(htmltextwrtter);
            //Response.Write(strwritter.ToString());
            //Response.End();



        }

        public void Excel()
        {
            //1.bind with paging disabled
            myTable.AllowPaging = false;
            myTable.DataBind();
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=GridViewExport.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                //To Export all pages
                myTable.AllowPaging = false;
                this.BindGridView();

                myTable.HeaderRow.BackColor = Color.White;
                foreach (TableCell cell in myTable.HeaderRow.Cells)
                {
                    cell.BackColor = myTable.HeaderStyle.BackColor;
                }
                foreach (GridViewRow row in myTable.Rows)
                {
                    row.BackColor = Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = myTable.AlternatingRowStyle.BackColor;
                        }
                        else
                        {
                            cell.BackColor = myTable.RowStyle.BackColor;
                        }
                        cell.CssClass = "textmode";
                    }
                }

                myTable.RenderControl(hw);

                //style to format numbers to string
                string style = @"<style> .textmode { } </style>";
                Response.Write(style);
                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();
            }

            myTable.AllowPaging = true;
            myTable.DataBind();


        }
        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
               server control at run time. */
        }

        protected void logoutBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Home.aspx");
        }


        protected void RegresarBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Default.aspx");

        }


        public void DataFilter()
        {
            DisableFields();
            using (SqlConnection connection1 = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ConnectionString))
            {
                SqlCommand sqlCommand1 = new SqlCommand("GetWOSMTFilterLike", connection1);
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
                    SaveBtn.Visible = false;
                    NewBtn.Visible = true;
                    ClearBtn.Visible = true;
                    RefreshBtn.Visible = false;
                    SearchBtn.Visible = true;
                    CancelBtn.Visible = true;
                    UpdateBtn.Visible = false;

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

        protected void myTable_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ComDelete")
            {
                try
                {
                    int index2 = Convert.ToInt32(e.CommandArgument);
                    GridViewRow row2 = myTable.Rows[index2];
                    string connectionString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
                    SqlConnection connection = new SqlConnection(connectionString);
                    SqlCommand sqlCommand4 = new SqlCommand("DeleteWOSMT", connection);
                    sqlCommand4.CommandType = CommandType.StoredProcedure;
                    connection.Open();
                    sqlCommand4.Parameters.Add("@WorkOrder", SqlDbType.VarChar, 30).Value = row2.Cells[2].Text.ToString();
                   // sqlCommand4.Parameters.Add("@ID", SqlDbType.Int).Value = row2.Cells[1].Text.ToString();
                    SqlDataReader reader = sqlCommand4.ExecuteReader();
                    reader.Read();
                    int row = reader.GetInt32(reader.GetOrdinal("RowDeleted"));
                    //sqlCommand4.ExecuteReader().Read();
                    connection.Close();
                    if (row == 1)
                    {
                        alert.Visible = true;
                        AlertIcon.Attributes.Add("class", "bi bi-database-exclamation");
                        alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
                        alertText.Text = "Workorder deleted succesfully";
                        ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",4000)</script>");
                    }
                    //if (row > 1)
                    //{
                    //    alert.Visible = true;
                    //    AlertIcon.Attributes.Add("class", "bi bi-database-exclamation");
                    //    alert.Attributes.Add("class", " alert alert-primary  alert-dismissible ");
                    //    alertText.Text = "1 or more failuremodes has been deleted, please, provide this info to it team. ";
                    //    ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",4000)</script>");
                    //}
                    else
                    {
                        alert.Visible = true;
                        AlertIcon.Attributes.Add("class", "bi bi-database-fill-x");
                        alert.Attributes.Add("class", " alert alert-warning  alert-dismissible ");
                        alertText.Text = "Something went wrong, please contact IT dept";
                        ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",4000)</script>");
                    }
                
                }
                catch (Exception ex)
                {
                    alert.Visible = true;
                    AlertIcon.Attributes.Add("class", " bi bi-info-circle-fill");
                    alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
                    alertText.Text = "Something went wrong: " + ex.Message;
                    ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",4000)</script>");
                    myTable.DataBind();
                }
                SaveBtn.Visible = false;
                ClearBtn.Visible = false;
                NewBtn.Visible = true;
                SearchBtn.Visible = false;
                QueryBtn.Visible = true;
                CancelBtn.Visible = false;
                RefreshBtn.Visible = true;
                filterText.Enabled = false;
                UpdateBtn.Visible = false;

                clearFields();
                BindGridView();
                DisableFields();
            }
            else if (e.CommandName == "Editar")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = myTable.Rows[index];
                alert.Visible = true;
                AlertIcon.Attributes.Add("class", "bi bi-database-fill");
                alert.Attributes.Add("class", " alert alert-info  alert-dismissible ");
                alertText.Text = "Work Order: " + row.Cells[2].Text +" ready to edit." ;
                ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",3000)</script>");
                clearFields();
                EnableFields();
                inputID.Text = row.Cells[1].Text;
                inputWorkorder.Text = row.Cells[2].Text;
                inputModel.Text = row.Cells[3].Text;
                inputQty.Text = row.Cells[4].Text;
                inputFirstQR.Text = row.Cells[5].Text;
                inputLastQR.Text = row.Cells[6].Text;
                NewBtn.Visible = false;
                UpdateBtn.Visible = true;
                SaveBtn.Visible = false;
                ClearBtn.Visible = true;
            }
        }

        protected void excelBtn_Click(object sender, EventArgs e)
        {

        }

        protected void addButton_Click(object sender, EventArgs e)
        {
            filterText.BackColor = System.Drawing.Color.White;
            filterText.Enabled = false;
            inputID.Text = null;
            inputWorkorder.Text = null;
            inputModel.Text = null;
            inputQty.Text = null;
            inputFirstQR.Text = null;
            inputLastQR.Text = null;
            inputWorkorder.Focus();
            ClearBtn.Visible = true;
            SaveBtn.Visible = true;
            NewBtn.Visible = false;
            SearchBtn.Visible = false;
            QueryBtn.Visible = true;
            CancelBtn.Visible = false;
            RefreshBtn.Visible = true;
            filterText.Enabled = false;
            UpdateBtn.Visible = false;
            alert.Visible = true;
            AlertIcon.Attributes.Add("class", " bi bi-info-circle-fill");
            alert.Attributes.Add("class", " alert alert-info  alert-dismissible ");
            alertText.Text = "Create new work order";
            ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",2000)</script>");
            //SaveBtn.Visible = true;
            clearFields();
            EnableFields();
        }
    }

}