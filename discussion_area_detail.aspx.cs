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
    public partial class discussion_area_detail : System.Web.UI.Page
    {
        public int totalCount;
        public int page;
        public int pageSize;

        public string cid;
        public Model.ht_bbs_topic model;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.cid = HTRequest.GetQueryString("cid");
            if (!IsPostBack)
            {
                GetDetail();
                BindList();
            }
        }
        //详情
        protected void GetDetail()
        {
            BLL.ht_bbs_topic bll = new BLL.ht_bbs_topic();
            model = bll.GetModel(this.cid);
            if (model == null)
            {
                Response.Redirect("error.aspx?msg=" + Utils.UrlEncode("出错啦，您要浏览的页面不存在或已删除啦！"));
                return;
            }
            if (Utils.GetCookie("token") != cid)
            {
                Utils.WriteCookie("token", cid, 1);
                model.click++;
                bll.Update(model);
            }
        }

        protected void BindList()
        {
            this.page = HTRequest.GetQueryInt("page", 1);
            BLL.ht_bbs_reply bll = new BLL.ht_bbs_reply();
            string whereStr = "status=0 AND topic_id=" + model.id;
            DataSet ds = bll.GetList(pageSize = 10, page, whereStr, "id asc", out this.totalCount);
            rptList.DataSource = ds;
            rptList.DataBind();
            string pageUrl = Utils.CombUrlTxt("discussion_area_detail.aspx", "page={0}&cid={1}", "__id__", model.cid);
            PageContent.InnerHtml = Utils.OutPageListWeb(this.pageSize, this.page, this.totalCount, pageUrl, 3);
        }


        //
        protected Model.users GetUserModel(int user_id)
        {
            Model.users userModel = new BLL.users().GetModel(user_id);
            if (userModel == null)
            {
                userModel = new Model.users();
                userModel.avatar = "/images/niming.png";
                userModel.user_name = "匿名";
                userModel.point = 0;
                userModel.id = 0;
            }
            return userModel;
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