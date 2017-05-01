using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web.admin.users
{
    public partial class comment_edit : Web.UI.ManagePage
    {
        private int id = 0;
        protected Model.ht_common_comment model = new Model.ht_common_comment();

        protected void Page_Load(object sender, EventArgs e)
        {
            this.id = HTRequest.GetQueryInt("id");
            if (id == 0)
            {
                JscriptMsg("传输参数不正确！", "back");
                return;
            }
            if (!new BLL.ht_common_comment().Exists(this.id))
            {
                JscriptMsg("记录不存在或已删除！", "back");
                return;
            }
            if (!Page.IsPostBack)
            {
                ShowInfo(this.id);
            }
        }

        #region 赋值操作=================================
        private void ShowInfo(int _id)
        {
            BLL.ht_common_comment bll = new BLL.ht_common_comment();
            model = bll.GetModel(_id);
            txtContent.Text = Utils.ToTxt(model.content);
            rblIsLock.SelectedValue = model.is_lock.ToString();
        }
        #endregion

        //保存
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            ChkAdminLevel("user_comment", HTEnums.ActionEnum.Edit.ToString()); //检查权限
            BLL.ht_common_comment bll = new BLL.ht_common_comment();
            model = bll.GetModel(this.id);
            model.content = Utils.ToHtml(txtContent.Text);
            model.is_lock = int.Parse(rblIsLock.SelectedValue);
            model.add_time = DateTime.Now;
            bll.Update(model);
            AddAdminLog(HTEnums.ActionEnum.Edit.ToString(), "编辑评论ID:" + model.id); //记录日志
            JscriptMsg("评论成功！", "comment_list.aspx");
        }

    }
}