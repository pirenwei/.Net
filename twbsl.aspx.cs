using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HT.Web
{
    public partial class twbsl : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindAdsBn();
                BindListCategory();
                BindListHot();
                BindListNew();
                BindListRecommend();
            }
        }
        protected void BindAdsBn()
        {
            rptListAdsBn.DataSource = new BLL.ht_ads().GetList(5, "status=0 AND code='af3f665fb8f24bb4996b7f2f98f99311'", "sort_id asc,id desc");
            rptListAdsBn.DataBind();
        }
        protected void BindListCategory()
        {
            rptListCategory.DataSource = new BLL.goods_category().GetList(6, "parent_id=0","sort_id asc,id desc");
            rptListCategory.DataBind();
        }
        protected void BindListHot()
        {
            DataSet ds = new BLL.ht_goods().GetList(5, "status=0", "is_hot desc,add_time desc,id desc");
            rptListHot.DataSource = ds;
            rptListHot.DataBind();
        }
        protected void BindListNew()
        {
            DataSet ds = new BLL.ht_goods().GetList(5, "status=0", "is_new desc,add_time desc,id desc");
            rptListNew.DataSource = ds;
            rptListNew.DataBind();
        }
        protected void BindListRecommend()
        {
            DataSet ds = new BLL.ht_goods().GetList(5, "status=0", "is_recommend desc,add_time desc,id desc");
            rptListRecommend.DataSource = ds;
            rptListRecommend.DataBind();
        }
    }
}