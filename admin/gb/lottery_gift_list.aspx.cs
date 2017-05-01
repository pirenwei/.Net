using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web.admin.gb
{
    public partial class lottery_gift_list : UI.ManagePage
    {
        protected int totalCount;
        protected int page;
        protected int pageSize;

        protected string keywords = string.Empty;
        protected string prolistview = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            this.keywords = HTRequest.GetQueryString("keywords");

            this.pageSize = GetPageSize(10); //每页数量
            this.prolistview = Utils.GetCookie("lottery_gift_list_view"); //显示方式
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("gb_lottery", HTEnums.ActionEnum.View.ToString()); //检查权限
                RptBind("id>0" + CombSqlTxt(this.keywords), "add_time desc,id desc");
            }
        }

        #region 数据绑定=================================
        private void RptBind(string _strWhere, string _orderby)
        {
            this.page = HTRequest.GetQueryInt("page", 1);
            this.txtKeywords.Text = this.keywords;
            //图表或列表显示
            BLL.gb_lottery_gift bll = new BLL.gb_lottery_gift();
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
            string pageUrl = Utils.CombUrlTxt("lottery_gift_list.aspx", "keywords={0}&page={1}", this.keywords, "__id__");
            PageContent.InnerHtml = Utils.OutPageList(this.pageSize, this.page, this.totalCount, pageUrl, 8);
        }
        #endregion

        #region 组合SQL查询语句==========================
        protected string CombSqlTxt(string _keywords)
        {
            StringBuilder strTemp = new StringBuilder();
            _keywords = _keywords.Replace("'", "");
            if (!string.IsNullOrEmpty(_keywords))
            {
                strTemp.Append(" and title like '%" + _keywords + "%'");
            }
            return strTemp.ToString();
        }
        #endregion

        #region 返回图文每页数量=========================
        private int GetPageSize(int _default_size)
        {
            int _pagesize;
            if (int.TryParse(Utils.GetCookie("gb_lottery_page_size", "HTPage"), out _pagesize))
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
            Response.Redirect(Utils.CombUrlTxt("lottery_gift_list.aspx", "keywords={0}",
                txtKeywords.Text));
        }

        //设置文字列表显示
        protected void lbtnViewTxt_Click(object sender, EventArgs e)
        {
            Utils.WriteCookie("lottery_gift_list_view", "Txt", 14400);
            Response.Redirect(Utils.CombUrlTxt("lottery_gift_list.aspx", "keywords={0}&page={1}",
                this.keywords,this.page.ToString()));
        }

        //设置图文列表显示
        protected void lbtnViewImg_Click(object sender, EventArgs e)
        {
            Utils.WriteCookie("lottery_gift_list_view", "Img", 14400);
            Response.Redirect(Utils.CombUrlTxt("lottery_gift_list.aspx", "keywords={0}&page={1}",
                this.keywords,this.page.ToString()));
        }

        //设置分页数量
        protected void txtPageNum_TextChanged(object sender, EventArgs e)
        {
            int _pagesize;
            if (int.TryParse(txtPageNum.Text.Trim(), out _pagesize))
            {
                if (_pagesize > 0)
                {
                    Utils.WriteCookie("gb_lottery_page_size", "HTPage", _pagesize.ToString(), 43200);
                }
            }
            Response.Redirect(Utils.CombUrlTxt("lottery_gift_list.aspx", "keywords={0}",
                this.keywords));
        }

        //批量删除
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            ChkAdminLevel("gb_lottery", HTEnums.ActionEnum.Delete.ToString()); //检查权限
            int sucCount = 0; //成功数量
            int errorCount = 0; //失败数量
            BLL.gb_lottery_gift bll = new BLL.gb_lottery_gift();
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
            AddAdminLog(HTEnums.ActionEnum.Edit.ToString(), "删除G币抽奖内容成功" + sucCount + "条，失败" + errorCount + "条"); //记录日志
            JscriptMsg("删除成功" + sucCount + "条，失败" + errorCount + "条！", Utils.CombUrlTxt("lottery_gift_list.aspx", "keywords={0}", this.keywords));
        }

        //计算中奖概率
        protected string WinRate(double quantity)
        {
            double sumCount = 0;
            List<Model.gb_lottery_gift> listModel = new BLL.gb_lottery_gift().GetModelList("");
            foreach (Model.gb_lottery_gift item in listModel)
            {
                sumCount += item.quantity;
            }
            decimal rate = Math.Round(Convert.ToDecimal(quantity / sumCount), 4) * 100;
            return rate.ToString("0.00") + "%";
        }

    }
}