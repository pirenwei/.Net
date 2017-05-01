using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web
{
    public partial class coupon_success : UI.UserPage
    {
        public int id;
        public Model.ht_shop_coupon model;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.id = HTRequest.GetQueryInt("id");
            if (!IsPostBack)
            {
                GetDetail();
            }
        }
        //详情
        protected void GetDetail()
        {
            BLL.ht_shop_coupon bll = new BLL.ht_shop_coupon();
            model = bll.GetModel(this.id);
            if (model == null)
            {
                Response.Redirect("/error.aspx?msg=" + Utils.UrlEncode("出错啦，您要浏览的页面不存在或已删除啦！"));
                return;
            }
            Model.ht_user_coupon modelUserCoupon = new BLL.ht_user_coupon().GetModel(GetUserInfo().id,model.id);
            if (modelUserCoupon != null)
            {
                Response.Redirect("/error.aspx?msg=" + Utils.UrlEncode("您已领取过，不能重复领取！"));
                return;
            }
            modelUserCoupon = new Model.ht_user_coupon();
            modelUserCoupon.user_id = GetUserInfo().id;
            modelUserCoupon.user_name = GetUserInfo().user_name;
            modelUserCoupon.title = model.title;
            modelUserCoupon.coupon_id = model.id;
            modelUserCoupon.begin_date = model.begin_date;
            modelUserCoupon.end_date = model.end_date;
            modelUserCoupon.remark = model.remark + "【" + model .code+ "】";
            new BLL.ht_user_coupon().Add(modelUserCoupon);
            new BLL.user_message().Add(1, "", userModel.user_name, "您已领取【" + model.title + "】优惠券", "");
        }
    }
}