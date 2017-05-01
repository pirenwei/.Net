using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web
{
    public partial class loginout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //清险Session
            HttpContext.Current.Session[HTKeys.SESSION_USER_INFO] = null;
            //清除Cookies
            Utils.WriteCookie(HTKeys.COOKIE_USER_NAME_REMEMBER, "HT", -43200);
            Utils.WriteCookie(HTKeys.COOKIE_USER_PWD_REMEMBER, "HT", -43200);
            //自动登录,跳转URL
            HttpContext.Current.Response.Redirect("/index.aspx");
        }
    }
}