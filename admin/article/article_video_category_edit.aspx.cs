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
    public partial class article_video_category_edit : Web.UI.ManagePage
    {
        private string action = HTEnums.ActionEnum.Add.ToString(); //操作类型
        protected int channel_id = 3;//video
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
                if (!new BLL.article_category().Exists(this.id))
                {
                    JscriptMsg("类别不存在或已被删除！", "back");
                    return;
                }
            }
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("article_video", HTEnums.ActionEnum.View.ToString()); //检查权限
                TreeBind(); //绑定类别
                if (action == HTEnums.ActionEnum.Edit.ToString()) //修改
                {
                    ShowInfo(this.id);
                }
                else
                {
                    if (this.id > 0)
                    {
                        this.ddlParentId.SelectedValue = this.id.ToString();
                    }
                }
            }
        }

        #region 绑定类别=================================
        private void TreeBind()
        {
            BLL.article_category bll = new BLL.article_category();
            DataTable dt = bll.GetList(0,this.channel_id);

            this.ddlParentId.Items.Clear();
            this.ddlParentId.Items.Add(new ListItem("无父级分类", "0"));
            foreach (DataRow dr in dt.Rows)
            {
                string Id = dr["id"].ToString();
                int ClassLayer = int.Parse(dr["class_layer"].ToString());
                string Title = dr["title"].ToString().Trim();

                if (ClassLayer == 1)
                {
                    this.ddlParentId.Items.Add(new ListItem(Title, Id));
                }
                else
                {
                    Title = "├ " + Title;
                    Title = Utils.StringOfChar(ClassLayer - 1, "　") + Title;
                    this.ddlParentId.Items.Add(new ListItem(Title, Id));
                }
            }
        }
        #endregion

        #region 赋值操作=================================
        private void ShowInfo(int _id)
        {
            BLL.article_category bll = new BLL.article_category();
            Model.article_category model = bll.GetModel(_id);

            ddlParentId.SelectedValue = model.parent_id.ToString();
            txtTitle.Text = model.title;
            txtSortId.Text = model.sort_id.ToString();
        }
        #endregion

        #region 增加操作=================================
        private bool DoAdd()
        {
            try
            {
                Model.article_category model = new Model.article_category();
                BLL.article_category bll = new BLL.article_category();
                model.channel_id = this.channel_id;
                model.title = txtTitle.Text.Trim();
                model.parent_id = int.Parse(ddlParentId.SelectedValue);
                model.sort_id = int.Parse(txtSortId.Text.Trim());
                if (bll.Add(model) > 0)
                {
                    AddAdminLog(HTEnums.ActionEnum.Add.ToString(), "添加栏目类别:" + model.title); //记录日志
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
                BLL.article_category bll = new BLL.article_category();
                Model.article_category model = bll.GetModel(_id);

                int parentId = int.Parse(ddlParentId.SelectedValue);
                model.title = txtTitle.Text.Trim();
                //如果选择的父ID不是自己,则更改
                if (parentId != model.id)
                {
                    model.parent_id = parentId;
                }
                model.channel_id = this.channel_id;
                model.sort_id = int.Parse(txtSortId.Text.Trim());
                if (bll.Update(model))
                {
                    AddAdminLog(HTEnums.ActionEnum.Edit.ToString(), "修改栏目类别:" + model.title); //记录日志
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

        //保存类别
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (action == HTEnums.ActionEnum.Edit.ToString()) //修改
            {
                ChkAdminLevel("article_video", HTEnums.ActionEnum.Edit.ToString()); //检查权限
                if (!DoEdit(this.id))
                {

                    JscriptMsg("保存过程中发生错误！", "");
                    return;
                }
                JscriptMsg("修改类别成功！", "article_video_category_list.aspx");
            }
            else //添加
            {
                ChkAdminLevel("article_video", HTEnums.ActionEnum.Add.ToString()); //检查权限
                if (!DoAdd())
                {
                    JscriptMsg("保存过程中发生错误！", "");
                    return;
                }
                JscriptMsg("添加类别成功！", "article_video_category_list.aspx");
            }
        }

    }
}