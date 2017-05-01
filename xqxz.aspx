<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="xqxz.aspx.cs" Inherits="HT.Web.xqxz" %>

<%@ Register Src="~/ucl/footer.ascx" TagPrefix="uc1" TagName="footer" %>
<%@ Register Src="~/ucl/header.ascx" TagPrefix="uc1" TagName="header" %>
<%@ Register Src="~/ucl/links.ascx" TagPrefix="uc1" TagName="links" %>

<%@ Import Namespace="HT.Common"%>

<!DOCTYPE html>
<html lang="zh">
<head>
  <title><%=HT.Web.UI.WebUI.config.webtitle %></title>
    <meta name="keywords" content="<%=HT.Web.UI.WebUI.config.webkeyword %>">
  <meta name="description" content="<%=HT.Web.UI.WebUI.config.webdescription %>">
  <uc1:links runat="server" id="links" />
</head>
<body>
<uc1:header runat="server" id="header" />
<div class="container">
    <div class="page-loct"><a href="index.aspx">首页</a> > <a href="xqxz.aspx">行前须知</a> > <span><%=new HT.BLL.article_category().GetTitle(category_id)%></span></div>
</div>
<div class="container">
    <div class="wrapper">
        <div class="left_page">
            <div class="left_center">
                <h2>行前须知</h2>
                <ul>
                <asp:Repeater runat="server" ID="rptListCategory">
                    <ItemTemplate>
                        <li <%#category_id==Utils.ObjToInt(Eval("id"))?"class=\"current\"":"" %>>
                            <a href="xqxz.aspx?category_id=<%#Eval("id") %>"><%#Eval("title") %></a></li>
                    </ItemTemplate>
                </asp:Repeater>
                </ul>
            </div>
        </div>
        <div class="right_page">
            <div class="page_title">
                <h1><%=new HT.BLL.article_category().GetTitle(category_id)%></h1>
            </div>
            <asp:Repeater runat="server" ID="rptList">
                <ItemTemplate>
                <div class="xqxz-item">
                    <label><a href="xqxz_detail.aspx?cid=<%#Eval("cid") %>">
                            <img src="<%#Eval("img_url") %>" /></a></label>
                    <h1><%#Eval("title") %></h1>
                    <p class="introduct"><%#Eval("zhaiyao")%></p>
                    <a href="xqxz_detail.aspx?cid=<%#Eval("cid") %>" class="more">查看内容</a>
                    <div class="time">
                        <p class="April"><%#string.Format("{0:MM月}",Eval("add_time"))%></p>
                        <p class="day"><%#string.Format("{0:dd}",Eval("add_time"))%></p>
                    </div>
                </div>
                </ItemTemplate>
            </asp:Repeater>

            <div id="PageContent" runat="server" class="page-class"></div>
        </div>

    </div>
</div>
<div class="H20"></div>
<uc1:footer runat="server" id="footer" />
</body>
</html>

