using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HT.Web
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) 
            {
                BindAdsBn();
                BindHotel();
                BindFoodShop();
                BindDrjx();
                BindScenery();
                BindBCar();
                BindLygl();
                BindXqxz();
                BindTopic();
                BindVideo();
                BindNews();
            }
        }
        protected void BindAdsBn()
        {
            rptListAdsBn.DataSource = new BLL.ht_ads().GetList(10, "status=0 AND code='2f73cac6bdf24bb1b99b541e2d70194d'", "sort_id asc,id desc");
            rptListAdsBn.DataBind();

            rptListAds1.DataSource = new BLL.ht_ads().GetList(5, "status=0 AND code='fe8399fa5dee4cd980edcbb8347edf98'", "sort_id asc,id desc");
            rptListAds1.DataBind();
            rptListAds2.DataSource = new BLL.ht_ads().GetList(5, "status=0 AND code='d8f2d49948664bdf99bdf4cea99ac258'", "sort_id asc,id desc");
            rptListAds2.DataBind();
            rptListAds3.DataSource = new BLL.ht_ads().GetList(5, "status=0 AND code='a2baf872cba443cfb85afa81724eb719'", "sort_id asc,id desc");
            rptListAds3.DataBind();
        }

        protected void BindHotel()
        {
            rptListHotel.DataSource = new BLL.ht_hotel().GetList(8,"status=0","sort_id asc,id desc");
            rptListHotel.DataBind();
            rptListHotelTop.DataSource = new BLL.ht_hotel().GetList(3, "status=0", "NewID()");
            rptListHotelTop.DataBind();
        }
        protected void BindFoodShop()
        {
            rptListFoodShop.DataSource = new BLL.ht_shop().GetList(8, "status=0", "sort_id asc,id desc");
            rptListFoodShop.DataBind();
            rptListFoodShopTop.DataSource = new BLL.ht_shop().GetList(3, "status=0", "NewID()");
            rptListFoodShopTop.DataBind();
        }
        protected void BindDrjx()
        {
            rptListDrjx.DataSource = new BLL.article_drjx().GetList(5, "status=0", "id desc");
            rptListDrjx.DataBind();
        }
        protected void BindScenery()
        {
            rptListScenery.DataSource = new BLL.ht_scenery().GetList(7, "status=0", "sort_id asc,id desc");
            rptListScenery.DataBind();
            rptListSceneryTop.DataSource = new BLL.ht_scenery().GetList(3, "status=0", "NewID()");
            rptListSceneryTop.DataBind();
        }
        protected void BindBCar()
        {
            rptListBCar.DataSource = new BLL.ht_car_server().GetList(3, "status=0", "id desc");
            rptListBCar.DataBind();
        }
        protected void BindLygl()
        {
            rptLygl.DataSource = new BLL.ht_article().GetList(3, "status=0 AND channel_id=4", "id desc");
            rptLygl.DataBind();
        }

        protected void BindXqxz()
        {
            rptListXqxz.DataSource = new BLL.ht_article().GetList(2, "status=0 AND channel_id=1", "id desc");
            rptListXqxz.DataBind();
            rptListXqxzImg.DataSource = new BLL.ht_article().GetList(5, "status=0 AND channel_id=1", "id desc");
            rptListXqxzImg.DataBind();
        }
        protected void BindTopic()
        {
            rptListTopic.DataSource = new BLL.ht_bbs_topic().GetList(5, "status=0", "id desc");
            rptListTopic.DataBind();
        }
        protected void BindVideo()
        {
            rptListVideo.DataSource = new BLL.ht_article().GetList(4, "status=0 AND channel_id=3", "id desc");
            rptListVideo.DataBind();
        }
        protected void BindNews()
        {
            rptListNews1.DataSource = new BLL.ht_article().GetList(5, "status=0 AND channel_id=2", "id desc");
            rptListNews1.DataBind();
            rptListNews2.DataSource = new BLL.ht_article().GetList(5, "status=0 AND channel_id=2", "id asc");
            rptListNews2.DataBind();
        }
    }
}