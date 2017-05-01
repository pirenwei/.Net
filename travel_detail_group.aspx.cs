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
    public partial class travel_detail_group : System.Web.UI.Page
    {
        public int id;
        public string Lat = "25.196853";
        public string Lng = "121.403877";
        public Model.ht_travel model;
        EF.HT_DB db = new EF.HT_DB();
        public bool joingroup_isshow = true;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.id = HTRequest.GetQueryInt("id");
            if (!IsPostBack)
            {
                GetDetail();
                BindListXG();
            }
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
                if (Utils.ObjectToDateTime(modelGroup.end_date) >= DateTime.Now.Date && modelGroup.status == 0)
                {
                    if (Utils.ObjToInt(modelViewGroup.renshu) > Utils.ObjToInt(modelViewGroup.apCount))
                    {
                        htmlStr = "<span class=\"zhaomu\">招募中</span>";
                 
                    }
                    else if (Utils.ObjToInt(modelViewGroup.renshu) == Utils.ObjToInt(modelViewGroup.apCount))
                    {
                        htmlStr = "<span class=\"zhaomu\">已额满</span>";
                        joingroup_isshow = false;
                    }
                }
                else
                {
                    htmlStr = "<span class=\"zhaomu\">已结束</span>";
                    joingroup_isshow = false;
                }
            }
            return htmlStr;
        }

        //是否登录
        protected Model.users GetUser()
        {
            Model.users model = null;
            //如果Session为Null
            if (HttpContext.Current.Session[HTKeys.SESSION_USER_INFO] != null)
            {
                model = HttpContext.Current.Session[HTKeys.SESSION_USER_INFO] as Model.users;
                model = new BLL.users().GetModel(model.id);
            }
            else
            {
                //检查Cookies
                string username = Utils.GetCookie(HTKeys.COOKIE_USER_NAME_REMEMBER, "HT");
                string password = Utils.GetCookie(HTKeys.COOKIE_USER_PWD_REMEMBER, "HT");
                if (username != "" && password != "")
                {
                    model = new BLL.users().GetModel(username, password, 0, 0, false);
                }
            }
            return model;
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
            var plan = ht_travel_day_planRepository.Repository.FirstOrDefault(x => x.travel_id == model.id);
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

            /////////////
            List<EF.travel_group> list = db.travel_group.Where<EF.travel_group>(x => x.travel_id == model.id).ToList<EF.travel_group>();
            rptListGourp.DataSource = list;
            rptListGourp.DataBind();

        }

        protected void rptListGourp_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rptGroupApply = e.Item.FindControl("rptGroupApply") as Repeater;
                EF.travel_group model = (EF.travel_group)e.Item.DataItem;
                int group_id = Utils.ObjToInt(model.id);
                var list = db.travel_group_apply.Where<EF.travel_group_apply>(x => x.group_id == group_id).ToList();
                rptGroupApply.DataSource = list;
                rptGroupApply.DataBind();

                rptGroupApplyList.DataSource = list;
                rptGroupApplyList.DataBind();
            }
        }

    }
}