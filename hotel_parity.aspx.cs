using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HT.Web
{
    public partial class hotel_parity : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindList();
            }
        }
        protected void BindList()
        {
            rptHotHotel.DataSource = new BLL.ht_hotel().GetList(5, "status=0", "id desc");
            rptHotHotel.DataBind();
            rptZuti.DataSource = new BLL.ht_article().GetList(5, "status=0 AND channel_id=5", "id desc");
            rptZuti.DataBind();
        }
    }
}