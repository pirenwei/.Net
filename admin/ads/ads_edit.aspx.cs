using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web.admin.ads
{
    public partial class ads_edit : Web.UI.ManagePage
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
                if (!new HT.BLL.ht_ads().Exists(this.id))
                {
                    JscriptMsg("信息不存在或已被删除！", "back");
                    return;
                }
            }
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("ads_setting", HTEnums.ActionEnum.Add.ToString()); //检查权限
                TreeBind();
                if (action == HTEnums.ActionEnum.Edit.ToString()) //修改
                {
                    ShowInfo(this.id);
                }
            }
        }

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

        #region 赋值操作=================================
        private void ShowInfo(int _id)
        {
            BLL.ht_ads bll = new BLL.ht_ads();
            Model.ht_ads model = bll.GetModel(_id);
            rblState.SelectedValue = model.status.ToString();
            ddlCode.SelectedValue = model.code;
            txtTitle.Text = model.title;
            txtImgUrl.Text = model.img_url;
            txtLink_url.Text = model.link_url;
            txtSortId.Text = model.sort_id.ToString();
        }
        #endregion

        #region 增加操作=================================
        private bool DoAdd()
        {
            bool result = false;
            BLL.ht_ads bll = new BLL.ht_ads();
            Model.ht_ads model = new HT.Model.ht_ads();

            model.status = Utils.StrToInt(rblState.SelectedValue,0);
            model.code = ddlCode.SelectedValue;
            model.remark = ddlCode.SelectedItem.Text;
            model.title = txtTitle.Text.Trim();
            model.img_url = txtImgUrl.Text.Trim();
            model.link_url = txtLink_url.Text.Trim();
            model.sort_id = Utils.StrToInt(txtSortId.Text,0);
            if (bll.Add(model) > 0)
            {
                AddAdminLog(HTEnums.ActionEnum.Add.ToString(), "添加广告内容:" + model.title); //记录日志
                result = true;
            }
            return result;
        }
        #endregion

        #region 修改操作=================================
        private bool DoEdit(int _id)
        {
            bool result = false;
            BLL.ht_ads bll = new BLL.ht_ads();
            Model.ht_ads model = bll.GetModel(this.id);
            model.status = Utils.StrToInt(rblState.SelectedValue,0);
            model.code = ddlCode.SelectedValue;
            model.remark = ddlCode.SelectedItem.Text;
            model.title = txtTitle.Text.Trim();
            model.img_url = txtImgUrl.Text.Trim();
            model.link_url = txtLink_url.Text.Trim();
            model.sort_id = Utils.StrToInt(txtSortId.Text, 0);
            if (bll.Update(model))
            {
                AddAdminLog(HTEnums.ActionEnum.Edit.ToString(), "编辑广告内容:" + model.title); //记录日志
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
                JscriptMsg("修改成功！", "ads_list.aspx");
            }
            else //添加
            {
                ChkAdminLevel("ads_setting", HTEnums.ActionEnum.Add.ToString()); //检查权限
                if (!DoAdd())
                {
                    JscriptMsg("保存过程中发生错误！", "");
                    return;
                }
                JscriptMsg("修改成功！", "ads_list.aspx");
            }
        }
    }
}