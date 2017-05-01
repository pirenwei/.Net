using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HT.Web
{
    public partial class publish_tourism : System.Web.UI.Page
    {
        protected int channel_id = 5;//主题旅游
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindListXG();
            }
        }
        protected void BindListXG()
        {
            rptListXG.DataSource = new BLL.ht_article().GetList(5, "status=0 AND channel_id=" + channel_id, "NewID()");
            rptListXG.DataBind();
        }
    }
}