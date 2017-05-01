using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;

namespace HT.Web
{
    public partial class foodshop_list : System.Web.UI.Page
    {
        protected string sort;
        public string area;
        protected string keywords = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            this.sort = HTRequest.GetQueryString("sort");
            this.area = HTRequest.GetQueryString("area");
            this.keywords = HTRequest.GetQueryString("keywords");

            BindTreeArea();
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