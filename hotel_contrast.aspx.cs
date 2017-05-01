using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web
{
    public partial class hotel_contrast : System.Web.UI.Page
    {
        EF.HT_DB db = new EF.HT_DB();
        public DateTime dateValue ;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HTRequest.GetQueryString("dateValue") != "")
            {
                dateValue = Convert.ToDateTime(HTRequest.GetQueryString("dateValue"));
            }
            else
            {
                dateValue =Convert.ToDateTime(DateTime.Now.AddDays(3).ToString("yyyy-MM-dd"));
            }
            if (!IsPostBack)
            {
                BindRpt();
            }
        }
        protected void BindRpt()
        {
            string parm = HTRequest.GetQueryString("parm").Trim(',');
            string whereStr = "status=0";
            if (!string.IsNullOrEmpty(parm))
            { 
                whereStr+=" AND id IN (" + parm + ")";
            }
            rptList.DataSource = new BLL.ht_hotel().GetList(4, whereStr, "id desc");
            rptList.DataBind();
        }

        protected string GetServerDesc(object prodNoObj,string tags)
        {
            string strHtml = "";
            string prodNo = prodNoObj.ToString();
            var modelEF = db.DN_Hotel.Where(s=>s.prodNo==prodNo).FirstOrDefault();
            if(modelEF!=null)
            {
                strHtml = modelEF.htlDesc.IndexOf(tags) != -1 ? "active" : "";
            }
            return strHtml;
        }

        //获取房型
        protected string GetHotelRmtp(object DN_ProdNoObj)
        {
            string DN_ProdNo = DN_ProdNoObj.ToString();
            string htmlStr = "";
            //var listRoom = db.DN_RoomList.Where(s => s.prodNo == DN_ProdNo).ToList();
            var listRoomDN = db.DN_RoomPrice.Where(x => x.prodNo == DN_ProdNo && x.begDt == dateValue).ToList();
            foreach (var item in listRoomDN)
            {
                htmlStr += "<p class=\"text\"><span>"+item.roomType+"</span><i></i><em>NT$"+item.price+"</em></p>";
            }
            var listRoomLR = db.LR_RoomList.Where(x => x.hotel_ref == DN_ProdNo).ToList();
            foreach (var item in listRoomLR)
            {
                htmlStr += "<p class=\"text\"><span>" + item.roomType + "</span><i></i><em>£" + item.price + "</em></p>";
            }
            return htmlStr;
        }
        //酒店房间数量
        public int GetHotelRmtpCount(object hotel_idObj)
        {
            int hotel_id = Utils.ObjToInt(hotel_idObj);
            var rmtp_count = db.ht_hotel_rmtp.Where(x => x.hotel_id == hotel_id).Count();
            return Utils.ObjToInt(rmtp_count);
        }
    }
}