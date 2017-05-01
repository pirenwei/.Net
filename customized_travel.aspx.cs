using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Web.UI;
namespace HT.Web
{
    public partial class customized_travel : BasePage
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
            rptHotScenery.DataSource = new BLL.ht_scenery().GetList(24, "status=0", "id desc");
            rptHotScenery.DataBind();
        }
    }
}