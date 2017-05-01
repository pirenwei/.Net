<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="foodshop_detail.aspx.cs" Inherits="HT.Web.foodshop_detail" %>

<%@ Register Src="~/ucl/footer.ascx" TagPrefix="uc1" TagName="footer" %>
<%@ Register Src="~/ucl/header.ascx" TagPrefix="uc1" TagName="header" %>
<%@ Register Src="~/ucl/links.ascx" TagPrefix="uc1" TagName="links" %>

<%@ Import Namespace="HT.Common" %>
<%@ Import Namespace="HT.Web.UI" %>

<!DOCTYPE html>
<html lang="zh">
<head>
    <title><%=model.title %></title>
    <meta name="keywords" content="<%=model.seo_keywords+""==""? HT.Web.UI.WebUI.config.webkeyword : model.seo_keywords %>">
    <meta name="description" content="<%=model.seo_description+""==""? HT.Web.UI.WebUI.config.webdescription : model.seo_description %>">
    <uc1:links runat="server" ID="links" />
    <script src="http://ditu.google.cn/maps/api/js?sensor=false&libraries=places&key=AIzaSyA_fSbr4yGpPdxIweEDTIwcu9Epn6jCz2A&callback=initialize" async defer></script>
    <script>
        var lat = '<%=model.lat %>';
        var lng = '<%=model.lng %>';
        function initialize() {
            var mapOptions = {
                zoom: 12,
                mapTypeId: google.maps.MapTypeId.ROADMAP,
                center: new google.maps.LatLng(lat, lng),
                scaleControl: true //比例控件 
            };

            var map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);
            var marker = new google.maps.Marker({
                position: new google.maps.LatLng(parseFloat(lat), parseFloat(lng)),
                icon: '/images/map/red-1.png'
            });
            marker.setMap(map);
        }
    </script>
