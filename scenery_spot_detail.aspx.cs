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
    public partial class scenery_spot_detail : System.Web.UI.Page
    {
        public string cid;
        public Model.ht_scenery model;
        protected void Page_Load(object sender, EventArgs e)
        {
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
            BLL.ht_scenery bll = new BLL.ht_scenery();
            model = bll.GetModel(this.cid);
            if (model == null)
            {
                Response.Redirect("/error.aspx?msg=" + Utils.UrlEncode("出错啦，您要浏览的页面不存在或已删除啦！"));
                return;
            }
            rptImg.DataSource = model.albums;
            rptImg.DataBind();
        }

        protected void BindListXG()
        {
            HT_DB db = new HT_DB();
            var list= ht_sceneryRepository.Repository.FirstOrDefault(x => x.cid == this.cid);
            rptTJJD.DataSource = db.proc_GetNearHotel(Convert.ToDouble(list.lat), Convert.ToDouble(list.lng)).Take(15);
            rptTJJD.DataBind();
            rptTJJD1.DataSource = db.proc_GetNearHotel(Convert.ToDouble(list.lat), Convert.ToDouble(list.lng)).OrderByDescending(x => x.commentCount).Take(3);
            rptTJJD1.DataBind();
            rptTJYS.DataSource = db.proc_GetNearShop(Convert.ToDouble(list.lat), Convert.ToDouble(list.lng)).Take(15);
            rptTJYS.DataBind();
            rptTJYS1.DataSource = db.proc_GetNearShop(Convert.ToDouble(list.lat), Convert.ToDouble(list.lng)).OrderByDescending(x => x.commentCount).Take(3);
            rptTJYS1.DataBind();
            rptTJFJ.DataSource = db.proc_GetNearScenery(Convert.ToDouble(list.lat), Convert.ToDouble(list.lng)).Where(x=>x.cid!=this.cid).Take(15);
            rptTJFJ.DataBind();
            rptTJFJ1.DataSource = db.proc_GetNearScenery(Convert.ToDouble(list.lat), Convert.ToDouble(list.lng)).Where(x => x.cid != this.cid).OrderByDescending(x => x.commentCount).Take(3);
            rptTJFJ1.DataBind();
            rptJL.DataSource = new BLL.ht_scenery().GetList(3, "status=0", "NewID()");
            rptJL.DataBind();
        }
    }
}