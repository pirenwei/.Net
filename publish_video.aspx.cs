using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HT.Web
{
    public partial class publish_video : System.Web.UI.Page
    {
        protected int channel_id = 3;//影音专区
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindListXG();
                BindTreeArea();
            }
        }
        protected void BindListXG()
        {
            rptListXG.DataSource = new BLL.ht_article().GetList(5, "status=0 AND channel_id=" + channel_id, "NewID()");
            rptListXG.DataBind();
        }
        #region 绑定区域=================================
        private void BindTreeArea()
        {
            rptListArea.DataSource = new BLL.ht_dictionary().GetList("category_id=1");//区域
            rptListArea.DataBind();
        }
        #endregion
    }
}