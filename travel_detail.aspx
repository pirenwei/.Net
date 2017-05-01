<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="travel_detail.aspx.cs" Inherits="HT.Web.travel_detail" %>

<%@ Register Src="~/ucl/footer.ascx" TagPrefix="uc1" TagName="footer" %>
<%@ Register Src="~/ucl/header.ascx" TagPrefix="uc1" TagName="header" %>
<%@ Register Src="~/ucl/links.ascx" TagPrefix="uc1" TagName="links" %>

<%@ Import Namespace="HT.Common" %>
<%@ Import Namespace="HT.Web.UI" %>

<!DOCTYPE html>
<html lang="zh">
<head>
  <title><%=model.title %></title>
    <meta name="keywords" content="<%=HT.Web.UI.WebUI.config.webkeyword %>">
  <meta name="description" content="<%=HT.Web.UI.WebUI.config.webdescription %>">
  <uc1:links runat="server" id="links" />
     <link rel="stylesheet" href="/css/map.css">
    <script src="http://ditu.google.cn/maps/api/js?sensor=false&libraries=places&key=AIzaSyA_fSbr4yGpPdxIweEDTIwcu9Epn6jCz2A&callback=initialize" async defer></script>
    <script>
        //地图变量
        var map;
        //旅行时间
        var travel_day_num=0;
        var Travel_id = <%=id%>;
        function initialize() {
            var mapOptions = {
                zoom: 12,
                mapTypeId: google.maps.MapTypeId.ROADMAP,
                center: new google.maps.LatLng(<%=Lat%>, <%=Lng%>),
                scaleControl: true //比例控件 
            };
         
            map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);
            google.maps.event.addDomListener(window, 'load', function () {
                loadMapData(); 
            });
            google.maps.event.addListener(map, 'zoom_changed', function () {
                loadMapData()
            });
            google.maps.event.addListener(map, 'mouseup', function () {
                loadMapData()
            });
            $.getScript("http://<%=HT.Common.HTRequest.GetCurrentFullHost()%>/js/map.js", function () {
                loadUserData();
            })
        }
    </script>
    <script src="/js/map_function.js" type="text/javascript"></script>
</head>
<body>
<uc1:header runat="server" id="header" />
<div class="container">
     <div class="page-loct"><a href="index.aspx">首页</a> > <a href="travel_open_list.aspx">定制旅行</a> > <span><%=model.title %></span> </div>
