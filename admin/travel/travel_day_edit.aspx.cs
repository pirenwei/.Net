using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web.admin.travel
{
    public partial class travel_day_edit : Web.UI.ManagePage
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
                if (!new BLL.ht_travel_day().Exists(this.id))
                {
                    JscriptMsg("信息不存在或已被删除！", "back");
                    return;
                }
            }
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("travel_list", HTEnums.ActionEnum.View.ToString()); //检查权限
                if (action == HTEnums.ActionEnum.Edit.ToString()) //修改
                {
                    ShowInfo(this.id);
                }
            }
        }

        #region 赋值操作=================================
        private void ShowInfo(int _id)
        {
            BLL.ht_travel_day bll = new BLL.ht_travel_day();
            Model.ht_travel_day model = bll.GetModel(_id);

            txtTitle.Text = model.note_title;
            txtContent.Value = model.note_content;
        }
        #endregion

        #region 增加操作=================================
        private bool DoAdd()
        {
            bool result = false;
            Model.ht_travel_day model = new Model.ht_travel_day();
            BLL.ht_travel_day bll = new BLL.ht_travel_day();
            model.note_title = txtTitle.Text.Trim();
            model.note_content = txtContent.Value;
            if (bll.Add(model) > 0)
            {
                AddAdminLog(HTEnums.ActionEnum.Add.ToString(), "添加每日行程内容:" + model.title); //记录日志
                result = true;
            }
            return result;
        }
        #endregion

        #region 修改操作=================================
        private bool DoEdit(int _id)
        {
            bool result = false;
            BLL.ht_travel_day bll = new BLL.ht_travel_day();
            Model.ht_travel_day model = bll.GetModel(_id);
            model.note_title = txtTitle.Text.Trim();
            model.note_content = txtContent.Value;
            if (bll.Update(model))
            {
                AddAdminLog(HTEnums.ActionEnum.Edit.ToString(), "修改每日行程内容:" + model.title); //记录日志
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
                ChkAdminLevel("travel_list", HTEnums.ActionEnum.Edit.ToString()); //检查权限
                if (!DoEdit(this.id))
                {
                    JscriptMsg("保存过程中发生错误啦！", string.Empty);
                    return;
                }
                JscriptMsg("修改信息成功！", "travel_day_list.aspx");
            }
            else //添加
            {
                ChkAdminLevel("travel_list", HTEnums.ActionEnum.Add.ToString()); //检查权限
                if (!DoAdd())
                {
                    JscriptMsg("保存过程中发生错误！", string.Empty);
                    return;
                }
                JscriptMsg("添加信息成功！", "travel_day_list.aspx");
            }
        }

    }
}