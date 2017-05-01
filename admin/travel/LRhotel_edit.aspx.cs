using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web.admin.travel
{
    public partial class LRhotel_edit : Web.UI.ManagePage
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
                if (!new BLL.LR_Hotel().Exists(this.id))
                {
                    JscriptMsg("信息不存在或已被删除！", "back");
                    return;
                }
            }
            if (!Page.IsPostBack)
            {
                //ChkAdminLevel("LRhotel_list", HTEnums.ActionEnum.View.ToString()); //检查权限
                if (action == HTEnums.ActionEnum.Edit.ToString()) //修改
                {
                    ShowInfo(this.id);
                }
            }
        }

        #region 赋值操作=================================
        private void ShowInfo(int _id)
        {
            BLL.LR_Hotel bll = new BLL.LR_Hotel();
            Model.LR_Hotel model = bll.GetModel(_id);

            txtTitle.Text = model.hotel_name;
            txtImgUrl.Text = model.img_url;
            txtAddress.Text = model.hotel_address;
            txtLat.Text = model.lat;
            txtLng.Text = model.lng;
            txtZhaiyao.Text = model.hotel_description;
            txtAddTime.Text = model.add_time.ToString("yyyy-MM-dd HH:mm:ss");
        }
        #endregion

        #region 修改操作=================================
        private bool DoEdit(int _id)
        {
            bool result = false;
            BLL.LR_Hotel bll = new BLL.LR_Hotel();
            Model.LR_Hotel model = bll.GetModel(_id);

            model.hotel_name = txtTitle.Text.Trim();
            model.hotel_address = txtAddress.Text.Trim();
            model.lat = txtLat.Text.Trim();
            model.lng = txtLng.Text.Trim();
            model.img_url = txtImgUrl.Text;
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
                //ChkAdminLevel("LRhotel_list", HTEnums.ActionEnum.Edit.ToString()); //检查权限
                if (!DoEdit(this.id))
                {
                    JscriptMsg("保存过程中发生错误啦！", string.Empty);
                    return;
                }
                JscriptMsg("修改信息成功！", "LRhotel_list.aspx");
            }
        }

    }
}