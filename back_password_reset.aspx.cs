using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web
{
    public partial class back_password_reset : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HTRequest.GetQueryString("code") != "")
            {
                string usercode = HTRequest.GetQueryString("code");
                try
                {
                    Model.users model = new BLL.users().GetModel(Utils.ObjToInt(DESEncrypt.Decrypt(usercode)));
                    if (model == null)
                    {
                        Response.Write("<script>alert('链接失效！');location.href='back_password.aspx'</script>");
                    }
                    else
                    {
                        Utils.WriteCookie("back_password_userid", model.id.ToString(), 20);
                    }
                }
                catch
                {
                    Response.Write("<script>alert('链接失效！');location.href='back_password.aspx'</script>");
                }
            }
            else
            {
                string status = Utils.GetCookie("back_password_status");
                if (status != "success")
                {
                    Response.Write("<script>alert('链接失效！');location.href='back_password.aspx'</script>");
                }
            }
        }
    }
}