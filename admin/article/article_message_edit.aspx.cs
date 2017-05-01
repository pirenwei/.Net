﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web.admin.article
{
    public partial class article_message_edit : Web.UI.ManagePage
    {
        protected string action = HTEnums.ActionEnum.Add.ToString(); //操作类型

        protected int channel_id = 2;//message
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
                if (!new BLL.ht_article().Exists(this.id))
                {
                    JscriptMsg("信息不存在或已被删除！", "back");
                    return;
                }
            }
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("article_message", HTEnums.ActionEnum.Add.ToString()); //检查权限
                TreeBind();
                if (action == HTEnums.ActionEnum.Edit.ToString()) //修改
                {
                    ShowInfo(this.id);
                }
            }
        }

        #region 绑定类别=================================
        private void TreeBind()
        {
            BLL.article_category bll = new BLL.article_category();
            DataTable dt = bll.GetList(0, this.channel_id);

            this.ddlCategoryId.Items.Clear();
            this.ddlCategoryId.Items.Add(new ListItem("请选择类别...", ""));
            foreach (DataRow dr in dt.Rows)
            {
                string Id = dr["id"].ToString();
                int ClassLayer = int.Parse(dr["class_layer"].ToString());
                string Title = dr["title"].ToString().Trim();

                if (ClassLayer == 1)
                {
                    this.ddlCategoryId.Items.Add(new ListItem(Title, Id));
                }
                else
                {
                    Title = "├ " + Title;
                    Title = Utils.StringOfChar(ClassLayer - 1, "　") + Title;
                    this.ddlCategoryId.Items.Add(new ListItem(Title, Id));
                }
            }
        }
        #endregion

        #region 赋值操作=================================
        private void ShowInfo(int _id)
        {
            BLL.ht_article bll = new BLL.ht_article();
            Model.ht_article model = bll.GetModel(_id);

            ddlCategoryId.SelectedValue = model.category_id.ToString();
            txtTitle.Text = model.title;
            //不是相册图片就绑定
            string filename = model.img_url.Substring(model.img_url.LastIndexOf("/") + 1);
            if (!filename.StartsWith("thumb_"))
            {
                txtImgUrl.Text = model.img_url;
            }
            txtSeoTitle.Text = model.seo_title;
            txtSeoKeywords.Text = model.seo_keywords;
            txtSeoDescription.Text = model.seo_description;
            txtZhaiyao.Text = model.zhaiyao;
            txtContent.Value = model.content;
            txtSortId.Text = model.sort_id.ToString();
            txtClick.Text = model.click.ToString();
            rblStatus.SelectedValue = model.status.ToString();
            if (action == HTEnums.ActionEnum.Edit.ToString())
            {
                txtAddTime.Text = model.add_time.ToString("yyyy-MM-dd HH:mm:ss");
            }
            if (model.is_top == 1)
            {
                cblItem.Items[0].Selected = true;
            }
            if (model.is_red == 1)
            {
                cblItem.Items[1].Selected = true;
            }
            if (model.is_hot == 1)
            {
                cblItem.Items[2].Selected = true;
            }
            txtSource.Text = model.source;
            txtAuthor.Text = model.author;
            txtAddress.Text = model.address;
            txtBeginTime.Text = model.begin_time;
            txtEndTime.Text = model.end_time;
        }
        #endregion


        #region 增加操作=================================
        private bool DoAdd()
        {
            bool result = false;
            Model.ht_article model = new Model.ht_article();
            BLL.ht_article bll = new BLL.ht_article();

            model.channel_id = this.channel_id;
            model.category_id = Utils.StrToInt(ddlCategoryId.SelectedValue, 0);
            model.title = txtTitle.Text.Trim();
            model.sub_title = txtSubTitle.Text.Trim();
            model.img_url = txtImgUrl.Text;
            model.seo_title = txtSeoTitle.Text.Trim();
            model.seo_keywords = txtSeoKeywords.Text.Trim();
            model.seo_description = txtSeoDescription.Text.Trim();
            //内容摘要提取内容前255个字符
            if (string.IsNullOrEmpty(txtZhaiyao.Text.Trim()))
            {
                model.zhaiyao = Utils.DropHTML(txtContent.Value, 255);
            }
            else
            {
                model.zhaiyao = Utils.DropHTML(txtZhaiyao.Text, 255);
            }
            model.content = txtContent.Value;
            model.sort_id = Utils.StrToInt(txtSortId.Text.Trim(), 99);
            model.click = int.Parse(txtClick.Text.Trim());
            model.status = Utils.StrToInt(rblStatus.SelectedValue, 0);
            model.is_top = 0;
            model.is_red = 0;
            model.is_hot = 0;
            if (cblItem.Items[0].Selected == true)
            {
                model.is_top = 1;
            }
            if (cblItem.Items[1].Selected == true)
            {
                model.is_red = 1;
            }
            if (cblItem.Items[2].Selected == true)
            {
                model.is_hot = 1;
            }
            model.is_sys = 1; //管理员发布
            model.add_time = Utils.StrToDateTime(txtAddTime.Text.Trim());
            model.source = txtSource.Text.Trim();
            model.author = txtAuthor.Text.Trim();
            model.address = txtAddress.Text;
            model.begin_time = txtBeginTime.Text;
            model.end_time = txtEndTime.Text;
            if (bll.Add(model) > 0)
            {
                AddAdminLog(HTEnums.ActionEnum.Add.ToString(), "添加文章内容:" + model.title); //记录日志
                result = true;
            }
            return result;
        }
        #endregion

        #region 修改操作=================================
        private bool DoEdit(int _id)
        {
            bool result = false;
            BLL.ht_article bll = new BLL.ht_article();
            Model.ht_article model = bll.GetModel(_id);

            model.channel_id = this.channel_id;
            model.category_id = Utils.StrToInt(ddlCategoryId.SelectedValue, 0);
            model.title = txtTitle.Text.Trim();
            model.sub_title = txtSubTitle.Text.Trim();
            model.img_url = txtImgUrl.Text;
            model.seo_title = txtSeoTitle.Text.Trim();
            model.seo_keywords = txtSeoKeywords.Text.Trim();
            model.seo_description = txtSeoDescription.Text.Trim();
            //内容摘要提取内容前255个字符
            if (string.IsNullOrEmpty(txtZhaiyao.Text.Trim()))
            {
                model.zhaiyao = Utils.DropHTML(txtContent.Value, 255);
            }
            else
            {
                model.zhaiyao = Utils.DropHTML(txtZhaiyao.Text, 255);
            }
            model.content = txtContent.Value;
            model.sort_id = Utils.StrToInt(txtSortId.Text.Trim(), 99);
            model.click = int.Parse(txtClick.Text.Trim());
            model.status = Utils.StrToInt(rblStatus.SelectedValue, 0);
            model.is_top = 0;
            model.is_red = 0;
            model.is_hot = 0;
            if (cblItem.Items[0].Selected == true)
            {
                model.is_top = 1;
            }
            if (cblItem.Items[1].Selected == true)
            {
                model.is_red = 1;
            }
            if (cblItem.Items[2].Selected == true)
            {
                model.is_hot = 1;
            }
            model.add_time = Utils.StrToDateTime(txtAddTime.Text.Trim());
            model.update_time = DateTime.Now;
            model.source = txtSource.Text.Trim();
            model.author = txtAuthor.Text.Trim();
            model.address = txtAddress.Text;
            model.begin_time = txtBeginTime.Text;
            model.end_time = txtEndTime.Text;
            if (bll.Update(model))
            {

                AddAdminLog(HTEnums.ActionEnum.Edit.ToString(), "修改文章内容:" + model.title); //记录日志
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
                ChkAdminLevel("article_message", HTEnums.ActionEnum.Add.ToString()); //检查权限
                if (!DoEdit(this.id))
                {
                    JscriptMsg("保存过程中发生错误！", "");
                    return;
                }
                JscriptMsg("修改成功！", "article_message_list.aspx");
            }
            else //添加
            {
                ChkAdminLevel("article_message", HTEnums.ActionEnum.Add.ToString()); //检查权限
                if (!DoAdd())
                {
                    JscriptMsg("保存过程中发生错误！", "");
                    return;
                }
                JscriptMsg("修改成功！", "article_message_list.aspx");
            }
        }
    }
}