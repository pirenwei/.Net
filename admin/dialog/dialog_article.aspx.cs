using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web.admin.dialog
{
    public partial class dialog_article : UI.ManagePage
    {
        protected int totalCount;
        protected int page;
        protected int pageSize;

        protected int main_id;
        protected int type_id;
        protected string channel_ids="0";
        protected int category_id;
        protected string property = string.Empty;
        protected string keywords = string.Empty;
        protected string prolistview = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            this.main_id = HTRequest.GetQueryInt("main_id");
            this.type_id = HTRequest.GetQueryInt("type_id");
            switch (this.type_id)
            { 
                case 1:
                    channel_ids = "3";//视频
                    break;
                case 2:
                    channel_ids = "4,5";//文章
                    break;
                case 3:
                    channel_ids = "3,4,5";//头条
                    break;
            }
            this.category_id = HTRequest.GetQueryInt("category_id");
            this.keywords = HTRequest.GetQueryString("keywords");
            this.property = HTRequest.GetQueryString("property");

            this.pageSize = GetPageSize(12); //每页数量
            this.prolistview = Utils.GetCookie("article_list_view"); //显示方式
            if (!Page.IsPostBack)
            {
                RptBind("status=0 " + CombSqlTxt(this.type_id, this.keywords, this.property), "sort_id asc,add_time desc,id desc");
            }
        }

        #region 数据绑定=================================
        private void RptBind(string _strWhere, string _orderby)
        {
            this.page = HTRequest.GetQueryInt("page", 1);
            this.ddlProperty.SelectedValue = this.property;
            this.txtKeywords.Text = this.keywords;
            //图表或列表显示
            BLL.ht_article bll = new BLL.ht_article();
            switch (this.prolistview)
            {
                case "Txt":
                    this.rptList2.Visible = false;
                    this.rptList1.DataSource = bll.GetList(this.pageSize, this.page, _strWhere, _orderby, out this.totalCount);
                    this.rptList1.DataBind();
                    break;
                default:
                    this.rptList1.Visible = false;
                    this.rptList2.DataSource = bll.GetList(this.pageSize, this.page, _strWhere, _orderby, out this.totalCount);
                    this.rptList2.DataBind();
                    break;
            }
            //绑定页码
            txtPageNum.Text = this.pageSize.ToString();
            string pageUrl = Utils.CombUrlTxt("dialog_article.aspx", "page={0}&type_id={1}&keywords={2}&property={3}&main_id={4}", "__id__", this.type_id.ToString(), this.category_id.ToString(), this.keywords, this.property, this.main_id.ToString());
            PageContent.InnerHtml = Utils.OutPageList(this.pageSize, this.page, this.totalCount, pageUrl, 8);
        }
        #endregion

        #region 组合SQL查询语句==========================
        protected string CombSqlTxt(int _type_id, string _keywords, string _property)
        {
            StringBuilder strTemp = new StringBuilder();
            strTemp.Append(" and channel_id in(" + channel_ids + ")");
            _keywords = _keywords.Replace("'", "");
            if (!string.IsNullOrEmpty(_keywords))
            {
                strTemp.Append(" and (title like '%" + _keywords + "%' OR user_name like '%" + _keywords + "%')");
            }
            if (!string.IsNullOrEmpty(_property))
            {
                switch (_property)
                {
                    case "isTop":
                        strTemp.Append(" and is_top=1");
                        break;
                    case "isRed":
                        strTemp.Append(" and is_red=1");
                        break;
                    case "isHot":
                        strTemp.Append(" and is_hot=1");
                        break;
                }
            }
            return strTemp.ToString();
        }
        #endregion

        #region 返回图文每页数量=========================
        private int GetPageSize(int _default_size)
        {
            int _pagesize;
            if (int.TryParse(Utils.GetCookie("article_page_size", "HTcmsPage"), out _pagesize))
            {
                if (_pagesize > 0)
                {
                    return _pagesize;
                }
            }
            return _default_size;
        }
        #endregion

        //关健字查询
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Response.Redirect(Utils.CombUrlTxt("dialog_article.aspx", "type_id={0}&keywords={1}&property={2}&main_id={3}", this.type_id.ToString(), txtKeywords.Text, this.property,this.main_id.ToString()));
        }

        //筛选属性
        protected void ddlProperty_SelectedIndexChanged(object sender, EventArgs e)
        {
            Response.Redirect(Utils.CombUrlTxt("dialog_article.aspx", "type_id={0}&keywords={1}&property={2}&main_id={3}", this.type_id.ToString(),this.keywords, ddlProperty.SelectedValue));
        }

        //设置文字列表显示
        protected void lbtnViewTxt_Click(object sender, EventArgs e)
        {
            Utils.WriteCookie("article_list_view", "Txt", 14400);
            Response.Redirect(Utils.CombUrlTxt("dialog_article.aspx", "page={0}&type_id={1}&keywords={2}&property={3}&main_id={4}", this.page.ToString(), this.type_id.ToString(), this.keywords, this.property,this.main_id.ToString()));
        }

        //设置图文列表显示
        protected void lbtnViewImg_Click(object sender, EventArgs e)
        {
            Utils.WriteCookie("article_list_view", "Img", 14400);
            Response.Redirect(Utils.CombUrlTxt("dialog_article.aspx", "page={0}&type_id={1}&keywords={2}&property={3}&main_id={4}", this.page.ToString(), this.type_id.ToString(), this.keywords, this.property, this.main_id.ToString()));
        }

        //设置分页数量
        protected void txtPageNum_TextChanged(object sender, EventArgs e)
        {
            int _pagesize;
            if (int.TryParse(txtPageNum.Text.Trim(), out _pagesize))
            {
                if (_pagesize > 0)
                {
                    Utils.WriteCookie("article_page_size", "HTcmsPage", _pagesize.ToString(), 43200);
                }
            }
            Response.Redirect(Utils.CombUrlTxt("dialog_article.aspx", "page={0}&type_id={1}&keywords={2}&property={3}&main_id={4}", this.page.ToString(), this.type_id.ToString(), this.keywords, this.property, this.main_id.ToString()));
        }

    }
}