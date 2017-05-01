<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="drjx.aspx.cs" Inherits="HT.Web.drjx" %>

<%@ Register Src="~/ucl/footer.ascx" TagPrefix="uc1" TagName="footer" %>
<%@ Register Src="~/ucl/header.ascx" TagPrefix="uc1" TagName="header" %>
<%@ Register Src="~/ucl/links.ascx" TagPrefix="uc1" TagName="links" %>

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
        <div class="page-loct"><a href="index.aspx">首页</a> > <span>达人精选</span> </div>
        <asp:Repeater runat="server" ID="rptListTop">
            <ItemTemplate>
                <div class="up-people-top">
                    <div class="up-people-img">
                        <a href="drjx_detail.aspx?cid=<%#Eval("cid") %>">
                            <img src="<%#Eval("img_url") %>" alt=""></a>
                    </div>
                    <div class="up-people-introduct">
                        <h1 class="title"><a href="drjx_detail.aspx?cid=<%#Eval("cid") %>">
                            <%#Eval("title") %></a></h1>
                        <div class="portrait">
                            <img src="<%#WebUI.GetUserAvatar(Eval("user_id"))%>" alt="">
                            <p><span>发布者：</span><%#Eval("user_name").ToString()==""?"匿名":Eval("user_name")+"" %></p>
                            <p><span>发布时间：</span><%#string.Format("{0:yyyy-MM-dd}",Eval("add_time"))%></p>
                        </div>
                        <div class="text-introduct">
                            <p><%#Eval("zhaiyao") %></p>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
    <div class="container">
        <div class="up-people-list">
            <ul>
                <asp:Repeater runat="server" ID="rptList">
                    <ItemTemplate>
                        <li class="H294" style="height:316px">
                            <div class="item">
                                <a href="drjx_detail.aspx?cid=<%#Eval("cid") %>">
                                    <img src="<%#Eval("img_url") %>" alt=""></a>
                                <p class="title">
                                    <a href="drjx_detail.aspx?cid=<%#Eval("cid") %>"><%#Eval("title") %></a>
                                    <span class="time">发布日期：<%#string.Format("{0:yyyy-MM-dd}",Eval("add_time"))%></span>
                                </p>
                                <p class="introduct">
                                    <%#Eval("zhaiyao") %>
                                </p>
                            </div>
                            <p class="keywork">
                                <span><em>标签：</em><%#Eval("tags") %></span>
                            </p>
                        </li>
                    </ItemTemplate>
                </asp:Repeater>
            </ul>
        </div>
        <div id="PageContent" runat="server" class="page-class"></div>
    </div>
    <uc1:footer runat="server" ID="footer" />
</body>
</html>
