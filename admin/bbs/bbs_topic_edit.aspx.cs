using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web.admin.bbs
{
    public partial class bbs_topic_edit : Web.UI.ManagePage
    {
        private string action = HTEnums.ActionEnum.Add.ToString(); //操作类型
        public int id = 0;

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
                if (!new BLL.ht_bbs_topic().Exists(this.id))
                {
                    JscriptMsg("信息不存在或已被删除！", "back");
                    return;
                }
            }
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("bbs_topic", HTEnums.ActionEnum.View.ToString()); //检查权限
                TreeBind(); //绑定类别
                if (action == HTEnums.ActionEnum.Edit.ToString()) //修改
                {
                    ShowInfo(this.id);
                }
            }
        }

        #region 绑定类别=================================
        private void TreeBind()
        {
            BLL.ht_bbs_category bll = new BLL.ht_bbs_category();
            DataTable dt = bll.GetList(0);

            this.ddlCategoryId.Items.Clear();
            this.ddlCategoryId.Items.Add(new ListItem("无父级类别...", ""));
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
            BLL.ht_bbs_topic bll = new BLL.ht_bbs_topic();
            Model.ht_bbs_topic model = bll.GetModel(_id);

            ddlCategoryId.SelectedValue = model.category_id.ToString();
            txtTitle.Text = model.title;
            rblIsElite.SelectedValue = model.is_elite.ToString();
            rblIsTop.SelectedValue = model.is_top.ToString();
            txtContent.Value = model.content;
            rblStatus.SelectedValue = model.status.ToString();
            txtAddTime.Text = model.add_time.ToString("yyyy-MM-dd HH:mm:ss");
        }
        #endregion

        #region 增加操作=================================
        private bool DoAdd()
        {
            bool result = false;
            Model.ht_bbs_topic model = new Model.ht_bbs_topic();
            BLL.ht_bbs_topic bll = new BLL.ht_bbs_topic();
            model.category_id = Utils.StrToInt(ddlCategoryId.SelectedValue, 0);
            model.title = txtTitle.Text.Trim();
            model.is_elite = Utils.StrToInt(rblIsElite.SelectedValue, 0);
            model.is_top = Utils.StrToInt(rblIsTop.SelectedValue, 0);
            model.content = txtContent.Value;
            model.status = Utils.StrToInt(rblStatus.SelectedValue, 0);
            model.add_time = Utils.StrToDateTime(txtAddTime.Text.Trim());

            if (bll.Add(model) > 0)
            {
                AddAdminLog(HTEnums.ActionEnum.Add.ToString(), "添加帖子内容:" + model.title); //记录日志
                result = true;
            }
            return result;
        }
        #endregion

        #region 修改操作=================================
        private bool DoEdit(int _id)
        {
            bool result = false;
            BLL.ht_bbs_topic bll = new BLL.ht_bbs_topic();
            Model.ht_bbs_topic model = bll.GetModel(_id);

            model.category_id = Utils.StrToInt(ddlCategoryId.SelectedValue, 0);
            model.title = txtTitle.Text.Trim();
            model.is_elite = Utils.StrToInt(rblIsElite.SelectedValue, 0);
            model.is_top = Utils.StrToInt(rblIsTop.SelectedValue, 0);
            model.content = txtContent.Value;
            model.status = Utils.StrToInt(rblStatus.SelectedValue, 0);
            model.update_time = DateTime.Now;

            if (bll.Update(model))
            {
                AddAdminLog(HTEnums.ActionEnum.Edit.ToString(), "修改帖子内容:" + model.title); //记录日志
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
                ChkAdminLevel("bbs_topic", HTEnums.ActionEnum.Edit.ToString()); //检查权限
                if (!DoEdit(this.id))
                {
                    JscriptMsg("保存过程中发生错误啦！", string.Empty);
                    return;
                }
                JscriptMsg("修改信息成功！", "bbs_topic_list.aspx");
            }
            else //添加
            {
                ChkAdminLevel("bbs_topic", HTEnums.ActionEnum.Add.ToString()); //检查权限
                if (!DoAdd())
                {
                    JscriptMsg("保存过程中发生错误！", string.Empty);
                    return;
                }
                JscriptMsg("添加信息成功！", "bbs_topic_list.aspx");
            }
        }
    }
}