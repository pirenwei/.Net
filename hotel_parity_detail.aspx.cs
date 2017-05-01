using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;
using HT.EF;
namespace HT.Web
{
    public partial class hotel_parity_detail : System.Web.UI.Page
    {
        public string cid;
        public Model.ht_hotel model;
        EF.HT_DB db = new EF.HT_DB();
        public DateTime dateValue;
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
            this.cid = HTRequest.GetQueryString("cid");
            if (!IsPostBack)
            {
                GetDetail();
                BindListXG();
            }
        }
        //详情
        protected void GetDetail()
        {
            BLL.ht_hotel bll = new BLL.ht_hotel();
            model = bll.GetModel(this.cid);
            if (model == null)
            {
                Response.Redirect("error.aspx?msg=" + Utils.UrlEncode("出错啦，您要浏览的页面不存在或已删除啦！"));
                return;
            }
            rptImg.DataSource = model.albums;
            rptImg.DataBind();
        }
        protected void BindListXG()
        {
            //rptListRmtp.DataSource = new BLL.ht_hotel_rmtp().GetList(0, "hotel_id=" + model.id, "sort_id asc,id asc");
            //rptListRmtp.DataBind();

            //var listRoom = db.DN_RoomList.Where(s => s.prodNo == model.DN_ProdNo).ToList();
            var listRoomDN = db.DN_RoomPrice.Where(x => x.prodNo == model.DN_ProdNo && x.begDt == dateValue).ToList();
            rptListRmtpDN.DataSource = listRoomDN;
            rptListRmtpDN.DataBind();
            var listRoomLR = db.LR_RoomList.Where(x => x.hotel_ref == model.LR_ProdNo).ToList();
            rptListRmtpLR.DataSource = listRoomLR;
            rptListRmtpLR.DataBind();

            var list = ht_hotelRepository.Repository.FirstOrDefault(x => x.cid == this.cid);

            rptHistory.DataSource = new BLL.ht_hotel().GetList(3, "status=0", "NewID()");
            rptHistory.DataBind();
            rptTJJD.DataSource = db.proc_GetNearHotel(Convert.ToDouble(list.lat), Convert.ToDouble(list.lng)).Where(x=>x.cid!=this.cid).Take(12);
            rptTJJD.DataBind();
            rpZBMS.DataSource = db.proc_GetNearShop(Convert.ToDouble(list.lat), Convert.ToDouble(list.lng)).Take(3);
            rpZBMS.DataBind();
            rptJDTJ.DataSource = db.proc_GetNearScenery(Convert.ToDouble(list.lat), Convert.ToDouble(list.lng)).Take(3);
            rptJDTJ.DataBind();
        }
    }
}