using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web.admin.gb
{
    public partial class standard_edit : UI.ManagePage
    {
        private string action = HTEnums.ActionEnum.Add.ToString(); //操作类型
        private int id = 0;
        private EF.HT_DB db = new EF.HT_DB();//实例化EF对象
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
                var efModel = db.gb_standard.Where(s => s.id == this.id).FirstOrDefault();
                if (efModel == null)
                {
                    JscriptMsg("信息不存在或已被删除！", "back");
                    return;
                }
            }
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("gb_standard", HTEnums.ActionEnum.View.ToString()); //检查权限
                if (action == HTEnums.ActionEnum.Edit.ToString()) //修改
                {
                    ShowInfo(this.id);
                }
            }
        }

        #region 赋值操作=================================
        private void ShowInfo(int _id)
        {
            var efModel = db.gb_standard.Where(s => s.id == this.id).FirstOrDefault();
            txtTitle.Text = efModel.title;
            txtContent.Value = efModel.content;
            txtSortId.Text = efModel.sort_id.ToString();
        }
        #endregion

        #region 增加操作=================================
        private bool DoAdd()
        {
            bool result = false;
            EF.gb_standard efModel = new EF.gb_standard();
            efModel.title = txtTitle.Text.Trim();
            efModel.content = txtContent.Value;
            efModel.sort_id = Utils.ObjToInt(txtSortId.Text);
            db.gb_standard.Add(efModel);
            if (db.SaveChanges() > 0)
            {
                AddAdminLog(HTEnums.ActionEnum.Add.ToString(), "添加G币规范内容:" + efModel.title); //记录日志
                result = true;
            }
            return result;
        }
        #endregion

        #region 修改操作=================================
        private bool DoEdit(int _id)
        {
            bool result = false;
            var efModel = db.gb_standard.Where(s => s.id == _id).FirstOrDefault();
            efModel.title = txtTitle.Text.Trim();
            efModel.content = txtContent.Value;
            efModel.sort_id = Utils.ObjToInt(txtSortId.Text);
            if (db.SaveChanges() > 0)
            {
                AddAdminLog(HTEnums.ActionEnum.Edit.ToString(), "修改G币规范内容:" + efModel.title); //记录日志
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
                ChkAdminLevel("gb_standard", HTEnums.ActionEnum.Edit.ToString()); //检查权限
                if (!DoEdit(this.id))
                {
                    JscriptMsg("保存过程中发生错误啦！", string.Empty);
                    return;
                }
                JscriptMsg("修改信息成功！", "standard_list.aspx");
            }
            else //添加
            {
                ChkAdminLevel("gb_standard", HTEnums.ActionEnum.Add.ToString()); //检查权限
                if (!DoAdd())
                {
                    JscriptMsg("保存过程中发生错误！", string.Empty);
                    return;
                }
                JscriptMsg("添加信息成功！", "standard_list.aspx");
            }
        }
    }
}