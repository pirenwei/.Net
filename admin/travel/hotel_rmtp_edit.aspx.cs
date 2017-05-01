using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web.admin.travel
{
    public partial class hotel_rmtp_edit : UI.ManagePage
    {
        private string action = HTEnums.ActionEnum.Add.ToString(); //操作类型
        public int id = 0;
        public int hotel_id = 0;
        //页面加载事件
        protected void Page_Load(object sender, EventArgs e)
        {
            string _action = HTRequest.GetQueryString("action");
            this.hotel_id = HTRequest.GetQueryInt("hotel_id");
            ViewState["hotel_id"] = this.hotel_id;
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
                if (!new BLL.ht_hotel_rmtp().Exists(this.id))
                {
                    JscriptMsg("信息不存在或已被删除！", "back");
                    return;
                }
            }
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("hotel_rmtp", HTEnums.ActionEnum.View.ToString()); //检查权限
                this.hotel_id = Utils.ObjToInt(ViewState["hotel_id"]);
                if (action == HTEnums.ActionEnum.Edit.ToString()) //修改
                {
                    ShowInfo(this.id);
                }
            }
        }

        #region 赋值操作=================================
        private void ShowInfo(int _id)
        {
            BLL.ht_hotel_rmtp bll = new BLL.ht_hotel_rmtp();
            Model.ht_hotel_rmtp model = bll.GetModel(_id);

            txtTitle.Text = model.title;
            txtRmtpPrice.Text = model.rmtp_price.ToString();
            txtCount.Text = model.rmtp_count.ToString();
        }
        #endregion

        #region 增加操作=================================
        private bool DoAdd()
        {
            bool result = false;
            Model.ht_hotel_rmtp model = new Model.ht_hotel_rmtp();
            BLL.ht_hotel_rmtp bll = new BLL.ht_hotel_rmtp();
            model.hotel_id = this.hotel_id;
            model.title = txtTitle.Text;
            model.rmtp_price = Utils.ObjToDecimal(txtRmtpPrice.Text,0);
            model.rmtp_count = Utils.ObjToInt(txtCount.Text);

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
            BLL.ht_hotel_rmtp bll = new BLL.ht_hotel_rmtp();
            Model.ht_hotel_rmtp model = bll.GetModel(_id);

            model.title = txtTitle.Text;
            model.rmtp_price = Utils.ObjToDecimal(txtRmtpPrice.Text, 0);
            model.rmtp_count = Utils.ObjToInt(txtCount.Text);
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
                ChkAdminLevel("hotel_rmtp", HTEnums.ActionEnum.Edit.ToString()); //检查权限
                if (!DoEdit(this.id))
                {
                    doScript("parent.layer.msg('保存过程中发生错误');");
                    return;
                }
                doScript("parent.layer.msg('修改信息成功');parent.location.href='hotel_rmtp_list.aspx?hotel_id=" + this.hotel_id + "';");
            }
            else //添加
            {
                ChkAdminLevel("hotel_rmtp", HTEnums.ActionEnum.Add.ToString()); //检查权限
                if (!DoAdd())
                {
                    doScript("parent.layer.msg('保存过程中发生错误');");
                    return;
                }
                doScript("parent.layer.msg('添加信息成功');parent.location.href='hotel_rmtp_list.aspx?hotel_id=" + this.hotel_id + "'");
            }
        }
    }
}