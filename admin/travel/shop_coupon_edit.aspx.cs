using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web.admin.travel
{
    public partial class shop_coupon_edit : Web.UI.ManagePage
    {
        private string action = HTEnums.ActionEnum.Add.ToString(); //操作类型
        public int id = 0;
        public int main_id = 0;
        //页面加载事件
        protected void Page_Load(object sender, EventArgs e)
        {
            string _action = HTRequest.GetQueryString("action");
            this.main_id = HTRequest.GetQueryInt("main_id");
            ViewState["main_id"] = this.main_id;
            //如果是编辑或复制则检查信息是否存在
            if (_action == HTEnums.ActionEnum.Edit.ToString())
            {
                this.action = _action;//修改类型
                this.id = HTRequest.GetQueryInt("id");
                if (this.id == 0)
                {
                    JscriptMsg("传输参数不正确！", "back");
                    return;
                }
                if (!new BLL.ht_shop_coupon().Exists(this.id))
                {
                    JscriptMsg("信息不存在或已被删除！", "back");
                    return;
                }
            }
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("shop_coupon", HTEnums.ActionEnum.View.ToString()); //检查权限
                this.main_id = Utils.ObjToInt(ViewState["main_id"]);
                if (action == HTEnums.ActionEnum.Edit.ToString()) //修改
                {
                    ShowInfo(this.id);
                }
            }
        }

        #region 赋值操作=================================
        private void ShowInfo(int _id)
        {
            BLL.ht_shop_coupon bll = new BLL.ht_shop_coupon();
            Model.ht_shop_coupon model = bll.GetModel(_id);

            txtTitle.Text = model.title;
            txtRemark.Text = model.remark;
            txtBeginTime.Text = model.begin_date.ToString("yyyy-MM-dd HH:mm:ss");
            txtEndTime.Text = model.end_date.ToString("yyyy-MM-dd HH:mm:ss");
        }
        #endregion

        #region 增加操作=================================
        private bool DoAdd()
        {
            bool result = false;
            Model.ht_shop_coupon model = new Model.ht_shop_coupon();
            BLL.ht_shop_coupon bll = new BLL.ht_shop_coupon();
            model.shop_id = this.main_id;
            model.title = txtTitle.Text;
            model.remark = txtRemark.Text;
            model.begin_date = Utils.StrToDateTime(txtBeginTime.Text.Trim());
            model.end_date = Utils.StrToDateTime(txtEndTime.Text.Trim());
            model.code = Utils.GetCheckCode(6);
            if (bll.Add(model) > 0)
            {
                result = true;
            }
            return result;
        }
        #endregion

        #region 修改操作=================================
        private bool DoEdit(int _id)
        {
            bool result = false;
            BLL.ht_shop_coupon bll = new BLL.ht_shop_coupon();
            Model.ht_shop_coupon model = bll.GetModel(_id);
            model.title = txtTitle.Text;
            model.remark = txtRemark.Text;
            model.begin_date = Utils.StrToDateTime(txtBeginTime.Text.Trim());
            model.end_date = Utils.StrToDateTime(txtEndTime.Text.Trim());
            model.update_time = DateTime.Now;

            if (bll.Update(model))
            {
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
                ChkAdminLevel("shop_coupon", HTEnums.ActionEnum.Edit.ToString()); //检查权限
                if (!DoEdit(this.id))
                {
                    doScript("parent.layer.msg('保存过程中发生错误');");
                    return;
                }
                doScript("parent.layer.msg('修改信息成功');parent.location.href='shop_coupon_list.aspx?main_id=" + this.main_id + "';");
            }
            else //添加
            {
                ChkAdminLevel("shop_coupon", HTEnums.ActionEnum.Add.ToString()); //检查权限
                if (!DoAdd())
                {
                    doScript("parent.layer.msg('保存过程中发生错误');");
                    return;
                }
                doScript("parent.layer.msg('添加信息成功');parent.location.href='shop_coupon_list.aspx?main_id=" + this.main_id + "'");
            }
        }
        protected void doScript(string script)
        {
            this.Page.ClientScript.RegisterStartupScript(this.GetType(), "jquery", "<script>" + script + "</script>");
        }
    }
}