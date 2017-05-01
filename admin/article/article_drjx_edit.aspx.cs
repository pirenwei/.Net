using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web.admin.article
{
    public partial class article_drjx_edit : Web.UI.ManagePage
    {
        protected string action = HTEnums.ActionEnum.Add.ToString(); //操作类型

        public int id = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            string _action = HTRequest.GetQueryString("action");
            if (!string.IsNullOrEmpty(_action) && _action == HTEnums.ActionEnum.Edit.ToString())
            {
                this.action = HTEnums.ActionEnum.Edit.ToString();//修改类型
                this.id = HTRequest.GetQueryInt("id");
                if (this.id == 0)
                {
                    JscriptMsg("传输参数不正确！", "back");
                    return;
                }
                if (!new BLL.article_drjx().Exists(this.id))
                {
                    JscriptMsg("信息不存在或已被删除！", "back");
                    return;
                }
            }
            if (!Page.IsPostBack)
            {
                ChkAdminLevel("article_drjx", HTEnums.ActionEnum.Add.ToString()); //检查权限
                if (action == HTEnums.ActionEnum.Edit.ToString()) //修改
                {
                    ShowInfo(this.id);
                }
            }
        }

        #region 赋值操作=================================
        private void ShowInfo(int _id)
        {
            BLL.article_drjx bll = new BLL.article_drjx();
            Model.article_drjx model = bll.GetModel(_id);
            txtTitle.Text = model.title;
            //不是相册图片就绑定
            string filename = model.img_url.Substring(model.img_url.LastIndexOf("/") + 1);
            if (!filename.StartsWith("thumb_"))
            {
                txtImgUrl.Text = model.img_url;
            }
            txtZhaiyao.Text = model.zhaiyao;
            txtClick.Text = model.click.ToString();
            rblStatus.SelectedValue = model.status.ToString();
            txtAddTime.Text = model.add_time.ToString("yyyy-MM-dd HH:mm:ss");
            txtTags.Text = model.tags;
            
            hidVideos.Value = model.video_ids;
            hidArticle.Value = model.article_ids;
            hidJxtt.Value = model.top_article_ids;
            //绑定达人视频
            if (!string.IsNullOrEmpty(model.video_ids))
            {
                rptVideo.DataSource = new BLL.ht_article().GetList("id IN (" + model.video_ids + ")");
                rptVideo.DataBind();
            }
            //绑定达人文章
            if (!string.IsNullOrEmpty(model.article_ids))
            {
                rptArticle.DataSource = new BLL.ht_article().GetList("id IN (" + model.article_ids + ")");
                rptArticle.DataBind();
            }
            //绑定精选头条
            if (!string.IsNullOrEmpty(model.top_article_ids))
            {
                rptJxtt.DataSource = new BLL.ht_article().GetList("id IN (" + model.top_article_ids + ")");
                rptJxtt.DataBind();
            }
        }
        #endregion


        #region 增加操作=================================
        private bool DoAdd()
        {
            bool result = false;
            Model.article_drjx model = new Model.article_drjx();
            BLL.article_drjx bll = new BLL.article_drjx();

            model.title = txtTitle.Text.Trim();
            model.img_url = txtImgUrl.Text;
            model.zhaiyao = Utils.DropHTML(txtZhaiyao.Text, 255);
            model.click = int.Parse(txtClick.Text.Trim());
            model.status = Utils.StrToInt(rblStatus.SelectedValue, 0);
            model.tags = txtTags.Text;

            model.video_ids = hidVideos.Value.Trim(',');
            model.article_ids = hidArticle.Value.Trim(',');
            model.top_article_ids = hidJxtt.Value.Trim(',');
            if (bll.Add(model) > 0)
            {
                AddAdminLog(HTEnums.ActionEnum.Add.ToString(), "添加达人精选内容:" + model.title); //记录日志
                result = true;
            }
            return result;
        }
        #endregion

        #region 修改操作=================================
        private bool DoEdit(int _id)
        {
            bool result = false;
            BLL.article_drjx bll = new BLL.article_drjx();
            Model.article_drjx model = bll.GetModel(_id);

            model.title = txtTitle.Text.Trim();
            model.img_url = txtImgUrl.Text;
            model.zhaiyao = Utils.DropHTML(txtZhaiyao.Text, 255);
            model.click = int.Parse(txtClick.Text.Trim());
            model.status = Utils.StrToInt(rblStatus.SelectedValue, 0);
            model.tags = txtTags.Text;

            model.video_ids = hidVideos.Value.Trim(',');
            model.article_ids = hidArticle.Value.Trim(',');
            model.top_article_ids = hidJxtt.Value.Trim(',');
            model.update_time = DateTime.Now;

            if (bll.Update(model))
            {
                AddAdminLog(HTEnums.ActionEnum.Edit.ToString(), "修改达人精选内容:" + model.title); //记录日志
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
                ChkAdminLevel("article_drjx", HTEnums.ActionEnum.Edit.ToString()); //检查权限
                if (!DoEdit(this.id))
                {
                    JscriptMsg("保存过程中发生错误！", "");
                    return;
                }
                JscriptMsg("修改成功！", "article_drjx_list.aspx");
            }
            else //添加
            {
                ChkAdminLevel("article_drjx", HTEnums.ActionEnum.Add.ToString()); //检查权限
                if (!DoAdd())
                {
                    JscriptMsg("保存过程中发生错误！", "");
                    return;
                }
                JscriptMsg("修改成功！", "article_drjx_list.aspx");
            }
        }
    }
}