using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web
{
    public partial class xqxz_detail : System.Web.UI.Page
    {
        public string cid;
        public Model.ht_article model;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.cid = HTRequest.GetQueryString("cid");
            if (!IsPostBack)
            {
                GetDetail();
                BindListCategory();
            }
        }
        protected void BindListCategory()
        {
            rptListCategory.DataSource = new BLL.article_category().GetList(0, "notice");
            rptListCategory.DataBind();
        }
        //详情
        protected void GetDetail()
        {
            BLL.ht_article bll = new BLL.ht_article();
            model = bll.GetModel(this.cid);
            if (model == null)
            {
                Response.Redirect("error.aspx?msg=" + Utils.UrlEncode("出错啦，您要浏览的页面不存在或已删除啦！"));
                return;
            }
            model.click++;
            bll.Update(model);
        }
        //上一篇
        protected string Previous()
        {
            string str = "无";
            string whereStr = "status=0 AND add_time <= getdate() AND id<" + model.id +" AND category_id =" +model.category_id;
            whereStr += " ORDER BY id desc";
            List<Model.ht_article> modelList = new BLL.ht_article().GetModelList(whereStr);
            if(modelList.Count>0)
            {
                str = "<a href=\"xqxz_detail.aspx?cid="+modelList[0].cid+"\">" + modelList[0].title + "</a>";
            }
            return str;
        }
        //下一篇
        protected string Next()
        {
            string str = "无";
            string whereStr = "status=0 AND add_time <= getdate() AND id>" + model.id + " AND category_id =" + model.category_id;
            whereStr += " ORDER BY id desc";
            List<Model.ht_article> modelList = new BLL.ht_article().GetModelList(whereStr);
            if (modelList.Count > 0)
            {
                str = "<a href=\"xqxz_detail.aspx?cid=" + modelList[0].cid + "\">" + modelList[0].title + "</a>";
            }
            return str;
        }
    }
}