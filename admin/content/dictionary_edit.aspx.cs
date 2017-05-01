using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web.admin.content
{
    public partial class dictionary_edit : Web.UI.ManagePage
    {
        private string action = HTEnums.ActionEnum.Add.ToString(); //操作类型
        private int id = 0;
        public int category_id = 0;
        //页面加载事件
        protected void Page_Load(object sender, EventArgs e)
        {
            string _action = HTRequest.GetQueryString("action");
            this.category_id = HTRequest.GetQueryInt("category_id");
            ViewState["category_id"] = this.category_id;
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
                if (!new BLL.ht_dictionary().Exists(this.id))
                {
                    JscriptMsg("信息不存在或已被删除！", "back");
                    return;
                }
            }
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("dictionary_list", HTEnums.ActionEnum.View.ToString()); //检查权限
                this.category_id = Utils.ObjToInt(ViewState["category_id"]);
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
            BLL.ht_dictionary_category bll = new BLL.ht_dictionary_category();
            DataTable dt = bll.GetList("").Tables[0];

            this.ddlCategoryId.Items.Clear();
            this.ddlCategoryId.Items.Add(new ListItem("无父级类别...", "0"));
            foreach (DataRow dr in dt.Rows)
            {
                string Id = dr["id"].ToString();
                string Title = dr["title"].ToString().Trim();

                this.ddlCategoryId.Items.Add(new ListItem(Title, Id));
            }
            BLL.ht_dictionary bll2 = new BLL.ht_dictionary();
            DataTable dt2 = bll2.GetList("id in(select id from ht_dictionary where category_id=1)").Tables[0];

            this.city.Items.Clear();
            this.city.Items.Add(new ListItem("请选择...", "0"));
            foreach (DataRow dr in dt2.Rows)
            {
                string Id = dr["id"].ToString();
                string Title = dr["title"].ToString().Trim();

                this.city.Items.Add(new ListItem(Title, Id));
            }
        }
        #endregion

        #region 赋值操作=================================
        private void ShowInfo(int _id)
        {
            BLL.ht_dictionary bll = new BLL.ht_dictionary();
            Model.ht_dictionary model = bll.GetModel(_id);

            ddlCategoryId.SelectedValue = model.category_id.ToString();
            txtTitle.Text = model.title;
            city.SelectedValue = model.p_id.ToString();
        }
        #endregion

        #region 增加操作=================================
        private bool DoAdd()
        {
            bool result = false;
            Model.ht_dictionary model = new Model.ht_dictionary();
            BLL.ht_dictionary bll = new BLL.ht_dictionary();
            model.category_id = Utils.StrToInt(ddlCategoryId.SelectedValue, 0);
            model.p_id = Utils.StrToInt(city.SelectedValue, 0);
            model.title = txtTitle.Text.Trim();

            if (bll.Add(model) > 0)
            {
                AddAdminLog(HTEnums.ActionEnum.Add.ToString(), "添加数据字典:" + model.title); //记录日志
                result = true;
            }
            return result;
        }
        #endregion

        #region 修改操作=================================
        private bool DoEdit(int _id)
        {
            bool result = false;
            BLL.ht_dictionary bll = new BLL.ht_dictionary();
            Model.ht_dictionary model = bll.GetModel(_id);
            model.p_id = Utils.StrToInt(city.SelectedValue, 0);
            model.category_id = Utils.StrToInt(ddlCategoryId.SelectedValue, 0);
            model.title = txtTitle.Text.Trim();

            if (bll.Update(model))
            {
                AddAdminLog(HTEnums.ActionEnum.Edit.ToString(), "修改数据字典:" + model.title); //记录日志
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
                ChkAdminLevel("data_dictionary", HTEnums.ActionEnum.Edit.ToString()); //检查权限
                if (!DoEdit(this.id))
                {
                    doScript("parent.layer.msg('保存过程中发生错误');");
                    return;
                }
                doScript("parent.layer.msg('修改信息成功');parent.location.href='dictionary_list.aspx?category_id=" + this.category_id + "'");
            }
            else //添加
            {
                ChkAdminLevel("data_dictionary", HTEnums.ActionEnum.Add.ToString()); //检查权限
                if (!DoAdd())
                {
                    doScript("parent.layer.msg('保存过程中发生错误');");
                    return;
                }
                doScript("parent.layer.msg('添加信息成功');parent.location.href='dictionary_list.aspx?category_id=" + this.category_id + "'");
            }
        }
    }
}