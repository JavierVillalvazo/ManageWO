using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace ManageWO
{
    public partial class UploadDeviation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DisableFields();
            SearchBtn.Visible = false;
            //SaveBtn.Visible = false;
            CancelBtn.Visible = false;
            QueryBtn.Visible = true;
            ClearBtn.Visible = false;
            RefreshBtn.Visible = true;
            //UpdateBtn.Visible = false;
            selectPDF.Visible = false;
            BindGridView();

        }

        protected void inputWorkorder_TextChanged(object sender, EventArgs e)
        {

            ClearBtn.Visible = true;
            selectPDF.Visible = true;

        }

        protected void Fudate(object sender, EventArgs e)
        {

        }

        protected void btnFile_Click(object sender, EventArgs e)
        {
            try
            {

                DateTime dt = DateTime.Now;
                string WO = inputWorkorder.Text.ToUpper();
                string model = inputModel.Text;
                string qty = inputQty.Text;
                string filename = Path.GetFileName(fuData.PostedFile.FileName);
                string contentType = fuData.PostedFile.ContentType;
                using (Stream fs = fuData.PostedFile.InputStream)
                {
                    using (BinaryReader br = new BinaryReader(fs))
                    {
                        byte[] bytes = br.ReadBytes((Int32)fs.Length);
                        string constr = ConfigurationManager.ConnectionStrings["dbFiles"].ConnectionString;
                        using (SqlConnection con = new SqlConnection(constr))
                        {
                            string query = "INSERT INTO deviationSMT VALUES (@WorkOrder,@Model,@Quantity,@filename, @uploadedDate, @ContentType, @Data )";
                            using (SqlCommand cmd = new SqlCommand(query))
                            {
                                cmd.Connection = con;
                                cmd.Parameters.AddWithValue("@WorkOrder", WO);
                                cmd.Parameters.AddWithValue("@Model", model);
                                cmd.Parameters.AddWithValue("@Quantity", qty);
                                cmd.Parameters.AddWithValue("@filename", filename);
                                cmd.Parameters.AddWithValue("@uploadedDate", dt);
                                cmd.Parameters.AddWithValue("@ContentType", contentType);
                                cmd.Parameters.AddWithValue("@Data", bytes);
                                con.Open();
                                cmd.ExecuteNonQuery();
                                con.Close();
                                alert.Visible = true;
                                AlertIcon.Attributes.Add("class", "bi bi-database-fill-check");
                                alert.Attributes.Add("class", " alert alert-success  alert-dismissible ");
                                alertText.Text = "Deviation file uploaded succesfully ";
                                ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",4000)</script>");
                            }
                        }
                    }
                }
                BindGridView();
                DisableFields();
                clearFields();
            }
            catch (Exception _e)
            {
                alert.Visible = true;
                AlertIcon.Attributes.Add("class", " bi bi-info-circle-fill");
                alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
                alertText.Text = "Something went wrong: work order duplicada";
                //alertText.Text = "Something went wrong: " + _e.Message;
                ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",4000)</script>");
            }
        }

        protected void ClearBtn_Click(object sender, EventArgs e)
        {
            //DeleteBtn.Visible = false;
            inputWorkorder.Text = null;
            inputModel.Text = null;
            inputQty.Text = null;
            ClearBtn.Visible = false;
            //EditBtn.Visible = false;
            CancelBtn.Visible = false;
            QueryBtn.Visible = true;
            SearchBtn.Visible = false;
            //UpdateBtn.Visible = false;
            DisableFields();
            fuData.Dispose();
            fuData.PostedFile.InputStream.Dispose();
            alert.Visible = true;
            AlertIcon.Attributes.Add("class", " bi bi-exclamation-diamond");
            alert.Attributes.Add("class", " alert alert-warning  alert-dismissible ");
            alertText.Text = "Data fields cleaned";
            ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",1500)</script>");
            BindGridView();
            filterText.Enabled = false;
        }

        protected void Reset_Click(object sender, EventArgs e)
        {
            fuData.Dispose();
        }

        protected void CancelBtn_Click(object sender, EventArgs e)
        {
            filterText.BackColor = System.Drawing.Color.White;
            filterText.Enabled = false;
            SearchBtn.Visible = false;
            RefreshBtn.Visible = true;
            QueryBtn.Visible = true;
            CancelBtn.Visible = false;
            //SaveBtn.Visible = false;
            ClearBtn.Visible = false;
            //UpdateBtn.Visible = false;

            clearFields();
            inputWorkorder.Focus();
            alert.Visible = true;
            AlertIcon.Attributes.Add("class", "bi bi-exclamation-diamond");
            alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
            alertText.Text = "Query cancelled";
            ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",3000)</script>");
            DisableFields();
        }
        public void clearFields()
        {
            inputWorkorder.Text = null;
            inputModel.Text = null;
            inputQty.Text = null;
            filterText.Text = null;
            fuData.Dispose();

        }

        public void EnableFields()
        {

            
            divModel.Visible = true;
            divQty.Visible = true;
            
        }

        public void DisableFields()
        {
            divModel.Visible = false;
            divQty.Visible = false;

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
            //SaveBtn.Visible = false;
            alert.Visible = true;
            //UpdateBtn.Visible = false;
            alert.Visible = true;

            AlertIcon.Attributes.Add("class", "bi bi-database-fill");
            alert.Attributes.Add("class", " alert alert-info  alert-dismissible ");
            alertText.Text = "Query enabled: Search by work order or model";
            ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",3000)</script>");
            DisableFields();
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
            DisableFields();
            clearFields();
            ClearBtn.Visible = false;
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
                e.Row.Cells[1].Text = "WorkOrder";
                e.Row.Cells[2].Text = "Model";
                e.Row.Cells[3].Text = "Quantity";
                e.Row.Cells[4].Text = "File Name";
                e.Row.Cells[5].Text = "Uploaded at";
                e.Row.Cells[6].Text = "Download PDF";
                e.Row.Cells[7].Text = "Delete";
                //e.Row.Cells[8].Text = "File";
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
                   string conString3 = ConfigurationManager.ConnectionStrings["dbFiles"].ConnectionString;
                   SqlConnection sqlConnection001 = new SqlConnection(conString3);
                   SqlCommand sqlCommand001 = new SqlCommand("DeleteDeviation", sqlConnection001)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    sqlConnection001.Open();
                    sqlCommand001.Parameters.Add("@WorkOrder", SqlDbType.VarChar, 50).Value = row2.Cells[1].Text.ToString();
                    sqlCommand001.ExecuteReader();
                    sqlConnection001.Close();
                    alert.Visible = true;
                    AlertIcon.Attributes.Add("class", " bi bi-trash-fill");
                    alert.Attributes.Add("class", " alert alert-warning  alert-dismissible ");
                    alertText.Text = "Deleted Succesfully";
                    ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",4000)</script>");
                    BindGridView();
                }
                catch (Exception ex)
                {

                    alert.Visible = true;
                    AlertIcon.Attributes.Add("class", " bi bi-info-circle-fill");
                    alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
                    alertText.Text = "Something went wrong: " + ex.Message;
                    ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",4000)</script>");
                    BindGridView();
                }

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

        protected void myTable_SelectedIndexChanged(object sender, EventArgs e)
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

        [System.Web.Services.WebMethod]

        public static object GetPDF(int fileId)
        {
            byte[] bytes;
            string fileName, contentType;
            string constr = ConfigurationManager.ConnectionStrings["dbFiles"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.CommandText = "SELECT filename, Data, ContentType FROM deviationSMT WHERE Id = @Id";
                    cmd.Parameters.AddWithValue("@Id", fileId);
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

            return new { FileName = fileName, ContentType = contentType, Data = bytes };
        }
            protected void addButton_Click(object sender, EventArgs e)
        {

        }

        protected void Validate_Click(object sender, EventArgs e)
        {

            SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["con"].ConnectionString);
            SqlCommand sqlCommand1 = new SqlCommand("GetModelQtyByWorkOrder", connection);
            sqlCommand1.CommandType = CommandType.StoredProcedure;
            SqlCommand sqlCommand2 = sqlCommand1;
            connection.Open();
            sqlCommand2.Parameters.Add("@WorkOrder", SqlDbType.VarChar, 50).Value = (object)inputWorkorder.Text.ToUpper();
            SqlDataReader sqlDataReader = sqlCommand2.ExecuteReader();
            sqlDataReader.Read();
            if (sqlDataReader.HasRows)
            {


                string workOrder = sqlDataReader.GetString(sqlDataReader.GetOrdinal("WorkOrder"));
                string model = sqlDataReader.GetString(sqlDataReader.GetOrdinal("Model"));
                int quantity = sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("Quantity"));
                connection.Close();
                EnableFields();
                inputModel.Text = model;
                inputQty.Text = quantity.ToString();
                //selectFile.Visible = true;
                alert.Visible = true;
                AlertIcon.Attributes.Add("class", " bi bi-info-circle-fill");
                alert.Attributes.Add("class", " alert alert-primary  alert-dismissible ");
                alertText.Text = "Work order has been found, please upload pdf file";
                ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",4000)</script>");
                ClientScript.RegisterStartupScript(this.GetType(), "Popup", "$('#exampleModal').modal('show')", true);

            }
            else
            {
                alert.Visible = true;
                AlertIcon.Attributes.Add("class", "bi bi-bug-fill");
                alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
                alertText.Text = "Work order is not available or is invalid";
                ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",4000)</script>");
                inputModel.Text = null;
                inputQty.Text = null;
                inputModel.Visible = false;
                inputQty.Visible = false;
            }
        }

         public void DataFilter()
        {
            DisableFields();
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
                    ClearBtn.Visible = true;
                    RefreshBtn.Visible = false;
                    SearchBtn.Visible = true;
                    CancelBtn.Visible = true;
                    //UpdateBtn.Visible = false;

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

        //protected void View(object sender, EventArgs e)
        //{
        //    string embed = "<object data=\"{0}\" type=\"application/pdf\" width=\"500px\" height=\"300px\">";
        //    embed += "If you are unable to view file, you can download from <a href = \"{0}\">here</a>";
        //    embed += " or download <a target = \"_blank\" href = \"http://get.adobe.com/reader/\">Adobe PDF Reader</a> to view the file.";
        //    embed += "</object>";
        //    ltEmbed.Text = string.Format(embed, ResolveUrl("~/Files/Mudassar_Khan.pdf"));
        //}

    }
}