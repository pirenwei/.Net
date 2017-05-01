using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web
{
    public partial class twbsl_detail : System.Web.UI.Page
    {
        public string cid;
        public Model.ht_goods model;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.cid = HTRequest.GetQueryString("cid");
            if (!IsPostBack)
            {
                GetDetail();
                BindListLike();
            }
        }
        //详情
        protected void GetDetail()
        {
            BLL.ht_goods bll = new BLL.ht_goods();
            model = bll.GetModel(this.cid);
            if (model == null)
            {
                Response.Redirect("error.aspx?msg=" + Utils.UrlEncode("出错啦，您要浏览的页面不存在或已删除啦！"));
                return;
            }
            rptImg.DataSource = model.albums;
            rptImg.DataBind();
            model.click++;
            bll.Update(model);
        }

        protected void BindListLike() 
        {
            rptListLike.DataSource = new BLL.ht_goods().GetList(5, "status=0", "NewID()");
            rptListLike.DataBind();
        }
    }
}