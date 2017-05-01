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
    public partial class hotel_parity_list : System.Web.UI.Page
    {
        protected int totalCount;
        protected int page;
        protected int pageSize;

        public string area;
        protected string sort;
        EF.HT_DB db = new EF.HT_DB();
        protected DateTime dateValue;
        protected string keywords = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HTRequest.GetQueryString("dateValue") != "")
            {
                dateValue = Convert.ToDateTime(HTRequest.GetQueryString("dateValue"));
            }
            else
            {
                dateValue = Convert.ToDateTime(DateTime.Now.AddDays(3).ToString("yyyy-MM-dd"));
            }
            this.keywords = HTRequest.GetQueryString("keywords");
            if (!IsPostBack)
            {
                BindList();
            }
        }

        protected void BindList()
        {
            this.page = HTRequest.GetQueryInt("page", 1);
            this.area = HTRequest.GetQueryString("area");
            this.sort = HTRequest.GetQueryString("sort");
            BLL.ht_hotel bll = new BLL.ht_hotel();
            string whereStr = "status=0 ";
            if (!string.IsNullOrEmpty(this.area))
            {
                whereStr += " AND (area like '%" + this.area + "%' OR address like '%" + this.area + "%')";
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
            string pageUrl = Utils.CombUrlTxt("hotel_parity_list.aspx", "page={0}&area={1}&keywords={2}", "__id__", this.area, this.keywords);
            PageContent.InnerHtml = Utils.OutPageListWeb(this.pageSize, this.page, this.totalCount, pageUrl, 3);
        }

        protected void rptList_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rptListRmtpDN = e.Item.FindControl("rptListRmtpDN") as Repeater;
                Repeater rptListRmtpLR = e.Item.FindControl("rptListRmtpLR") as Repeater;
                DataRowView model = (DataRowView)e.Item.DataItem;
                string DN_ProdNo = model.Row["DN_ProdNo"].ToString();
                string LR_ProdNo = model.Row["LR_ProdNo"].ToString();
                //var listRoom = db.DN_RoomList.Where(s => s.prodNo == DN_ProdNo).ToList();
                var priceRoomDN = db.DN_RoomPrice.Where(x => x.prodNo == DN_ProdNo && x.begDt == dateValue).Min(x=>x.price);
                var listRoomDN = db.DN_RoomPrice.Where(x => x.prodNo == DN_ProdNo && x.begDt == dateValue && x.price == priceRoomDN).ToList().Take(1);
                //
                var priceRoomLR = db.LR_RoomList.Where(x => x.hotel_ref == LR_ProdNo).Min(x=>x.price);
                var listRoomLR = db.LR_RoomList.Where(x => x.hotel_ref == LR_ProdNo && x.price ==priceRoomLR).ToList().Take(1);
                rptListRmtpDN.DataSource = listRoomDN;
                rptListRmtpDN.DataBind();
                rptListRmtpLR.DataSource = listRoomLR;
                rptListRmtpLR.DataBind();
            }
        }

        protected void rptList_ItemCommand(object source, RepeaterCommandEventArgs e)
        {

        }
    }
}