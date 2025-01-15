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
    public partial class edit_pthkn : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["material"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (con.State == ConnectionState.Closed)
            {
                con.Open();
            }

            if (!Page.IsPostBack)
            {
                getDataKN(ddlSearchBy.SelectedItem.Text, txtSearch.Text.Trim());
                btnSearch_Click(this, null);
                txtSearch.Enabled = false;
            }
        }

        protected void ddlSearchBy_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlSearchBy.SelectedItem.Text == "All")
            {
                txtSearch.Text = string.Empty;
                txtSearch.Enabled = false;
                btnFilter.Visible = false;
                btnSearch_Click(this, null);
                btnFilter.Enabled = true;
            }
            else
            {
                txtSearch.Enabled = true;
                txtSearch.Text = string.Empty;
                txtSearch.Focus();
            }
            btnFilter.Visible = true;
            btnFilter.Enabled = true;
            alert.Visible = false;
            txtSearch.Attributes["placeholder"] = ddlSearchBy.SelectedItem.Text.ToString();
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            btnSearch_Click(this, null);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            SqlDataAdapter adp = new SqlDataAdapter();
            try
            {
                if (ddlSearchBy.SelectedItem.Text == "WorkOrder")
                {
                    getDataKN(ddlSearchBy.SelectedItem.Text, txtSearch.Text.Trim());
                }
                else if (ddlSearchBy.SelectedItem.Text == "PartNumber")
                {
                    getDataKN(ddlSearchBy.SelectedItem.Text, txtSearch.Text.Trim());
                }
                else
                {
                    getDataKN(ddlSearchBy.SelectedItem.Text, txtSearch.Text.Trim());
                }
            }
            catch (Exception ex)
            {
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Error occured : " + ex.Message.ToString() + "');", true);
                alert.Visible = true;
                AlertIcon.Attributes.Add("class", "bi bi-database-fill");
                alert.Attributes.Add("class", " alert alert-info  alert-dismissible ");
                alertText.Text = ex.Message.ToString();
                ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",2500)</script>");
            }
            finally
            {
                dt.Clear();
                dt.Dispose();
                cmd.Dispose();
                con.Close();
            }
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            ddlSearchBy.SelectedValue = "All";
            txtSearch.Text = string.Empty;
            txtSearch.Enabled = false;
            btnFilter.Visible = false;
            alert.Visible = false;
        }

        protected void myTable_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            //int ID = Convert.ToInt32(myTable.DataKeys[e.RowIndex].Value.ToString());
            //string partnumber = (string)e.NewValues["PartNumber"];
            //string description = (string)e.NewValues["Description"];
            //int qty = (int)e.Keys["KNQty"];
            Label labelID = myTable.Rows[e.RowIndex].FindControl("lblID") as Label;
            TextBox partnumber = myTable.Rows[e.RowIndex].FindControl("txtPartNumber") as TextBox;
            TextBox description = myTable.Rows[e.RowIndex].FindControl("txtDescription") as TextBox;
            TextBox KNQty = myTable.Rows[e.RowIndex].FindControl("txtKNQty") as TextBox;
            TextBox KNQPA = myTable.Rows[e.RowIndex].FindControl("txtQPA") as TextBox;

            int ID = Convert.ToInt32(labelID.Text.ToString());
            int qty = Convert.ToInt32(KNQty.Text.ToString());
            int QPA = Convert.ToInt32(KNQPA.Text.ToString());

            // Update here the database record for the selected patientID
            string connectionString = ConfigurationManager.ConnectionStrings["material"].ConnectionString;
            //string WO = inputWorkorder.Text;
            //string Model = inputModel.Text;
            //int Qty = int.Parse(inputQty.Text);
            //string InitialSN = inputFirstQR.Text;
            //string FinalSN = inputLastQR.Text;
            SqlConnection connection = new SqlConnection(connectionString);
            SqlCommand sqlCommand4 = new SqlCommand("UpdateNP", connection);
            sqlCommand4.CommandType = CommandType.StoredProcedure;
            connection.Open();
            sqlCommand4.Parameters.Add("@ID", SqlDbType.Int).Value = ID;
            sqlCommand4.Parameters.Add("@PartNumber", SqlDbType.VarChar, 30).Value = partnumber.Text.Trim();
            sqlCommand4.Parameters.Add("@Description", SqlDbType.VarChar, 50).Value = description.Text.Trim();
            sqlCommand4.Parameters.Add("@Quantity", SqlDbType.Int).Value = qty;
            sqlCommand4.Parameters.Add("@QPA", SqlDbType.Int).Value = QPA;

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
                alertText.Text = "Partnumber updated succesfully";
                ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",2000)</script>");
            }
            else
            {
                alert.Visible = true;
                AlertIcon.Attributes.Add("class", "bi bi-bug-fill");
                alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
                alertText.Text = "Something went wrong, please contact IT dept";
                ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",2000)</script>");
            }
            myTable.EditIndex = -1;

            getDataKN("", "");
        }

        protected void myTable_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            myTable.PageIndex = e.NewPageIndex;
            getDataKN(ddlSearchBy.SelectedItem.Text, txtSearch.Text.Trim());
        }
        private void BindGridView()
        {
            SqlDataAdapter adp = new SqlDataAdapter();
            DataTable dt = new DataTable();
            try
            {
                adp = new SqlDataAdapter("KittingNote_GridView", con);

                adp.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    myTable.DataSource = dt;
                    myTable.DataBind();
                }
                else
                {
                    myTable.DataSource = null;
                    myTable.DataBind();
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Error occured : " + ex.Message.ToString() + "');", true);
                alert.Visible = true;
                AlertIcon.Attributes.Add("class", "bi bi-bug-fill");
                alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
                alertText.Text = ex.Message.ToString() + "  BindGridView()";
                ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",2500)</script>");
            }
            finally
            {
                dt.Clear();
                dt.Dispose();
                adp.Dispose();
                con.Close();
            }
        }

        protected void myTable_RowEditing(object sender, GridViewEditEventArgs e)
        {
            myTable.EditIndex = e.NewEditIndex;
            getDataKN("", "");
        }

        protected void myTable_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            myTable.EditIndex = -1;
            getDataKN("", "");


        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string conDBsmt = ConfigurationManager.ConnectionStrings["material"].ConnectionString;
            string WO = inputWorkOrder.Text.Trim();
            string NP = inputPartNumber.Text.Trim();
            string DESC = inputDescription.Text.Trim();
            int Qty = int.Parse(inputQty.Text);

            SqlConnection connectionDBsmt = new SqlConnection(conDBsmt);
            SqlCommand cmdSP = new SqlCommand("AddPartnumberKittingNotePTH", connectionDBsmt);
            cmdSP.CommandType = CommandType.StoredProcedure;
            connectionDBsmt.Open();
            cmdSP.Parameters.Add("@WorkOrder", SqlDbType.VarChar, 30).Value = WO;
            cmdSP.Parameters.Add("@PartNumber", SqlDbType.VarChar, 50).Value = NP;
            cmdSP.Parameters.Add("@KNQty", SqlDbType.Int).Value = Qty;
            cmdSP.Parameters.Add("@Description", SqlDbType.VarChar, 100).Value = DESC;


            SqlDataReader sqlDataReader = cmdSP.ExecuteReader();
            sqlDataReader.Read();
            int int32 = sqlDataReader.GetInt32(sqlDataReader.GetOrdinal("rowAffected"));
            connectionDBsmt.Close();
            if (int32 == 0)
            {

                alert.Visible = true;
                AlertIcon.Attributes.Add("class", " bi bi-database-check");
                alert.Attributes.Add("class", " alert alert-success  alert-dismissible");
                alertText.Text = "Numberpart added succesfully";
                ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",4000)</script>");

            }
            else if (int32 == 1)
            {
                alert.Visible = true;
                AlertIcon.Attributes.Add("class", " bi bi-database-x");
                alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
                alertText.Text = "ERROR: Number part is already registered for this workorder   " + WO + " - " + NP;
                ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",4000)</script>");

                //DisableFields();

            }
            else
            {
                alert.Visible = true;
                AlertIcon.Attributes.Add("class", " bi bi-database-x");
                alert.Attributes.Add("class", " alert alert-danger  alert-dismissible ");
                alertText.Text = "something went wrong, please contact IT";
                ClientScript.RegisterStartupScript(GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + alert.ClientID + "').style.display='none'\",4000)</script>");
                //DisableFields();
            }
            inputWorkOrder.Text = string.Empty;
            inputDescription.Text = string.Empty;
            inputPartNumber.Text = string.Empty;
            inputQty.Text = string.Empty;
            getDataKN("", "");
            alert.Visible = false;
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {

        }
        private void getDataKN(string searchBy, string searchVal)
        {
            DataTable dt = new DataTable();
            SqlCommand cmd = new SqlCommand();
            SqlDataAdapter adp = new SqlDataAdapter();
            try
            {
                cmd = new SqlCommand("KittingNote_GridView", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@SearchBy", searchBy);
                cmd.Parameters.AddWithValue("@SearchVal", searchVal);
                adp.SelectCommand = cmd;
                adp.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    myTable.DataSource = dt;
                    myTable.DataBind();
                }
                else
                {
                    myTable.DataSource = dt;
                    myTable.DataBind();
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Error occured : " + ex.Message.ToString() + "');", true);
            }
            finally
            {
                dt.Clear();
                dt.Dispose();
                cmd.Dispose();
                con.Close();
            }
        }
    }
}