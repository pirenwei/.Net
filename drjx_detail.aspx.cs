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
    public partial class drjx_detail : System.Web.UI.Page
    {
        public string cid;
        public Model.article_drjx model;

        public int countArticle = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.cid = HTRequest.GetQueryString("cid");
            if (!IsPostBack)
            {
                GetDetail();

                //绑定精选头条
                if (!string.IsNullOrEmpty(model.video_ids))
                {
                    rptDrtt.DataSource = new BLL.ht_article().GetList(1, "id IN (" + model.video_ids + ")", "is_top desc,id desc");
                    rptDrtt.DataBind();
                }
            }
        }
        //详情
        protected void GetDetail()
        {
            BLL.article_drjx bll = new BLL.article_drjx();
            model = bll.GetModel(this.cid);
            if (model == null)
            {
                Response.Redirect("error.aspx?msg=" + Utils.UrlEncode("出错啦，您要浏览的页面不存在或已删除啦！"));
                return;
            }
            //绑定达人视频
            if (!string.IsNullOrEmpty(model.video_ids))
            {
                countArticle += model.video_ids.Split(',').Length;
                rptDrsp.DataSource = new BLL.ht_article().GetList("id IN (" + model.video_ids + ")");
                rptDrsp.DataBind();
            }
            //绑定达人文章
            if (!string.IsNullOrEmpty(model.article_ids))
            {
                countArticle += model.article_ids.Split(',').Length;
                rptDrwz.DataSource = new BLL.ht_article().GetList("id IN (" + model.article_ids + ")");
                rptDrwz.DataBind();
            }
            //绑定精选头条
            if (!string.IsNullOrEmpty(model.top_article_ids))
            {
                countArticle += model.top_article_ids.Split(',').Length;
                rptJxtt.DataSource = new BLL.ht_article().GetList("id IN (" + model.top_article_ids + ")");
                rptJxtt.DataBind();
            }
        }
    }
}