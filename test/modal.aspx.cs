using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ManageWO.test
{
    public partial class test : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                List<String> names = new List<string>() { "Kobe", "Jordan", "Wilt" };
                gvTest.DataSource = names;
                gvTest.DataBind();
            }
        }

        protected void gvTest_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Button btnShowSubscription = (Button)e.Row.FindControl("btnShowSubscription");
                if (btnShowSubscription != null)
                {
                    // usually if my DataItem is an object, I'll cast it first and make sure it's not null
                    btnShowSubscription.CommandArgument = (string)e.Row.DataItem;
                }
            }
        }

        protected void gvTest_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (string.Equals(e.CommandName, "Subscription"))
            {
                // again, probably cast this and do a !string.IsNullOrWhiteSpace() check
                switch ((string)e.CommandArgument)
                {
                    case "Kobe":
                        this.lblTestOutput.Text = "Kobe is the best";
                        break;
                    case "Wilt":
                        this.lblTestOutput.Text = "Wilt is the best";
                        break;
                    case "Jordan":
                        this.lblTestOutput.Text = "Jordan is the best";
                        break;
                }

                ClientScript.RegisterClientScriptBlock(typeof(string), "ShowSubscriptionStatus", "ShowStatus();", true);
            }
        }
    }
}