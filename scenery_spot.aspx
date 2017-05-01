<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="scenery_spot.aspx.cs" Inherits="HT.Web.scenery_spot" %>

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
    <div class="container">
        <div class="page-loct"><a href="/index.aspx">首页</a> > <span>景点推荐</span></div>
        <div class="news-search">
            <dl>
                <dd>
                    <label>城市：</label>
                    <select onchange="onSelclick(this)" class="dropdown">
                        <option value="scenery_spot.aspx">所有城市</option>
                        <asp:Repeater runat="server" ID="rptListArea">
                            <ItemTemplate>
                                <option <%#Eval("title").ToString()==this.area?"selected=\"selected\"":"" %> value="scenery_spot.aspx?area=<%#Eval("title") %>"><%#Eval("title") %></option>
                            </ItemTemplate>
                        </asp:Repeater>
                    </select>
                    <em>市</em>
                </dd>
                <dd></dd>
                <dd></dd>
                <dd>
                    <label>关键字：</label>
                    <div class="search-form">
                        <input type="text" id="txtKeywords" placeholder="请输入关键字" class="k">
                        <button type="submit" class="btn" onclick="onBtnclick(this)"><i></i></button>
                    </div>
                </dd>
            </dl>
        </div>
    </div>
    <div class="H20"></div>
    <div class="container">
        <div class="page-Sort">
            <a <%=sort=="zh"?"class=\"active\"":"" %> href="scenery_spot.aspx?sort=zh">综合<i></i></a>
            <a <%=sort=="star"?"class=\"active\"":"" %> href="scenery_spot.aspx?sort=star">星级<i></i></a>
            <a <%=sort=="addtime"?"class=\"active\"":"" %> href="scenery_spot.aspx?sort=addtime">最近发布<i></i></a>
        </div>
    </div>
    <div class="H10"></div>
    <div class="container">
        <div class="scenic-spots-box">
            <ul>
                <asp:Repeater runat="server" ID="rptList">
                    <ItemTemplate>
                        <li>
                            <a href="scenery_spot_detail.aspx?cid=<%#Eval("cid") %>">
                                <img src="<%#Eval("img_url") %>" alt="" class="img"></a>
                            <p class="title"><a href="scenery_spot_detail.aspx?cid=<%#Eval("cid") %>"><%#Eval("title") %></a></p>
                            <p class="address"><span>地址：</span><%#Eval("address") %></p>
                            <p class="xj"><span>星级：</span><span class="span-grade grade"><%#WebUI.GetStarLevel(Eval("star_level"))%></span></p>
                            <p class="pf">点评：<%#WebUI.GetCommentCount(Eval("id"),(int)HTEnums.DataFKType.Scenery)%>人点评</p>
                            <div class="zan">
                                <div class="Share-span">
                                    <span class="Zambia MR8" onclick="zan_add(this,'<%#Eval("id")%>',(int)HTEnums.DataFKType.Scenery)"><i></i>赞（<%#WebUI.GetZanCount(Eval("id"),(int)HTEnums.DataFKType.Scenery)%>）</span>
                                    <a href="scenery_spot_detail.aspx?cid=<%#Eval("cid")%>#detail-content5">
                                        <span class="comment MR8"><i></i>评论（<%#WebUI.GetCommentCount(Eval("id"),(int)HTEnums.DataFKType.Scenery)%>）</span></a>
                                    <span class="collection MR8" onclick="user_collect_add(this,'<%#Eval("id") %>',<%#(int)HTEnums.DataFKType.Scenery %>)"><i></i>收藏（<%#WebUI.GetCollectCount(Eval("id"),(int)HTEnums.DataFKType.Scenery)%>）</span>
                                    <span class="Share MR8"><i></i>分享<div class="bshare-custom pos">
                                        <div class="bsPromo bsPromo2"></div>
                                        <a title="更多平台" class="bshare-more bshare-more-icon more-style-addthis"></a></div>
                                    </span>
                                    <script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/buttonLite.js#style=-1&amp;uuid=&amp;pophcol=2&amp;lang=zh"></script>
                                    <script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/bshareC0.js"></script>
                                </div>
                            </div>
                        </li>
                    </ItemTemplate>
                </asp:Repeater>
            </ul>
        </div>
        <div id="PageContent" runat="server" class="page-class bg"></div>

    </div>
    <uc1:footer runat="server" ID="footer" />
    <script>
        //下拉框页面跳转
        function onSelclick(_this) {
            var url = $(_this).val();
            location.href = url;
        }
        //按钮页面跳转
        function onBtnclick(_this) {
            var url = "scenery_spot.aspx?keywords=" + $("#txtKeywords").val();
            location.href = url;
        }
    </script>
</body>
</html>

