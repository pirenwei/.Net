using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web
{
    public partial class travel_note_post : System.Web.UI.Page
    {
        public int main_id;
        public Model.ht_travel_day model;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.main_id = HTRequest.GetQueryInt("main_id");
            if (!IsPostBack)
            {
                GetDetail();
            }
        }
        //详情
        protected void GetDetail()
        {
            BLL.ht_travel_day bll = new BLL.ht_travel_day();
            model = bll.GetModel(this.main_id);
            if (model == null)
            {
                Response.Redirect("/error.aspx?msg=" + Utils.UrlEncode("出错啦，您要浏览的页面不存在或已删除啦！"));
                return;
            }
        }
        protected Model.users GetUser()
        {
            Model.users model = null;
            //如果Session为Null
            if (HttpContext.Current.Session[HTKeys.SESSION_USER_INFO] != null)
            {
                model = HttpContext.Current.Session[HTKeys.SESSION_USER_INFO] as Model.users;
                model = new BLL.users().GetModel(model.id);
            }
            else
            {
                //检查Cookies
                string username = Utils.GetCookie(HTKeys.COOKIE_USER_NAME_REMEMBER, "HT");
                string password = Utils.GetCookie(HTKeys.COOKIE_USER_PWD_REMEMBER, "HT");
                if (username != "" && password != "")
                {
                    model = new BLL.users().GetModel(username, password, 0, 0, false);
                }
            }
            return model;
        }
    }
}