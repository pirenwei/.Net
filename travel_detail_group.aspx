<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="travel_detail_group.aspx.cs" Inherits="HT.Web.travel_detail_group" %>

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
            <form mainid="<%=model.id %>" url="/tools/submit_ajax.ashx?action=SaveTravelImgUrl">
                <div class="page1_img">
                    <img class="upload-images" src="<%=model.img_url %>" />
                </div>
                <div class="page1_text">
                    <p class="txt1"><span class="title"><%=model.title %></span><%=GroupStatusHtml() %></p>
                    <div class="clear"></div>
                    <p class="txt3">
                        <img width="60" src="<%=WebUI.GetUserAvatar(model.user_id) %>" />
                        <span>发布者：<%=model.user_name %></span>
                        <span class="trip_date">行程日期：<%=string.Format("{0:yyyy/MM/dd}",model.begin_date)%>~<%=string.Format("{0:yyyy/MM/dd}",model.end_date)%></span>
                    </p>
                    <%if (joingroup_isshow)
                      {
                      if (GetUser() != null)
                      {
                          if (GetUser().id == model.user_id)
                          {%>
                    <div class="change_trip">
                        <div class="upload-box upload-img"></div>
                        <%--<a href="##">
                                <span>更换行程封面<img src="../images/member/change_trip_icon.png" /></span></a>--%>
                    </div>
                    <% }
                          else
                          { %>
                    <p class="txt2">游玩景点：<%=WebUI.GetTravelPlace(model.id)%></p>
                    <%} %>
                    <%}
                      else
                      {%>
                    <p class="txt2">游玩景点：<%=WebUI.GetTravelPlace(model.id)%></p>
                    <%}
                  } %>
                </div>
            </form>
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
                <li>
                    <a href="travel_detail.aspx?id=<%=model.id %>">
                        <img src="images/member/zonglan_icon1.png" />总览</a></li>
                <li class="current">
                    <a href="travel_detail_group.aspx?id=<%=model.id %>">
                        <img src="images/member/zutuan_icon1.png" />组团</a></li>
            </ul>
            <div class="clear"></div>
        </div>
        <div class="H10"></div>

        <div class="page-left3 MR20">
            <div class="page-bg PD00">
                <asp:Repeater runat="server" ID="rptListGourp" OnItemDataBound="rptListGourp_ItemDataBound">
                    <ItemTemplate>
                        <div class="travelpage-box">
                            <div class="table">
                                <table>
                                    <tr>
                                        <td colspan="2">标题：<%#Eval("title") %></td>
                                    </tr>
                                    <tr>
                                        <td>组团人数：<%#Eval("renshu") %>人 </td>
                                        <td>组团性别：<%#Eval("gender") %></td>
                                    </tr>
                                    <tr>
                                        <td>招募时间：<%#string.Format("{0:yyyy-MM-dd}",Eval("begin_date"))%> ~ <%#string.Format("{0:yyyy-MM-dd}",Eval("end_date"))%></td>
                                        <td>集合时间：<%#Eval("jihe_time") %></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">集合地点：<%#Eval("jihe_place") %></td>
                                    </tr>
                                    <tr class="beizhu">
                                        <td colspan="2">备注：<%#Eval("remark") %></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="H20"></div>
                            <%if (GetUser() != null)
                              {
                                  if (GetUser().id == model.user_id)
                                  {%>
                            <div class="registration_btn1" style="padding-left: 25px">
                                <a href="##" class="chakan" ht-click="show" data-target="#registration-box">查看报名</a>
                                <a href="##" class="jieshu" onclick="fn_closeByGroup(this,'<%#Eval("id") %>')">结束组团</a>
                                <div class="clear"></div>
                            </div>
                            <%}
                                else
                                {%>
                            <div class="registration_btn1" style="padding-left: 25px">
                                <button class="icon-save-btn" onclick="fn_applyByGroup(this,'<%#Eval("id") %>')">立即报名</button>
                                <div class="clear"></div>
                            </div>
                            <%}%>
                            <%}
                              else
                              {%>
                            <div class="registration_btn1" style="padding-left: 25px">
                                <button class="icon-save-btn" onclick="fn_applyByGroup(this,'<%#Eval("id") %>')">立即报名</button>
                                <div class="clear"></div>
                            </div>
                            <%} %>
                            <div class="H20"></div>
                            <p class="group_title" style="padding-left: 25px">现有团员列表</p>
                            <div class="H10"></div>
                            <div class="group_list" style="padding-left: 25px">
                                <ul pagesize="8">
                                    <asp:Repeater runat="server" ID="rptGroupApply">
                                        <ItemTemplate>
                                            <li>
                                                <img src="<%#WebUI.GetUserAvatar(Eval("user_id"))%>" />
                                                <p><%#Eval("user_name") %></p>
                                            </li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ul>
                            </div>
                        </div>
                    </ItemTemplate>
                    <FooterTemplate>
                        <%#rptListGourp.Items.Count == 0 ? "<div>暂无记录</div>" : ""%>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
            <div class="H20"></div>
        </div>
        <div class="travelpage_right">
            <div class="travel_right1" id="map_canvas"></div>
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
                                                <p>
                                                    <span class="span_left">星级</span>
                                                    <span class="span_right score"><%#WebUI.GetStarLevel(Eval("star_level"))%></span>
                                                </p>
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
                                                <p>
                                                    <span class="span_left">星级</span>
                                                    <span class="span_right score"><%#WebUI.GetStarLevel(Eval("star_level"))%></span>
                                                </p>
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
        <div class="H20"></div>
    </div>
    <div class="PopBox hide" id="registration-box">
        <div class="Pop_upBox_bg"></div>
        <div class="Pop_upBox W800">
            <div class="pop_content">
                <div class="PopBox_title">想要参加您的组团《<%=model.title %>》的会员</div>
                <div class="content PD20">
                    <div class="registration_content">
                        <div class="H20"></div>
                        <table>
                            <colgroup>
                                <col style="width: 20%" />
                                <col style="width: 40%" />
                                <col style="width: 20%" />
                                <col style="width: 20%" />
                            </colgroup>
                            <tr>
                                <th>申请人</th>
                                <th>申请时间</th>
                                <th>操作</th>
                                <th>状态</th>
                            </tr>
                            <asp:Repeater runat="server" ID="rptGroupApplyList">
                                <ItemTemplate>
                                    <tr>
                                        <td><span class="pic">
                                            <img src="<%#WebUI.GetUserAvatar(Eval("user_id"))%>" /></span>
                                            <span class="txt"><%#Eval("user_name") %></span></td>
                                        <td><%#Eval("add_time") %></td>
                                        <td><a href="##" onclick="fn_refuseJoin(this,'<%#Eval("id") %>')">拒绝</a></td>
                                        <td>已接受</td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <%#rptGroupApplyList.Items.Count == 0 ? "<tr><td align=\"center\" colspan=\"7\">暂无记录</td></tr>" : ""%>
                                </FooterTemplate>
                            </asp:Repeater>
                        </table>
                    </div>
                </div>
                <div class="close" ht-click="hide" data-target="#registration-box">
                    <img src="images/e/close.png" alt="" />
                </div>
            </div>
        </div>
    </div>
    <uc1:footer runat="server" ID="footer" />
    <script type="text/javascript" charset="utf-8" src="/scripts/webuploader/webuploader.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="/scripts/webuploader/uploader.js"></script>
    <script type="text/javascript">
        $(function () {
            AjaxInitForm('formCmt', 'btnSubmitCmt', 'msgtipCmt');
            AjaxPageList('#comment00', '#pagination', 10, '<%=WebUI.GetCommentCount(model.id,(int)HTEnums.DataFKType.Travel)%>', '/tools/submit_ajax.ashx?action=user_comment_list', '<%=model.id%>', '<%=(int)HTEnums.DataFKType.Travel%>');
            //初始化上传控件
            $(".upload-img").InitUploader({ sendurl: "/tools/upload_ajax.ashx", swf: "/scripts/webuploader/uploader.swf" });
            
        })
    </script>
    <script type="text/javascript">
        $(function () {
            $(".chakan").click(function () {
                $(".registration_bg").show();
            })
            $(".close").click(function () {
                $(".registration_bg").hide();
            })
        })
        //立即报名
        function fn_applyByGroup(obj,group_id){
            $.ajax({
                type: "post",
                url: "/tools/submit_ajax.ashx?action=applyByGroup",
                data: { "group_id": group_id },
                dataType: "json",
                success: function (data) {
                    layer.msg(data.msg)
                    if (data.status == 1) {
                        location.reload();
                    }
                }
            });
        }
        //结束组团
        function fn_closeByGroup(obj,group_id){
            $.ajax({
                type: "post",
                url: "/tools/submit_ajax.ashx?action=closeByGroup",
                data: { "group_id": group_id },
                dataType: "json",
                success: function (data) {
                    layer.msg(data.msg)
                    if (data.status == 1) {
                        location.reload();
                    }
                }
            });
        }
        //拒绝加入
        function fn_refuseJoin(obj,apply_id){
            alert(111);
            $.ajax({
                type: "post",
                url: "/tools/submit_ajax.ashx?action=refuseJoin",
                data: { "apply_id": apply_id },
                dataType: "json",
                success: function (data) {
                    layer.msg(data.msg)
                    if (data.status == 1) {
                        location.reload();
                    }
                }
            });
        }
    </script>
</body>
</html>


