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
    public partial class scenery_spot : System.Web.UI.Page
    {
        protected int totalCount;
        protected int page;
        protected int pageSize;

        protected string area;
        protected string keywords = string.Empty;

        protected string sort;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.area = HTRequest.GetQueryString("area");
            this.keywords = HTRequest.GetQueryString("keywords");

            this.sort = HTRequest.GetQueryString("sort");
            if (!IsPostBack)
            {
                BindTreeArea();
                BindList();
            }
        }

        #region 绑定区域=================================
        private void BindTreeArea()
        {
            rptListArea.DataSource = new BLL.ht_dictionary().GetList("category_id=1");//区域
            rptListArea.DataBind();
        }
        #endregion

        protected void BindList()
        {
            this.page = HTRequest.GetQueryInt("page", 1);
            BLL.ht_scenery bll = new BLL.ht_scenery();
            string whereStr = "status=0 ";
            if (!string.IsNullOrEmpty(this.area))
            {
                whereStr += " AND area like '%" + this.area + "%'";
            }
            if (!string.IsNullOrEmpty(this.keywords))
            {
                whereStr += " AND title LIKE '%" + this.keywords + "%'";
            }
            string order_by = UI.WebUI.GetSort(sort);
            if (order_by == "id desc")
            {
                order_by = "sort_id asc," + order_by;
            }
            DataSet ds = bll.GetList(pageSize = 10, page, whereStr, order_by, out this.totalCount);
            rptList.DataSource = ds;
            rptList.DataBind();
            string pageUrl = Utils.CombUrlTxt("scenery_spot.aspx", "page={0}&area={1}&keywords={2}", "__id__", this.area, keywords);
            PageContent.InnerHtml = Utils.OutPageListWeb(this.pageSize, this.page, this.totalCount, pageUrl, 3);
        }

    }
}