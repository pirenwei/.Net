using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web.admin.bbs
{
    public partial class bbs_reply_edit : Web.UI.ManagePage
    {
        private string action = HTEnums.ActionEnum.Add.ToString(); //操作类型
        public int id = 0;
        public int topic_id = 0;
        //页面加载事件
        protected void Page_Load(object sender, EventArgs e)
        {
            string _action = HTRequest.GetQueryString("action");
            this.topic_id = HTRequest.GetQueryInt("topic_id");
            ViewState["topic_id"] = this.topic_id;
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
                if (!new BLL.ht_bbs_reply().Exists(this.id))
                {
                    JscriptMsg("信息不存在或已被删除！", "back");
                    return;
                }
            }
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("bbs_reply", HTEnums.ActionEnum.View.ToString()); //检查权限
                this.topic_id = Utils.ObjToInt(ViewState["topic_id"]);
                if (action == HTEnums.ActionEnum.Edit.ToString()) //修改
                {
                    ShowInfo(this.id);
                }
            }
        }

        #region 赋值操作=================================
        private void ShowInfo(int _id)
        {
            BLL.ht_bbs_reply bll = new BLL.ht_bbs_reply();
            Model.ht_bbs_reply model = bll.GetModel(_id);

            txtContent.Value = model.content;
            rblStatus.SelectedValue = model.status.ToString();
            txtAddTime.Text = model.add_time.ToString("yyyy-MM-dd HH:mm:ss");
        }
        #endregion

        #region 增加操作=================================
        private bool DoAdd()
        {
            bool result = false;
            Model.ht_bbs_reply model = new Model.ht_bbs_reply();
            BLL.ht_bbs_reply bll = new BLL.ht_bbs_reply();
            model.topic_id = this.topic_id;
            model.content = txtContent.Value;
            model.status = Utils.StrToInt(rblStatus.SelectedValue, 0);
            model.add_time = Utils.StrToDateTime(txtAddTime.Text.Trim());

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
            BLL.ht_bbs_reply bll = new BLL.ht_bbs_reply();
            Model.ht_bbs_reply model = bll.GetModel(_id);

            model.topic_id = this.topic_id;
            model.content = txtContent.Value;
            model.status = Utils.StrToInt(rblStatus.SelectedValue, 0);
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
                ChkAdminLevel("bbs_reply", HTEnums.ActionEnum.Edit.ToString()); //检查权限
                if (!DoEdit(this.id))
                {
                    doScript("parent.layer.msg('保存过程中发生错误');");
                    return;
                }
                doScript("parent.layer.msg('修改信息成功');parent.location.href='bbs_reply_list.aspx?topic_id=" + this.topic_id + "';");
            }
            else //添加
            {
                ChkAdminLevel("bbs_reply", HTEnums.ActionEnum.Add.ToString()); //检查权限
                if (!DoAdd())
                {
                    doScript("parent.layer.msg('保存过程中发生错误');");
                    return;
                }
                doScript("parent.layer.msg('添加信息成功');parent.location.href='bbs_reply_list.aspx?topic_id=" + this.topic_id + "'");
            }
        }
    }
}