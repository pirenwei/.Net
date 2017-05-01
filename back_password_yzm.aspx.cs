using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web
{
    public partial class back_password_yzm : System.Web.UI.Page
    {
        public Model.users model;
        protected void Page_Load(object sender, EventArgs e)
        {
            int user_id = Utils.StrToInt(Utils.GetCookie("back_password_userid"), 0);
            if (user_id > 0)
            {
                model = new BLL.users().GetModel(user_id);
            }
            else
            {
                model = new Model.users();
                model.mobile = "";
                Response.Write("<script>alert('页面已失效！');location.href='back_password.aspx'</script>");
            }
        }
    }
}