</head>
<body>
    <uc1:header runat="server" ID="header" />
    <div class="container">
        <div class="page-loct"><a href="index.aspx">首页</a> > <a href="foodshop_list.aspx">吃在台湾</a> > <span><%=model.title %></span> </div>
    </div>
    <div class="container main">
        <div class="page-left MR20">
            <div class="page-bg PD20">
                <div class="scenic-spots-slide-box">
                    <div class="scenic-spots-slide W340 Scroll-slide">
                        <span class="btn left-btn"><i></i></span>
                        <span class="btn right-btn"><i></i></span>
                        <div class="slide-img W340" data-leng="1">
                            <ul>
                                <li>
                                    <img src="<%=model.img_url %>" alt=""></li>
                                <asp:Repeater runat="server" ID="rptImg">
                                    <ItemTemplate>
                                        <li>
                                            <img src="<%#Eval("original_path") %>" alt=""></li>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </ul>
                        </div>
                    </div>
                    <div class="scenic-spots-slide-introduct H29">
                        <p class="title"><%=model.title %></p>
                        <div class="H15"></div>
                        <p class="xj"><span>星级：</span><span class="span-grade grade"><%=WebUI.GetStarLevel(model.star_level)%></span></p>
                        <p class="address"><span>地址：</span><%=model.address %></p>
                        <p class="address"><span>电话：</span><%=model.telphone %></p>
                        <p class="pf"><span>点评：</span><%=WebUI.GetCommentCount(model.id,(int)HTEnums.DataFKType.Shop)%>人点评</p>
                        <p class="price"><span><b class="color2">¥<%=model.avg_price %></b></span> （人均价格）</p>
                        <p class="btn">
                            <%if (counponCount > 0)
                              { %>
                            <span class="icon-Receive-btn" ht-click="show" data-target="#Coupon-box">领取优惠券</span>
                            <%} %>
                        </p>
                    </div>
                </div>
                <div class="tab-box">
                    <div class="page-tab-title title">
                        <ul>
                            <li class="active"><span>店铺详情</span></li>
                            <li><span>用户点评</span></li>
                        </ul>
                    </div>
                    <div class="Accommodation-Shop-content content">
                        <div class="top">
                            <p>
                                <%=model.content %>
                            </p>
                        </div>
                    </div>
                    <div class="Accommodation-Shop-content content hide">
                        <div class="news2-detail-comment">
                            <div class="news2-detail-comment-title">评论（<%=WebUI.GetCommentCount(model.id,(int)HTEnums.DataFKType.Shop)%>）</div>
                            <form id="formCmt" url="/tools/submit_ajax.ashx?action=user_comment_add">
                                <div class="news2-detail-comment-form">
                                    <textarea name="txtContent" cols="30" rows="10" placeholder="填写评论内容..." datatype="*1-5000" nullmsg="请输入评论内容" sucmsg=" "></textarea>
                                    <span id="msgtipCmt" class="msgtip"></span>
                                    <input type="hidden" name="fk_id" value="<%=model.id %>" />
                                    <input type="hidden" name="fk_type" value="<%=(int)HTEnums.DataFKType.Shop %>" />
                                    <input type="hidden" name="parent_id" value="0" />
                                    <button type="submit" id="btnSubmitCmt" class="btn">发表评论</button>
                                </div>
                            </form>
                            <div class="comment-bot-list" id="comment00">
                                <div id="pagination" class="flickr paging"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="H20"></div>
            </div>
        </div>
        <div class="page-right">
            <div class="page-bg">
                <div class="scenic-spots-title">
                    <span>查看地图</span>
                </div>
                <div class="scenic-spots-map">
                    <div id="map_canvas" style="width: 260px; height: 210px;"></div>
                </div>
                <div class="H20"></div>
            </div>
            <div class="page-bg">
                <script type="text/javascript">
                    agoda_ad_client = "1729777_47508";
                    agoda_ad_width = 300;
                    agoda_ad_height = 600;
                </script>
                <script type="text/javascript" src="//banner.agoda.com/js/show_ads.js"></script>
                <div class="H20"></div>
            </div>
            <div class="H20"></div>
            <div class="page-bg">
                <div class="scenic-spots-title">
                    <span>周边酒店推荐</span>
                </div>
                <div class="scenic-spots-recommend content">
                    <ul>
                        <asp:Repeater runat="server" ID="rptTJJD">
                            <ItemTemplate>
                                <li>
                                    <a href="hotel_parity_detail.aspx?cid=<%#Eval("cid") %>">
                                        <img src="<%#Eval("img_url") %>" alt="">
                                        <p class="title"><%#Eval("title") %></p>
                                        <p class="dj"><span class="score"><%#WebUI.GetStarLevel(Eval("star_level"))%></span></p>
                                        <p class="dp"><%#WebUI.GetCommentCount(Eval("id"),(int)HTEnums.DataFKType.Hotel)%>人点评</p>
                                        <p>距离:<%#Eval("Distance2") %></p>
                                    </a>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
                <div class="H20"></div>
            </div>
            <div class="H20"></div>
            <div class="page-bg">
                <div class="scenic-spots-title">
                    <span>浏览记录</span>
                </div>
                <div class="scenic-spots-recommend content">
                    <ul>
                        <asp:Repeater runat="server" ID="rptJL">
                            <ItemTemplate>
                                <li>
                                    <a href="foodshop_detail.aspx?cid=<%#Eval("cid") %>">
                                        <img src="<%#Eval("img_url") %>" alt="">
                                        <p class="title"><%#Eval("title") %></p>
                                        <p class="dj"><span class="score"><%#WebUI.GetStarLevel(Eval("star_level"))%></span></p>
                                        <p class="dp"><%#WebUI.GetCommentCount(Eval("id"),(int)HTEnums.DataFKType.Shop)%>人点评</p>
                                    </a>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
                <div class="H20"></div>
            </div>
            <div class="H20"></div>

        </div>
    </div>
    <div class="H20"></div>
    <uc1:footer runat="server" ID="footer" />
    <script type="text/javascript">
        $(function () {
            AjaxInitForm('formCmt', 'btnSubmitCmt', 'msgtipCmt');
            AjaxPageList('#comment00', '#pagination', 10, '<%=WebUI.GetCommentCount(model.id,(int)HTEnums.DataFKType.Shop)%>', '/tools/submit_ajax.ashx?action=user_comment_list', '<%=model.id%>', '<%=(int)HTEnums.DataFKType.Shop%>');
    })
    </script>

    <div class="PopBox hide" id="Coupon-box">
        <div class="Pop_upBox_bg"></div>
        <div class="Pop_upBox H312">
            <div class="pop_content">
                <div class="PopBox_title">领取优惠券</div>
                <div class="content PD20">
                    <div class="Coupon-title">该商家共有 <em><%=totalCount %></em> 种优惠券可领取</div>
                    <div class="Coupon-table">
                        <asp:Repeater runat="server" ID="rptCounpon">
                            <HeaderTemplate>
                                <table>
                                    <tr>
                                        <th>优惠</th>
                                        <th>说明</th>
                                        <th>有效时间</th>
                                        <th>操作</th>
                                    </tr>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr class="tr">
                                    <td>
                                        <span class="yhj"><%#Eval("title") %></span>
                                    </td>
                                    <td><%#Eval("remark") %></td>
                                    <td><%#string.Format("{0:yyyy-MM-dd}",Eval("begin_date"))%> ~ <%#string.Format("{0:yyyy-MM-dd}",Eval("end_date"))%></td>
                                    <td><a class="Receive" href="coupon_success.aspx?id=<%#Eval("id") %>">领取</a></td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </div>
                <div class="close" ht-click="hide" data-target="#Coupon-box">
                    <img src="images/e/close.png" alt="" />
                </div>
            </div>
        </div>
    </div>

</body>
</html>


