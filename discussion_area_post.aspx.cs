using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web
{
    public partial class discussion_area_post : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                TreeBind();
            }
        }
        #region 绑定类别=================================
        private void TreeBind()
        {
            BLL.ht_bbs_category bll = new BLL.ht_bbs_category();
            DataTable dt = bll.GetList(0);

            this.ddlCategoryId.Items.Clear();
            this.ddlCategoryId.Items.Add(new ListItem("请选择类别...", ""));
            foreach (DataRow dr in dt.Rows)
            {
                string Id = dr["id"].ToString();
                int ClassLayer = int.Parse(dr["class_layer"].ToString());
                string Title = dr["title"].ToString().Trim();

                if (ClassLayer == 1)
                {
                    this.ddlCategoryId.Items.Add(new ListItem(Title, Id));
                }
                else
                {
                    Title = "├ " + Title;
                    Title = Utils.StringOfChar(ClassLayer - 1, "　") + Title;
                    this.ddlCategoryId.Items.Add(new ListItem(Title, Id));
                }
            }
        }
        #endregion

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