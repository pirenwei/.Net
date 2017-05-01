using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web.admin.gb
{
    public partial class paipai_goods_edit : UI.ManagePage
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
                if (!new BLL.gb_paipai().Exists(this.id))
                {
                    JscriptMsg("信息不存在或已被删除！", "back");
                    return;
                }
            }
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("gb_paipai", HTEnums.ActionEnum.View.ToString()); //检查权限
                if (action == HTEnums.ActionEnum.Edit.ToString()) //修改
                {
                    ShowInfo(this.id);
                }
            }
        }

        #region 赋值操作=================================
        private void ShowInfo(int _id)
        {
            BLL.gb_paipai bll = new BLL.gb_paipai();
            Model.gb_paipai model = bll.GetModel(_id);

            txtTitle.Text = model.title;
            //不是相册图片就绑定
            string filename = model.img_url.Substring(model.img_url.LastIndexOf("/") + 1);
            if (!filename.StartsWith("thumb_"))
            {
                txtImgUrl.Text = model.img_url;
            }
            txtLowPoint.Text = model.low_point.ToString();
            txtHighPoint.Text = model.high_point.ToString();
            //txtBeginTime.Text = model.begin_time.ToString("yyyy-MM-dd HH:mm:ss");
            txtEndTime.Text = model.end_time.ToString("yyyy-MM-dd HH:mm:ss");
            rblStatus.SelectedValue = model.status.ToString();
            //txtAddTime.Text = model.add_time.ToString("yyyy-MM-dd HH:mm:ss");
            txtContent.Value = model.content;
        }
        #endregion

        #region 增加操作=================================
        private bool DoAdd()
        {
            bool result = false;
            Model.gb_paipai model = new Model.gb_paipai();
            BLL.gb_paipai bll = new BLL.gb_paipai();
            model.title = txtTitle.Text.Trim();
            model.img_url = txtImgUrl.Text;
            model.low_point = Utils.ObjToInt(txtLowPoint.Text);
            model.high_point = Utils.ObjToInt(txtLowPoint.Text);
            //model.begin_time = Utils.ObjectToDateTime(txtBeginTime.Text);
            model.end_time = Utils.ObjectToDateTime(txtEndTime.Text);
            model.status = Utils.StrToInt(rblStatus.SelectedValue, 0);
            model.add_time = DateTime.Now;
            model.content = txtContent.Value;
            if (bll.Add(model) > 0)
            {
                AddAdminLog(HTEnums.ActionEnum.Add.ToString(), "添加G币竞拍内容:" + model.title); //记录日志
                result = true;
            }
            return result;
        }
        #endregion

        #region 修改操作=================================
        private bool DoEdit(int _id)
        {
            bool result = false;
            BLL.gb_paipai bll = new BLL.gb_paipai();
            Model.gb_paipai model = bll.GetModel(_id);
            model.title = txtTitle.Text.Trim();
            model.img_url = txtImgUrl.Text;
            model.low_point = Utils.ObjToInt(txtLowPoint.Text);
            model.high_point = Utils.ObjToInt(txtHighPoint.Text);
            //model.begin_time = Utils.ObjectToDateTime(txtBeginTime.Text);
            model.end_time = Utils.ObjectToDateTime(txtEndTime.Text);
            model.status = Utils.StrToInt(rblStatus.SelectedValue, 0);
            model.update_time = DateTime.Now;
            model.content = txtContent.Value;
            if (bll.Update(model))
            {
                AddAdminLog(HTEnums.ActionEnum.Edit.ToString(), "修改G币竞拍内容:" + model.title); //记录日志
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
                ChkAdminLevel("gb_paipai", HTEnums.ActionEnum.Edit.ToString()); //检查权限
                if (!DoEdit(this.id))
                {
                    JscriptMsg("保存过程中发生错误啦！", string.Empty);
                    return;
                }
                JscriptMsg("修改信息成功！", "paipai_goods_list.aspx");
            }
            else //添加
            {
                ChkAdminLevel("gb_paipai", HTEnums.ActionEnum.Add.ToString()); //检查权限
                if (!DoAdd())
                {
                    JscriptMsg("保存过程中发生错误！", string.Empty);
                    return;
                }
                JscriptMsg("添加信息成功！", "paipai_goods_list.aspx");
            }
        }
    }
}