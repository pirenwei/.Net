<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="travel_strategy_list.aspx.cs" Inherits="HT.Web.travel_strategy_list" %>

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
        <div class="page-loct"><a href="index.aspx">首页</a> > <span>旅遊攻略</span> </div>
        <div class="news-search">
            <dl>
                <dd>
                    <label>城市：</label>
                    <select onchange="onSelclick(this)" class="dropdown">
                        <option value="travel_strategy_list.aspx">所有城市</option>
                        <asp:Repeater runat="server" ID="rptListArea">
                            <ItemTemplate>
                                <option <%#Eval("title").ToString()==this.area?"selected=\"selected\"":"" %> value="travel_strategy_list.aspx?area=<%#Eval("title") %>"><%#Eval("title") %></option>
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
            <a href="travel_strategy_list.aspx?sort=click" <%=sort=="click"?"class=\"active\"":"" %>>浏览最多<i></i></a>
            <a href="travel_strategy_list.aspx?sort=addtime" <%=sort=="addtime"?"class=\"active\"":"" %>>最近更新<i></i></a>
        </div>
    </div>
    <div class="H10"></div>
    <div class="container main">
        <div class="page-left MR20">
            <div class="travel-strategy-box W880">
                <ul>
                    <asp:Repeater runat="server" ID="rptList">
                        <ItemTemplate>
                            <li>
                                <div class="item">
                                    <a href="travel_strategy_detail.aspx?cid=<%#Eval("cid") %>">
                                        <img src="<%#Eval("img_url") %>" alt=""></a>
                                    <p class="title"><a href="travel_strategy_detail.aspx?cid=<%#Eval("cid") %>"><%#Eval("title") %></a></p>
                                    <div class="zan">
                                        <div class="Share-span">
                                            <span class="Zambia MR8" onclick="zan_add(this,'<%#Eval("id")%>','<%#(int)HTEnums.DataFKType.Article %>')"><i></i>赞（<%#WebUI.GetZanCount(Eval("id"),(int)HTEnums.DataFKType.Article)%>）</span>
                                            <span class="Browse right"><i></i>浏览（<%#Eval("click") %>）</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="time">更新时间：<%#string.Format("{0:yyyy-MM-dd}",Eval("add_time"))%></div>
                            </li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>
            <div id="PageContent" runat="server" class="page-class"></div>
        </div>
        <div class="page-right">
            <div class="Release-strategy">
                <a style="display: block" href="publish_strategy.aspx">发布攻略 +</a>
            </div>
            <div class="page-bg">
                <div class="scenic-spots-title">
                    <span>热门精选</span>
                </div>
                <div class="travel-strategy-Selected">
                    <ul>
                        <asp:Repeater runat="server" ID="rptListJX">
                            <ItemTemplate>
                                <li>
                                    <a href="travel_strategy_detail.aspx?cid=<%#Eval("cid") %>">
                                        <img src="<%#Eval("img_url") %>" alt="">
                                        <p class="title"><%#Eval("title") %></p>
                                        <p class="time"><%#string.Format("{0:yyyy-MM-dd}",Eval("add_time"))%></p>
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
    <script>
        //下拉框页面跳转
        function onSelclick(_this) {
            var url = $(_this).val();
            location.href = url;
        }
        //按钮页面跳转
        function onBtnclick(_this) {
            var url = "travel_strategy_list.aspx?keywords=" + $("#txtKeywords").val();
            location.href = url;
        }
    </script>
</body>
</html>
