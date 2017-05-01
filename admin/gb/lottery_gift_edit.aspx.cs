﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web.admin.gb
{
    public partial class lottery_gift_edit : UI.ManagePage
    {
        private string action = HTEnums.ActionEnum.Add.ToString(); //操作类型
        private int id = 0;

        //页面加载事件
        protected void Page_Load(object sender, EventArgs e)
        {
            string _action = HTRequest.GetQueryString("action");

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
                if (!new BLL.gb_lottery_gift().Exists(this.id))
                {
                    JscriptMsg("信息不存在或已被删除！", "back");
                    return;
                }
            }
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("gb_lottery", HTEnums.ActionEnum.View.ToString()); //检查权限
                if (action == HTEnums.ActionEnum.Edit.ToString()) //修改
                {
                    ShowInfo(this.id);
                }
            }
        }

        #region 赋值操作=================================
        private void ShowInfo(int _id)
        {
            BLL.gb_lottery_gift bll = new BLL.gb_lottery_gift();
            Model.gb_lottery_gift model = bll.GetModel(_id);

            txtTitle.Text = model.title;
            //不是相册图片就绑定
            string filename = model.img_url.Substring(model.img_url.LastIndexOf("/") + 1);
            if (!filename.StartsWith("thumb_"))
            {
                txtImgUrl.Text = model.img_url;
            }
            ddlPrizeCode.SelectedValue = model.prize_code.ToString();
            txtQuantity.Text = model.quantity_sum.ToString();
            txtTips.Text = model.tips;
            txtAddTime.Text = model.add_time.ToString("yyyy-MM-dd HH:mm:ss");
        }
        #endregion

        #region 增加操作=================================
        private bool DoAdd()
        {
            bool result = false;
            Model.gb_lottery_gift model = new Model.gb_lottery_gift();
            BLL.gb_lottery_gift bll = new BLL.gb_lottery_gift();
            model.prize_code = Utils.ObjToInt(ddlPrizeCode.SelectedValue);
            model.prize_name = ddlPrizeCode.SelectedItem.Text;
            model.quantity = Utils.ObjToInt(txtQuantity.Text);
            model.quantity_sum = Utils.ObjToInt(txtQuantity.Text);
            model.tips = txtTips.Text;
            model.title = txtTitle.Text.Trim();
            model.img_url = txtImgUrl.Text;
            model.add_time = Utils.StrToDateTime(txtAddTime.Text.Trim());

            if (bll.Add(model) > 0)
            {
                AddAdminLog(HTEnums.ActionEnum.Add.ToString(), "添加G币抽奖内容:" + model.title); //记录日志
                result = true;
            }
            return result;
        }
        #endregion

        #region 修改操作=================================
        private bool DoEdit(int _id)
        {
            bool result = false;
            BLL.gb_lottery_gift bll = new BLL.gb_lottery_gift();
            Model.gb_lottery_gift model = bll.GetModel(_id);
            model.prize_code = Utils.ObjToInt(ddlPrizeCode.SelectedValue);
            model.prize_name = ddlPrizeCode.SelectedItem.Text;
            model.quantity = Utils.ObjToInt(txtQuantity.Text);
            model.quantity_sum = Utils.ObjToInt(txtQuantity.Text);
            model.tips = txtTips.Text;
            model.title = txtTitle.Text.Trim();
            model.img_url = txtImgUrl.Text;
            model.update_time = DateTime.Now;

            if (bll.Update(model))
            {
                AddAdminLog(HTEnums.ActionEnum.Edit.ToString(), "修改G币抽奖内容:" + model.title); //记录日志
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
                ChkAdminLevel("gb_lottery", HTEnums.ActionEnum.Edit.ToString()); //检查权限
                if (!DoEdit(this.id))
                {
                    JscriptMsg("保存过程中发生错误啦！", string.Empty);
                    return;
                }
                JscriptMsg("修改信息成功！", "lottery_gift_list.aspx");
            }
            else //添加
            {
                ChkAdminLevel("gb_lottery", HTEnums.ActionEnum.Add.ToString()); //检查权限
                if (!DoAdd())
                {
                    JscriptMsg("保存过程中发生错误！", string.Empty);
                    return;
                }
                JscriptMsg("添加信息成功！", "lottery_gift_list.aspx");
            }
        }
    }
}