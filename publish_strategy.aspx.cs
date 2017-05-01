using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.EF;
namespace HT.Web
{
    public partial class publish_strategy : System.Web.UI.Page
    {
        protected int channel_id = 4;//旅游攻略
        protected string title = "";
        protected string content = "";
        protected string area = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            int id = HT.Common.HTRequest.GetQueryInt("id");
            if (id > 0)
            {
              var list=  ht_articleRepository.Repository.FindBy(id);
              title = list.title;
              content = list.content;
              area = list.area;
            }
            if (!IsPostBack)
            {
                BindListJX();
                BindTreeArea();
            }
        }
        #region 绑定区域=================================
        private void BindTreeArea()
        {
            rptListArea.DataSource = new BLL.ht_dictionary().GetList("category_id=1");//区域
            rptListArea.DataBind();
        }
        #endregion
        protected void BindListJX()
        {
            rptListJX.DataSource = new BLL.ht_article().GetList(5, "status=0 AND channel_id=" + channel_id, "NewID()");
            rptListJX.DataBind();
        }
    }
}