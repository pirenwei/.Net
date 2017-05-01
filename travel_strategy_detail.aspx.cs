using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web
{
    public partial class travel_strategy_detail : System.Web.UI.Page
    {
        public string cid;
        public Model.ht_article model;
        protected int channel_id = 4;//旅游攻略
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
            BLL.ht_article bll = new BLL.ht_article();
            model = bll.GetModel(this.cid);
            if (model == null)
            {
                Response.Redirect("/error.aspx?msg=" + Utils.UrlEncode("出错啦，您要浏览的页面不存在或已删除啦！"));
                return;
            }
            model.click++;
            bll.Update(model);
        }
        protected void BindListXG()
        {
            rptListTJHotel.DataSource = new BLL.ht_hotel().GetList(3, "status=0", "NewID()");
            rptListTJHotel.DataBind();

            rptListTJShop.DataSource = new BLL.ht_shop().GetList(3, "status=0", "NewID()");
            rptListTJShop.DataBind();

            rptListHistory.DataSource = new BLL.ht_article().GetList(3, "status=0 AND is_open=1 AND channel_id=" + channel_id, "NewID()");
            rptListHistory.DataBind();

            rptListXctj.DataSource = new BLL.ht_travel().GetList(3, "status=0", "NewID()");
            rptListXctj.DataBind();
        }
    }
}