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
    public partial class xqxz : System.Web.UI.Page
    {
        protected int totalCount;
        protected int page;
        protected int pageSize;

        protected int channel_id = 1;//行前须知
        public int category_id;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.category_id = HTRequest.GetQueryInt("category_id");
            if (!IsPostBack)
            {
                BindListCategory();
                BindList();
            }
        }
        protected void BindListCategory()
        {
            rptListCategory.DataSource = new BLL.article_category().GetList(0, "notice");
            rptListCategory.DataBind();
        }
        protected void BindList()
        {
            this.page = HTRequest.GetQueryInt("page", 1);
            BLL.ht_article bll = new BLL.ht_article();
            string whereStr = "status=0 AND channel_id=" + channel_id;
            if (this.category_id > 0)
            {
                whereStr += " AND category_id=" + this.category_id;
            }
            DataSet ds = bll.GetList(pageSize = 10, page, whereStr, "add_time desc,id desc", out this.totalCount);
            rptList.DataSource = ds;
            rptList.DataBind();
            string pageUrl = Utils.CombUrlTxt("xqxz.aspx", "page={0}&category_id={1}", "__id__", this.category_id.ToString());
            PageContent.InnerHtml = Utils.OutPageListWeb(this.pageSize, this.page, this.totalCount, pageUrl, 3);
        }
    }
}