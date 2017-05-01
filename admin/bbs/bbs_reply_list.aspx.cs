using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web.admin.bbs
{
    public partial class bbs_reply_list : Web.UI.ManagePage
    {
        protected int totalCount;
        protected int page;
        protected int pageSize;

        protected int topic_id;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.topic_id = HTRequest.GetQueryInt("topic_id");

            this.pageSize = GetPageSize(10); //每页数量
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("bbs_reply", HTEnums.ActionEnum.View.ToString()); //检查权限
                RptBind("id>0" + CombSqlTxt(this.topic_id), "add_time desc,id desc");
            }
        }

        #region 数据绑定=================================
        private void RptBind(string _strWhere, string _orderby)
        {
            this.page = HTRequest.GetQueryInt("page", 1);
            //列表显示
            BLL.ht_bbs_reply bll = new BLL.ht_bbs_reply();
            this.rptList.DataSource = bll.GetList(this.pageSize, this.page, _strWhere, _orderby, out           this.totalCount);
            this.rptList.DataBind();
            //绑定页码
            txtPageNum.Text = this.pageSize.ToString();
            string pageUrl = Utils.CombUrlTxt("bbs_reply_list.aspx", "topic_id={0}page={1}", this.topic_id.ToString(), "__id__");
            PageContent.InnerHtml = Utils.OutPageList(this.pageSize, this.page, this.totalCount, pageUrl, 8);
        }
        #endregion

        #region 组合SQL查询语句==========================
        protected string CombSqlTxt(int _topic_id)
        {
            StringBuilder strTemp = new StringBuilder();
            if (_topic_id > 0)
            {
                strTemp.Append(" and topic_id=" + _topic_id);
            }
            return strTemp.ToString();
        }
        #endregion

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
            Response.Redirect(Utils.CombUrlTxt("bbs_reply_list.aspx", "topic_id={0}",
                this.topic_id.ToString()));
        }

        //批量审核
        protected void btnAudit_Click(object sender, EventArgs e)
        {
            ChkAdminLevel("bbs_reply", HTEnums.ActionEnum.Audit.ToString()); //检查权限
            BLL.ht_bbs_reply bll = new BLL.ht_bbs_reply();
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
            JscriptMsg("批量审核成功！", Utils.CombUrlTxt("bbs_reply_list.aspx", "topic_id={0}", this.topic_id.ToString()));
        }

        //批量删除
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            ChkAdminLevel("bbs_reply", HTEnums.ActionEnum.Delete.ToString()); //检查权限
            int sucCount = 0; //成功数量
            int errorCount = 0; //失败数量
            BLL.ht_bbs_reply bll = new BLL.ht_bbs_reply();
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
            JscriptMsg("删除成功" + sucCount + "条，失败" + errorCount + "条！", Utils.CombUrlTxt("bbs_reply_list.aspx", "topic_id={0}", this.topic_id.ToString()));
        }
    }
}