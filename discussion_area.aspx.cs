using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web
{
    public partial class discussion_area : System.Web.UI.Page
    {
        protected int totalCount;
        protected int page;
        protected int pageSize;

        public int category_id;
        public int sort = 0;
        public string type="";
        protected void Page_Load(object sender, EventArgs e)
        {
            this.category_id = HTRequest.GetQueryInt("category_id");
            this.sort = HTRequest.GetQueryInt("sort");
            this.type = HTRequest.GetQueryString("type");
            if (!IsPostBack)
            {
                BindListCategory();
                BindList();
            }
        }
        protected int GetCountTopic(int _category_id)
        {
            string whereStr = "status=0";
            if (_category_id > 0)
            {
                whereStr += " AND category_id in (select id from ht_bbs_category where parent_id=" + _category_id+")";
            }
            if (!string.IsNullOrEmpty(type))
            {
                switch (type)
                { 
                    case "is_elite":
                        whereStr += " AND is_elite=1";
                        break;
                    case "is_top":
                        whereStr += " AND is_top=1";
                        break;
                }
            }
            return new BLL.ht_bbs_topic().GetRecordCount(whereStr);
        }
        protected void BindListCategory()
        {
            rptListCategory.DataSource = new BLL.ht_bbs_category().GetList(3, "parent_id=0", "sort_id asc,id desc");
            rptListCategory.DataBind();
        }
        protected void BindList()
        {
            this.page = HTRequest.GetQueryInt("page", 1);
            
            BLL.ht_bbs_topic bll = new BLL.ht_bbs_topic();
            string whereStr = "status=0";
            if (this.category_id > 0)
            {
                whereStr += " AND category_id in (select id from ht_bbs_category where parent_id=" + this.category_id + ")";
            }
            if (!string.IsNullOrEmpty(type))
            {
                switch (type)
                {
                    case "is_elite":
                        whereStr += " AND is_elite=1";
                        break;
                    case "is_top":
                        whereStr += " AND is_top=1";
                        break;
                }
            }
            DataSet ds = bll.GetList(pageSize = 20, page, whereStr, GetOrderBy(this.sort), out this.totalCount);
            rptList.DataSource = ds;
            rptList.DataBind();
            string pageUrl = Utils.CombUrlTxt("discussion_area.aspx", "page={0}&category_id={1}&sort={2}", "__id__", this.category_id.ToString(), this.sort.ToString());
            PageContent.InnerHtml = Utils.OutPageListWeb(this.pageSize, this.page, this.totalCount, pageUrl, 3);
        }

        protected string GetOrderBy(int sort)
        {
            string _orderBy = "is_elite desc,is_top desc,id desc";
            switch (sort)
            {
                case 1:
                    _orderBy = "click desc,id desc";
                    break;
                case 2:
                    _orderBy = "add_time desc,id desc";
                    break;
            }
            return _orderBy;
        }
    }
}