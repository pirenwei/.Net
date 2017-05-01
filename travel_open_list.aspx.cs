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
    public partial class travel_open_list : System.Web.UI.Page
    {
        protected int totalCount;
        protected int page;
        protected int pageSize;

        protected string sort;
        protected int gt;

        public string days;
        public string month;
        public string area;
        protected string keywords = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.gt = HTRequest.GetQueryInt("gt");

            this.days = HTRequest.GetQueryString("days");
            this.month = HTRequest.GetQueryString("month");
            this.area = HTRequest.GetQueryString("area");
            this.keywords = HTRequest.GetQueryString("keywords");
            if (!IsPostBack)
            {
                BindTreeDays();
                BindTreeMonth();
                BindTreeArea();

                BindList();
            }
        }
        #region 绑定天数=================================
        private void BindTreeDays()
        {
            DataTable tblDatas = new DataTable();
            DataColumn dtc = new DataColumn("title", typeof(string));
            tblDatas.Columns.Add(dtc);
            tblDatas.Rows.Add(new object[] { "1-3" });
            tblDatas.Rows.Add(new object[] { "3-5" });
            tblDatas.Rows.Add(new object[] { "5-10" });
            tblDatas.Rows.Add(new object[] { "10-20" });
            rptListDays.DataSource = tblDatas;
            rptListDays.DataBind();
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
        #region 绑定区域=================================
        private void BindTreeArea()
        {
            rptListArea.DataSource = new BLL.ht_dictionary().GetList("category_id=1");//区域
            rptListArea.DataBind();
        }
        #endregion
        protected void BindList()
        {
            this.sort = HTRequest.GetQueryString("sort");
            string order_by = sort;
            switch (order_by)
            {
                case "pl":
                    order_by = "plCount desc";
                    break;
                case "zan":
                    order_by = "zanCount desc";
                    break;
                case "addtime":
                    order_by = "id desc";
                    break;
                default:
                    order_by = "id desc";
                    break;
            }
            this.page = HTRequest.GetQueryInt("page", 1);
            BLL.ht_travel bll = new BLL.ht_travel();
            string whereStr = "is_open=1 ";
            if (gt > 0)
            {
                switch (gt)
                {
                    case 1:
                        whereStr += " AND groupCount=1 AND renshu-apCount<3";
                        order_by = "apCount desc,id desc";
                        break;
                    case 2:
                        whereStr += " AND groupCount=1";
                        order_by = "renshu desc,id desc";
                        break;
                    case 3:
                        whereStr += " AND groupCount=1";
                        order_by = "id desc";
                        break;
                }
            }

            if (!string.IsNullOrEmpty(this.days))
            {
                string[] daysArr = this.days.Split('-');
                whereStr += " AND DATEDIFF(DAY,begin_date,end_date) BETWEEN " + daysArr[0] + " AND " + daysArr[1];
            }
            if (!string.IsNullOrEmpty(this.month))
            {
                whereStr += " AND MONTH(begin_date) =" + this.month;
            }
            if (!string.IsNullOrEmpty(this.area))
            {
                whereStr += " AND area LIKE '%" + this.area + "%'";
            }
            if (!string.IsNullOrEmpty(this.keywords))
            {
                whereStr += " AND title LIKE '%" + this.keywords + "%'";
            }
            DataSet ds = bll.GetList(pageSize = 10, page, whereStr, order_by, out this.totalCount);
            rptList.DataSource = ds;
            rptList.DataBind();
            string pageUrl = Utils.CombUrlTxt("travel_open_list.aspx", "page={0}&days={1}&area={2}&month={3}&keywords={4}", "__id__", days, area, month, keywords);
            PageContent.InnerHtml = Utils.OutPageListWeb(this.pageSize, this.page, this.totalCount, pageUrl, 3);
        }
    }
}