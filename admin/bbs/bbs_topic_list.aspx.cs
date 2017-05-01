using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web.admin.bbs
{
    public partial class bbs_topic_list : Web.UI.ManagePage
    {
        protected int totalCount;
        protected int page;
        protected int pageSize;

        protected int category_id;
        protected string property = string.Empty;
        protected string keywords = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            this.category_id = HTRequest.GetQueryInt("category_id");
            this.keywords = HTRequest.GetQueryString("keywords");
            this.property = HTRequest.GetQueryString("property");

            this.pageSize = GetPageSize(10); //每页数量
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("bbs_topic", HTEnums.ActionEnum.View.ToString()); //检查权限
                TreeBind(); //绑定类别
                RptBind("id>0" + CombSqlTxt(this.category_id, this.keywords, this.property), "add_time desc,id desc");
            }
        }

        #region 绑定类别=================================
        private void TreeBind()
        {
            BLL.ht_bbs_category bll = new BLL.ht_bbs_category();
            DataTable dt = bll.GetList(0);

            this.ddlCategoryId.Items.Clear();
            this.ddlCategoryId.Items.Add(new ListItem("所有类别", ""));
            foreach (DataRow dr in dt.Rows)
            {
                string Id = dr["id"].ToString();
                int ClassLayer = int.Parse(dr["class_layer"].ToString());
                string Title = dr["title"].ToString().Trim();

                if (ClassLayer == 1)
                {
                    this.ddlCategoryId.Items.Add(new ListItem(Title, Id));
                }
                else
                {
                    Title = "├ " + Title;
                    Title = Utils.StringOfChar(ClassLayer - 1, "　") + Title;
                    this.ddlCategoryId.Items.Add(new ListItem(Title, Id));
                }
            }
        }
        #endregion

        #region 数据绑定=================================
        private void RptBind(string _strWhere, string _orderby)
        {
            this.page = HTRequest.GetQueryInt("page", 1);
            if (this.category_id > 0)
            {
                this.ddlCategoryId.SelectedValue = this.category_id.ToString();
            }
            this.ddlProperty.SelectedValue = this.property;
            this.txtKeywords.Text = this.keywords;
            //列表显示
            BLL.ht_bbs_topic bll = new BLL.ht_bbs_topic();
            this.rptList.DataSource = bll.GetList(this.pageSize, this.page, _strWhere, _orderby, out           this.totalCount);
            this.rptList.DataBind();
            //绑定页码
            txtPageNum.Text = this.pageSize.ToString();
            string pageUrl = Utils.CombUrlTxt("bbs_topic_list.aspx", "category_id={0}&keywords={1}&property={2}&page={3}", this.category_id.ToString(), this.keywords, this.property, "__id__");
            PageContent.InnerHtml = Utils.OutPageList(this.pageSize, this.page, this.totalCount, pageUrl, 8);
        }
        #endregion

        #region 组合SQL查询语句==========================
        protected string CombSqlTxt(int _category_id, string _keywords, string _property)
        {
            StringBuilder strTemp = new StringBuilder();
            if (_category_id > 0)
            {
                strTemp.Append(" and category_id=" + _category_id);
            }
            _keywords = _keywords.Replace("'", "");
            if (!string.IsNullOrEmpty(_keywords))
            {
                strTemp.Append(" and title like '%" + _keywords + "%'");
            }
            if (!string.IsNullOrEmpty(_property))
            {
                switch (_property)
                {
                    case "isLock":
                        strTemp.Append(" and status=1");
                        break;
                    case "unIsLock":
                        strTemp.Append(" and status=0");
                        break;
                    case "isTop":
                        strTemp.Append(" and is_top=1");
                        break;
                    case "isElite":
                        strTemp.Append(" and is_elite=1");
                        break;
                }
            }
            return strTemp.ToString();
        }
        #endregion
        //设置操作
        protected void rptList_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            ChkAdminLevel("bbs_topic", HTEnums.ActionEnum.Edit.ToString()); //检查权限
            int id = Convert.ToInt32(((HiddenField)e.Item.FindControl("hidId")).Value);
            BLL.ht_bbs_topic bll = new BLL.ht_bbs_topic();
            Model.ht_bbs_topic model = bll.GetModel(id);
            switch (e.CommandName)
            {
                case "lbtnIsTop":
                    if (model.is_top == 1)
                        bll.UpdateField(id, "is_top=0");
                    else
                        bll.UpdateField(id, "is_top=1");
                    break;
                case "lbtnIsElite":
                    if (model.is_elite == 1)
                        bll.UpdateField(id, "is_elite=0");
                    else
                        bll.UpdateField(id, "is_elite=1");
                    break;
            }
            this.RptBind("id>0 " + CombSqlTxt(this.category_id, this.keywords, this.property), "add_time desc,id desc");
        }
        #region 返回图文每页数量=========================
        private int GetPageSize(int _default_size)
        {
            int _pagesize;
            if (int.TryParse(Utils.GetCookie("bbsTopic_page_size", "HTPage"), out _pagesize))
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
            Response.Redirect(Utils.CombUrlTxt("bbs_topic_list.aspx", "category_id={0}&keywords={1}&property={2}",
                this.category_id.ToString(), txtKeywords.Text, this.property));
        }

        //筛选类别
        protected void ddlCategoryId_SelectedIndexChanged(object sender, EventArgs e)
        {
            Response.Redirect(Utils.CombUrlTxt("bbs_topic_list.aspx", "category_id={0}&keywords={1}&property={2}",
                ddlCategoryId.SelectedValue, this.keywords, this.property));
        }

        //筛选属性
        protected void ddlProperty_SelectedIndexChanged(object sender, EventArgs e)
        {
            Response.Redirect(Utils.CombUrlTxt("bbs_topic_list.aspx", "category_id={0}&keywords={1}&property={2}",
               this.category_id.ToString(), this.keywords, ddlProperty.SelectedValue));
        }

        //设置分页数量
        protected void txtPageNum_TextChanged(object sender, EventArgs e)
        {
            int _pagesize;
            if (int.TryParse(txtPageNum.Text.Trim(), out _pagesize))
            {
                if (_pagesize > 0)
                {
                    Utils.WriteCookie("bbsTopic_page_size", "HTPage", _pagesize.ToString(), 43200);
                }
            }
            Response.Redirect(Utils.CombUrlTxt("bbs_topic_list.aspx", "category_id={0}&keywords={1}&property={2}",
                this.category_id.ToString(), this.keywords, this.property));
        }

        //批量审核
        protected void btnAudit_Click(object sender, EventArgs e)
        {
            ChkAdminLevel("bbs_topic", HTEnums.ActionEnum.Audit.ToString()); //检查权限
            BLL.ht_bbs_topic bll = new BLL.ht_bbs_topic();
            for (int i = 0; i < rptList.Items.Count; i++)
            {
                int id = Convert.ToInt32(((HiddenField)rptList.Items[i].FindControl("hidId")).Value);
                CheckBox cb = (CheckBox)rptList.Items[i].FindControl("chkId");
                if (cb.Checked)
                {
                    bll.UpdateField(id, "status=0");
                }
            }
            AddAdminLog(HTEnums.ActionEnum.Audit.ToString(), "审核帖子内容信息"); //记录日志
            JscriptMsg("批量审核成功！", Utils.CombUrlTxt("bbs_topic_list.aspx", "category_id={0}&keywords={1}&property={2}", this.category_id.ToString(), this.keywords, this.property));
        }

        //批量删除
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            ChkAdminLevel("bbs_topic", HTEnums.ActionEnum.Delete.ToString()); //检查权限
            int sucCount = 0; //成功数量
            int errorCount = 0; //失败数量
            BLL.ht_bbs_topic bll = new BLL.ht_bbs_topic();
            for (int i = 0; i < rptList.Items.Count; i++)
            {
                int id = Convert.ToInt32(((HiddenField)rptList.Items[i].FindControl("hidId")).Value);
                CheckBox cb = (CheckBox)rptList.Items[i].FindControl("chkId");
                if (cb.Checked)
                {
                    if (bll.Delete(id))
                    {
                        sucCount++;
                    }
                    else
                    {
                        errorCount++;
                    }
                }
            }
            AddAdminLog(HTEnums.ActionEnum.Edit.ToString(), "删除帖子内容成功" + sucCount + "条，失败" + errorCount + "条"); //记录日志
            JscriptMsg("删除成功" + sucCount + "条，失败" + errorCount + "条！", Utils.CombUrlTxt("bbs_topic_list.aspx", "category_id={0}&keywords={1}&property={2}", this.category_id.ToString(), this.keywords, this.property));
        }
    }
}