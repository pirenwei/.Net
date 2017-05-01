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
    public partial class twbsl_list : System.Web.UI.Page
    {
        protected int totalCount;
        protected int page;
        protected int pageSize;
        protected int category_id;
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
            rptListCategory.DataSource = new BLL.goods_category().GetList(6, "parent_id=0", "sort_id asc,id desc");
            rptListCategory.DataBind();
        }
        protected void BindList()
        {
            this.page = HTRequest.GetQueryInt("page", 1);
            BLL.ht_goods bll = new BLL.ht_goods();
            string whereStr = "status=0 ";
            if (category_id > 0)
            {
                whereStr += " AND category_id=" + category_id;
            }
            DataSet ds = bll.GetList(pageSize = 24, page, whereStr, "add_time desc,id desc", out this.totalCount);
            rptList.DataSource = ds;
            rptList.DataBind();
            string pageUrl = Utils.CombUrlTxt("twbsl_list.aspx", "page={0}", "__id__");
            PageContent.InnerHtml = Utils.OutPageListWeb(this.pageSize, this.page, this.totalCount, pageUrl, 3);
        }
    }
}