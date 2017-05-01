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
    public partial class news : System.Web.UI.Page
    {
        protected int totalCount;
        protected int page;
        protected int pageSize;
        protected int channel_id = 2;//最新消息
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindList();
                BindListHot();
            }
        }
        protected void BindList()
        {
            this.page = HTRequest.GetQueryInt("page", 1);
            BLL.ht_article bll = new BLL.ht_article();
            string whereStr = "status=0 AND channel_id=" + channel_id +" AND category_id=11";
            DataSet ds = bll.GetList(pageSize = 10, page, whereStr, "add_time desc,id desc", out this.totalCount);
            rptList.DataSource = ds;
            rptList.DataBind();
            string pageUrl = Utils.CombUrlTxt("news.aspx", "page={0}", "__id__");
            PageContent.InnerHtml = Utils.OutPageListWeb(this.pageSize, this.page, this.totalCount, pageUrl, 3);
        }
        protected void BindListHot()
        {
            rptListHot.DataSource = new BLL.ht_article().GetList(10, "status=0 AND channel_id=" + channel_id,"click desc,id desc");
            rptListHot.DataBind();
        }
    }
}