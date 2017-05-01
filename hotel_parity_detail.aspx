<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="hotel_parity_detail.aspx.cs" Inherits="HT.Web.hotel_parity_detail" %>

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
        <div class="page-loct"><a href="index.aspx">首页</a> > <a href="hotel_parity_list.aspx">住在台湾</a> > <span><%=model.title %></span> </div>
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
                        <p class="title">
                            <%=model.title %>
                            <span class="collection" onclick="user_collect_add(this,'<%=model.id %>','<%=(int)HTEnums.DataFKType.Hotel%>')">收藏<i></i></span>
                        </p>
                        <div class="H10"></div>
                        <p class="xj"><span>星级：</span><span class="span-grade grade"><%=WebUI.GetStarLevel(model.star_level)%></span></p>
                        <p class="address"><span>地址：</span><%=model.address %></p>
                        <p class="address"><span>电话：</span><%=model.telphone %></p>
                        <p class="pf"><span>点评：</span><%=WebUI.GetCommentCount(model.id,(int)HTEnums.DataFKType.Hotel)%>人点评</p>
                        <div class="H10"></div>
                        <p class="introduct">
                            <%=model.zhaiyao %>
                        </p>
                    </div>
                </div>
                <div class="tab-box">
                    <div class="page-tab-title title">
                        <ul>
                            <li class="active"><span>房型预定</span></li>
                            <li><span>用户点评</span></li>
                        </ul>
                    </div>
                    <div class="Accommodation-Shop-content content">
                        <div class="H10"></div>
                        <div class="Accommodation-parity-time">
                            <form action="hotel_parity_detail.aspx" method="get">
                            <dl>
                                <dt>入住时间：</dt>
                                <dd class="W270">
                                    <input type="text" name="dateValue" class="k W100 time" placeholder="选择入住日期" onfocus="laydate()" value="<%=string.Format("{0:yyyy-MM-dd}",dateValue) %>"/></dd>
                                <dd class="W270">
                                    <input type="text" name="txtCheckOut" class="k W100 time" placeholder="选择离店日期" onfocus="laydate()" value="<%=string.Format("{0:yyyy-MM-dd}",dateValue.AddDays(1)) %>"/></dd>
                                <dd class="W97">共 <span>0</span> 天</dd>
                                <dd class="W81">
                                    <input type="hidden" name="cid" value="<%=cid %>"/>
                                    <button type="submit" class="btn">重新搜索</button></dd>
                            </dl>
                            </form>
                        </div>
                        <div class="H10"></div>
                        <div class="ccommodation-parity-content"  style="position:relative;">
                            <table class="Accommodation-parity-table W100">
                            <colgroup>
                                <col style="width: 20%"></col>
                                <col style="width: 30%"></col>
                                <col style="width: 20%"></col>
                                <col style="width: 15%"></col>
                                <col style="width: 15%"></col>
                            </colgroup>
                            <tr class="th bg border">
                                <th>信息来源</th>
                                <th>房型</th>
                                <th>剩余房价数</th>
                                <th>价格</th>
                                <th>操作</th>
                            </tr>
                            <asp:Repeater runat="server" ID="rptListRmtpDN">
                                <ItemTemplate>
                                <tr class="tr">
                                    <td>
                                        <p><img src="images/hotel/set_logo.png" height="25"/></p>
                                    </td>
                                    <td>
                                        <p><%#Eval("roomType") %></p>
                                    </td>
                                    <td>
                                        <p><%#Utils.ObjToInt(Eval("qty"))>0?""+Eval("qty"):"0" %>间</p>
                                    </td>
                                    <td>
                                        <p>￥<%#Eval("price") %></p>
                                    </td>
                                    <td>
                                        <p><a target="_blank" href="http://www.settour.com.tw/">查看</a></p>
                                    </td>
                                </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                            <asp:Repeater runat="server" ID="rptListRmtpLR">
                                <ItemTemplate>
                                <tr class="tr">
                                    <td>
                                        <p><img src="images/hotel/lateroom.png" height="25" />LateRooms</p>
                                    </td>
                                    <td>
                                        <p><%#Eval("roomType") %></p>
                                    </td>
                                    <td>
                                        <p><%#Utils.ObjToInt(Eval("qty"))>0?""+Eval("qty"):"0" %>间</p>
                                    </td>
                                    <td>
                                        <p>￥<%#Eval("price") %></p>
                                    </td>
                                    <td>
                                        <p><a target="_blank" href="http://www.laterooms.com/">查看</a></p>
                                    </td>
                                </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </table>
