<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="scenery_spot_detail.aspx.cs" Inherits="HT.Web.scenery_spot_detail" %>

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
        <div class="page-loct"><a href="/index.aspx">首页</a> > <a href="scenery_spot.aspx">景点推荐</a> > <span><%=model.title %></span> </div>
    </div>
    <div class="container main">
        <div class="page-left MR20">
            <div class="page-bg PD20">
                <div class="scenic-spots-slide-box">
                    <div class="scenic-spots-slide Scroll-slide">
                        <span class="btn left-btn"><i></i></span>
                        <span class="btn right-btn"><i></i></span>
                        <div class="slide-img" data-leng="1">
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
                    <div class="scenic-spots-slide-introduct">
                        <p class="title"><%=model.title %></p>
                        <div class="H15"></div>
                        <p class="xj"><span>星级：</span><span class="span-grade grade"><%=WebUI.GetStarLevel(model.star_level)%></span></p>
                        <p class="address"><span>地址：</span><%=model.address%></p>
                        <p class="introduct"><span>景点介绍：</span><%=model.zhaiyao %></p>
                        <p>
                            <div class="Share-span">
                                <span class="Zambia MR8" onclick="zan_add(this,'<%=model.id %>','<%=(int)HTEnums.DataFKType.Scenery %>')"><i></i>赞（<%=WebUI.GetZanCount(model.id,(int)HTEnums.DataFKType.Scenery)%>）</span>
                                <a href="scenery_spot_detail.aspx?cid=<%=model.cid %>#detail-content5">
                                    <span class="comment MR8"><i></i>评论（<%=WebUI.GetCommentCount(model.id,(int)HTEnums.DataFKType.Scenery)%>）</span></a>
                                <span class="collection MR8" onclick="user_collect_add(this,'<%=model.id %>','<%=(int)HTEnums.DataFKType.Scenery %>')"><i></i>收藏（<%=WebUI.GetCollectCount(model.id,(int)HTEnums.DataFKType.Scenery)%>）</span>
                                <span class="Share MR8"><i></i>分享<div class="bshare-custom pos">
                                    <div class="bsPromo bsPromo2"></div>
                                    <a title="更多平台" class="bshare-more bshare-more-icon more-style-addthis"></a></div>
                                </span>
                                <script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/buttonLite.js#style=-1&amp;uuid=&amp;pophcol=2&amp;lang=zh"></script>
                                <script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/bshareC0.js"></script>
                            </div>
                        </p>
                    </div>
                </div>
                <div class="H20"></div>
                <div class="tab-box">
                    <div class="page-tab-title title location-title W840">
                        <ul>
                            <li class="active"><a href="#detail-content1">景点说明</a></li>
                            <li><a href="#detail-content2">周边推荐</a></li>
                            <li><a href="#detail-content5">用户点评</a></li>
                        </ul>
                    </div>
                </div>
                <div class="H20"></div>
                <div id="detail-content1" class="news1-detail-content">
                    <%=model.content %>
                </div>
                <div id="detail-content2" class="news2-detail-content">
                    <div class="H20"></div>
                    <div class="H20"></div>
                    <div class="tab-box">
                        <div class="page-tab-title title bg removeborder">
                            <ul>
                                <li class="active"><span>周边酒店推荐</span></li>
                                <li><span>周边饮食推荐</span></li>
                                <li><span>周边风景推荐</span></li>
                            </ul>
                        </div>
                        <div class="H20"></div>
                        <div class="scenic-spots-content content ">
                             <div class="pic_rolling2">
                                <div class="pic_content">
                                        <ul>
                                            <asp:Repeater runat="server" ID="rptTJJD">
                                                <ItemTemplate>
                                                    <li>
                                                        <a href="hotel_parity_detail.aspx?cid=<%#Eval("cid") %>" style="height:300px;">
                                                            <img src="<%#Eval("img_url") %>" alt="">
                                                            <p class="title"><%#Eval("title") %></p>
                                                            <p><span class="score"><%#WebUI.GetStarLevel(Eval("star_level"))%></span></p>
                                                            <p class="dp"><%#WebUI.GetCommentCount(Eval("id"),(int)HTEnums.DataFKType.Hotel)%>人点评</p>
                                                            <p>距离:<%#Eval("Distance2") %></p>
                                                        </a>
                                                    </li>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </ul>
                                </div>
                             </div>
                            <%--<ul>
                                <asp:Repeater runat="server" ID="rptTJJD">
                                    <ItemTemplate>
                                        <li>
                                            <a href="hotel_parity_detail.aspx?cid=<%#Eval("cid") %>">
                                                <img src="<%#Eval("img_url") %>" alt="">
                                                <p class="title"><%#Eval("title") %></p>
                                                <p><span class="score"><%#WebUI.GetStarLevel(Eval("star_level"))%></span></p>
                                                <p class="dp"><%#WebUI.GetCommentCount(Eval("id"),(int)HTEnums.DataFKType.Hotel)%>人点评</p>
                                                <p>距离:<%#Eval("Distance2") %></p>
                                            </a>
                                        </li>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </ul>--%>
                        </div>
                        <div class="scenic-spots-content content hide">
                            
                            <div class="pic_rolling2">
                                <div class="pic_content">
                                        <ul>
                                            <asp:Repeater runat="server" ID="rptTJYS">
                                                <ItemTemplate>
                                                    <li>
                                                        <a href="foodshop_detail.aspx?cid=<%#Eval("cid") %>">
                                                            <img src="<%#Eval("img_url") %>" alt="">
                                                            <p class="title"><%#Eval("title") %></p>
                                                            <p><span class="score"><%#WebUI.GetStarLevel(Eval("star_level"))%></span></p>
                                                            <p class="dp"><%#WebUI.GetCommentCount(Eval("id"),(int)HTEnums.DataFKType.Shop)%>人点评</p>
                                                             <p>距离:<%#Eval("Distance2") %></p>
                                                        </a>
                                                    </li>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </ul>
                                </div>
                             </div>

                            <%--<ul>
                                <asp:Repeater runat="server" ID="rptTJYS">
                                    <ItemTemplate>
                                        <li>
                                            <a href="foodshop_detail.aspx?cid=<%#Eval("cid") %>">
                                                <img src="<%#Eval("img_url") %>" alt="">
                                                <p class="title"><%#Eval("title") %></p>
                                                <p><span class="score"><%#WebUI.GetStarLevel(Eval("star_level"))%></span></p>
                                                <p class="dp"><%#WebUI.GetCommentCount(Eval("id"),(int)HTEnums.DataFKType.Shop)%>人点评</p>
                                                 <p>距离:<%#Eval("Distance2") %></p>
                                            </a>
                                        </li>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </ul>--%>
                        </div>
                        <div class="scenic-spots-content content hide">

                            <div class="pic_rolling2">
                                <div class="pic_content">
                                        <ul>
                                            <asp:Repeater runat="server" ID="rptTJFJ">
                                                <ItemTemplate>
                                                    <li>
                                                        <a href="scenery_spot_detail.aspx?cid=<%#Eval("cid") %>">
                                                            <img src="<%#Eval("img_url") %>" alt="">
                                                            <p class="title"><%#Eval("title") %></p>
                                                            <p><span class="score"><%#WebUI.GetStarLevel(Eval("star_level"))%></span></p>
                                                            <p class="dp"><%#WebUI.GetCommentCount(Eval("id"),(int)HTEnums.DataFKType.Scenery)%>人点评</p>
                                                             <p>距离:<%#Eval("Distance2") %></p>
                                                        </a>
                                                    </li>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </ul>
                                </div>
                             </div>

                            <%--<ul>
                                <asp:Repeater runat="server" ID="rptTJFJ">
                                    <ItemTemplate>
                                        <li>
                                            <a href="scenery_spot_detail.aspx?cid=<%#Eval("cid") %>">
                                                <img src="<%#Eval("img_url") %>" alt="">
                                                <p class="title"><%#Eval("title") %></p>
                                                <p><span class="score"><%#WebUI.GetStarLevel(Eval("star_level"))%></span></p>
                                                <p class="dp"><%#WebUI.GetCommentCount(Eval("id"),(int)HTEnums.DataFKType.Scenery)%>人点评</p>
                                                 <p>距离:<%#Eval("Distance2") %></p>
                                            </a>
                                        </li>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </ul>--%>
                        </div>
                    </div>
                </div>
                <div id="detail-content5" class="news2-detail-content">
                    <div class="H20"></div>
                    <div class="H20"></div>
                    <div class="news2-detail-comment">
                        <div class="news2-detail-comment-title">评论（<%=WebUI.GetCommentCount(model.id,(int)HTEnums.DataFKType.Scenery)%>）</div>
                        <form action="#" id="formCmt" url="/tools/submit_ajax.ashx?action=user_comment_add">
                            <div class="news2-detail-comment-form">
                                <textarea name="txtContent" cols="30" rows="10" placeholder="填写评论内容..." datatype="*1-5000" nullmsg="请输入评论内容" sucmsg=" "></textarea>
                                <span id="msgtipCmt" class="msgtip"></span>
                                <input type="hidden" name="fk_id" value="<%=model.id %>" />
                                <input type="hidden" name="fk_type" value="<%=(int)HTEnums.DataFKType.Scenery %>" />
                                <input type="hidden" name="parent_id" value="0" />
                                <button type="submit" id="btnSubmitCmt" class="btn">发表评论</button>
                            </div>
                        </form>
                        <div class="comment-bot-list" id="comment00">
                            <div id="pagination" class="flickr paging"></div>
                        </div>
                    </div>
                </div>
                <div class="H10"></div>
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
            <div class="H20"></div>
            <div class="page-bg">
                <%=WebUI.GetSingleAds("2b35465228544bbbbb5047f2baf764e1",model.title,true) %>
            </div>

            <%--            <script type="text/javascript">
                agoda_ad_client = "1729777_47508";
                agoda_ad_width = 300;
                agoda_ad_height = 600;
            </script>
            <script type="text/javascript" src="//banner.agoda.com/js/show_ads.js"></script>--%>
            <div class="H20"></div>
            <div class="page-bg">
                <div class="scenic-spots-title">
                    <span>热门酒店推荐</span>
                </div>
                <div class="scenic-spots-recommend content">
                    <ul>
                        <asp:Repeater runat="server" ID="rptTJJD1">
                            <ItemTemplate>
                                <li>
                                    <a href="hotel_parity_detail.aspx?cid=<%#Eval("cid") %>">
                                        <img src="<%#Eval("img_url") %>" alt="">
                                        <p class="title"><%#Eval("title") %></p>
                                        <p><span class="score"><%#WebUI.GetStarLevel(Eval("star_level"))%></span></p>
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
                    <span>热门饮食推荐</span>
                </div>
                <div class="scenic-spots-recommend content">
                    <ul>
                        <asp:Repeater runat="server" ID="rptTJYS1">
                            <ItemTemplate>
                                <li>
                                    <a href="foodshop_detail.aspx?cid=<%#Eval("cid") %>">
                                        <img src="<%#Eval("img_url") %>" alt="">
                                        <p class="title"><%#Eval("title") %></p>
                                        <p><span class="score"><%#WebUI.GetStarLevel(Eval("star_level"))%></span></p>
                                        <p class="dp"><%#WebUI.GetCommentCount(Eval("id"),(int)HTEnums.DataFKType.Shop)%>人点评</p>
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
                    <span>热门景点推荐</span>
                </div>
                <div class="scenic-spots-recommend content">
                    <ul>
                        <asp:Repeater runat="server" ID="rptTJFJ1">
                            <ItemTemplate>
                                <li>
                                    <a href="scenery_spot_detail.aspx?cid=<%#Eval("cid") %>">
                                        <img src="<%#Eval("img_url") %>" alt="">
                                        <p class="title"><%#Eval("title") %></p>
                                        <p><span class="score"><%#WebUI.GetStarLevel(Eval("star_level"))%></span></p>
                                        <p class="dp"><%#WebUI.GetCommentCount(Eval("id"),(int)HTEnums.DataFKType.Scenery)%>人点评</p>
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
                                    <a href="scenery_spot_detail.aspx?cid=<%#Eval("cid") %>">
                                        <img src="<%#Eval("img_url") %>" alt="">
                                        <p class="title"><%#Eval("title") %></p>
                                        <p><span class="score"><%#WebUI.GetStarLevel(Eval("star_level"))%></span></p>
                                        <p class="dp"><%#WebUI.GetCommentCount(Eval("id"),(int)HTEnums.DataFKType.Scenery)%>人点评</p>
                                    </a>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
                <div class="H20"></div>
            </div>
        </div>
    </div>
    <div class="H20"></div>
    <uc1:footer runat="server" ID="footer" />
    <script type="text/javascript">
        $(function () {
            AjaxInitForm('formCmt', 'btnSubmitCmt', 'msgtipCmt');
            AjaxPageList('#comment00', '#pagination', 10, '<%=WebUI.GetCommentCount(model.id,(int)HTEnums.DataFKType.Scenery)%>', '/tools/submit_ajax.ashx?action=user_comment_list', '<%=model.id%>', '<%=(int)HTEnums.DataFKType.Scenery%>');
        })
    </script>
    <script type="text/javascript">
        var $index_rolling1 = $(".pic_rolling2");
        $index_rolling1.each(function () {
            var _this = $(this);
            var str = '<div class="btn_div left_div"><a href="javascript:" class="leftBtn"></a></div>';
            str += ' <div class="btn_div right_div"><a href="javascript:" class="rightBtn disabled"></a></div>';
            _this.append(str);
            var $pic_content = _this.find('.pic_content');
            var $pic_box = _this.find('ul');
            var $pic = $pic_box.find('li');
            var $li_width = $pic.outerWidth(true);
            var $len = $pic.length;
            var direction = "-";
            var counter = 0;
            $pic_content.find("ul").width($len * $li_width);
            $pic_content.on('pic_contentEvent', function () {
                $pic_box.animate({ 'left': direction + '=' + $li_width },
	                500, function () {
	                    _this.trigger('BtnEvent');
	                });
            });

            _this.on('click', '.leftBtn', function () {
                if (counter < 1) {
                    return false;
                }
                else {
                    counter--;
                }
                direction = "+";
                $pic_content.trigger("pic_contentEvent");
            })


            _this.on('click', '.rightBtn', function () {
                if (counter < $len - 1) {
                    counter++;
                }
                else {
                    return false;
                }
                direction = "-";
                $pic_content.trigger("pic_contentEvent");
            })
            _this.on("BtnEvent", function () {
                if (counter == 0) {
                    $(this).find(".leftBtn").removeClass("disabled");
                }
                else {
                    $(this).find(".leftBtn").addClass("disabled");
                }
                if (counter == ($len - 1)) {
                    $(this).find(".rightBtn").removeClass("disabled");
                }
                else {
                    $(this).find(".rightBtn").addClass("disabled");
                }
            })
        })
	</script>
</body>
</html>

