using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using HT.Common;

namespace HT.Web.admin.settings
{
    public partial class appapi_manage : HT.Web.UI.ManagePage
    {
        private string action = HTEnums.ActionEnum.Add.ToString(); //操作类型
        private int id = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            string _action = HTRequest.GetQueryString("action");
            this.id = HTRequest.GetQueryInt("id");

            if (!string.IsNullOrEmpty(_action) && _action == HTEnums.ActionEnum.Edit.ToString())
            {
                this.action = HTEnums.ActionEnum.Edit.ToString();//修改类型
                if (this.id == 0)
                {
                    JscriptMsg("传输参数不正确！", "back");
                    return;
                }
                if (!new HT.BLL.ht_appapi().Exists(this.id))
                {
                    JscriptMsg("不存在或已被删除！", "back");
                    return;
                }
            }
            if (!IsPostBack)
            {
                ChkAdminLevel("appapi_query", HTEnums.ActionEnum.View.ToString()); //检查权限
                if (action == HTEnums.ActionEnum.Edit.ToString()) //修改
                {
                    ShowInfo(this.id);
                }

            }
        }

        #region 赋值操作=================================
        private void ShowInfo(int _id)
        {
            HT.BLL.ht_appapi bll = new HT.BLL.ht_appapi();
            HT.Model.ht_appapi model = bll.GetModel(_id);
            txtrequest_parameter.Value = model.request_parameter;
            txtreturn_parameter.Value = model.return_parameter;
            txtremark.Value = model.remark;
            txtname.Text = model.name;
            txtSort.Text = model.sort;
            txturl.Text = model.url;
            if (model.is_top == 1)
            {
                cblItem.Items[0].Selected = true;
            }
            if (model.is_color == 1)
            {
                cblItem.Items[1].Selected = true;
            }
        }
        #endregion

        #region 增加操作=================================
        private bool DoAdd()
        {
            try
            {
                HT.BLL.ht_appapi bll = new HT.BLL.ht_appapi();
                HT.Model.ht_appapi model = new HT.Model.ht_appapi();
                model.name = txtname.Text;
                model.sort = txtSort.Text;
                model.addtime = DateTime.Now;
                model.request_parameter = txtrequest_parameter.Value;
                model.remark = txtremark.Value;
                model.return_parameter = txtreturn_parameter.Value;
                model.url = txturl.Text;
                model.is_top = 0;
                model.is_color = 0;
                if (cblItem.Items[0].Selected == true)
                {
                    model.is_top = 1;
                }
                if (cblItem.Items[1].Selected == true)
                {
                    model.is_color = 1;
                }
                if (bll.Add(model) > 0)
                {
                    return true;
                }
            }
            catch
            {
                return false;
            }
            return false;
        }
        #endregion

        #region 修改操作=================================
        private bool DoEdit(int _id)
        {
            try
            {
                HT.BLL.ht_appapi bll = new HT.BLL.ht_appapi();
                HT.Model.ht_appapi model = bll.GetModel(_id);
                model.name = txtname.Text;
                model.sort = txtSort.Text;
                model.upadtetime = DateTime.Now;
                model.request_parameter = txtrequest_parameter.Value;
                model.remark = txtremark.Value;
                model.return_parameter = txtreturn_parameter.Value;
                model.url = txturl.Text;
                model.is_top = 0;
                model.is_color = 0;
                if (cblItem.Items[0].Selected == true)
                {
                    model.is_top = 1;
                }
                if (cblItem.Items[1].Selected == true)
                {
                    model.is_color = 1;
                }
                if (bll.Update(model))
                {
                    return true;
                }
            }
            catch
            {
                return false;
            }
            return false;
        }
        #endregion

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (action == HTEnums.ActionEnum.Edit.ToString()) //修改
            {
                ChkAdminLevel("appapi_query", HTEnums.ActionEnum.Edit.ToString()); //检查权限
                if (!DoEdit(this.id))
                {
                    JscriptMsg("保存过程中发生错误！", "");
                    return;
                }
                JscriptMsg("修改成功！", "appapi_query.aspx");
            }
            else //添加
            {
                ChkAdminLevel("appapi_query", HTEnums.ActionEnum.Add.ToString()); //检查权限
                if (!DoAdd())
                {
                    JscriptMsg("保存过程中发生错误！", "");
                    return;
                }
                JscriptMsg("添加成功！", "appapi_query.aspx");
            }
        }
    }
}