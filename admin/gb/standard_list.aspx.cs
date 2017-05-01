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
    public partial class standard_list : UI.ManagePage
    {
        protected int totalCount;
        protected int page;
        protected int pageSize;
        private EF.HT_DB db = new EF.HT_DB();//实例化EF对象
        protected void Page_Load(object sender, EventArgs e)
        {
            this.pageSize = GetPageSize(10); //每页数量
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("gb_standard", HTEnums.ActionEnum.View.ToString()); //检查权限
                RptBind("id>0", "id desc");
            }
        }

        #region 数据绑定=================================
        private void RptBind(string _strWhere, string _orderby)
        {
            this.page = HTRequest.GetQueryInt("page", 1);
            //列表显示
            
            var list = db.gb_standard.ToList();
            totalCount = list.Count;
            var listN = list.Skip(pageSize * (page - 1)).Take(pageSize).OrderBy(s => s.id);
            this.rptList1.DataSource = listN;
            this.rptList1.DataBind();
            //绑定页码
            txtPageNum.Text = this.pageSize.ToString();
            string pageUrl = Utils.CombUrlTxt("standard_list.aspx", "page={0}", "__id__");
            PageContent.InnerHtml = Utils.OutPageList(this.pageSize, this.page, this.totalCount, pageUrl, 8);
        }
        #endregion

        #region 返回图文每页数量=========================
        private int GetPageSize(int _default_size)
        {
            int _pagesize;
            if (int.TryParse(Utils.GetCookie("gb_standard_page_size", "HTPage"), out _pagesize))
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
                    Utils.WriteCookie("gb_standard_page_size", "HTPage", _pagesize.ToString(), 43200);
                }
            }
            Response.Redirect("standard_list.aspx");
        }

        //批量删除
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            ChkAdminLevel("gb_standard", HTEnums.ActionEnum.Delete.ToString()); //检查权限
            int sucCount = 0; //成功数量
            int errorCount = 0; //失败数量

            for (int i = 0; i < rptList1.Items.Count; i++)
            {                
                int id = Convert.ToInt32(((HiddenField)rptList1.Items[i].FindControl("hidId")).Value);
                CheckBox cb = (CheckBox)rptList1.Items[i].FindControl("chkId");
                if (cb.Checked)
                {
                    var efModel = db.gb_standard.Where(s => s.id == id).FirstOrDefault();
                    try
                    {
                        db.gb_standard.Remove(efModel);
                        sucCount++;
                    }
                    catch (Exception)
                    {
                        errorCount++;
                    }
                }
            }
            db.SaveChanges();
            AddAdminLog(HTEnums.ActionEnum.Edit.ToString(), "删除G币规范内容成功" + sucCount + "条，失败" + errorCount + "条"); //记录日志
            JscriptMsg("删除成功" + sucCount + "条，失败" + errorCount + "条！", "standard_list.aspx");
        }
    }
}