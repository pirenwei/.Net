using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web
{
    public partial class login : System.Web.UI.Page
    {
        protected string UrlReferrer;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.UrlReferrer = HTRequest.GetQueryString("UrlReferrer");
            if (Request.UrlReferrer != null)
            {
                this.UrlReferrer = Request.UrlReferrer.ToString();
            }
            if (this.UrlReferrer=="")
            {
                this.UrlReferrer = "/member/member.aspx";
            }
            if (this.UrlReferrer.Contains("login.aspx"))
            {
                this.UrlReferrer = "/member/member.aspx";
            }
            if (this.UrlReferrer.Contains("register.aspx"))
            {
                this.UrlReferrer = "/member/member.aspx";
            }
            if (this.UrlReferrer.Contains("UrlReferrer.aspx"))
            {
                this.UrlReferrer = "/member/member.aspx";
            }
            if (this.UrlReferrer.Contains("discussion_area_post.aspx"))
            {
                this.UrlReferrer = "/discussion_area.aspx";
            }
            if (this.UrlReferrer.Contains("back_password"))
            {
                this.UrlReferrer = "/member/member.aspx";
            }
            if (this.UrlReferrer.Contains("customized_travel_map"))
            {
                this.UrlReferrer = "customized_travel_map.aspx";
            }
        }
    }
}