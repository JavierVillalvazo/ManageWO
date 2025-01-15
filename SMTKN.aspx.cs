using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SpreadsheetLight.Drawing;
using SpreadsheetLight;
using System.IO;
using DocumentFormat.OpenXml.Spreadsheet;
using System.Data.Common;
using System.Data.OleDb;

namespace ManageWO
{
    public partial class SMTKN : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            BindGridView();
            QueryBtn.Visible = true;

        }

        protected void logoutBtn_Click(object sender, EventArgs e)
        {

        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (fuData.PostedFile != null)
            {
                if (fuData.PostedFile.FileName != "")
                {
                    try
                    {
                        string filename = Server.MapPath("~/UploadFile/KN_SMT/" + fuData.FileName);
                        //string filename = Server.MapPath("C:/inetpub/wwwroot/AlimentacionDB_2.0/UploadFile/" + fuData.FileName);
                        fuData.SaveAs(filename);
                        using (OleDbConnection connection = new OleDbConnection(string.Format("Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties=Excel 8.0", (object)filename)))
                        {
                            OleDbCommand oleDbCommand = new OleDbCommand("SELECT * FROM [Hoja1$] WHERE WorkOrder <> '' and  Flag ='N:General Item'  ", connection);
                            connection.Open();
                            new SqlBulkCopy(ConfigurationManager.ConnectionStrings["smt"].ConnectionString)
                            {
                                DestinationTableName = "MaterialToSupply",
                                ColumnMappings =
                                {
                                      {
                                        "WorkOrder",
                                        "WorkOrder"
                                      },
                                      {
                                        "P/N",
                                        "PartNumber"
                                      },
                                      {
                                        "Part Name",
                                        "Description"
                                      },
                                      { "Qty To Issue",
                                        "KNQty"
                                      }
                                }
                            }.WriteToServer((DbDataReader)oleDbCommand.ExecuteReader());
                            BindGridView();
                            connection.Close();
                            alert.Visible = true;
                            AlertIcon.Attributes.Add("class", "bi bi-database-fill");
                            alert.Attributes.Add("class", " alert alert-info  alert-dismissible ");
                            alertText.Text = "Kitting Note SMT Uploaded succesfully";
                            ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",6000)</script>");
                            //Response.Write("<script language='Javascript'>alert('Archivo importado con exito');</script>");
                            return;
                        }
                    }
                    catch (Exception ex)
                    {
                        alert.Visible = true;
                        AlertIcon.Attributes.Add("class", "bi bi-database-x-fill");
                        alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
                        alertText.Text = "Something went wrong, Try Again... " + ex.Message;
                        ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",6000)</script>");
                        //Response.Write("<script language='Javascript'>alert('" + ex.Message + "');</script>");
                        return;
                    }
                }
            }
            alert.Visible = true;
            AlertIcon.Attributes.Add("class", "bi bi-database-fill");
            alert.Attributes.Add("class", " alert alert-warning  alert-dismissible ");
            alertText.Text = "No file selected, Try Again";
            ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",6000)</script>");
            //Response.Write("<script language='Javascript'>alert('Sin archivo seleccionado');</script>");

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
            alertText.Text = "Query Enabled";
            ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",3000)</script>");

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
            alertText.Text = "Updated Succesfully";
            ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",3000)</script>");
        }

        protected void CancelBtn_Click(object sender, EventArgs e)
        {
            filterText.BackColor = System.Drawing.Color.White;
            filterText.Enabled = false;
            SearchBtn.Visible = false;
            RefreshBtn.Visible = true;
            QueryBtn.Visible = true;
            CancelBtn.Visible = false;
            filterText.Text = null;
            alert.Visible = true;
            AlertIcon.Attributes.Add("class", "bi bi-exclamation-diamond");
            alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
            alertText.Text = "Query Aborted";
            ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",3000)</script>");
            BindGridView();
        }


        protected void tableKN_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            tableKN.PageIndex = e.NewPageIndex;
        }

        protected void tableKN_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void tableKN_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DownloadKN")
            {
                try
                {
                    int index = Convert.ToInt32(e.CommandArgument);
                    GridViewRow row = tableKN.Rows[index];
                    string conString2 = ConfigurationManager.ConnectionStrings["smt"].ConnectionString;
                    SqlConnection sqlConnection00 = new SqlConnection(conString2);
                    SqlCommand sqlCommand00 = new SqlCommand("GetKNWO", sqlConnection00)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    string WO = row.Cells[1].Text.Trim();
                    sqlConnection00.Open();
                    sqlCommand00.Parameters.Add("@WorkOrder", SqlDbType.VarChar, 30).Value = WO;
                    SqlDataAdapter sqlDataAdapter00 = new SqlDataAdapter(sqlCommand00);
                    DataTable dt00 = new DataTable();
                    dt00.Load(sqlCommand00.ExecuteReader());
                    sqlConnection00.Close();
                    string date = DateTime.Now.ToString("dd/MM/yyyy");
                    date = date.Replace('/', '_');
                    string pathFile00 = HttpContext.Current.Server.MapPath(@"~/Files/" + "Kitting Note SMT " + Session["wo"] + " " + Session["model"] + "  " + date + ".xlsx");
                    SLDocument document00 = new SLDocument();
                    string TabName = row.Cells[1].Text.ToString();
                    document00.AddWorksheet(TabName);
                    string projectFolder = AppDomain.CurrentDomain.BaseDirectory;
                    string imgPath = Path.Combine(projectFolder, "Resources\\Images\\inv.png");
                    SLStyle styleHeader = document00.CreateStyle();
                    styleHeader.SetHorizontalAlignment(DocumentFormat.OpenXml.Spreadsheet.HorizontalAlignmentValues.Center);
                    styleHeader.Font.Bold = true;
                    document00.SetRowStyle(12, styleHeader);
                    SLStyle styleCenter = document00.CreateStyle();
                    styleCenter.SetHorizontalAlignment(DocumentFormat.OpenXml.Spreadsheet.HorizontalAlignmentValues.Center);
                    document00.SetColumnStyle(1, 5, styleCenter);
                    document00.MergeWorksheetCells("A2", "E2");
                    document00.SetActiveCell("A2");
                    document00.SetCellValue("A2", "KITTING NOTE SMT UPLOADED");
                    document00.SetCellStyle("A2", styleHeader);
                    SLPicture img = new SLPicture(imgPath);
                    img.SetPosition(6.5, 0.5);
                    img.ResizeInPixels(400, 130);
                    document00.InsertPicture(img);
                    document00.SetActiveCell("D5");
                    document00.SetCellValue("D5", "Work Order");
                    document00.SetCellStyle("D5", styleHeader);
                    document00.SetActiveCell("D6");
                    document00.SetCellValue("D6", "Model");
                    document00.SetCellStyle("D6", styleHeader);
                    document00.SetActiveCell("D7");
                    document00.SetCellValue("D7", "Quantity");
                    document00.SetCellStyle("D7", styleHeader);
                    document00.SetActiveCell("D");
                    document00.SetCellValue("D8", "Fecha");
                    document00.SetCellStyle("D8", styleHeader);
                    document00.SetActiveCell("E5");
                    document00.SetCellValue("E5", row.Cells[1].Text.ToString());
                    document00.SetActiveCell("E6");
                    document00.SetCellValue("E6", row.Cells[2].Text.ToString());
                    document00.SetActiveCell("E7");
                    document00.SetCellValue("E7", row.Cells[3].Text.ToString() + "  PCS");
                    document00.SetActiveCell("E8");
                    document00.SetCellValue("E8", DateTime.Now.ToString("dd/MM/yyyy"));
                    document00.AutoFitColumn(6);
                    SLStyle styleBorder = document00.CreateStyle();
                    styleBorder.Border.BottomBorder.BorderStyle = DocumentFormat.OpenXml.Spreadsheet.BorderStyleValues.Thin;
                    styleBorder.Border.TopBorder.BorderStyle = DocumentFormat.OpenXml.Spreadsheet.BorderStyleValues.Thin;
                    styleBorder.Border.LeftBorder.BorderStyle = DocumentFormat.OpenXml.Spreadsheet.BorderStyleValues.Thin;
                    styleBorder.Border.RightBorder.BorderStyle = DocumentFormat.OpenXml.Spreadsheet.BorderStyleValues.Thin;
                    SLStyle nonBorder = document00.CreateStyle();
                    nonBorder.Border.BottomBorder.BorderStyle = DocumentFormat.OpenXml.Spreadsheet.BorderStyleValues.None;
                    nonBorder.Border.TopBorder.BorderStyle = DocumentFormat.OpenXml.Spreadsheet.BorderStyleValues.None;
                    nonBorder.Border.LeftBorder.BorderStyle = DocumentFormat.OpenXml.Spreadsheet.BorderStyleValues.None;
                    nonBorder.Border.RightBorder.BorderStyle = DocumentFormat.OpenXml.Spreadsheet.BorderStyleValues.None;
                    document00.SetRowStyle(12, 12 + dt00.Rows.Count, styleBorder);
                    //document00.SetColumnStyle(5, 5+ dt00.Columns.Count,  nonBorder);
                    document00.SetActiveCell("A12");
                    document00.ImportDataTable("A12", dt00, true);
                    //document00.CopyCellStyle("A12", "F12", "Q12");
                    document00.AutoFitColumn(1, 6);
                    int rows = dt00.Rows.Count + 12;
                    document00.DeleteWorksheet("Sheet1");
                    document00.SaveAs(pathFile00);
                    Response.ContentType = "application/octet-stream";
                    string WOrowData = row.Cells[0].Text.ToString();
                    Response.AddHeader("Content-Disposition", "attachment; filename=" + "Kitting Note SMT " + WOrowData + ".xlsx");
                    Response.TransmitFile(pathFile00);
                    Response.End();
                    alert.Visible = true;
                    AlertIcon.Attributes.Add("class", " bi bi-info-circle-fill");
                    alert.Attributes.Add("class", " alert alert-info  alert-dismissible ");
                    alertText.Text = "Kitting Note Downloaded Succesfully";
                    ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",2000)</script>");
                    BindGridView();
                }
                catch (Exception ex)
                {
                   
                    alert.Visible = true;
                    AlertIcon.Attributes.Add("class", " bi bi bi-bug-fill");
                    alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
                    alertText.Text =  "You need to select a row of the table first. ERROR: " + ex.Message;
                    ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",2000)</script>");
                    BindGridView();
                }
            }
            else if (e.CommandName == "DeleteKN")
            {
                try
                {
                    int index2 = Convert.ToInt32(e.CommandArgument);
                    GridViewRow row2 = tableKN.Rows[index2];
                    string conString3 = ConfigurationManager.ConnectionStrings["smt"].ConnectionString;
                    SqlConnection sqlConnection001 = new SqlConnection(conString3);
                    SqlCommand sqlCommand001 = new SqlCommand("DeleteKNByWO", sqlConnection001)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    string WO = row2.Cells[1].Text.Trim();
                    sqlConnection001.Open();
                    sqlCommand001.Parameters.Add("@WorkOrder", SqlDbType.VarChar, 30).Value = WO;
                    sqlCommand001.ExecuteReader();
                    sqlConnection001.Close();
                    alert.Visible = true;
                    AlertIcon.Attributes.Add("class", " bi bi-trash-fill");
                    alert.Attributes.Add("class", " alert alert-warning  alert-dismissible ");
                    alertText.Text = "Kitting Note SMT Deleted Succesfully";
                    ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",4000)</script>");
                    BindGridView();
                }
                catch (Exception ex)
                {
                    alert.Visible = true;
                    AlertIcon.Attributes.Add("class", " bi bi-info-circle-fill");
                    alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
                    alertText.Text = "Something went wrong. ERROR: " + ex.Message;
                    ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",4000)</script>");
                    BindGridView();
                }
            }
        }

        protected void tableKN_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {

        }

        protected void tableKN_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //if (e.Row.RowType == DataControlRowType.Header)
            //{
            //    e.Row.Cells[0].Text = "WorkOrder";
            //    e.Row.Cells[1].Text = "Model";
            //    e.Row.Cells[2].Text = "Quantity";
            //    e.Row.Cells[3].Text = "Actions ";
            //}
        }

        protected void filterText_TextChanged(object sender, EventArgs e)
        {
            DataFilter();
        }
        public void BindGridView()
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ConnectionString))
            {
                SqlCommand sqlCommand = new SqlCommand("GetLastWOSMT2", connection);
                sqlCommand.CommandType = CommandType.StoredProcedure;
                connection.Open();
                SqlDataAdapter adapter = new SqlDataAdapter(sqlCommand);
                DataSet data = new DataSet();
                adapter.Fill(data); if (data.Tables.Count > 0)
                {
                    tableKN.DataSource = data.Tables[0];
                    tableKN.AllowPaging = false;
                    tableKN.DataBind();
                    connection.Close();
                }
                else
                {
                    alert.Visible = true;
                    AlertIcon.Attributes.Add("class", " bi bi-exclamation-octagon");
                    alert.Attributes.Add("class", "alert alert-danger  alert-dismissible");
                    alertText.Text = "Data Not Found";
                    ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",5000)</script>");
                }
            }
        }
        public void DataFilter()
        {
            using (SqlConnection connection1 = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ConnectionString))
            {
                SqlCommand sqlCommand1 = new SqlCommand("GetKNLike", connection1);
                sqlCommand1.CommandType = CommandType.StoredProcedure;
                connection1.Open();
                sqlCommand1.Parameters.Add("@data", SqlDbType.VarChar, 100).Value = filterText.Text;
                SqlDataAdapter adapter1 = new SqlDataAdapter(sqlCommand1);
                DataSet data1 = new DataSet();
                adapter1.Fill(data1);
                if (data1.Tables.Count > 0)
                {
                    tableKN.DataSource = data1.Tables[0];
                    tableKN.AllowPaging = false;
                    tableKN.DataBind();
                    connection1.Close();
                    QueryBtn.Visible = false;
                    RefreshBtn.Visible = false;
                    SearchBtn.Visible = true;
                    CancelBtn.Visible = true;
                    filterText.Text = null;
                    filterText.Focus();
                    alert.Visible = true;
                    AlertIcon.Attributes.Add("class", "bi bi-clipboard2-data");
                    alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
                    alertText.Text = "Query Executed Succesfully ";
                    ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",2500)</script>");
                }
                else
                {
                    alert.Visible = true;
                    AlertIcon.Attributes.Add("class", " bi bi-exclamation-octagon");
                    alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
                    alertText.Text = "Data Not Found, Try Again";
                    ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",5000)</script>");
                }
            }
        }

        protected void ddlSearchBy_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {

        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {

        }

        protected void addModal_Click(object sender, EventArgs e)
        {

        }
    }
}