</div>
<div class="container">
    <div class="travel_page1">
        <div class="page1_img">
            <img src="<%=model.img_url %>" />
        </div>
        <div class="page1_text">
            <p class="txt1"><span class="title"><%=model.title %></span>
                <%=GroupStatusHtml() %></p>
            <div class="clear"></div>
            <p class="txt2">游玩景点：<%=WebUI.GetTravelPlace(model.id) %></p>
            <p class="txt2">行程日期：<%=string.Format("{0:yyyy/MM/dd}",model.begin_date)%>~<%=string.Format("{0:yyyy/MM/dd}",model.end_date)%>
                总共<%=DateTimeDiff.DateDiff_full_days(model.begin_date,model.end_date) %>
            </p>
            <p class="txt3"><img width="60" src="<%=WebUI.GetUserAvatar(model.user_id) %>" /><span>发布者：<%=model.user_name %></span></p>
        </div>
        <div class="page1_share">
            <div class="share1">
                <div class="share1">
                    <a href="##" onclick="zan_add(this,'<%=model.id %>','<%=(int)HTEnums.DataFKType.Travel%>')">
                        <img src="images/member/zan.png" />赞（<%=WebUI.GetZanCount(model.id,(int)HTEnums.DataFKType.Travel)%>）</a>
                    <a href="travel_detail.aspx?id=<%=model.id %>#detail-comment">
                        <img src="images/member/pinglun.png" />评论（<%=WebUI.GetCommentCount(model.id,(int)HTEnums.DataFKType.Travel)%>） </a>
                    <a href="##" onclick="user_collect_add(this,'<%=model.id %>','<%=(int)HTEnums.DataFKType.Travel%>')">
                        <img src="images/member/shoucang.png" />收藏（<%=WebUI.GetCollectCount(model.id,(int)HTEnums.DataFKType.Travel)%>）</a>
                </div>
            </div>
            <div class="share2" onclick="fn_BaskGB('<%=model.id %>')">
                <img src="images/member/shangbi_icon.png" />赏币一个
            </div>
        </div>
    </div>
    <div class="H20"></div>
    <div class="travel_title">
        <ul>
            <li class="current"><a href="travel_detail.aspx?id=<%=model.id %>">行程</a></li>
            <li><a href="travel_detail_note.aspx?id=<%=model.id %>">笔记</a></li>
        </ul>
        <div class="public">
            <a href="##"><%=model.is_open==1?"公开":"隐藏" %></a>
        </div>
        <div class="clear"></div>
    </div>
    <div class="H10"></div>
    <div class="travel_trip_title">
        <ul>
            <li class="current">
                <a href="travel_detail.aspx?id=<%=model.id %>"><img src="images/member/zonglan_icon.png" />总览</a></li>
            <li><a href="travel_detail_group.aspx?id=<%=model.id %>"><img src="images/member/zutuan_icon.png" />组团</a></li>
        </ul>
        <div class="clear"></div>
    </div>
    <div class="H10"></div>
    <div class="travelpage_left">
        <asp:Repeater runat="server" ID="rptListDay" OnItemDataBound="rptListDay_ItemDataBound">
            <ItemTemplate>
                <div class="travelpage_left_item">
                    <div class="view_title">
                        <span><%#Eval("title") %></span>
                    </div>
                    <asp:Repeater runat="server" ID="rptItem">
                        <ItemTemplate>
                        <div class="view1">
                            <span class="dizhi_icon"><img src="images/member/dizhi_icon.png" /></span>
                            <span class="dizhi_pic"><img src="<%#GetItemString(Eval("item_id"),Eval("type"),"img_url")%>" /></span>
                            <div class="dizhi">
                                <div class="H10"></div>
                                <p><%#Eval("name") %></p>
                                <div class="H5"></div>
                                <p>地址：<%#GetItemString(Eval("item_id"),Eval("type"),"addresss")%></p>
                            </div>
                            <span class="dizhi_jiudian"><a href="<%#GetItemString(Eval("item_id"),Eval("type"),"link")%>">查看周边特价酒店>></a></span>
                        </div>
                        </ItemTemplate>
                    </asp:Repeater>
    	     </div>
            </ItemTemplate>
        </asp:Repeater>

         <div class="H10"></div>
            <div class="news2-detail-comment" id="detail-comment">
                <div class="news2-detail-comment-title">评论（<%=WebUI.GetCommentCount(model.id,(int)HTEnums.DataFKType.Travel)%>）</div>
                <form action="#" id="formCmt" url="/tools/submit_ajax.ashx?action=user_comment_add">
                <div class="news2-detail-comment-form">
                    <textarea name="txtContent" cols="30" rows="10" placeholder="填写评论内容..." datatype="*1-5000" nullmsg="请输入评论内容" sucmsg=" "></textarea>
                    <span id="msgtipCmt" class="msgtip"></span>
                    <input type="hidden" name="fk_id" value="<%=model.id %>" />
                    <input type="hidden" name="fk_type" value="<%=(int)HTEnums.DataFKType.Travel %>" />
                    <input type="hidden" name="parent_id" value="0" />
                    <button type="submit" id="btnSubmitCmt" class="btn">发表评论</button>
                </div>
                </form>
                <div class="comment-bot-list" id="comment00">
                    <div id="pagination" class="flickr paging"></div>
                </div>
            </div>
    </div>
    <div class="travelpage_right">
        <div class="travel_right1" id="map_canvas">
 
           
        </div>
        <div class="H20"></div>
        <div class="travel_right2">
            <div class="perimeter_title">
                <span>周边地区类似</span>
            </div>
            <div class="tab-box">
                <div class="tab-title title">
                    <ul>
                        <li class="current"><span>酒店推荐</span></li>
                        <li><span>美食推荐</span></li>
                    </ul>
                    <div class="clear"></div>
                </div>
                <div class="tab-content content">
                    <ul>
                        <asp:Repeater runat="server" ID="rptTjHotel">
                            <ItemTemplate>
                            <li>
                                <a href="hotel_parity_detail.aspx?cid=<%#Eval("cid") %>">
                                    <div class="perimeter_img">
                                        <img src="<%#Eval("img_url") %>" />
                                    </div>
                                    <div class="perimeter">
                                        <p class="biaoti"><%#Eval("title") %></p>
                                        <p><span class="span_left">星级</span>
                                            <span class="span_right score"><%#WebUI.GetStarLevel(Eval("star_level"))%></span></p>
                                        <p><span class="span_left"><%#WebUI.GetCommentCount(Eval("id"),(int)HTEnums.DataFKType.Hotel)%>人点评</span></p>
                                    </div>
                                </a>
                                <div class="clear"></div>
                            </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
                <div class="tab-content content hide">
                    <ul>
                        <asp:Repeater runat="server" ID="rptTjShop">
                            <ItemTemplate>
                            <li>
                                <a href="foodshop_detail.aspx?cid=<%#Eval("cid") %>">
                                    <div class="perimeter_img">
                                        <img src="<%#Eval("img_url") %>" />
                                    </div>
                                    <div class="perimeter">
                                        <p class="biaoti"><%#Eval("title") %></p>
                                        <p><span class="span_left">星级</span>
                                            <span class="span_right score"><%#WebUI.GetStarLevel(Eval("star_level"))%></span></p>
                                        <p><span class="span_left"><%#WebUI.GetCommentCount(Eval("id"),(int)HTEnums.DataFKType.Shop)%>人点评</span></p>
                                    </div>
                                </a>
                                <div class="clear"></div>
                            </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="clear"></div>
    <div class="H30"></div>
</div>
<div class="H20"></div>
<uc1:footer runat="server" id="footer" />
<script type="text/javascript">
    $(function () {
        AjaxInitForm('formCmt', 'btnSubmitCmt', 'msgtipCmt');
        AjaxPageList('#comment00', '#pagination', 10, '<%=WebUI.GetCommentCount(model.id,(int)HTEnums.DataFKType.Travel)%>', '/tools/submit_ajax.ashx?action=user_comment_list', '<%=model.id%>', '<%=(int)HTEnums.DataFKType.Travel%>');
    })
</script>
</body>
</html>


