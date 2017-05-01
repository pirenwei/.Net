using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web.admin.ads
{
    public partial class ads_list : Web.UI.ManagePage
    {
        protected int totalCount;
        protected int page;
        protected int pageSize;

        protected string code;
        protected string prolistview = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.code = HTRequest.GetQueryString("code");
            this.pageSize = GetPageSize(10); //每页数量
            this.prolistview = Utils.GetCookie("ads_list_view"); //显示方式
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("ads_setting", HTEnums.ActionEnum.View.ToString()); //检查权限
                TreeBind();
                RptBind("id>0 " + CombSqlTxt(code), "sort_id asc,id desc");
            }
        }

        #region 组合SQL查询语句==========================
        protected string CombSqlTxt(string _code)
        {
            StringBuilder strTemp = new StringBuilder();
            if (!string.IsNullOrEmpty(_code))
            {
                strTemp.Append(" and code ='" + _code + "'");
            }
            return strTemp.ToString();
        }
        #endregion

        #region 绑定位置=================================
        private void TreeBind()
        {
            BLL.ht_ads_place bll = new BLL.ht_ads_place();
            DataTable dt = bll.GetAllList().Tables[0];

            this.ddlCode.Items.Clear();
            this.ddlCode.Items.Add(new ListItem("请选择广告位...", ""));
            foreach (DataRow dr in dt.Rows)
            {
                this.ddlCode.Items.Add(new ListItem(dr["title"].ToString(), dr["code"].ToString()));
            }
        }
        #endregion

        #region 数据绑定=================================
        private void RptBind(string _strWhere, string _orderby)
        {
            this.page = HTRequest.GetQueryInt("page", 1);

            if (!string.IsNullOrEmpty(this.code))
            {
                ddlCode.SelectedValue = this.code.ToString();
            }
            //图表或列表显示
            BLL.ht_ads bll = new BLL.ht_ads();
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
            string pageUrl = Utils.CombUrlTxt("ads_list.aspx", "page={0}&code={1}", "__id__",this.code);
            PageContent.InnerHtml = Utils.OutPageList(this.pageSize, this.page, this.totalCount, pageUrl, 8);
        }
        #endregion

        //设置文字列表显示
        protected void lbtnViewTxt_Click(object sender, EventArgs e)
        {
            Utils.WriteCookie("ads_list_view", "Txt", 14400);
            Response.Redirect(Utils.CombUrlTxt("ads_list.aspx", "page={0}&code={1}",
               this.page.ToString(), this.code));
        }

        //设置图文列表显示
        protected void lbtnViewImg_Click(object sender, EventArgs e)
        {
            Utils.WriteCookie("ads_list_view", "Img", 14400);
            Response.Redirect(Utils.CombUrlTxt("ads_list.aspx", "page={0}&code={1}",
                           this.page.ToString(), this.code));
        }

        #region 返回图文每页数量=========================
        private int GetPageSize(int _default_size)
        {
            int _pagesize;
            if (int.TryParse(Utils.GetCookie("ads_page_size"), out _pagesize))
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
                    Utils.WriteCookie("ads_page_size", _pagesize.ToString(), 43200);
                }
            }
            Response.Redirect(Utils.CombUrlTxt("ads_list.aspx", "code={0}",this.code));
        }

        //保存排序
        protected void btnSave_Click(object sender, EventArgs e)
        {
            ChkAdminLevel("ads_setting", HTEnums.ActionEnum.Edit.ToString()); //检查权限
            BLL.ht_ads bll = new BLL.ht_ads();
            Repeater rptList = new Repeater();
            switch (this.prolistview)
            {
                case "Txt":
                    rptList = this.rptList1;
                    break;
                default:
                    rptList = this.rptList2;
                    break;
            }
            for (int i = 0; i < rptList.Items.Count; i++)
            {
                int id = Convert.ToInt32(((HiddenField)rptList.Items[i].FindControl("hidId")).Value);
                int sortId;
                if (!int.TryParse(((TextBox)rptList.Items[i].FindControl("txtSortId")).Text.Trim(), out sortId))
                {
                    sortId = 99;
                }
                bll.UpdateField(id, "sort_id=" + sortId.ToString());
            }
            AddAdminLog(HTEnums.ActionEnum.Edit.ToString(), "保存广告内容排序"); //记录日志
            JscriptMsg("保存排序成功！", Utils.CombUrlTxt("ads_list.aspx", "code={0}",this.code));
        }

        //批量删除
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            ChkAdminLevel("ads_setting", HTEnums.ActionEnum.Delete.ToString()); //检查权限
            int sucCount = 0; //成功数量
            int errorCount = 0; //失败数量
            BLL.ht_ads bll = new BLL.ht_ads();
            Repeater rptList = new Repeater();
            switch (this.prolistview)
            {
                case "Txt":
                    rptList = this.rptList1;
                    break;
                default:
                    rptList = this.rptList2;
                    break;
            }
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
            AddAdminLog(HTEnums.ActionEnum.Edit.ToString(), "删除广告内容成功" + sucCount + "条，失败" + errorCount + "条"); //记录日志
            JscriptMsg("删除成功" + sucCount + "条，失败" + errorCount + "条！", Utils.CombUrlTxt("ads_list.aspx", "code={0}", this.code));
        }
        //筛选广告位
        protected void ddlCode_SelectedIndexChanged(object sender, EventArgs e)
        {
            Response.Redirect(Utils.CombUrlTxt("ads_list.aspx", "code={0}", ddlCode.SelectedValue));
        }
    }
}