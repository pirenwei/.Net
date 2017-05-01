using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web.admin.car
{
    public partial class car_server_edit : Web.UI.ManagePage
    {
        private string action = HTEnums.ActionEnum.Add.ToString(); //操作类型
        private int id = 0;

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
                if (!new BLL.ht_car_server().Exists(this.id))
                {
                    JscriptMsg("信息不存在或已被删除！", "back");
                    return;
                }
            }
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("car_server", HTEnums.ActionEnum.View.ToString()); //检查权限
                TreeBindArea();
                TreeBindAreaLine();
                if (action == HTEnums.ActionEnum.Edit.ToString()) //修改
                {
                    ShowInfo(this.id);
                }
            }
        }

        #region 绑定区域=================================
        private void TreeBindArea()
        {
            DataTable dt = new BLL.ht_dictionary().GetList("category_id=1").Tables[0];//区域
            this.ddlArea.Items.Clear();
            this.ddlArea.Items.Add(new ListItem("请选择区域...", ""));
            foreach (DataRow dr in dt.Rows)
            {
                string Id = dr["id"].ToString();
                string Title = dr["title"].ToString().Trim();
                this.ddlArea.Items.Add(new ListItem(Title, Id));
            }
        }
        #endregion
        #region 绑定路线=================================
        private void TreeBindAreaLine(int p_id=0)
        {
            DataTable dt;
            if (p_id != 0)
            {
                dt = new BLL.ht_dictionary().GetList("category_id=2 and p_id=" + p_id + "").Tables[0];//区域
            }
            else
            {
                 dt = new BLL.ht_dictionary().GetList("category_id=2").Tables[0];//区域
            }
            this.ddlAreaLine.Items.Clear();
            this.ddlAreaLine.Items.Add(new ListItem("请选择路线...", ""));
            foreach (DataRow dr in dt.Rows)
            {
                string Id = dr["id"].ToString();
                string Title = dr["title"].ToString().Trim();
                this.ddlAreaLine.Items.Add(new ListItem(Title, Id));
            }
        }
        #endregion
        protected void ddlArea_Changed(object sender, EventArgs e) {
            if (ddlArea.SelectedValue != "")
            {
                TreeBindAreaLine(Convert.ToInt32(ddlArea.SelectedValue));
            }
        }

        #region 赋值操作=================================
        private void ShowInfo(int _id)
        {
            BLL.ht_car_server bll = new BLL.ht_car_server();
            Model.ht_car_server model = bll.GetModel(_id);

            ddlType.SelectedValue = model.type.ToString();
            ddlArea.SelectedItem.Text = model.area;
            ddlAreaLine.SelectedItem.Text = model.area_line;
            txtTitle.Text = model.title;
            txtMarketPrice.Text = model.market_price.ToString();
            txtSellPrice.Text = model.sell_price.ToString();
            
            //不是相册图片就绑定
            string filename = model.img_url.Substring(model.img_url.LastIndexOf("/") + 1);
            if (!filename.StartsWith("thumb_"))
            {
                txtImgUrl.Text = model.img_url;
            }
            txtZhaiyao.Text = model.zhaiyao;
            txtContent.Value = model.content;
            rblStatus.SelectedValue = model.status.ToString();
            txtAddTime.Text = model.add_time.ToString("yyyy-MM-dd HH:mm:ss");
            //绑定图片相册
            if (filename.StartsWith("thumb_"))
            {
                hidFocusPhoto.Value = model.img_url; //封面图片
            }
            rptAlbumList.DataSource = model.albums;
            rptAlbumList.DataBind();
        }
        #endregion

        #region 增加操作=================================
        private bool DoAdd()
        {
            bool result = false;
            Model.ht_car_server model = new Model.ht_car_server();
            BLL.ht_car_server bll = new BLL.ht_car_server();
            model.type = Utils.StrToInt(ddlType.SelectedValue, 0);
            model.area = ddlArea.SelectedItem.Text;
            model.area_line = ddlAreaLine.SelectedItem.Text;
            model.title = txtTitle.Text.Trim();
            model.market_price = Utils.StrToDecimal(txtMarketPrice.Text, 0);
            model.sell_price = Utils.StrToDecimal(txtSellPrice.Text, 0);
            model.img_url = txtImgUrl.Text;
            model.is_recommend = Utils.StrToInt(rblIsRecommend.SelectedValue, 0);
            //内容摘要提取内容前255个字符
            if (string.IsNullOrEmpty(txtZhaiyao.Text.Trim()))
            {
                model.zhaiyao = Utils.DropHTML(txtContent.Value, 255);
            }
            else
            {
                model.zhaiyao = Utils.DropHTML(txtZhaiyao.Text, 255);
            }
            model.content = txtContent.Value;
            model.status = Utils.StrToInt(rblStatus.SelectedValue, 0);
            model.add_time = Utils.StrToDateTime(txtAddTime.Text.Trim());

            #region 保存相册====================
            //检查是否有自定义图片
            if (txtImgUrl.Text.Trim() == "")
            {
                model.img_url = hidFocusPhoto.Value;
            }
            string[] albumArr = Request.Form.GetValues("hid_photo_name");
            string[] remarkArr = Request.Form.GetValues("hid_photo_remark");
            if (albumArr != null && albumArr.Length > 0)
            {
                List<Model.ht_common_albums> ls = new List<Model.ht_common_albums>();
                for (int i = 0; i < albumArr.Length; i++)
                {
                    string[] imgArr = albumArr[i].Split('|');
                    if (imgArr.Length == 3)
                    {
                        if (!string.IsNullOrEmpty(remarkArr[i]))
                        {
                            ls.Add(new Model.ht_common_albums { original_path = imgArr[1], thumb_path = imgArr[2], remark = remarkArr[i] });
                        }
                        else
                        {
                            ls.Add(new Model.ht_common_albums { original_path = imgArr[1], thumb_path = imgArr[2] });
                        }
                    }
                }
                model.albums = ls;
            }
            #endregion

            if (bll.Add(model) > 0)
            {
                AddAdminLog(HTEnums.ActionEnum.Add.ToString(), "添加包车服务内容:" + model.title); //记录日志
                result = true;
            }
            return result;
        }
        #endregion

        #region 修改操作=================================
        private bool DoEdit(int _id)
        {
            bool result = false;
            BLL.ht_car_server bll = new BLL.ht_car_server();
            Model.ht_car_server model = bll.GetModel(_id);

            model.type = Utils.StrToInt(ddlType.SelectedValue, 0);
            model.area = ddlArea.SelectedItem.Text;
            model.area_line = ddlAreaLine.SelectedItem.Text;
            model.title = txtTitle.Text.Trim();
            model.market_price = Utils.StrToDecimal(txtMarketPrice.Text, 0);
            model.sell_price = Utils.StrToDecimal(txtSellPrice.Text, 0);
            model.img_url = txtImgUrl.Text;

            model.is_recommend = Utils.StrToInt(rblIsRecommend.SelectedValue, 0);
            //内容摘要提取内容前255个字符
            if (string.IsNullOrEmpty(txtZhaiyao.Text.Trim()))
            {
                model.zhaiyao = Utils.DropHTML(txtContent.Value, 255);
            }
            else
            {
                model.zhaiyao = Utils.DropHTML(txtZhaiyao.Text, 255);
            }
            model.content = txtContent.Value;
            model.status = Utils.StrToInt(rblStatus.SelectedValue, 0);
            model.add_time = Utils.StrToDateTime(txtAddTime.Text.Trim());
            model.update_time = DateTime.Now;

            #region 保存相册====================
            //检查是否有自定义图片
            if (txtImgUrl.Text.Trim() == "")
            {
                model.img_url = hidFocusPhoto.Value;
            }
            if (model.albums != null)
            {
                model.albums.Clear();
            }
            string[] albumArr = Request.Form.GetValues("hid_photo_name");
            string[] remarkArr = Request.Form.GetValues("hid_photo_remark");
            if (albumArr != null)
            {
                List<Model.ht_common_albums> ls = new List<Model.ht_common_albums>();
                for (int i = 0; i < albumArr.Length; i++)
                {
                    string[] imgArr = albumArr[i].Split('|');
                    int img_id = Utils.StrToInt(imgArr[0], 0);
                    if (imgArr.Length == 3)
                    {
                        if (!string.IsNullOrEmpty(remarkArr[i]))
                        {
                            ls.Add(new Model.ht_common_albums { id = img_id, fk_id = _id, original_path = imgArr[1], thumb_path = imgArr[2], remark = remarkArr[i] });
                        }
                        else
                        {
                            ls.Add(new Model.ht_common_albums { id = img_id, fk_id = _id, original_path = imgArr[1], thumb_path = imgArr[2] });
                        }
                    }
                }
                model.albums = ls;
            }
            #endregion

            if (bll.Update(model))
            {
                AddAdminLog(HTEnums.ActionEnum.Edit.ToString(), "修改包车服务内容:" + model.title); //记录日志
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
                ChkAdminLevel("car_server", HTEnums.ActionEnum.Edit.ToString()); //检查权限
                if (!DoEdit(this.id))
                {
                    JscriptMsg("保存过程中发生错误啦！", string.Empty);
                    return;
                }
                JscriptMsg("修改信息成功！", "car_server_list.aspx");
            }
            else //添加
            {
                ChkAdminLevel("car_server", HTEnums.ActionEnum.Add.ToString()); //检查权限
                if (!DoAdd())
                {
                    JscriptMsg("保存过程中发生错误！", string.Empty);
                    return;
                }
                JscriptMsg("添加信息成功！", "car_server_list.aspx");
            }
        }
    }
}