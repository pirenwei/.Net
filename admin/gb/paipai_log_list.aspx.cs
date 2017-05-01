using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web.admin.gb
{
    public partial class paipai_log_list : UI.ManagePage
    {
        protected int totalCount;
        protected int page;
        protected int pageSize;

        protected int paipai_id;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.paipai_id = HTRequest.GetQueryInt("paipai_id", 0);
            this.pageSize = GetPageSize(10); //每页数量
            if (!Page.IsPostBack)
            {
                string strWhere = "id>0";
                if (this.paipai_id > 0)
                { 
                    strWhere+=" AND paipai_id=" + this.paipai_id;
                }
                RptBind(strWhere, "id desc");
            }
        }

        #region 数据绑定=================================
        private void RptBind(string _strWhere, string _orderby)
        {
            this.page = HTRequest.GetQueryInt("page", 1);
            //图表或列表显示
            BLL.gb_paipai_log bll = new BLL.gb_paipai_log();
            this.rptList.DataSource = bll.GetList(this.pageSize, this.page, _strWhere, _orderby, out this.totalCount);
            this.rptList.DataBind();
            //绑定页码
            txtPageNum.Text = this.pageSize.ToString();
            string pageUrl = Utils.CombUrlTxt("paipai_log_list.aspx", "page={0}&paipai_id={1}", "__id__",this.paipai_id.ToString());
            PageContent.InnerHtml = Utils.OutPageList(this.pageSize, this.page, this.totalCount, pageUrl, 8);
        }
        #endregion

        #region 返回图文每页数量=========================
        private int GetPageSize(int _default_size)
        {
            int _pagesize;
            if (int.TryParse(Utils.GetCookie("gb_paipai_page_size", "HTPage"), out _pagesize))
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
                    Utils.WriteCookie("gb_paipai_page_size", "HTPage", _pagesize.ToString(), 43200);
                }
            }
            Response.Redirect("paipai_log_list.aspx");
        }

        //批量删除
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            int sucCount = 0; //成功数量
            int errorCount = 0; //失败数量
            BLL.gb_paipai_log bll = new BLL.gb_paipai_log();
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
            AddAdminLog(HTEnums.ActionEnum.Edit.ToString(), "删除G币竞拍记录成功" + sucCount + "条，失败" + errorCount + "条"); //记录日志
            JscriptMsg("删除成功" + sucCount + "条，失败" + errorCount + "条！","paipai_log_list.aspx");
        }
    }
}