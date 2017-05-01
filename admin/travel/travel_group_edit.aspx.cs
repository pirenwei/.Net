using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web.admin.travel
{
    public partial class travel_group_edit : Web.UI.ManagePage
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
                if (!new BLL.travel_group().Exists(this.id))
                {
                    JscriptMsg("信息不存在或已被删除！", "back");
                    return;
                }
            }
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("travel_group", HTEnums.ActionEnum.View.ToString()); //检查权限
                if (action == HTEnums.ActionEnum.Edit.ToString()) //修改
                {
                    ShowInfo(this.id);
                }
            }
        }

        #region 赋值操作=================================
        private void ShowInfo(int _id)
        {
            BLL.travel_group bll = new BLL.travel_group();
            Model.travel_group model = bll.GetModel(_id);

            rblStatus.SelectedValue = model.status.ToString();
            txtTitle.Text = model.title;
            txtRenshu.Text = model.renshu.ToString();
            rblGender.SelectedValue = model.gender;
            txtRemark.Text = model.remark;
            txtBeginTime.Text = model.begin_date.ToString("yyyy-MM-dd HH:mm:ss");
            txtEndTime.Text = model.end_date.ToString("yyyy-MM-dd HH:mm:ss");
            txtJihePlace.Text = model.jihe_place;
            txtJiheTime.Text = model.add_time.ToString("yyyy-MM-dd HH:mm:ss");
        }
        #endregion

        #region 增加操作=================================
        private bool DoAdd()
        {
            bool result = false;
            Model.travel_group model = new Model.travel_group();
            BLL.travel_group bll = new BLL.travel_group();
            model.status = Utils.ObjToInt(rblStatus.SelectedValue);
            model.title = txtTitle.Text.Trim();
            model.renshu = Utils.ObjToInt(txtRenshu.Text);
            model.gender = rblGender.SelectedValue;
            model.remark = txtRemark.Text;
            model.begin_date = Utils.ObjectToDateTime(txtBeginTime.Text);
            model.end_date = Utils.ObjectToDateTime(txtEndTime.Text);
            model.jihe_place = txtJihePlace.Text;
            model.add_time = Utils.ObjectToDateTime(txtJiheTime.Text);
            if (bll.Add(model) > 0)
            {
                AddAdminLog(HTEnums.ActionEnum.Add.ToString(), "添加组团内容:" + model.title); //记录日志
                result = true;
            }
            return result;
        }
        #endregion

        #region 修改操作=================================
        private bool DoEdit(int _id)
        {
            bool result = false;
            BLL.travel_group bll = new BLL.travel_group();
            Model.travel_group model = bll.GetModel(_id);
            model.status = Utils.ObjToInt(rblStatus.SelectedValue);
            model.title = txtTitle.Text.Trim();
            model.renshu = Utils.ObjToInt(txtRenshu.Text);
            model.gender = rblGender.SelectedValue;
            model.remark = txtRemark.Text;
            model.begin_date = Utils.ObjectToDateTime(txtBeginTime.Text);
            model.end_date = Utils.ObjectToDateTime(txtEndTime.Text);
            model.jihe_place = txtJihePlace.Text;
            model.add_time = Utils.ObjectToDateTime(txtJiheTime.Text);
            if (bll.Update(model))
            {
                AddAdminLog(HTEnums.ActionEnum.Edit.ToString(), "修改组团内容:" + model.title); //记录日志
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
                ChkAdminLevel("travel_group", HTEnums.ActionEnum.Edit.ToString()); //检查权限
                if (!DoEdit(this.id))
                {
                    JscriptMsg("保存过程中发生错误啦！", string.Empty);
                    return;
                }
                JscriptMsg("修改信息成功！", "travel_group_list.aspx");
            }
            else //添加
            {
                ChkAdminLevel("travel_group_list", HTEnums.ActionEnum.Add.ToString()); //检查权限
                if (!DoAdd())
                {
                    JscriptMsg("保存过程中发生错误！", string.Empty);
                    return;
                }
                JscriptMsg("添加信息成功！", "travel_group_list.aspx");
            }
        }

    }
}