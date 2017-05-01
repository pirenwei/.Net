using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web
{
    public partial class car_charter_service_detail : System.Web.UI.Page
    {
        public string cid;
        public Model.ht_car_server model;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.cid = HTRequest.GetQueryString("cid");
            if (!IsPostBack)
            {
                GetDetail();
                BindListXGTJ();
                BindListXGGQ();
            }
        }
        //详情
        protected void GetDetail()
        {
            BLL.ht_car_server bll = new BLL.ht_car_server();
            model = bll.GetModel(this.cid);
            if (model == null)
            {
                Response.Redirect("/error.aspx?msg=" + Utils.UrlEncode("出错啦，您要浏览的页面不存在或已删除啦！"));
                return;
            }
            rptImg.DataSource = model.albums;
            rptImg.DataBind();
            model.click++;
            bll.Update(model);
        }

        //相关推荐
        protected void BindListXGTJ()
        {
            rptListXGTJ.DataSource = new BLL.ht_car_server().GetList(10, "status=0 AND type=1", "id desc");
            rptListXGTJ.DataBind();
        }
        //相关标签
        protected void BindListXGGQ()
        {
            rptListXGBQ.DataSource = new BLL.ht_car_server().GetList(16, "status=0 AND type=1", "id desc");
            rptListXGBQ.DataBind();
        }
    }
}