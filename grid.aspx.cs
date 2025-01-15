using System;
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
    public partial class grid : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            bind();

        }

        private static DataTable GetData(string query)
        {
            string conString = ConfigurationManager.ConnectionStrings["smt"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conString))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter(query, con))
                {
                    using (DataTable dt = new DataTable())
                    {
                        sda.Fill(dt);
                        return dt;
                    }
                }
            }
        }


        void bind()
        {
            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["con"].ToString();
            con.Open();
            SqlCommand cmd = new SqlCommand("select top(20) *  from WODETAILS", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet  ds  = new DataSet();
            da.Fill(ds);
            con.Close();
            gvCustomers.DataSource = ds;
            gvCustomers.DataBind();
        }



        DataTable BindSecGrid(int id)
        {
            using (
                      SqlConnection con =
                          new SqlConnection(ConfigurationManager.ConnectionStrings["smt"].ConnectionString))
            {

                string Query = "select top(10) * from dbo.alternatePArts where Workorder =" + id;
                SqlCommand cmd = new SqlCommand(Query, con);
                DataTable dt = new DataTable();
                SqlDataAdapter adpt = new SqlDataAdapter(cmd);
                adpt.Fill(dt);

                return dt;
            }
        }
        protected void gvCustomers_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            
        }
    }
}