using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DocumentFormat.OpenXml.Wordprocessing;
using DocumentFormat.OpenXml.EMMA;
using DocumentFormat.OpenXml.Office2010.Excel;

namespace ManageWO
{
    public partial class UploadAlterns : System.Web.UI.Page
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
                //DisableFields();
                BindGridView();
                //OriginalStateButton();
            }
        }

        public void EnableFields()
        {
            inputWorkorder.Enabled = true;
            inputModel.Enabled = true;
            inputKN.Enabled = true;
            inputOriginal.Enabled = true;
            inputAlternate.Enabled = true;
            inputECN.Enabled = true;
        }

        public void DisableFields()
        {
            //inputWorkorder.Enabled = false;
            //inputModel.Enabled = false;
            //inputKN.Enabled = false;
            inputOriginal.Enabled = true;
            inputAlternate.Enabled = true;
            inputECN.Enabled = true;

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
            using (SqlConnection connection1 = new SqlConnection(ConfigurationManager.ConnectionStrings["smt"].ConnectionString))
            {
                SqlCommand sqlCommand1 = new SqlCommand("GetLastAlternatesLike", connection1);
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


        protected void NewBtn_Click(object sender, EventArgs e)
        {
            inputID.Text = null;
            inputWorkorder.Text = null;
            inputModel.Text = null;
            inputKN.Text = null;
            inputOriginal.Text = null;
            inputAlternate.Text = null;
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
            btnReset.Visible = false;
            alert.Visible = true;
            AlertIcon.Attributes.Add("class", " bi bi-info-circle-fill");
            alert.Attributes.Add("class", " alert alert-info  alert-dismissible ");
            alertText.Text = "Add a new Alternate part";
            ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",2000)</script>");
            //SaveBtn.Visible = true;
            EnableFields();
        }

        protected void btnNewWO_Click(object sender, EventArgs e)
        {

        }

        protected void SaveBtn_Click(object sender, EventArgs e)
        {
            string WO = inputWorkorder.Text.Trim();
            string Model = inputModel.Text.Trim();
            string KN = inputKN.Text.Trim();
            string Original = inputOriginal.Text.Trim();
            string Alternate = inputAlternate.Text.Trim();
            string ECN = inputECN.Text.Trim();

            string conDBsmt = ConfigurationManager.ConnectionStrings["smt"].ConnectionString;
            using (SqlConnection connectionDBsmt = new SqlConnection(conDBsmt))
            {
                SqlCommand cmdSP = new SqlCommand("AddAlternPartsDB", connectionDBsmt);
                cmdSP.CommandType = CommandType.StoredProcedure;

                // Agregar parámetros del procedimiento almacenado
                cmdSP.Parameters.Add("@WorkOrder", SqlDbType.VarChar, 50).Value = WO;
                cmdSP.Parameters.Add("@KittingNote", SqlDbType.VarChar, 50).Value = KN;
                cmdSP.Parameters.Add("@Model", SqlDbType.VarChar, 50).Value = Model;
                cmdSP.Parameters.Add("@PartNumber", SqlDbType.VarChar, 50).Value = Original;
                cmdSP.Parameters.Add("@AlternatePartNumber", SqlDbType.VarChar, 50).Value = Alternate;
                cmdSP.Parameters.Add("@ECN", SqlDbType.VarChar, 50).Value = ECN;

                try
                {
                    connectionDBsmt.Open();
                    SqlDataReader sqlDataReader = cmdSP.ExecuteReader();

                    if (sqlDataReader.Read())
                    {
                        // Obtiene el resultado del procedimiento almacenado
                        int rowAffected = sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("rowAffected"));

                        if (rowAffected == 1)
                        {
                            // Operación exitosa
                            alert.Visible = true;
                            AlertIcon.Attributes.Add("class", "bi bi-database-check");
                            alert.Attributes.Add("class", "alert alert-success alert-dismissible");
                            alertText.Text = "Alternate Partnumber added successfully";
                            inputOriginal.Text = string.Empty;
                            inputAlternate.Text = string.Empty;
                        }
                        else
                        {
                            // Registro duplicado o faltante
                            alert.Visible = true;
                            AlertIcon.Attributes.Add("class", "bi bi-database-x");
                            alert.Attributes.Add("class", "alert alert-danger alert-dismissible");
                            alertText.Text = "Partnumber duplicated or something is missing";
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Manejo de errores
                    alert.Visible = true;
                    AlertIcon.Attributes.Add("class", "bi bi-exclamation-triangle");
                    alert.Attributes.Add("class", "alert alert-danger alert-dismissible");
                    alertText.Text = "An error occurred: " + ex.Message;
                }
                finally
                {
                    connectionDBsmt.Close();
                }
                BindGridView();
                btnReset.Visible = true;
                DisableFields();
            }

            //SqlConnection connectionDBsmt = new SqlConnection(conDBsmt);
            //SqlCommand cmdSP = new SqlCommand("AddAlternPartsDB", connectionDBsmt);
            //cmdSP.CommandType = CommandType.StoredProcedure;
            //connectionDBsmt.Open();
            //cmdSP.Parameters.Add("@WorkOrder", SqlDbType.VarChar, 30).Value = WO;
            //cmdSP.Parameters.Add("@Model", SqlDbType.VarChar, 50).Value = Model;
            //cmdSP.Parameters.Add("@KittingNote", SqlDbType.Int).Value = KN;
            //cmdSP.Parameters.Add("@PartNumber", SqlDbType.VarChar, 100).Value = Original;
            //cmdSP.Parameters.Add("@AlternatePartNumber", SqlDbType.VarChar, 100).Value = Alternate;
            //cmdSP.Parameters.Add("@ECN", SqlDbType.VarChar, 100).Value = ECN;
            //SqlDataReader sqlDataReader = cmdSP.ExecuteReader();
            //sqlDataReader.Read();
            //int int32 = sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("rowAffected"));
            //connectionDBsmt.Close();
            //if (int32 == 1)
            //{
            //    alert.Visible = true;
            //    AlertIcon.Attributes.Add("class", " bi bi-database-check");
            //    alert.Attributes.Add("class", " alert alert-success  alert-dismissible");
            //    alertText.Text = "Partnumber added succesfully";
            //    ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",4000)</script>");
            //}
            //else
            //{
            //    alert.Visible = true;
            //    AlertIcon.Attributes.Add("class", " bi bi-database-x");
            //    alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
            //    alertText.Text = "Partnumber duplicated or something is missing";
            //    ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",4000)</script>");

            //    DisableFields();

            //}
            //SaveBtn.Visible = false;
            //ClearBtn.Visible = false;
            //NewBtn.Visible = true;
            //SearchBtn.Visible = false;
            //CancelBtn.Visible = false;
            //QueryBtn.Visible = true;
            //RefreshBtn.Visible = true;
            //filterText.Enabled = false;
            //UpdateBtn.Visible = false;

            //clearFields();
            //DisableFields();
            //BindGridView();
        }


        private void ShowAlert(string message, string iconClass, string alertClass)
        {
            alert.Visible = true;
            AlertIcon.Attributes.Add("class", iconClass);
            alert.Attributes.Add("class", alertClass);
            alertText.Text = message;
            ClientScript.RegisterStartupScript(GetType(), "HideLabel",
                $"<script type=\"text/javascript\">setTimeout(\"document.getElementById('{alert.ClientID}').style.display='none'\",4000)</script>");
        }
        protected void UpdateBtn_Click(object sender, EventArgs e)
        {

            int id = int.Parse(inputID.Text);
            string workOrder = inputWorkorder.Text;
            string model = inputModel.Text;
            string kittingNote = inputKN.Text;
            string Original = inputOriginal.Text;
            string alternatePartNumber = inputAlternate.Text;
            string ecn = inputECN.Text;
            bool result = UpdateAlternate(id, workOrder, kittingNote, model, Original, alternatePartNumber, ecn);

            if (result)
            {
                // Mostrar mensaje de éxito
                alert.Visible = true;
                AlertIcon.Attributes.Add("class", "bi bi-check2-circle");
                alert.Attributes.Add("class", "alert alert-success alert-dismissible");
                alertText.Text = "Partnumber updated successfully ID: " + id;
            }
            //else
            //{
            //    // Mostrar mensaje de error
            //    alert.Visible = true;
            //    AlertIcon.Attributes.Add("class", "bi bi-x-circle");
            //    alert.Attributes.Add("class", "alert alert-danger alert-dismissible");
            //    alertText.Text = "Error updating partnumber ID: " + id;
            //}

            // Ocultar el mensaje después de 4 segundos
            ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(function(){document.getElementById('" + alert.ClientID + "').style.display='none';}, 4000);</script>");
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

        

        protected void addButton_Click(object sender, EventArgs e)
        {

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

        public void clearFields()
        {
            inputWorkorder.Text = null;
            inputModel.Text = null;
            inputKN.Text = null;
            inputID.Text = null;
            inputOriginal.Text = null;
            inputAlternate.Text = null;
            filterText.Text = null;
            inputECN.Text = string.Empty;
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
            alertText.Text = "Query enabled: Search by work order, model, Original or Alternate";
            ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",3000)</script>");
            DisableFields();
        }

        protected void filterText_TextChanged(object sender, EventArgs e)
        {
            DataFilter();
        }

        protected void SearchBtn_Click(object sender, EventArgs e)
        {

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
            alertText.Text = "Refresh";
            ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",3000)</script>");
        }

        protected void myTable_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        protected void myTable_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ComDelete")
            {
                try
                {
                    int index2 = Convert.ToInt32(e.CommandArgument);
                    GridViewRow row2 = myTable.Rows[index2];
                    string connectionString = ConfigurationManager.ConnectionStrings["smt"].ConnectionString;
                    SqlConnection connection = new SqlConnection(connectionString);
                    SqlCommand sqlCommand4 = new SqlCommand("DeleteAlternatePN", connection);
                    sqlCommand4.CommandType = CommandType.StoredProcedure;
                    connection.Open();
                    sqlCommand4.Parameters.Add("@ID", SqlDbType.VarChar, 30).Value = row2.Cells[1].Text.ToString();
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
                        alertText.Text = "Alternate partnumber deleted succesfully";
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
                alertText.Text = "Alternate Partnumber for: " + row.Cells[2].Text + " is ready to edit.";
                ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",3000)</script>");
                clearFields();
                EnableFields();
                inputID.Text = row.Cells[1].Text;
                inputWorkorder.Text = row.Cells[2].Text;
                inputKN.Text = row.Cells[3].Text;
                inputModel.Text = row.Cells[4].Text;
                inputOriginal.Text = row.Cells[5].Text;
                inputAlternate.Text = row.Cells[6].Text;
                string ECN = row.Cells[7].Text.ToString();
                if (ECN == "&nbsp;" || string.IsNullOrWhiteSpace(ECN))
                {
                    inputECN.Text = string.Empty;
                }
                else
                {
                inputECN.Text = row.Cells[7].Text;
                }
                NewBtn.Visible = false;
                UpdateBtn.Visible = true;
                SaveBtn.Visible = false;
                ClearBtn.Visible = true;
            }
        }

        public bool UpdateAlternate(int id, string workOrder, string kittingNote, string model,
                                string partNumber, string alternatePartNumber, string ecn)
        {
            string conDBsmt = ConfigurationManager.ConnectionStrings["smt"].ConnectionString;


            using (SqlConnection connectionDBsmt = new SqlConnection(conDBsmt))
            {
                SqlCommand cmd = new SqlCommand("UpdateAlternatePN", connectionDBsmt);
                cmd.CommandType = CommandType.StoredProcedure;

                // Agregar los parámetros al procedimiento almacenado
                cmd.Parameters.AddWithValue("@ID", id);
                cmd.Parameters.AddWithValue("@WorkOrder", workOrder);
                cmd.Parameters.AddWithValue("@KittingNote", kittingNote);
                cmd.Parameters.AddWithValue("@Model", model);
                cmd.Parameters.AddWithValue("@PartNumber", partNumber);
                cmd.Parameters.AddWithValue("@AlternatePartNumber", alternatePartNumber);
                cmd.Parameters.AddWithValue("@ECN", ecn);

                try
                {
                    connectionDBsmt.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();  // Ejecutar el procedimiento almacenado

                    // Verificar si se actualizó al menos una fila
                    return rowsAffected > 0;
                }
                catch (Exception ex)
                {
                    // Manejo de errores
                   // Log.Error("Error updating alternate part number", ex);

                    // Mensaje amigable para el usuario
                    alert.Visible = true;
                    AlertIcon.Attributes.Add("class", "bi bi-x-circle");
                    alert.Attributes.Add("class", "alert alert-danger alert-dismissible");
                    alertText.Text = "An unexpected error occurred while updating the part number. ERROR: "+ ex.Message;
                    return false;
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
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["smt"].ConnectionString))
            {
                SqlCommand sqlCommand = new SqlCommand("GetLastAlternates", connection);
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

        protected void btnReset_Click(object sender, EventArgs e)
        {
            btnReset.Visible = false;
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
            alertText.Text = "insert a new workorder";
            ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",1500)</script>");

            //OriginalStateButton();
            clearFields();
            BindGridView();
            DisableFields();
            filterText.Enabled = false;
        }

        public void SearchWorkorder(string workorder)
        {
            //string workorder = inputWorkorder.Text.Trim();
            string conDBsmt = ConfigurationManager.ConnectionStrings["smt"].ConnectionString;


            using (SqlConnection connectionDBsmt = new SqlConnection(conDBsmt))
            { 
            }
            }
    }
}