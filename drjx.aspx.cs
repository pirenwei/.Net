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
    public partial class drjx : System.Web.UI.Page
    {
        protected int totalCount;
        protected int page;
        protected int pageSize;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindList();
                BindListTop();
            }
        }
        protected void BindList()
        {
            this.page = HTRequest.GetQueryInt("page", 1);
            BLL.article_drjx bll = new BLL.article_drjx();
            string whereStr = "status=0 ";
            DataSet ds = bll.GetList(pageSize = 12, page, whereStr, "add_time desc,id desc", out this.totalCount);
            rptList.DataSource = ds;
            rptList.DataBind();
            string pageUrl = Utils.CombUrlTxt("drjx.aspx", "page={0}", "__id__");
            PageContent.InnerHtml = Utils.OutPageListWeb(this.pageSize, this.page, this.totalCount, pageUrl, 3);
        }
        protected void BindListTop()
        {
            rptListTop.DataSource = new BLL.article_drjx().GetList(1, "status=0","is_top desc,update_time desc,id desc");
            rptListTop.DataBind();
        }
    }
}