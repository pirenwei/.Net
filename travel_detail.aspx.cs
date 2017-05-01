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
    public partial class travel_detail : System.Web.UI.Page
    {
        public int id;
        public string Lat ="25.196853";
        public string Lng = "121.403877";
        public Model.ht_travel model;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.id = HTRequest.GetQueryInt("id");
            if (!IsPostBack)
            {
                GetDetail();
                BindListDay();
                BindListXG();
            }
        }

        
        protected string GetItemString(object item_idObj, object typeObj,string fieldName)
        {
            string str = "";
            switch (Utils.ObjToInt(typeObj))
            {
                case 1://景点
                    Model.ht_scenery modelScenery = new BLL.ht_scenery().GetModel(Utils.ObjToInt(item_idObj));
                    if (modelScenery != null)
                    {
                        switch (fieldName)
                        { 
                            case "img_url":
                                str = modelScenery.img_url;
                                break;
                            case "address":
                                str = modelScenery.address;
                                break;
                            case "link":
                                str = "/scenery_spot_detail.aspx?cid=" + modelScenery.cid;
                                break;
                        }
                    }
                    break;
                case 2://酒店
                    Model.ht_hotel modelHotel = new BLL.ht_hotel().GetModel(Utils.ObjToInt(item_idObj));
                    if (modelHotel != null)
                    {
                        switch (fieldName)
                        { 
                            case "img_url":
                                str = modelHotel.img_url;
                                break;
                            case "address":
                                str = modelHotel.address;
                                break;
                            case "link":
                                str = "/hotel_parity_detail.aspx?cid=" + modelHotel.cid;
                                break;
                        }
                    }
                    break;
                case 3://店家
                    Model.ht_shop modelShop = new BLL.ht_shop().GetModel(Utils.ObjToInt(item_idObj));
                    if (modelShop != null)
                    {
                        switch (fieldName)
                        { 
                            case "img_url":
                                str = modelShop.img_url;
                                break;
                            case "address":
                                str = modelShop.address;
                                break;
                            case "link":
                                str = "/foodshop_detail.aspx?cid=" + modelShop.cid;
                                break;
                        }
                    }
                    break;
            }
            return str;
        }

        //是否招募
        protected string GroupStatusHtml()
        {
            string htmlStr = "";
            HT_DB db = new HT_DB();
            var modelViewGroup = db.view_travel_group.Where(x => x.id == model.id).FirstOrDefault();
            var modelGroup = db.travel_group.Where(x => x.travel_id == modelViewGroup.id).FirstOrDefault();
            if (modelGroup != null)
            {
                if (Utils.ObjectToDateTime(modelGroup.end_date) >= DateTime.Now && modelGroup.status == 0)
                {
                    if (Utils.ObjToInt(modelViewGroup.renshu) > Utils.ObjToInt(modelViewGroup.apCount))
                    {
                        htmlStr = "<span class=\"zhaomu\">招募中</span>";
                    }
                    else if (Utils.ObjToInt(modelViewGroup.renshu) == Utils.ObjToInt(modelViewGroup.apCount))
                    {
                        htmlStr = "<span class=\"zhaomu\">已额满</span>";
                    }
                }
                else
                {
                    htmlStr = "<span class=\"zhaomu\">已结束</span>";
                }
            }
            return htmlStr;
        }

        //详情
        protected void GetDetail()
        {
            BLL.ht_travel bll = new BLL.ht_travel();
            model = bll.GetModel(this.id);
            if (model == null)
            {
                Response.Redirect("/error.aspx?msg=" + Utils.UrlEncode("出错啦，您要浏览的页面不存在或已删除啦！"));
                return;
            }
           var plan= ht_travel_day_planRepository.Repository.FirstOrDefault(x => x.travel_id == model.id);
           if (plan != null)
           {
               Lat = plan.lat;
               Lng = plan.lng;
           }

        }

        protected void BindListXG()
        {
            rptTjHotel.DataSource = new BLL.ht_hotel().GetList(5, "status=0", "NewID()");
            rptTjHotel.DataBind();
            rptTjShop.DataSource = new BLL.ht_shop().GetList(5, "status=0", "NewID()");
            rptTjShop.DataBind();
        }

        protected void BindListDay()
        {
            rptListDay.DataSource = new BLL.ht_travel_day().GetList(0, "travel_id="+model.id, "id asc");
            rptListDay.DataBind();
        }
        protected void rptListDay_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rptItem = e.Item.FindControl("rptItem") as Repeater;
                DataRowView model = (DataRowView)e.Item.DataItem;
                int id = Common.Utils.ObjToInt(model.Row["id"]);
                rptItem.DataSource = new BLL.ht_travel_day_plan().GetList(0, "day_id=" + id, "id asc");
                rptItem.DataBind();
            }
        }
    }
}