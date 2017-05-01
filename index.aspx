<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="HT.Web.index" %>

<%@ Register Src="~/ucl/footer.ascx" TagPrefix="uc1" TagName="footer" %>
<%@ Register Src="~/ucl/header.ascx" TagPrefix="uc1" TagName="header" %>
<%@ Register Src="~/ucl/links.ascx" TagPrefix="uc1" TagName="links" %>

<%@ Import Namespace="HT.Common" %>
<%@ Import Namespace="HT.Web.UI" %>

<!DOCTYPE html>
<html lang="zh">
<head>
    <title><%=HT.Web.UI.WebUI.config.webtitle %></title>
    <meta name="keywords" content="<%=HT.Web.UI.WebUI.config.webkeyword %>">
  <meta name="description" content="<%=HT.Web.UI.WebUI.config.webdescription %>">
    <uc1:links runat="server" ID="links" />
</head>
<body>
    <uc1:header runat="server" ID="header" />

    <div class="slidesBox H330" style="z-index:0">
        <ul class="slides">
            <asp:Repeater runat="server" ID="rptListAdsBn">
                <ItemTemplate>
                    <li style="background: url('<%#Eval("img_url")%>') no-repeat center top">
                        <a href="<%#Eval("link_url") %>"></a></li>
                </ItemTemplate>
            </asp:Repeater>
        </ul> 
    </div>
    <div class="index_2 container mian">
        <h2>定制旅行<i></i></h2>
        <h3>输入您想去的台湾景点：</h3>
        <form action="customized_travel_map.aspx">
            <input class="txt" type="text" id="customized_travel_keyword">
            <input class="sub" type="button"  onclick="customized_travel_map()">
        </form>
        <h4>游玩天数：</h4>
        <div class="train_day">
            <a class="reduce" onclick="countNum(-1)"><i></i></a>
            <span class="inS">
                <input class="inp" type="text" id="item_num" name="num" value="1" onblur="checkinputxgnum();" onfocus="in()value=='1' {value=''}">
            </span>
            <a class="add" onclick="countNum(1)"><i></i></a>
        </div>
        <input class="btn" type="submit" value="确认" onclick="customized_travel_map()">
    </div>
    <script>
        function customized_travel_map() {
            var customized_travel_keyword = $('#customized_travel_keyword').val();
            var item_num = $('#item_num').val();
            location.href = 'customized_travel_map.aspx?keyword=' + customized_travel_keyword + '&travel_day_num=' + item_num;
        }
    </script>
    <div class="container mian">
        <div class="index-slide left">
            <div class="slidesBox H210">
                <ul class="slides">
                    <asp:Repeater runat="server" ID="rptListAds1">
                        <ItemTemplate>
                            <li style="background: url('<%#Eval("img_url")%>') no-repeat center top">
                                <a href="<%#Eval("link_url") %>"></a></li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>
        </div>
        <div class="index-slide center">
            <div class="slidesBox H210">
                <ul class="slides">
                    <asp:Repeater runat="server" ID="rptListAds2">
                        <ItemTemplate>
                            <li style="background: url('<%#Eval("img_url")%>') no-repeat center top">
                                <a href="<%#Eval("link_url") %>"></a></li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>
        </div>
        <div class="index-slide right">
            <div class="slidesBox H210">
                <ul class="slides">
                    <asp:Repeater runat="server" ID="rptListAds3">
                        <ItemTemplate>
                            <li style="background: url('<%#Eval("img_url")%>') no-repeat center top">
                                <a href="<%#Eval("link_url") %>"></a></li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>
        </div>
    </div>
     <div class="H20"></div>
    <div class="container mian">
        <div class="main-left tab-box">
            <div class="index-title">
                <span class="span-title"><em class="color1">景点推荐</em><i>ATTRACTIONS</i></span>
                <!-- 景点搜索 -->
                <div class="index-title-more"><a href="scenery_spot.aspx">查看更多</a><i></i></div>
            </div>
            <div class="index-list">
                <div class="attractions-list content">
                    <div class="attractions-box">
                        <ul>
                            <asp:Repeater runat="server" ID="rptListScenery">
                                <ItemTemplate>
                                    <li <%#rptListScenery.Items.Count==0?"class=\"first_li\"":"" %>>
                                        <a href="scenery_spot_detail.aspx?cid=<%#Eval("cid") %>">
                                            <img src="<%#Eval("img_url") %>" alt="">
                                            <div class="attractions-text">
                                                <%#Eval("title") %>
                                            </div>
                                        </a>
                                    </li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                     </div>
                </div>
            </div>
        </div>
        <div class="main-right">
            <div class="index-title">
                <span class="span-title"><a href="#"><em class="color2">热门排行</em></a></span>
            </div>
            <div class="index-ranking-two">
                <div class="index-ranking-two-box">
                    <ul>
                        <asp:Repeater runat="server" ID="rptListSceneryTop">
                            <ItemTemplate>
                                <li>
                                    <a href="scenery_spot_detail.aspx?cid=<%#Eval("cid") %>" title="<%#Eval("title") %>">
                                        <label>
                                            <img src="<%#Eval("img_url") %>" alt=""></label>
                                    </a>
                                    <p class="title">
                                        <%#Eval("title") %>
                                        <span class="zs">
                                            <span class="grade"><%#WebUI.GetStarLevel(Eval("star_level"))%></span>
                                        </span>
                                    </p>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
                <div class="btn-control">
                      <span class=""></span><span class=""></span><span class="current"></span>
                </div>
            </div>
        </div>
    </div>
    <div class="H20"></div>
    <div class="container mian">
        <div class="main-left tab-box">
            <div class="index-title">
                <span class="span-title"><em class="color1">住宿比价</em><i>ACCOMMODACTION</i></span>
                <div class="index-title-more"><a href="hotel_parity_list.aspx">查看更多</a><i></i></div>
            </div>
            <div class="index-list PD0">
                <div class="index-list-item content">
                    <ul>
                        <asp:Repeater runat="server" ID="rptListHotel">
                            <ItemTemplate>
                                <li>
                                    <a href="hotel_parity_detail.aspx?cid=<%#Eval("cid")%>">
                                        <img src="<%#Eval("img_url") %>" alt="">
                                        <p class="title"><%#Utils.DropHTML(Eval("title").ToString(),20) %></p>
                                        <p class="pf">星级<span class="span-grade grade"><%#WebUI.GetStarLevel(Eval("star_level"))%></span></p>
                                        <p class="dp"><%#WebUI.GetCommentCount(Eval("id"),(int)HTEnums.DataFKType.Hotel)%>人点评<em class="price">¥<%#WebUI.GetHotelRmtpMin(Utils.ObjToInt(Eval("id")))%></em></p>
                                    </a>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
        </div>
        <div class="main-right">
            <div class="index-title">
                <span class="span-title"><em class="color2">酒店搜索</em></span>
            </div>
            <div class="index-search">
                <div class="index-search-slides">
                    <div class="search-slides slides-box">
                        <ul>
                            <asp:Repeater runat="server" ID="rptListHotelTop">
                                <ItemTemplate>
                                    <li _text="<%#Eval("title") %>">
                                        <a href="hotel_parity_detail.aspx?cid=<%#Eval("cid")%>" title="<%#Eval("title") %>">
                                            <img src="<%#Eval("img_url") %>" alt=""></a></li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                    </div>
                    <div class="slides-text"><%#Eval("title") %></div>
                </div>
                <form action="hotel_parity_list.aspx" method="get">
                <div class="index-search-form">
                    <p>目的地：</p>
                    <input type="text" name="area" class="search-input">
                    <p>入住日期：</p>
                    <input type="text" name1="txtCheckIn" onclick="laydate()" class="search-input">
                    <p>离店日期</p>
                    <input type="text" name1="txtCheckOut" onclick="laydate()" class="search-input">
                    <button type="submit" class="icon-search-submit-btn">查询</button>
                </div>
                </form>
            </div>
        </div>
    </div>
    <div class="H20"></div>
    <div class="container mian">
        <div class="main-left tab-box">
            <div class="index-title">
                <span class="span-title"><em class="color1">吃在台湾</em><i>FOOD</i></span>
                <div class="index-title-more"><a href="foodshop_list.aspx">查看更多</a><i></i></div>
            </div>
            <div class="index-list PD0">
                <div class="index-list-item content">
                    <ul>
                        <asp:Repeater runat="server" ID="rptListFoodShop">
                            <ItemTemplate>
                                <li>
                                    <a href="foodshop_detail.aspx?cid=<%#Eval("cid")%>">
                                        <img src="<%#Eval("img_url") %>" alt="">
                                        <p class="title"><%#Utils.DropHTML(Eval("title").ToString(),20) %></p>
                                        <p class="pf">星级<span class="span-grade grade"><%#WebUI.GetStarLevel(Eval("star_level"))%></span></p>
                                        <p class="dp"><%#WebUI.GetCommentCount(Eval("id"),(int)HTEnums.DataFKType.Shop)%>人点评
                                            <em class="youhui">领取优惠<i class="youhui-icon"></i></em>
                                        </p>
                                    </a>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
        </div>
        <div class="main-right">
            <div class="index-title">
                <span class="span-title"><a href="#"><em class="color2">热门排行</em></a></span>
            </div>
            <div class="index-ranking">
                <ul>
                    <asp:Repeater runat="server" ID="rptListFoodShopTop">
                        <ItemTemplate>
                            <li>
                                <a href="foodshop_detail.aspx?cid=<%#Eval("cid")%>" title="<%#Eval("title") %>">
                                    <label>
                                        <img src="<%#Eval("img_url") %>" alt=""></label>
                                </a>
                                <p class="title"><%#Eval("title") %></p>
                                <p class="dp"><%#WebUI.GetCommentCount(Eval("id"),(int)HTEnums.DataFKType.Shop)%>人点评</p>
                            </li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>
        </div>
    </div>
    <div class="index-people">
        <div class="container  mian">
            <div class="index-title">
                <span class="span-title"><em class="color1">达人精选</em><i>SELECTION</i></span>
                <div class="index-title-more"><a href="drjx.aspx">查看更多</a><i></i></div>
            </div>
            <div class="index-people-item">
                <asp:Repeater runat="server" ID="rptListDrjx">
                    <ItemTemplate>
                        <div class="box index<%#rptListDrjx.Items.Count+1 %>">
                            <div class="item">
                                <img src="<%#Eval("img_url") %>" alt="" width="100%" style="<%#rptListDrjx.Items.Count>0?"max-height:200px": ""%>">
                                <div class="Shadow"></div>
                                <div class="item-text">
                                    <span class="title"><%#Eval("title") %></span>
                                    <p class="introduct"><%#Utils.DropHTML(Eval("zhaiyao").ToString(),100)%></p>
                                    <p class="btn"><a href="drjx_detail.aspx?cid=<%#Eval("cid") %>">查看</a></p>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
    
    <div class="H20"></div>
    <div class="container mian">
        <div class="main2-left">
            <div class="index-title">
                <span class="span-title"><a href="travel_strategy_list.aspx"><em class="color2">旅遊攻略</em></a></span>
                <div class="index-title-more"><a href="travel_strategy_list.aspx">查看更多</a><i></i></div>
            </div>
            <div class="index-bg">
                <div class="index-travel-strategy">
                    <ul>
                        <asp:Repeater runat="server" ID="rptLygl">
                            <ItemTemplate>
                                <li>
                                    <a href="travel_strategy_detail.aspx?cid=<%#Eval("cid") %>">
                                        <label>
                                            <img src="<%#Eval("img_url") %>" alt=""></label>
                                        <p class="title"><%#Eval("title") %></p>
                                        <p class="introduct"><%#Utils.DropHTML(Eval("zhaiyao").ToString(),50)%></p>
                                        <p class="browse"><i></i>浏览数：<%#Eval("click") %>人</p>
                                    </a>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
        </div>
        <div class="main2-center">
            <div class="index-title">
                <span class="span-title"><em class="color2">两岸大不同</em></span>
                <div class="index-title-more"><a href="xqxz.aspx">查看更多</a><i></i></div>
            </div>
            <div class="index-bg">
                <div class="index-taiwan">
                    <div class="index-taiwan-slide Scroll-slide">
                        <div class="slide-img"  data-leng="1">
                            <ul>
                                <asp:Repeater runat="server" ID="rptListXqxzImg">
                                    <ItemTemplate>
                                        <li>
                                            <img src="<%#Eval("img_url") %>" alt="">
                                            <p class="title"><a href="xqxz_detail.aspx?cid=<%#Eval("cid") %>">
                                                <%#Eval("title") %><i></i></a></p>
                                        </li>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </ul>
                        </div>
                        <span class="btn left-btn"></span>
                        <span class="btn right-btn"></span>
                    </div>
                    <div class="index-taiwan-list">
                        <ul>
                            <asp:Repeater runat="server" ID="rptListXqxz">
                                <ItemTemplate>
                                <li>
                                    <p class="title"><a href="xqxz_detail.aspx?cid=<%#Eval("cid") %>">
                                        <%#Eval("title") %></a></p>
                                    <p class="introduct"><%#Eval("zhaiyao") %></p>
                                </li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="main2-right">
            <div class="index-title">
                <span class="span-title"><a href="car_charter_service.aspx"><em class="color2">包车服务</em></a></span>
                <div class="index-title-more"><a href="car_charter_service.aspx">查看更多</a><i></i></div>
            </div>
            <div class="index-bg">
                <div class="index-charter-service">
                    <ul>
                        <asp:Repeater runat="server" ID="rptListBCar">
                            <ItemTemplate>
                                <li>
                                    <a href="car_charter_service_detail.aspx?cid=<%#Eval("cid") %>" title="<%#Eval("title") %>">
                                        <label>
                                            <img src="<%#Eval("img_url") %>" alt=""></label>
                                        <p class="title"><%#Eval("title") %></p>
                                        <p class="title2"><%#Utils.DropHTML(Eval("zhaiyao").ToString(),20)%></p>
                                        <p class="price">¥<%#Eval("sell_price") %></p>
                                        <p class="btn">
                                            <a href="car_charter_service_detail.aspx?cid=<%#Eval("cid") %>" class="icon-buy-btn">预订</a>
                                            <a href="###" onclick="user_collect_add(this,'<%#Eval("id") %>','<%#(int)HTEnums.DataFKType.Car%>')" class="icon-collection-btn">收藏</a>
                                        </p>
                                    </a>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="H20"></div>
    <div class="container mian">
        <div class="main2-left">
            <div class="index-title">
                <span class="span-title"><em class="color1">讨论区</em></span>
                <div class="index-title-more"><a href="discussion_area.aspx">查看更多</a><i></i></div>
            </div>
            <div class="index-bg H315">
                <div class="slidesBox H201">
                    <ul class="slides">
                        <li style="background: url('images/e/pic041.png') no-repeat center top"><a href="discussion_area.aspx"></a></li>
                    </ul>
                </div>
                <div class="index-discussion-area-list">
                    <ul>
                        <asp:Repeater runat="server" ID="rptListTopic">
                            <ItemTemplate>
                                <li><a href="discussion_area_detail.aspx?cid=<%#Eval("cid") %>"><em><%#string.Format("{0:yyyy-MM-dd}",Eval("add_time")) %></em>
                                    <%#Utils.DropHTML(Eval("title").ToString(),30)%></a></li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
        </div>
        <div class="main2-center">
            <div class="index-title">
                <span class="span-title"><em class="color1">影音专区</em></span>
                <div class="index-title-more"><a href="video.aspx">查看更多</a><i></i></div>
            </div>
            <div class="index-bg H315">
                <div class="index-video-area">
                     <ul>
                         <asp:Repeater runat="server" ID="rptListVideo">
                             <ItemTemplate>
                                 <li><a href="video_detail.aspx?cid=<%#Eval("cid") %>">
                                     <img width="100%" src="<%#Eval("img_url") %>" alt=""></a></li>
                             </ItemTemplate>
                         </asp:Repeater>
                     </ul>
                </div>
            </div>
        </div>
        <div class="main2-right">
            <div class="index-title">
                <span class="span-title"><em class="color1">最新消息</em></span>
                <div class="index-title-more"><a href="news.aspx">查看更多</a><i></i></div>
            </div>
            <div class="index-bg tab-box">
                <div class="index-news-tab title">
                    <ul>
                        <li class="active"><span>观光局资讯</span></li>
                        <li><span>活动资讯</span></li>
                    </ul>
                </div>
                <div class="index-news-list content">
                    <div class="index-news-img">
                        <a href="news.aspx"><img src="images/e/pic045.png" alt=""></a></div>
                    <div class="index-discussion-area-list">
                        <ul>
                            <asp:Repeater runat="server" ID="rptListNews1">
                                <ItemTemplate>
                                    <li><a href="news_detail.aspx?cid=<%#Eval("cid") %>">
                                        <em><%#string.Format("{0:yyyy-MM-dd}",Eval("add_time"))%></em>
                                        <%#Utils.DropHTML(Eval("title").ToString(),25)%></a></li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                    </div>
                </div>
                <div class="index-news-list content hide">
                    <div class="index-news-img">
                        <a href="news_activity.aspx"><img src="images/e/pic045.png" alt=""></a></div>
                    <div class="index-discussion-area-list">
                        <ul>
                            <asp:Repeater runat="server" ID="rptListNews2">
                                <ItemTemplate>
                                    <li><a href="news_detail.aspx?cid=<%#Eval("cid") %>">
                                        <em><%#string.Format("{0:yyyy-MM-dd}",Eval("add_time"))%></em>
                                        <%#Utils.DropHTML(Eval("title").ToString(),25)%></a></li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="H20"></div>
    <uc1:footer runat="server" ID="footer" />
</body>
</html>

