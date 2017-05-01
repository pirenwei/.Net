using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HT.Common;
using HT.Web.UI;
using HT.EF;
using HT.Model;
using System.Collections;
namespace HT.Web
{
    public partial class customized_travel_map : UI.BasePage
    {
        protected string keyword;
        protected string travel_title;
        protected string begin_date;
        protected string end_date;
        protected string start_airport = "";
        protected string end_airport = "";
        protected int travel_day_num = 0;
        protected int Travel_id = 0;
        protected Model.siteconfig siteConfig;

       
        protected void Page_Load(object sender, EventArgs e)
        {
  
            if (!IsUserLogin())
            {
                Response.Write("<script>location.href='/login.aspx'</script>");
                Response.End();
            }
            siteConfig = new BLL.siteconfig().loadConfig();

            keyword = HTRequest.GetQueryString("keyword");
            Travel_id = HTRequest.GetQueryInt("Travel_id");
            travel_day_num = HTRequest.GetQueryInt("travel_day_num");
            begin_date = DateTime.Now.Date.ToString("yyyy-MM-dd");
            end_date = DateTime.Now.Date.AddDays(3).ToString("yyyy-MM-dd");
            travel_title = "台湾3日游";
            travel_day_num = 3;
            //新增旅行
            if (keyword != "")
            {
                try
                {
                    if (travel_day_num == 0)
                    {
                        TimeSpan ts = Convert.ToDateTime(end_date) - Convert.ToDateTime(begin_date);
                        travel_day_num = ts.Days+1;
                    }
                    travel_title = keyword + travel_day_num.ToString() + "日游";
                }
                catch (Exception err)
                {
                    Response.Write("<script>alert('请选择正确时间');location.href='/customized_travel.aspx'</script>");
                    Response.End();
                }
            }
            //载入行程
            if (Travel_id != 0)
            {
                DateTime a;
                var list = ht_travelRepository.Repository.FindBy(Travel_id);
                begin_date =((DateTime)list.begin_date).ToString("yyyy-MM-dd");
                end_date = ((DateTime)list.end_date).ToString("yyyy-MM-dd");
                travel_title =list.title;
                start_airport = list.start_airport;
                end_airport = list.end_airport;

            }
           
           BindList();
       
        }

        protected void BindList()
        {
            int userId = GetUserInfo().id;
            myTravelList.DataSource = ht_travelRepository.Repository.FindList(x => x.user_id == userId, y => y.id, false).ToList();
            myTravelList.DataBind();
        }


    }
}