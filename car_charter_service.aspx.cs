using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;
using HT.EF;
namespace HT.Web
{
    public partial class car_charter_service : System.Web.UI.Page
    {
        protected int totalCount;
        protected int page;
        protected int pageSize;

        public string price;
        public string area;
        public string areaLine;
        protected string keywords = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.price = HTRequest.GetQueryString("price");
            this.area = HTRequest.GetQueryString("area");
            this.areaLine = HTRequest.GetQueryString("areaLine");
            this.keywords = HTRequest.GetQueryString("keywords");
            if (!IsPostBack)
            {
                BindTreePrice();
                BindTreeArea();
                BindTreeAreaLine();
                BindList();
                BindListHot();
                BindListYHBC();
            }
        }

        #region 绑定价格=================================
        private void BindTreePrice()
        {
            DataTable tblDatas = new DataTable();
            DataColumn dtc = new DataColumn("title", typeof(string));
            tblDatas.Columns.Add(dtc);
            tblDatas.Rows.Add(new object[] { "0-200" });
            tblDatas.Rows.Add(new object[] { "200-500" });
            tblDatas.Rows.Add(new object[] { "500-1000" });
            tblDatas.Rows.Add(new object[] { "1000-10000" });
            rptListPrice.DataSource = tblDatas;
            rptListPrice.DataBind();
        }
        #endregion
        #region 绑定区域=================================
        private void BindTreeArea()
        {
            rptListArea.DataSource = new BLL.ht_dictionary().GetList("category_id=1");//区域
            rptListArea.DataBind();
        }
        #endregion
        #region 绑定路线=================================
        private void BindTreeAreaLine()
        {
            if (this.area != "")
            {
                int? p_id = ht_dictionaryRepository.Repository.FirstOrDefault(x => x.title == this.area).id;
                if (p_id != null)
                {
                    rptListAreaLine.DataSource = new BLL.ht_dictionary().GetList("category_id=2 and p_id=" + p_id + "");//路线
                }
                else
                {
                    rptListAreaLine.DataSource = new BLL.ht_dictionary().GetList("category_id=2");//路线
                }
            }
            else {
                rptListAreaLine.DataSource = new BLL.ht_dictionary().GetList("category_id=2");//路线
            }
           
            rptListAreaLine.DataBind();
        }
        #endregion

        protected void BindList()
        {
            this.page = HTRequest.GetQueryInt("page", 1);
            BLL.ht_car_server bll = new BLL.ht_car_server();
            string whereStr = "status=0 AND type=1";
            if (!string.IsNullOrEmpty(this.price))
            {
                string[] priceArr = this.price.Split('-');
                whereStr += " AND sell_price BETWEEN " + priceArr[0] + " AND " + priceArr[1];
            }
            if (!string.IsNullOrEmpty(this.area))
            {
                whereStr += " AND area LIKE '%" + this.area + "%'";
            }
            if (!string.IsNullOrEmpty(this.areaLine))
            {
                whereStr += " AND area_line LIKE '%" + this.areaLine + "%'";
            }
            if (!string.IsNullOrEmpty(this.keywords))
            {
                whereStr += " AND title LIKE '%" + this.keywords + "%'";
            }
            DataSet ds = bll.GetList(pageSize = 16, page, whereStr, "add_time desc,id desc", out this.totalCount);
            rptList.DataSource = ds;
            rptList.DataBind();
            string pageUrl = Utils.CombUrlTxt("car_charter_service.aspx", "page={0}&price={1}&area={2}&areaLine={3}&keywords={4}", "__id__", price, area, areaLine, keywords);
            PageContent.InnerHtml = Utils.OutPageListWeb(this.pageSize, this.page, this.totalCount, pageUrl, 3);
        }
        protected void BindListHot()
        {
            rptListHot.DataSource = new BLL.ht_car_server().GetList(3, "status=0 AND type=1", "is_recommend desc,id desc");
            rptListHot.DataBind();
        }
        protected void BindListYHBC()
        {
            rptListYHBC.DataSource = new BLL.ht_car_server().GetList(3, "status=0 AND type=1", "sell_price asc,id desc");
            rptListYHBC.DataBind();
        }
    }
}