using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web.admin.goods
{
    public partial class goods_edit : Web.UI.ManagePage
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
                if (!new BLL.ht_goods().Exists(this.id))
                {
                    JscriptMsg("信息不存在或已被删除！", "back");
                    return;
                }
            }
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("goods_list", HTEnums.ActionEnum.View.ToString()); //检查权限
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
            BLL.goods_category bll = new BLL.goods_category();
            DataTable dt = bll.GetList(0);

            this.ddlCategoryId.Items.Clear();
            this.ddlCategoryId.Items.Add(new ListItem("无父级类别...", "0"));
            foreach (DataRow dr in dt.Rows)
            {
                string Id = dr["id"].ToString();
                int ClassLayer = int.Parse(dr["class_layer"].ToString());
                string Title = dr["title"].ToString().Trim();

                if (ClassLayer == 1)
                {
                    this.ddlCategoryId.Items.Add(new ListItem(Title, Id));
                }
                else
                {
                    Title = "├ " + Title;
                    Title = Utils.StringOfChar(ClassLayer - 1, "　") + Title;
                    this.ddlCategoryId.Items.Add(new ListItem(Title, Id));
                }
            }
        }
        #endregion

        #region 赋值操作=================================
        private void ShowInfo(int _id)
        {
            BLL.ht_goods bll = new BLL.ht_goods();
            Model.ht_goods model = bll.GetModel(_id);

            ddlCategoryId.SelectedValue = model.category_id.ToString();
            txtTitle.Text = model.title;
            txtLinkUrl.Text = model.link_url;
            txtClick.Text = model.click.ToString();
            txtPlace.Text = model.place;
            txtMarketPrice.Text = model.market_price.ToString();
            txtSellPrice.Text = model.sell_price.ToString();
            //不是相册图片就绑定
            string filename = model.img_url.Substring(model.img_url.LastIndexOf("/") + 1);
            if (!filename.StartsWith("thumb_"))
            {
                txtImgUrl.Text = model.img_url;
            }
            rblIsHot.SelectedValue = model.is_hot.ToString();
            rblIsNew.SelectedValue = model.is_new.ToString();
            rblIsRecommend.SelectedValue = model.is_recommend.ToString();
            txtSeoTitle.Text = model.seo_title;
            txtSeoKeywords.Text = model.seo_keywords;
            txtSeoDescription.Text = model.seo_description;
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
            Model.ht_goods model = new Model.ht_goods();
            BLL.ht_goods bll = new BLL.ht_goods();
            model.category_id = Utils.StrToInt(ddlCategoryId.SelectedValue, 0);
            model.title = txtTitle.Text.Trim();
            model.link_url = txtLinkUrl.Text;
            model.click = Utils.StrToInt(txtClick.Text,0);
            model.place = txtPlace.Text;
            model.market_price = Utils.StrToDecimal(txtMarketPrice.Text,0);
            model.sell_price = Utils.StrToDecimal(txtSellPrice.Text,0);
            model.img_url = txtImgUrl.Text;
            model.is_hot = Utils.StrToInt(rblIsHot.SelectedValue, 0);
            model.is_new = Utils.StrToInt(rblIsNew.SelectedValue, 0);
            model.is_recommend = Utils.StrToInt(rblIsRecommend.SelectedValue, 0);

            model.seo_title = txtSeoTitle.Text.Trim();
            model.seo_keywords = txtSeoKeywords.Text.Trim();
            model.seo_description = txtSeoDescription.Text.Trim();
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
                AddAdminLog(HTEnums.ActionEnum.Add.ToString(), "添加商品内容:" + model.title); //记录日志
                result = true;
            }
            return result;
        }
        #endregion

        #region 修改操作=================================
        private bool DoEdit(int _id)
        {
            bool result = false;
            BLL.ht_goods bll = new BLL.ht_goods();
            Model.ht_goods model = bll.GetModel(_id);

            model.category_id = Utils.StrToInt(ddlCategoryId.SelectedValue, 0);
            model.title = txtTitle.Text.Trim();
            model.link_url = txtLinkUrl.Text;
            model.click = Utils.StrToInt(txtClick.Text, 0);
            model.place = txtPlace.Text;
            model.market_price = Utils.StrToDecimal(txtMarketPrice.Text, 0);
            model.sell_price = Utils.StrToDecimal(txtSellPrice.Text, 0);
            model.img_url = txtImgUrl.Text;

            model.is_hot = Utils.StrToInt(rblIsHot.SelectedValue, 0);
            model.is_new = Utils.StrToInt(rblIsNew.SelectedValue, 0);
            model.is_recommend = Utils.StrToInt(rblIsRecommend.SelectedValue, 0);

            model.seo_title = txtSeoTitle.Text.Trim();
            model.seo_keywords = txtSeoKeywords.Text.Trim();
            model.seo_description = txtSeoDescription.Text.Trim();
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
                AddAdminLog(HTEnums.ActionEnum.Edit.ToString(), "修改商品内容:" + model.title); //记录日志
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
                ChkAdminLevel("goods_list", HTEnums.ActionEnum.Edit.ToString()); //检查权限
                if (!DoEdit(this.id))
                {
                    JscriptMsg("保存过程中发生错误啦！", string.Empty);
                    return;
                }
                JscriptMsg("修改信息成功！", "goods_list.aspx");
            }
            else //添加
            {
                ChkAdminLevel("goods_list", HTEnums.ActionEnum.Add.ToString()); //检查权限
                if (!DoAdd())
                {
                    JscriptMsg("保存过程中发生错误！", string.Empty);
                    return;
                }
                JscriptMsg("添加信息成功！", "goods_list.aspx");
            }
        }

    }
}