<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="tourism_list.aspx.cs" Inherits="HT.Web.tourism_list" %>

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
        <div class="page-loct"><a href="index.aspx">首页</a> > <span>主题旅游</span></div>
        <div class="news-search">
            <dl>
                <dd>
                    <label>城市：</label>
                    <select onchange="onSelclick(this)" class="dropdown">
                        <option value="tourism_list.aspx">所有城市</option>
                        <asp:Repeater runat="server" ID="rptListArea">
                            <ItemTemplate>
                                <option <%#Eval("title").ToString()==this.area?"selected=\"selected\"":"" %> value="tourism_list.aspx?area=<%#Eval("title") %>"><%#Eval("title") %></option>
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
        <div class="Sort-box">
            <div class="page-Sort">
                <a href="tourism_list.aspx?sort=click" <%=sort=="click"?"class=\"active\"":"" %>>浏览最多<i></i></a>
                <a href="tourism_list.aspx?sort=addtime" <%=sort=="addtime"?"class=\"active\"":"" %>>最近更新<i></i></a>
            </div>
            <div class="right-btn"><a href="publish_tourism.aspx" class="icon-release-btn">发布主题旅游+</a></div>
        </div>
    </div>
    <div class="H20"></div>
    <div class="container">
        <div class="video_list_bg">
            <div class="out">
                <ul class="video_list in">
                    <asp:Repeater runat="server" ID="rptList">
                        <ItemTemplate>
                            <li>
                                <div class="list1">
                                    <div class="list1_img">
                                        <a href="tourism_detail.aspx?cid=<%#Eval("cid") %>">
                                            <img width="200" src="<%#Eval("img_url") %>" /></a>
                                    </div>
                                    <div class="list1_text">
                                        <p class="p4"><a href="tourism_detail.aspx?cid=<%#Eval("cid") %>"><%#Eval("title") %></a></p>
                                        <p class="p5"><%#Eval("zhaiyao") %></p>
                                        <p class="p6">发布时间：<%#string.Format("{0:yyyy-MM-dd}",Eval("add_time"))%></p>
                                        <div class="pinglun">
                                            <dl>
                                                <dd><a href="##" onclick="zan_add(this,'<%#Eval("id")%>','<%#(int)HTEnums.DataFKType.Article%>')">
                                                    <img src="images/zyxc/zan.png" />赞（<%#WebUI.GetZanCount(Eval("id"),(int)HTEnums.DataFKType.Article)%>）</a></dd>
                                                <dd><a href="tourism_detail.aspx?cid=<%#Eval("cid") %>#detail-content2">
                                                    <img src="images/zyxc/pinglun.png" />评论（<%#WebUI.GetCommentCount(Eval("id"),(int)HTEnums.DataFKType.Article)%>） </a></dd>
                                                <dd><a href="##" onclick="user_collect_add(this,'<%#Utils.ObjToInt(Eval("id")) %>',<%#(int)HTEnums.DataFKType.Article %>)">
                                                    <img src="images/zyxc/shoucang.png" />收藏（<%#WebUI.GetCollectCount(Eval("id"),(int)HTEnums.DataFKType.Article)%>）</dd>
                                                <dd><a href="##">
                                                    <img src="images/zyxc/fenxiang.png" />分享<div class="bshare-custom pos">
                                                        <div class="bsPromo bsPromo2"></div>
                                                        <a title="更多平台" class="bshare-more bshare-more-icon more-style-addthis"></a></div>
                                                </a>
                                                    <script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/buttonLite.js#style=-1&amp;uuid=&amp;pophcol=2&amp;lang=zh"></script>
                                                    <script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/bshareC0.js"></script>
                                                </dd>
                                            </dl>
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>
        </div>
        <div id="PageContent" runat="server" class="page-class"></div>
    </div>
    <div class="H20"></div>
    <uc1:footer runat="server" ID="footer" />
        <script>
            //下拉框页面跳转
            function onSelclick(_this) {
                var url = $(_this).val();
                location.href = url;
            }
            //按钮页面跳转
            function onBtnclick(_this) {
                var url = "tourism_list.aspx?keywords=" + $("#txtKeywords").val();
                location.href = url;
            }
    </script>
</body>
</html>
