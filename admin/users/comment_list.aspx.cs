using System;
using System.Text;
using System.Data;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web.admin.users
{
    public partial class comment_list : Web.UI.ManagePage
    {
        protected int totalCount;
        protected int page;
        protected int pageSize;

        protected string property = string.Empty;
        protected string keywords = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            this.property = HTRequest.GetQueryString("property");
            this.keywords = HTRequest.GetQueryString("keywords");

            this.pageSize = GetPageSize(10); //每页数量
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("user_comment", HTEnums.ActionEnum.View.ToString()); //检查权限
                RptBind("parent_id=0 " + CombSqlTxt(this.keywords, this.property), "add_time desc,id desc");
            }
        }

        #region 数据绑定=================================
        private void RptBind(string _strWhere, string _orderby)
        {
            this.page = HTRequest.GetQueryInt("page", 1);
            this.ddlProperty.SelectedValue = this.property;
            this.txtKeywords.Text = this.keywords;
            BLL.ht_common_comment bll = new BLL.ht_common_comment();
            this.rptList.DataSource = bll.GetList(this.pageSize, this.page, _strWhere, _orderby, out this.totalCount);
            this.rptList.DataBind();

            //绑定页码
            txtPageNum.Text = this.pageSize.ToString();
            string pageUrl = Utils.CombUrlTxt("comment_list.aspx", "keywords={0}&property={1}&page={2}", this.keywords, this.property, "__id__");
            PageContent.InnerHtml = Utils.OutPageList(this.pageSize, this.page, this.totalCount, pageUrl, 8);
        }
        #endregion

        #region 组合SQL查询语句==========================
        protected string CombSqlTxt(string _keywords, string _property)
        {
            StringBuilder strTemp = new StringBuilder();
            _keywords = _keywords.Replace("'", "");
            if (!string.IsNullOrEmpty(_keywords))
            {
                strTemp.Append(" and (user_name like '%" + _keywords + "%' or title like '%" + _keywords + "%' or content like '%" + _keywords + "%')");
            }
            if (!string.IsNullOrEmpty(_property))
            {
                switch (_property)
                {
                    case "isLock":
                        strTemp.Append(" and is_lock=1");
                        break;
                    case "unLock":
                        strTemp.Append(" and is_lock=0");
                        break;
                }
            }
            return strTemp.ToString();
        }
        #endregion

        #region 返回评论每页数量=========================
        private int GetPageSize(int _default_size)
        {
            int _pagesize;
            if (int.TryParse(Utils.GetCookie("user_comment_page_size", "HTPage"), out _pagesize))
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
            Response.Redirect(Utils.CombUrlTxt("comment_list.aspx", "keywords={0}&property={1}", txtKeywords.Text, this.property));
        }

        //筛选属性
        protected void ddlProperty_SelectedIndexChanged(object sender, EventArgs e)
        {
            Response.Redirect(Utils.CombUrlTxt("comment_list.aspx", "keywords={0}&property={1}", this.keywords, ddlProperty.SelectedValue));
        }

        //设置分页数量
        protected void txtPageNum_TextChanged(object sender, EventArgs e)
        {
            int _pagesize;
            if (int.TryParse(txtPageNum.Text.Trim(), out _pagesize))
            {
                if (_pagesize > 0)
                {
                    Utils.WriteCookie("user_comment_page_size", "HTPage", _pagesize.ToString(), 14400);
                }
            }
            Response.Redirect(Utils.CombUrlTxt("comment_list.aspx", "keywords={0}&property={1}", this.keywords, this.property));
        }

        //审核
        protected void btnAudit_Click(object sender, EventArgs e)
        {
            ChkAdminLevel("user_comment", HTEnums.ActionEnum.Audit.ToString()); //检查权限
            BLL.ht_common_comment bll = new BLL.ht_common_comment();
            for (int i = 0; i < rptList.Items.Count; i++)
            {
                int id = Convert.ToInt32(((HiddenField)rptList.Items[i].FindControl("hidId")).Value);
                CheckBox cb = (CheckBox)rptList.Items[i].FindControl("chkId");
                if (cb.Checked)
                {
                    bll.UpdateField(id, "is_lock=0");
                }
            }
            AddAdminLog(HTEnums.ActionEnum.Audit.ToString(), "审核评论信息"); //记录日志
            JscriptMsg("审核通过成功！", Utils.CombUrlTxt("comment_list.aspx", "keywords={0}&property={1}",
this.keywords, this.property));
        }

        //批量删除
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            ChkAdminLevel("user_comment", HTEnums.ActionEnum.Delete.ToString()); //检查权限
            int sucCount = 0;
            int errorCount = 0;
            BLL.ht_common_comment bll = new BLL.ht_common_comment();
            for (int i = 0; i < rptList.Items.Count; i++)
            {
                int id = Convert.ToInt32(((HiddenField)rptList.Items[i].FindControl("hidId")).Value);
                CheckBox cb = (CheckBox)rptList.Items[i].FindControl("chkId");
                if (cb.Checked)
                {
                    if (bll.Delete(id,true))
                    {
                        sucCount += 1;
                    }
                    else
                    {
                        errorCount += 1;
                    }
                }
            }
            AddAdminLog(HTEnums.ActionEnum.Delete.ToString(), "删除评论成功" + sucCount + "条，失败" + errorCount + "条"); //记录日志
            JscriptMsg("删除成功" + sucCount + "条，失败" + errorCount + "条！",
                Utils.CombUrlTxt("comment_list.aspx", "keywords={0}&property={1}", this.keywords, this.property));
        }

        protected void rptList_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater rptListRp = e.Item.FindControl("rptListRp") as Repeater;
                DataRowView model = (DataRowView)e.Item.DataItem;
                int id = Common.Utils.ObjToInt(model.Row["id"]);
                rptListRp.DataSource = new BLL.ht_common_comment().GetList(0, "parent_id=" + id, "add_time asc,id desc");
                rptListRp.DataBind();
            }
        }

    }
}