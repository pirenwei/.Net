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
    public partial class video : System.Web.UI.Page
    {
        protected int totalCount;
        protected int page;
        protected int pageSize;
        protected int channel_id = 3;//video
        protected int category_id;
        public string area = string.Empty;
        protected string keywords = string.Empty;
        public string month;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.area = HTRequest.GetQueryString("area");
            this.keywords = HTRequest.GetQueryString("keywords");
            this.month = HTRequest.GetQueryString("month");
            if (!IsPostBack)
            {
                BindList();
                BindListHot();
                BindTreeArea();
                BindTreeMonth();
            }
        }
        #region 绑定区域=================================
        private void BindTreeArea()
        {
            rptListArea.DataSource = new BLL.ht_dictionary().GetList("category_id=1");//区域
            rptListArea.DataBind();
        }
        #endregion
        #region 绑定月份=================================
        private void BindTreeMonth()
        {
            DataTable tblDatas = new DataTable();
            DataColumn dtc = new DataColumn("title", typeof(string));
            tblDatas.Columns.Add(dtc);
            for (int i = 1; i <= 12; i++)
            {
                tblDatas.Rows.Add(new object[] { i.ToString() });
            }
            rptListMonth.DataSource = tblDatas;
            rptListMonth.DataBind();
        }
        #endregion
        protected void BindList()
        {
            this.page = HTRequest.GetQueryInt("page", 1);
            this.category_id = HTRequest.GetQueryInt("category_id", 9);
            BLL.ht_article bll = new BLL.ht_article();
            string whereStr = "status=0 AND is_open=1 AND channel_id=" + channel_id + " AND category_id=" + this.category_id;
            if (!string.IsNullOrEmpty(this.area))
            {
                whereStr += " AND area LIKE '%" + this.area + "%'";
            }
            if (!string.IsNullOrEmpty(this.keywords))
            {
                whereStr += " AND title LIKE '%" + this.keywords + "%'";
            }
            if (!string.IsNullOrEmpty(this.month))
            {
                whereStr += " AND MONTH(add_time) =" + this.month;
            }
            DataSet ds = bll.GetList(pageSize = 5, page, whereStr, "add_time desc,id desc", out this.totalCount);
            rptList.DataSource = ds;
            rptList.DataBind();
            string pageUrl = Utils.CombUrlTxt("video.aspx", "page={0}&category_id={1}", "__id__", this.category_id.ToString());
            PageContent.InnerHtml = Utils.OutPageListWeb(this.pageSize, this.page, this.totalCount, pageUrl, 3);
        }
        protected void BindListHot()
        {
            rptListHot.DataSource = new BLL.ht_article().GetList(10, "status=0 AND channel_id=" + channel_id, "click desc,id desc");
            rptListHot.DataBind();
        }
    }
}