<%--                            <div class="Accommodation-parity-hotal">
                            <div class="hotal h1">
                                <script type="text/javascript">
                                    agoda_ad_client = "1738944_48420";
                                    agoda_ad_width = 200;
                                    agoda_ad_height = 200;
                                </script>
                                <script type="text/javascript" src="//banner.agoda.com/js/show_ads.js"></script>
                            </div>
                            <div class="hotal h2">
                                <script type="text/javascript">
                                    agoda_ad_client = "1738944_48420";
                                    agoda_ad_width = 200;
                                    agoda_ad_height = 200;
                                </script>
                                <script type="text/javascript" src="//banner.agoda.com/js/show_ads.js"></script>
                            </div>
                            <div class="hotal h3">
                                <script type="text/javascript">
                                    agoda_ad_client = "1738944_48420";
                                    agoda_ad_width = 200;
                                    agoda_ad_height = 200;
                                </script>
                                <script type="text/javascript" src="//banner.agoda.com/js/show_ads.js"></script>
                            </div>
                            <div class="hotal h4">
                                <script type="text/javascript">
                                    agoda_ad_client = "1738944_48420";
                                    agoda_ad_width = 200;
                                    agoda_ad_height = 200;
                                </script>
                                <script type="text/javascript" src="//banner.agoda.com/js/show_ads.js"></script>
                            </div>
                            <div class="clearfix"></div>
                        </div>--%>
                        </div>
                        <div class="H20"></div>
                        <div class="page-tab-title">
                            <ul>
                                <li class="active"><span>酒店详情</span></li>
                            </ul>
                        </div>
                        <div class="Accommodation-Shop-content-img">
                            <%=model.content %>
                        </div>

                    </div>
                    <div class="Accommodation-Shop-content content hide">
                        <div class="H10"></div>
                        <div class="news2-detail-comment">
                            <div class="news2-detail-comment-title">评论（<%=WebUI.GetCommentCount(model.id,(int)HTEnums.DataFKType.Hotel)%>）</div>
                            <form id="formCmt" url="/tools/submit_ajax.ashx?action=user_comment_add">
                                <div class="news2-detail-comment-form">
                                    <textarea name="txtContent" cols="30" rows="10" placeholder="填写评论内容..." datatype="*1-5000" nullmsg="请输入评论内容" sucmsg=" "></textarea>
                                    <span id="msgtipCmt" class="msgtip"></span>
                                    <input type="hidden" name="fk_id" value="<%=model.id %>" />
                                    <input type="hidden" name="fk_type" value="<%=(int)HTEnums.DataFKType.Hotel %>" />
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
                <div class="page-tab-title">
                    <ul>
                        <li class="active"><span>为您推荐以下酒店</span></li>
                    </ul>
                </div>
                <div class="H15"></div>
                <div class="Accommodation-parity-detail-list PD10">

                     <div class="pic_rolling2">
                            <div class="pic_content">
                                    <ul>
                                        <asp:Repeater runat="server" ID="rptTJJD">
                                            <ItemTemplate>
                                            <li>
                                                <a href="hotel_parity_detail.aspx?cid=<%#Eval("cid") %>">
                                                    <img src="<%#Eval("img_url") %>" alt="" class="img"></a>
                                                <p class="title"><a href="#hotel_parity_detail.aspx?cid=<%#Eval("cid") %>"><%#Eval("title") %> </a></p>
                                                <p class="dj"><span>星级：</span><span class="span-grade grade"><%#WebUI.GetStarLevel(Eval("star_level"))%></span></p>
                                                <p>距离:<%#Eval("Distance2") %></p>
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
                                    <img src="<%#Eval("img_url") %>" alt="" class="img"></a>
                                <p class="title"><a href="#hotel_parity_detail.aspx?cid=<%#Eval("cid") %>"><%#Eval("title") %> </a></p>
                                <p class="dj"><span>星级：</span><span class="span-grade grade"><%#WebUI.GetStarLevel(Eval("star_level"))%></span></p>
                             <p>距离:<%#Eval("Distance2") %></p>
                                 </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>--%>
                </div>
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
                <div class="scenic-spots-title">
                    <span>酒店周边美食</span>
                </div>
                <div class="scenic-spots-recommend content">
                    <ul>
                        <asp:Repeater runat="server" ID="rpZBMS">
                            <ItemTemplate>
                            <li>
                                <a href="foodshop_detail.aspx?cid=<%#Eval("cid") %>">
                                    <img src="<%#Eval("img_url") %>" alt="">
                                    <p class="title"><%#Eval("title") %></p>
                                    <p class="dj"><span class="score"><%#WebUI.GetStarLevel(Eval("star_level"))%></span></p>
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
                    <span>景点推荐</span>
                </div>
                <div class="scenic-spots-recommend content">
                    <ul>
                        <asp:Repeater runat="server" ID="rptJDTJ">
                            <ItemTemplate>
                            <li>
                                <a href="scenery_spot_detail.aspx?cid=<%#Eval("cid") %>">
                                    <img src="<%#Eval("img_url") %>" alt="">
                                    <p class="title333"><%#Eval("title") %></p>
                                    <p class="dj"><span class="score"><%#WebUI.GetStarLevel(Eval("star_level"))%></span></p>
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
                        <asp:Repeater runat="server" ID="rptHistory">
                            <ItemTemplate>
                            <li>
                                <a href="hotel_parity_detail.aspx?cid=<%#Eval("cid") %>">
                                    <img src="<%#Eval("img_url") %>" alt="">
                                    <p class="title"><%#Eval("title") %></p>
                                    <p class="dj"><span class="score"><%#WebUI.GetStarLevel(Eval("star_level"))%></span></p>
                                    <p class="dp"><%#WebUI.GetCommentCount(Eval("id"),(int)HTEnums.DataFKType.Hotel)%>人点评</p>
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

    <script type="text/javascript">
        $(function () {
            AjaxInitForm('formCmt', 'btnSubmitCmt', 'msgtipCmt');
            AjaxPageList('#comment00', '#pagination', 10, '<%=WebUI.GetCommentCount(model.id,(int)HTEnums.DataFKType.Hotel)%>', '/tools/submit_ajax.ashx?action=user_comment_list', '<%=model.id%>', '<%=(int)HTEnums.DataFKType.Hotel%>');
    })
    </script>
</body>
</html>

