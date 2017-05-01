using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web.admin.gb
{
    public partial class gb_config : Web.UI.ManagePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("user_config", HTEnums.ActionEnum.View.ToString()); //检查权限
                ShowInfo();
            }
        }

        #region 赋值操作=================================
        private void ShowInfo()
        {
            BLL.userconfig bll = new BLL.userconfig();
            Model.userconfig model = bll.loadConfig();

            txtValue1.Text = model.pointgb1.ToString();
            txtValue2.Text = model.pointgb2.ToString();
            txtValue3.Text = model.pointgb3.ToString();
            txtValue4.Text = model.pointgb4.ToString();
            txtTitle1.Text = model.pointgbTitle1.ToString();
            txtTitle2.Text = model.pointgbTitle2.ToString();
            txtTitle3.Text = model.pointgbTitle3.ToString();
            txtTitle4.Text = model.pointgbTitle4.ToString();
            txtRemark1.Text = model.pointgbRemark1.ToString();
            txtRemark2.Text = model.pointgbRemark2.ToString();
            txtRemark3.Text = model.pointgbRemark3.ToString();
            txtRemark4.Text = model.pointgbRemark4.ToString();
        }
        #endregion

        /// <summary>
        /// 保存配置信息
        /// </summary>
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            ChkAdminLevel("user_config", HTEnums.ActionEnum.Edit.ToString()); //检查权限
            BLL.userconfig bll = new BLL.userconfig();
            Model.userconfig model = bll.loadConfig();
            try
            {
                model.pointgb1 = Utils.ObjToInt(txtValue1.Text);
                model.pointgb2 = Utils.ObjToInt(txtValue2.Text);
                model.pointgb3 = Utils.ObjToInt(txtValue3.Text);
                model.pointgb4 = Utils.ObjToInt(txtValue4.Text);
                model.pointgbTitle1 = txtTitle1.Text;
                model.pointgbTitle2 = txtTitle2.Text;
                model.pointgbTitle3 = txtTitle3.Text;
                model.pointgbTitle4 = txtTitle4.Text;
                model.pointgbRemark1 = txtRemark1.Text;
                model.pointgbRemark2 = txtRemark2.Text;
                model.pointgbRemark3 = txtRemark3.Text;
                model.pointgbRemark4 = txtRemark4.Text;

                bll.saveConifg(model);
                AddAdminLog(HTEnums.ActionEnum.Edit.ToString(), "修改G币配置信息"); //记录日志
                JscriptMsg("修改G币配置成功！", "gb_config.aspx");
            }
            catch
            {
                JscriptMsg("文件写入失败，请检查文件夹权限！", "");
            }
        }

    }
}