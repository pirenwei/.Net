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
    public partial class tourism_list : System.Web.UI.Page
    {
        protected int totalCount;
        protected int page;
        protected int pageSize;
        protected int channel_id = 5;//主题旅游
        protected string sort;

        public string area;
        protected string keywords = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.area = HTRequest.GetQueryString("area");
            this.keywords = HTRequest.GetQueryString("keywords");
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
            this.sort = HTRequest.GetQueryString("sort");
            BLL.ht_article bll = new BLL.ht_article();
            string whereStr = "status=0 AND is_open=1 AND channel_id=" + channel_id;
            if (!string.IsNullOrEmpty(this.area))
            {
                whereStr += " AND area LIKE '%" + this.area + "%'";
            }
            if (!string.IsNullOrEmpty(this.keywords))
            {
                whereStr += " AND title LIKE '%" + this.keywords + "%'";
            }
            DataSet ds = bll.GetList(pageSize = 12, page, whereStr, UI.WebUI.GetSort(sort), out this.totalCount);
            rptList.DataSource = ds;
            rptList.DataBind();
            string pageUrl = Utils.CombUrlTxt("tourism_list.aspx", "page={0}&area={1}&keywords={2}", "__id__", area, keywords);
            PageContent.InnerHtml = Utils.OutPageListWeb(this.pageSize, this.page, this.totalCount, pageUrl, 3);
        }
    }
}