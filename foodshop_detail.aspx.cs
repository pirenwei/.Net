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
    public partial class foodshop_detail : System.Web.UI.Page
    {
        public string cid;
        public Model.ht_shop model;
        public int counponCount = 0;
        public int totalCount = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.cid = HTRequest.GetQueryString("cid");
            if (!IsPostBack)
            {
                GetDetail();
                BinListXG();

            }
        }
        //详情
        protected void GetDetail()
        {
            BLL.ht_shop bll = new BLL.ht_shop();
            model = bll.GetModel(this.cid);
            if (model == null)
            {
                Response.Redirect("error.aspx?msg=" + Utils.UrlEncode("出错啦，您要浏览的页面不存在或已删除啦！"));
                return;
            }
            EF.HT_DB db = new EF.HT_DB();
            counponCount = db.ht_shop_coupon.Where(x => x.shop_id == model.id && x.status == 0).Count();
            rptImg.DataSource = model.albums;
            rptImg.DataBind();
        }

        protected void BinListXG()
        {
            DataSet ds = new BLL.ht_shop_coupon().GetList(0, "status=0 AND shop_id=" + model.id, "id desc");
            totalCount = ds.Tables[0].Rows.Count;
            rptCounpon.DataSource = ds;
            rptCounpon.DataBind();
            HT_DB db = new HT_DB();
            var list = ht_shopRepository.Repository.FirstOrDefault(x => x.cid == this.cid);
            rptTJJD.DataSource = db.proc_GetNearHotel(Convert.ToDouble(list.lat), Convert.ToDouble(list.lng)).Take(3);
            rptTJJD.DataBind();
            rptJL.DataSource = new BLL.ht_shop().GetList(3, "status=0", "NewID()");
            rptJL.DataBind();
        }
    }
}