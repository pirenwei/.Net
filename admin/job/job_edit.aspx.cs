using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web.admin.job
{
    public partial class job_edit : Web.UI.ManagePage
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
                if (!new BLL.ht_job().Exists(this.id))
                {
                    JscriptMsg("信息不存在或已被删除！", "back");
                    return;
                }
            }
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("job", HTEnums.ActionEnum.View.ToString()); //检查权限
                if (action == HTEnums.ActionEnum.Edit.ToString()) //修改
                {
                    ShowInfo(this.id);
                }
            }
        }

        #region 赋值操作=================================
        private void ShowInfo(int _id)
        {
            BLL.ht_job bll = new BLL.ht_job();
            Model.ht_job model = bll.GetModel(_id);
            txtPosition.Text = model.position;
            txtGender.Text = model.gender;
            txtWorkLife.Text = model.work_life;
            txtNumbers.Text = model.numbers;
            txtDegree.Text = model.degree;
            txtWorkPlace.Text = model.work_place;
            txtSalary.Text = model.salary;
            txtSalaryForm.Text = model.salary_form;
            txtEndTime.Text = model.end_time;
            txtWorkDepict.Value = model.work_depict;
            txtWorkDemand.Value= model.work_demand;

            rblStatus.SelectedValue = model.status.ToString();
            txtAddTime.Text = model.add_time.ToString("yyyy-MM-dd HH:mm:ss");
        }
        #endregion

        #region 增加操作=================================
        private bool DoAdd()
        {
            bool result = false;
            Model.ht_job model = new Model.ht_job();
            BLL.ht_job bll = new BLL.ht_job();
            model.position = txtPosition.Text;
            model.gender = txtGender.Text;
            model.work_life = txtWorkLife.Text;
            model.numbers = txtNumbers.Text;
            model.degree = txtDegree.Text;
            model.work_place = txtWorkPlace.Text;
            model.salary = txtSalary.Text;
            model.salary_form = txtSalaryForm.Text;
            model.end_time = txtEndTime.Text;
            model.work_depict = txtWorkDepict.Value;
            model.work_demand = txtWorkDemand.Value;

            model.status = Utils.StrToInt(rblStatus.SelectedValue, 0);
            model.add_time = Utils.StrToDateTime(txtAddTime.Text.Trim());

            if (bll.Add(model) > 0)
            {
                AddAdminLog(HTEnums.ActionEnum.Add.ToString(), "添加招聘职位:" + model.position); //记录日志
                result = true;
            }
            return result;
        }
        #endregion

        #region 修改操作=================================
        private bool DoEdit(int _id)
        {
            bool result = false;
            BLL.ht_job bll = new BLL.ht_job();
            Model.ht_job model = bll.GetModel(_id);
            model.position = txtPosition.Text;
            model.gender = txtGender.Text;
            model.work_life = txtWorkLife.Text;
            model.numbers = txtNumbers.Text;
            model.degree = txtDegree.Text;
            model.work_place = txtWorkPlace.Text;
            model.salary = txtSalary.Text;
            model.salary_form = txtSalaryForm.Text;
            model.end_time = txtEndTime.Text;
            model.work_depict = txtWorkDepict.Value;
            model.work_demand = txtWorkDemand.Value;

            model.status = Utils.StrToInt(rblStatus.SelectedValue, 0);
            model.update_time = DateTime.Now;

            if (bll.Update(model))
            {
                AddAdminLog(HTEnums.ActionEnum.Edit.ToString(), "修改招聘职位:" + model.position); //记录日志
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
                ChkAdminLevel("job", HTEnums.ActionEnum.Edit.ToString()); //检查权限
                if (!DoEdit(this.id))
                {
                    JscriptMsg("保存过程中发生错误啦！", string.Empty);
                    return;
                }
                JscriptMsg("修改信息成功！", "job_list.aspx");
            }
            else //添加
            {
                ChkAdminLevel("job", HTEnums.ActionEnum.Add.ToString()); //检查权限
                if (!DoAdd())
                {
                    JscriptMsg("保存过程中发生错误！", string.Empty);
                    return;
                }
                JscriptMsg("添加信息成功！", "job_list.aspx");
            }
        }
    }
}