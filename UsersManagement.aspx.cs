using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ManageWO
{
    public partial class UsersManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            CREATE.Visible = true;
            BindGridView();
            
            
        }

        protected void CREATE_Click(object sender, EventArgs e)
        {
            FormUser.Visible = true;
            SAVE.Visible = true;
            CREATE.Visible = false;
            dataFullName.Focus();
            alert.Visible = true;
            AlertIcon.Attributes.Add("class", "bi bi-person-fill-add");
            alert.Attributes.Add("class", " alert alert-info  alert-dismissible ");
            alertText.Text = "Ingrese la informacion necesaria para agregar usuario";
            ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",3000)</script>");
            CancelUser.Visible = true;
        }

        protected void SaveChanges_Click(object sender, EventArgs e)
        {
            int admin = !this.CheckBox1.Checked ? 0 : 1;
            int trained = !this.CheckBox2.Checked ? 0 : 1;
            DateTime dateTime = DateTime.Now;
            string dateFormat = dateTime.ToLongTimeString();
            if (!(dataFullName.Text != "") || !(dataUsername.Text != "") || !(dataPassword.Text != ""))
                return;
            string connectionString = ConfigurationManager.ConnectionStrings["mmc"].ConnectionString;
            SqlConnection connection = new SqlConnection(connectionString);
            SqlCommand sqlCommand1 = new SqlCommand("EditUser", connection);
            sqlCommand1.CommandType = CommandType.StoredProcedure;
            SqlCommand sqlCommand2 = sqlCommand1;
            connection.Open();
            sqlCommand2.Parameters.Add("@User", SqlDbType.VarChar, 50).Value = dataUsername.Text.ToString();
            sqlCommand2.Parameters.Add("@FullName", SqlDbType.VarChar, 300).Value = dataFullName.Text.ToString();
            sqlCommand2.Parameters.Add("@EmpNumber", SqlDbType.VarChar, 10).Value = DataEmployeeNumber.Text.ToString();
            sqlCommand2.Parameters.Add("@Area", SqlDbType.VarChar, 50).Value = dataArea.SelectedValue.ToString();
            sqlCommand2.Parameters.Add("@Pass", SqlDbType.VarChar, 50).Value = dataPassword.Text.ToString();
            sqlCommand2.Parameters.Add("@Admin", SqlDbType.Bit).Value = admin;
            sqlCommand2.Parameters.Add("@Trained", SqlDbType.Bit).Value = trained;
            sqlCommand2.Parameters.Add("@CreateDate", SqlDbType.DateTime).Value = dateFormat;
            SqlDataReader sqlDataReader = sqlCommand2.ExecuteReader();
            sqlDataReader.Read();
            int result = sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("rowAffected"));
            if (result == 1)
            {
                alert.Visible = true;
                AlertIcon.Attributes.Add("class", "bi bi-database-check");
                alert.Attributes.Add("class", " alert alert-success  alert-dismissible ");
                alertText.Text = "Usuario modificado exitosamente";
                ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",5000)</script>");
            }
            else
            {
                alert.Visible = true;
                AlertIcon.Attributes.Add("class", "bi bi-database-fill-x");
                alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
                alertText.Text = "Error al editar usuario: contacte a IT";
                ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",5000)</script>");
            }
            connection.Close();
            dataFullName.Text = string.Empty;
            dataArea.SelectedIndex = 0;
            dataPassword.Text = string.Empty;
            dataUsername.Text = string.Empty;
            DataEmployeeNumber.Text = string.Empty;
            FormUser.Visible = false;
            CheckBox1.Checked = false;
            CheckBox2.Checked = false;
            BindGridView();
            CancelUser.Visible = false;
        }

        protected void SAVE_Click(object sender, EventArgs e)
        {
            int admin = !this.CheckBox1.Checked ? 0 : 1;
            int trained = !this.CheckBox2.Checked ? 0 : 1;
            DateTime dateTime = DateTime.Now;
            string dateFormat = dateTime.ToLongTimeString();
            if (!(dataFullName.Text != "") || !(dataUsername.Text != "") || !(dataPassword.Text != ""))
                return;
            string connectionString = ConfigurationManager.ConnectionStrings["mmc"].ConnectionString;
            SqlConnection connection = new SqlConnection(connectionString);
            SqlCommand sqlCommand1 = new SqlCommand("AddUser", connection);
            sqlCommand1.CommandType = CommandType.StoredProcedure;
            SqlCommand sqlCommand2 = sqlCommand1;
            connection.Open();
            sqlCommand2.Parameters.Add("@User", SqlDbType.VarChar, 50).Value = dataUsername.Text.ToString();
            sqlCommand2.Parameters.Add("@FullName", SqlDbType.VarChar, 300).Value = dataFullName.Text.ToString();
            sqlCommand2.Parameters.Add("@EmpNumber", SqlDbType.VarChar, 10).Value = DataEmployeeNumber.Text.ToString();
            sqlCommand2.Parameters.Add("@Area", SqlDbType.VarChar, 50).Value = dataArea.SelectedValue.ToString();
            sqlCommand2.Parameters.Add("@Pass", SqlDbType.VarChar, 50).Value = dataPassword.Text.ToString();
            sqlCommand2.Parameters.Add("@Admin", SqlDbType.Bit).Value = admin;
            sqlCommand2.Parameters.Add("@Trained", SqlDbType.Bit).Value = trained;
            sqlCommand2.Parameters.Add("@CreateDate", SqlDbType.DateTime).Value = dateFormat;
            SqlDataReader sqlDataReader = sqlCommand2.ExecuteReader();
            sqlDataReader.Read();
            int result = sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("rowAffected"));
            if (result == 1)
            {
                alert.Visible = true;
                AlertIcon.Attributes.Add("class", "bi bi-database-check");
                alert.Attributes.Add("class", " alert alert-success  alert-dismissible ");
                alertText.Text = "Usuario Agregado exitosamente";
                ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",5000)</script>");
            }
            else if (result == 2)
            {
                alert.Visible = true;
                AlertIcon.Attributes.Add("class", "bi bi-person-fill-slash");
                alert.Attributes.Add("class", " alert alert-warning  alert-dismissible ");
                alertText.Text = "Usuario duplicado, ya se econtraba registrado";
                ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",5000)</script>");
            }
            else
            {
                alert.Visible = true;
                AlertIcon.Attributes.Add("class", "bi bi-database-fill-x");
                alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
                alertText.Text = "Error al agregar usuario: contacte a IT";
                ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",5000)</script>");
            }
            connection.Close();
            dataFullName.Text = string.Empty;
            dataArea.SelectedIndex = 0;
            dataPassword.Text = string.Empty;
            dataUsername.Text = string.Empty;
            DataEmployeeNumber.Text = string.Empty;
            FormUser.Visible = false;
            CheckBox1.Checked = false;
            CheckBox2.Checked = false;
            BindGridView();
            CancelUser.Visible = false;
        }

        protected void CancelUser_Click(object sender, EventArgs e)
        {
            CREATE.Visible = true;
            CancelUser.Visible = false;
            FormUser.Visible = false;
            dataArea.SelectedIndex = 0;
            dataFullName.Text = string.Empty;
            dataPassword.Text = string.Empty;
            dataUsername.Text = string.Empty;
            CheckBox1.Checked = false;
            CheckBox2.Checked = false;
            alert.Visible = true;
            AlertIcon.Attributes.Add("class", " bi bi-exclamation-octagon");
            alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
            alertText.Text = "Ingreso Cancelado";
            ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",5000)</script>");
        }

        protected void myTable_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditUser")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = myTable.Rows[index];
                alert.Visible = true;
                AlertIcon.Attributes.Add("class", "bi bi-database-fill");
                alert.Attributes.Add("class", " alert alert-info  alert-dismissible ");
                alertText.Text = "Usuario seleccionado";
                ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",3000)</script>");
                FormUser.Visible = true;
                CancelUser.Visible = true;
                CREATE.Visible = false;
                SaveChanges.Visible = true;
                dataFullName.Text = row.Cells[0].Text;
                DataEmployeeNumber.Text = row.Cells[1].Text.ToString();
                dataArea.Text = row.Cells[2].Text.ToString();
                dataUsername.Text = row.Cells[3].Text.ToString();
                dataPassword.Text = row.Cells[4].Text.ToString();
                if (row.Cells[5].Text == "1" || row.Cells[5].Text == "True")
                {
                    CheckBox1.Checked = true;
                }
                else
                {
                    CheckBox1.Checked = false;
                }
                if (row.Cells[6].Text == "1" || row.Cells[6].Text == "True")
                {
                    CheckBox2.Checked = true;
                }
                else
                {
                    CheckBox2.Checked = false;
                }
            }
            if (e.CommandName == "DeleteUser")
            {
                try
                {
                    int index = Convert.ToInt32(e.CommandArgument);
                    GridViewRow row = myTable.Rows[index];
                    string conString2 = ConfigurationManager.ConnectionStrings["mmc"].ConnectionString;
                    SqlConnection sqlConnection00 = new SqlConnection(conString2);
                    SqlCommand sqlCommand00 = new SqlCommand("DeleteUser", sqlConnection00)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    sqlConnection00.Open();
                    sqlCommand00.Parameters.Add("@User", SqlDbType.VarChar, 30).Value = row.Cells[3].Text.ToString();

                    SqlDataReader sqlDataReader = sqlCommand00.ExecuteReader();
                    sqlDataReader.Read();
                    int result = sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("rowAffected"));
                    if (result >= 1)
                    {
                        alert.Visible = true;
                        AlertIcon.Attributes.Add("class", " bi bi-trash-fill");
                        alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
                        alertText.Text = "Usuario Eliminado";
                        ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",4000)</script>");
                    }
                    else
                    {
                        alert.Visible = true;
                        AlertIcon.Attributes.Add("class", " bi bi-info-circle-fill");
                        alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
                        alertText.Text = "Error al eliminar usuario";
                        ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",4000)</script>");
                    }
                    BindGridView();
                    sqlConnection00.Close();
                }
                catch (Exception ex)
                {
                    alert.Visible = true;
                    AlertIcon.Attributes.Add("class", " bi bi-info-circle-fill");
                    alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
                    alertText.Text = "Something went wrong";
                    ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",4000)</script>");
                    Response.Write("<script language=javascript>alert('" + ex + "');</script>");
                    BindGridView();
                }
            }
        }

        protected void myTable_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.Cells[0].Text = "Nombre completo";
                e.Row.Cells[1].Text = "# Empleado";
                e.Row.Cells[2].Text = "Area";
                e.Row.Cells[3].Text = "Usuario";
                e.Row.Cells[4].Text = "Contraseña";
                e.Row.Cells[5].Text = "Admin?";
                e.Row.Cells[6].Text = "Capacitado?";
                e.Row.Cells[7].Text = "Fecha de Creación";
                e.Row.Cells[8].Text = "Editar";
                e.Row.Cells[9].Text = "Eliminar";
            }
        }

        protected void myTable_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

        }

        protected void myTable_SelectedIndexChanged(object sender, EventArgs e)
        {
            alert.Visible = true;
            AlertIcon.Attributes.Add("class", "bi bi-database-fill");
            alert.Attributes.Add("class", " alert alert-info  alert-dismissible ");
            alertText.Text = "Usuario seleccionado";
            ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",3000)</script>");
            FormUser.Visible = true;
            CancelUser.Visible = true;
            dataFullName.Text = myTable.SelectedRow.Cells[1].Text;
            DataEmployeeNumber.Text = myTable.SelectedRow.Cells[2].Text.ToString();
            dataArea.Text = myTable.SelectedRow.Cells[3].Text.ToString();
            dataUsername.Text = myTable.SelectedRow.Cells[4].Text.ToString();
            dataPassword.Text = myTable.SelectedRow.Cells[5].Text.ToString();
            if (myTable.SelectedRow.Cells[6].Text == "1" || myTable.SelectedRow.Cells[6].Text == "True")
            {
                CheckBox1.Checked = true;
            }
            else
            {
                CheckBox1.Checked = false;
            }
            if (myTable.SelectedRow.Cells[7].Text == "1" || myTable.SelectedRow.Cells[7].Text == "True")
            {
                CheckBox2.Checked = true;
            }
            else
            {
                CheckBox2.Checked = false;
            }
        }
        private void BindGridView()
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["mmc"].ConnectionString))
            {
                SqlCommand sqlCommand = new SqlCommand("GetUsersDetails", connection);
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
            SAVE.Visible = false;
            CREATE.Visible = true;
            SaveChanges.Visible = false;
        }
    }
}