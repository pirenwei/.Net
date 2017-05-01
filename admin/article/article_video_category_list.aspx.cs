using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web.admin.article
{
    public partial class article_video_category_list : Web.UI.ManagePage
    {
        protected int channel_id = 3;//video
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("article_video", HTEnums.ActionEnum.View.ToString()); //检查权限
                RptBind();
            }
        }

        //数据绑定
        private void RptBind()
        {
            BLL.article_category bll = new BLL.article_category();
            DataTable dt = bll.GetList(0, this.channel_id);
            this.rptList.DataSource = dt;
            this.rptList.DataBind();
        }

        //美化列表
        protected void rptList_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item)
            {
                Literal LitFirst = (Literal)e.Item.FindControl("LitFirst");
                HiddenField hidLayer = (HiddenField)e.Item.FindControl("hidLayer");
                string LitStyle = "<span style=\"display:inline-block;width:{0}px;\"></span>{1}{2}";
                string LitImg1 = "<span class=\"folder-open\"></span>";
                string LitImg2 = "<span class=\"folder-line\"></span>";

                int classLayer = Convert.ToInt32(hidLayer.Value);
                if (classLayer == 1)
                {
                    LitFirst.Text = LitImg1;
                }
                else
                {
                    LitFirst.Text = string.Format(LitStyle, (classLayer - 2) * 24, LitImg2, LitImg1);
                }
            }
        }

        //保存排序
        protected void btnSave_Click(object sender, EventArgs e)
        {
            ChkAdminLevel("article_video", HTEnums.ActionEnum.Edit.ToString()); //检查权限
            BLL.article_category bll = new BLL.article_category();
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
            AddAdminLog(HTEnums.ActionEnum.Edit.ToString(), "保存栏目类别排序"); //记录日志
            JscriptMsg("保存排序成功！", "article_video_category_list.aspx");
        }

        //删除类别
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            ChkAdminLevel("article_video", HTEnums.ActionEnum.Delete.ToString()); //检查权限
            BLL.article_category bll = new BLL.article_category();
            for (int i = 0; i < rptList.Items.Count; i++)
            {
                int id = Convert.ToInt32(((HiddenField)rptList.Items[i].FindControl("hidId")).Value);
                CheckBox cb = (CheckBox)rptList.Items[i].FindControl("chkId");
                if (cb.Checked)
                {
                    bll.Delete(id);
                }
            }
            AddAdminLog(HTEnums.ActionEnum.Edit.ToString(), "删除栏目类别数据"); //记录日志
            JscriptMsg("删除数据成功！", "article_video_category_list.aspx");
        }

    }
}