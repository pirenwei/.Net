<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="drjx_detail.aspx.cs" Inherits="HT.Web.drjx_detail" %>

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
</head>
<body>
    <uc1:header runat="server" ID="header" />
    <div class="container">
        <div class="page-loct"><a href="/index.aspx">首页</a> > <span>达人精选</span> </div>
        <div class="H20"></div>
        <div class="up-people-list-top">
            <dl>
                <dt>
                    <img src="<%=WebUI.GetUserAvatar(model.user_id) %>" alt="" class="img">
                    <p class="title"><%=model.title %></p>
                    <p class="title2"><span>达人：</span><%=model.user_name==""?"匿名":model.user_name %></p>
                    <p class="title2"><span>一共发表：</span>文章数（<%=countArticle %>）</p>
                </dt>
                <dd>
                    <p class="time">更新日期：<%=string.Format("{0:yyyy-MM-dd}",model.add_time)%></p>
                </dd>
            </dl>
        </div>
        <div class="H20"></div>
        <div class="up-people-list-img">
            <img src="<%=model.img_url %>" alt=""></div>
        <div class="H15"></div>
        <div class="up-people-list-introduction-box">
            <div class="introduction">
                <div class="introduction-title">
                    <span>达人介绍</span>
                </div>
                <div class="introduction-content">
                    <p><%=model.zhaiyao %></p>
                </div>
            </div>
            <div class="headlines">
                <div class="introduction-title">
                    <span>达人头条</span>
                </div>
                <div class="headlines-content border">
                    <ul class="W242">
                        <asp:Repeater runat="server" ID="rptDrtt">
                            <ItemTemplate>
                                <li>
                                    <div class="video">
                                        <a href="<%#HT.Web.UI.WebUI.GetDataLink(Eval("id"),(int)HTEnums.DataFKType.Article) %>">
                                            <img src="<%#Eval("img_url") %>" alt=""></a>
                                    </div>
                                    <div class="title">
                                        <span><%#Eval("title")%></span>
                                        <em>观看次数（<%#Eval("click") %>）</em>
                                    </div>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="H20"></div>
    <div class="container">
        <div class="page-tab-title">
            <ul>
                <li class="active"><span>达人视频</span></li>
            </ul>
        </div>
        <div class="H10"></div>
        <div class="headlines-content">
            <ul class="W1220">
                <asp:Repeater runat="server" ID="rptDrsp">
                    <ItemTemplate>
                        <li>
                            <div class="video">
                                <a href="<%#HT.Web.UI.WebUI.GetDataLink(Eval("id"),(int)HTEnums.DataFKType.Article) %>">
                                    <img src="<%#Eval("img_url") %>" alt=""></a>
                            </div>
                            <div class="title">
                                <span>
                                    <a href="<%#HT.Web.UI.WebUI.GetDataLink(Eval("id"),(int)HTEnums.DataFKType.Article) %>">
                                        <%#Eval("title") %></a></span>
                                <em>观看次数（<%#Eval("click") %>）</em>
                            </div>
                        </li>
                    </ItemTemplate>
                </asp:Repeater>
            </ul>
        </div>
    </div>
    <div class="container">
        <div class="page-tab-title">
            <ul>
                <li class="active"><span>达人文章</span></li>
            </ul>
        </div>
        <div class="up-people-list">
            <ul class="H282">
                <asp:Repeater runat="server" ID="rptDrwz">
                    <ItemTemplate>
                        <li>
                            <div class="item">
                                <a href="<%#HT.Web.UI.WebUI.GetDataLink(Eval("id"),(int)HTEnums.DataFKType.Article) %>">
                                    <img src="<%#Eval("img_url")%>" alt=""></a>
                                <p class="title PDR134">
                                    <a href="<%#HT.Web.UI.WebUI.GetDataLink(Eval("id"),(int)HTEnums.DataFKType.Article) %>">
                                        <%#Eval("title") %></a>
                                    <span class="time">发布日期：<%#string.Format("{0:yyyy-MM-dd}",Eval("add_time"))%></span>
                                </p>
                                <p class="introduct">
                                    <%#Eval("zhaiyao") %>
                                </p>
                            </div>
                        </li>
                    </ItemTemplate>
                </asp:Repeater>
            </ul>
        </div>
    </div>
    <div class="H20"></div>
    <div class="container">
        <div class="page-tab-title">
            <ul>
                <li class="active"><span>精选头条</span></li>
            </ul>
        </div>
        <div class="up-people-list">
            <ul class="H320">
                <asp:Repeater runat="server" ID="rptJxtt">
                    <ItemTemplate>
                        <li>
                            <div class="item">
                                <a href="<%#HT.Web.UI.WebUI.GetDataLink(Eval("id"),(int)HTEnums.DataFKType.Article) %>">
                                    <img src="<%#Eval("img_url")%>" alt=""></a>
                                <p class="title PDR134">
                                    <a href="<%#HT.Web.UI.WebUI.GetDataLink(Eval("id"),(int)HTEnums.DataFKType.Article) %>">
                                        <%#Eval("title") %></a>
                                    <span class="time">发布日期：<%#string.Format("{0:yyyy-MM-dd}",Eval("add_time"))%></span>
                                </p>
                                <p class="introduct">
                                    <%#Eval("zhaiyao") %>
                                </p>
                            </div>
<%--                            <div class="item">
                                <a href="drjx_detail.aspx?cid=<%#Eval("cid") %>">
                                    <img src="<%#Eval("img_url") %>" alt=""></a>
                                <p class="title">
                                    <a href="drjx_detail.aspx?cid=<%#Eval("cid") %>">
                                        <%#Eval("title") %></a>
                                </p>
                                <p class="introduct">
                                    <%#Eval("zhaiyao") %>
                                </p>
                            </div>
                            <p class="keywork">
                                <span><em>标签：</em><%#Eval("tags") %></span>
                            </p>--%>
                        </li>
                    </ItemTemplate>
                </asp:Repeater>
            </ul>
        </div>
    </div>
    <div class="H20"></div>

    <uc1:footer runat="server" ID="footer" />
</body>
</html>
