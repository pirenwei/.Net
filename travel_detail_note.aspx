<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="travel_detail_note.aspx.cs" Inherits="HT.Web.travel_detail_note" %>

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
    <uc1:links runat="server" ID="links" />
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
    <uc1:header runat="server" ID="header" />
    <div class="container">
        <div class="page-loct"><a href="index.aspx">首页</a> > <a href="travel_open_list.aspx">定制旅行</a> > <span><%=model.title %></span> </div>
    </div>
    <div class="container">
        <div class="travel_page1">
            <div class="page1_img">
                <img src="<%=model.img_url %>" />
            </div>
            <div class="page1_text">
                <p class="txt1"><span class="title"><%=model.title %></span><%=GroupStatusHtml() %></p>
                <div class="clear"></div>
                <p class="txt2">游玩景点：<%=WebUI.GetTravelPlace(model.id) %></p>
                <p class="txt2">行程日期：<%=string.Format("{0:yyyy-MM-dd}",model.begin_date)%>-<%=string.Format("{0:yyyy-MM-dd}",model.end_date)%></p>
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
                <li><a href="travel_detail.aspx?id=<%=model.id %>">行程</a></li>
                <li class="current"><a href="travel_detail_note.aspx?id=<%=model.id %>">笔记</a></li>
            </ul>
            <div class="public"><%=model.is_open==1?"公开":"隐藏" %></div>
            <div class="clear"></div>
        </div>
        <div class="H10"></div>
        <div class="travel_trip_title">
            <ul>
                <li class="current">
                    <a href="travel_detail.aspx?id=<%=model.id %>">
                        <img src="images/member/zonglan_icon.png" />总览</a></li>
                <li><a href="travel_detail_group.aspx?id=<%=model.id %>">
                    <img src="images/member/zutuan_icon.png" />组团</a></li>
            </ul>
            <div class="clear"></div>
        </div>
        <div class="H10"></div>
        <div class="page-left3 MR20">
            <div class="page-bg">
                <asp:Repeater runat="server" ID="rptDayNote">
                    <ItemTemplate>
                        <div class="travelpage_left_item">
                            <div class="view_title">
                                <span><%#Eval("title") %></span>
                                <div class="operation">
                                <%if(GetUser()!=null)
                                {
                                    if(GetUser().id ==model.user_id)
                                    {%>
                                    <a href="javascript:;" onclick="layer_OpenEdit(<%#Eval("id") %>)">
                                        <img src="images/member/bianji_icon.png" />编辑</a>
                                 <% }
                                } %>
                                </div>
                            </div>
                            <div class="view2">
                                <p class="txt1"><%#Eval("note_title") %></p>
                                <p class="txt2"><%#Eval("note_content") %></p>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <div class="H20"></div>
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
    <uc1:footer runat="server" ID="footer" />
    
    <script type="text/javascript">
        $(function () {
            var editorMini = KindEditor.create('.editor-mini', {
                width: '100%',
                height: '250px',
                resizeType: 1,
                uploadJson: '../../tools/upload_ajax.ashx?action=EditorFile&IsWater=1',
                items: [
                    'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
                    'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
                    'insertunorderedlist', '|', 'emoticons', 'image', 'link']
            });

            AjaxInitForm('formCmt', 'btnSubmitCmt', 'msgtipCmt');
            AjaxPageList('#comment00', '#pagination', 10, '<%=WebUI.GetCommentCount(model.id,(int)HTEnums.DataFKType.Travel)%>', '/tools/submit_ajax.ashx?action=user_comment_list', '<%=model.id%>', '<%=(int)HTEnums.DataFKType.Travel%>');
        })
        function layer_OpenEdit(main_id) {
            layer.open({
                type: 2,
                title: '编辑笔记',
                shadeClose: true,
                shade: 0.8,
                area: ['690px', '70%'],
                content: 'travel_note_post.aspx?main_id='+main_id 
            });
        }
    </script>
</body>
</html>



