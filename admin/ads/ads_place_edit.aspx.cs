using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web.admin.ads
{
    public partial class ads_place_edit : Web.UI.ManagePage
    {
        protected string action = HTEnums.ActionEnum.Add.ToString(); //操作类型
        private int id = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            string _action = HTRequest.GetQueryString("action");
            if (!string.IsNullOrEmpty(_action) && _action == HTEnums.ActionEnum.Edit.ToString())
            {
                this.action = HTEnums.ActionEnum.Edit.ToString();//修改类型
                this.id = HTRequest.GetQueryInt("id");
                if (this.id == 0)
                {
                    JscriptMsg("传输参数不正确！", "back");
                    return;
                }
                if (!new BLL.ht_ads_place().Exists(this.id))
                {
                    JscriptMsg("信息不存在或已被删除！", "back");
                    return;
                }
            }
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("ads_setting", HTEnums.ActionEnum.Add.ToString()); //检查权限
                if (action == HTEnums.ActionEnum.Edit.ToString()) //修改
                {
                    ShowInfo(this.id);
                }
            }
        }

        #region 赋值操作=================================
        private void ShowInfo(int _id)
        {
            BLL.ht_ads_place bll = new BLL.ht_ads_place();
            Model.ht_ads_place model = bll.GetModel(_id);
            txtTitle.Text = model.title;
        }
        #endregion

        #region 增加操作=================================
        private bool DoAdd()
        {
            bool result = false;
            BLL.ht_ads_place bll = new BLL.ht_ads_place();
            Model.ht_ads_place model = new Model.ht_ads_place();

            model.title = txtTitle.Text.Trim();
            if (bll.Add(model) > 0)
            {
                AddAdminLog(HTEnums.ActionEnum.Add.ToString(), "添加广告位内容:" + model.title); //记录日志
                result = true;
            }
            return result;
        }
        #endregion

        #region 修改操作=================================
        private bool DoEdit(int _id)
        {
            bool result = false;
            BLL.ht_ads_place bll = new BLL.ht_ads_place();
            Model.ht_ads_place model = bll.GetModel(this.id);
            model.title = txtTitle.Text.Trim();

            if (bll.Update(model))
            {
                AddAdminLog(HTEnums.ActionEnum.Edit.ToString(), "添加广告位内容:" + model.title); //记录日志
                result = true;
            }
            return result;
        }
        #endregion

        //保存
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (action == HTEnums.ActionEnum.Edit.ToString()) //修改
            {
                ChkAdminLevel("ads_setting", HTEnums.ActionEnum.Edit.ToString()); //检查权限
                if (!DoEdit(this.id))
                {
                    JscriptMsg("保存过程中发生错误！", "");
                    return;
                }
                JscriptMsg("修改成功！", "ads_place_list.aspx");
            }
            else //添加
            {
                ChkAdminLevel("ads_setting", HTEnums.ActionEnum.Add.ToString()); //检查权限
                if (!DoAdd())
                {
                    JscriptMsg("保存过程中发生错误！", "");
                    return;
                }
                JscriptMsg("修改成功！", "ads_place_list.aspx");
            }
        }
    }
}