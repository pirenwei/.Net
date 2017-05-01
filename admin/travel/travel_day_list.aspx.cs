using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web.admin.travel
{
    public partial class travel_day_list : UI.ManagePage
    {
        protected int totalCount;
        protected int page;
        protected int pageSize;

        public int travel_id;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.travel_id = HTRequest.GetQueryInt("travel_id");
            this.pageSize = GetPageSize(10); //每页数量
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("travel_list", HTEnums.ActionEnum.View.ToString()); //检查权限
                RptBind("id>0 AND travel_id=" + travel_id, "id asc");
            }
        }

        //每日游玩景点
        protected string GetItemsList(object day_idObj)
        {
            string str = "";
            DataSet ds = new BLL.ht_travel_day_plan().GetList(0, "day_id=" + Utils.ObjToInt(day_idObj), "id asc");
            if (ds.Tables[0].Rows.Count >0 )
            {
                foreach (DataRow item in ds.Tables[0].Rows)
                {
                    switch (Utils.ObjToInt(item["type"]))
                    { 
                        case 1://景点
                            str += "<a target=\"_blank\" href=\"/scenery_spot_detail.aspx?cid=" + new BLL.ht_scenery().GetCid(Utils.ObjToInt(item["item_id"])) + "\">" + item["name"] + "</a>，";
                            break;
                        case 2://酒店
                            str += "<a target=\"_blank\" href=\"/hotel_parity_detail.aspx?cid=" + new BLL.ht_hotel().GetCid(Utils.ObjToInt(item["item_id"])) + "\">" + item["name"] + "</a>，";
                            break;
                        case 3://店家
                            str += "<a target=\"_blank\" href=\"/foodshop_detail.aspx?cid=" + new BLL.ht_shop().GetCid(Utils.ObjToInt(item["item_id"])) + "\">" + item["name"] + "</a>，";
                            break;
                    }
                }
            }
            return str;
        }

        #region 数据绑定=================================
        private void RptBind(string _strWhere, string _orderby)
        {
            this.page = HTRequest.GetQueryInt("page", 1);
            //列表显示
            BLL.ht_travel_day bll = new BLL.ht_travel_day();
            this.rptList.DataSource = bll.GetList(this.pageSize, this.page, _strWhere, _orderby, out this.totalCount);
            this.rptList.DataBind();
            //绑定页码
            txtPageNum.Text = this.pageSize.ToString();
            string pageUrl = Utils.CombUrlTxt("travel_day_list.aspx", "page={0}&travel_id={1}", "__id__",this.travel_id.ToString());
            PageContent.InnerHtml = Utils.OutPageList(this.pageSize, this.page, this.totalCount, pageUrl, 8);
        }
        #endregion

        #region 返回图文每页数量=========================
        private int GetPageSize(int _default_size)
        {
            int _pagesize;
            if (int.TryParse(Utils.GetCookie("travel_page_size", "HTPage"), out _pagesize))
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
                    Utils.WriteCookie("travel_page_size", "HTPage", _pagesize.ToString(), 43200);
                }
            }
            Response.Redirect(Utils.CombUrlTxt("travel_list.aspx", "travel_id={0}",
                this.travel_id.ToString()));
        }
        //批量删除
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            ChkAdminLevel("travel_list", HTEnums.ActionEnum.Delete.ToString()); //检查权限
            int sucCount = 0; //成功数量
            int errorCount = 0; //失败数量
            BLL.ht_travel_day bll = new BLL.ht_travel_day();
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
            AddAdminLog(HTEnums.ActionEnum.Edit.ToString(), "删除行程内容成功" + sucCount + "条，失败" + errorCount + "条"); //记录日志
            JscriptMsg("删除成功" + sucCount + "条，失败" + errorCount + "条！", Utils.CombUrlTxt("travel_day_list.aspx", "travel_id={0}", this.travel_id.ToString()));
        }
    }
}