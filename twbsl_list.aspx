<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="twbsl_list.aspx.cs" Inherits="HT.Web.twbsl_list" %>

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
  <uc1:links runat="server" id="links" />
</head>
<body>
<uc1:header runat="server" id="header" />
<div class="container">
     <div class="page-loct"><a href="index.aspx">首页</a> > <a href="twbsl.aspx">台湾伴手礼</a>  >  <span><%=new HT.BLL.goods_category().GetTitle(category_id) %></span></div>
</div>
<div class="container main">
     <div class="twbsl-left">
         <div class="twbsl-top-title">商品类别</div>
         <div class="twbsl-menu">
             <ul>
                <asp:Repeater runat="server" ID="rptListCategory">
                    <ItemTemplate>
                        <li><a href="twbsl_list.aspx?category_id=<%#Eval("id") %>"><i></i><%#Eval("title") %></a></li>
                    </ItemTemplate>
                </asp:Repeater>
             </ul>
        </div>
        <div class="H10"></div>
        <div class="twbsl-top-title col_22">商品推广</div>
        <div class="twbsl-extension">
            <a href="<%=WebUI.GetSingleAds("9825c17dfd534127b112480ed438cb8b").link_url %>"><img src="<%=WebUI.GetSingleAds("9825c17dfd534127b112480ed438cb8b").img_url %>" alt="" class="img"></a>
            <a href="<%=WebUI.GetSingleAds("7b90131b1c99443195fbe78500b9e5d4").link_url %>"><img src="<%=WebUI.GetSingleAds("7b90131b1c99443195fbe78500b9e5d4").img_url %>" alt="" class="img"></a>
            <a href="<%=WebUI.GetSingleAds("42d1bf4fcfb44f369cae41e8cf9afd11").link_url %>"><img src="<%=WebUI.GetSingleAds("42d1bf4fcfb44f369cae41e8cf9afd11").img_url %>" alt="" class="img"></a>
        </div>
     </div>
     <div class="twbsl-right">
         <div class="twbsl-search">
             <span class="count">共计 <%=totalCount %> 记录</span>
         </div>
         <div class="H10"></div>
          <div class="twbsl-list PD10">
              <ul class="H210">
                  <asp:Repeater runat="server" ID="rptList">
                      <ItemTemplate>
                        <li>
                          <a href="twbsl_detail.aspx?cid=<%#Eval("cid") %>"><img src="<%#Eval("img_url") %>" alt="" class="img"></a>
                          <p class="title"><a href="twbsl_detail.aspx?cid=<%#Eval("cid") %>"><%#Eval("title") %></a></p>
                          <p class="title2"><%#Eval("zhaiyao")%></p>
                          <p class="price">¥<%#Eval("sell_price") %></p>
                        </li>
                      </ItemTemplate>
                  </asp:Repeater>
              </ul>
          </div>
            <div id="PageContent" runat="server" class="page-class"></div>
     </div>
</div>
<uc1:footer runat="server" id="footer" />
</body>
</html>



