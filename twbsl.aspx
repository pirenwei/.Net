<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="twbsl.aspx.cs" Inherits="HT.Web.twbsl" %>

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
     <div class="page-loct"><a href="index.aspx">首页</a> > 台湾伴手礼 </div>
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
     </div>
     <div class="twbsl-right">
            <div class="slidesBox H340">
                <ul class="slides">
                <asp:Repeater runat="server" ID="rptListAdsBn">
                    <ItemTemplate>
                        <li style="background: url('<%#Eval("img_url")%>') no-repeat center top">
                            <a href="<%#Eval("link_url") %>"></a></li>
                    </ItemTemplate>
                </asp:Repeater>
                </ul>
            </div>
     </div>
</div>
<div class="H20"></div>
<div class="container main">
     <div class="page-left2 MR20">
           <div class="shop-title">
                 <span>热销商品</span><em>/ BEST SELLERS</em>
           </div>
          <div class="twbsl-list PD20">
              <ul class="H225">
                <asp:Repeater runat="server" ID="rptListHot">
                    <ItemTemplate>
                        <li>
                            <a href="twbsl_detail.aspx?cid=<%#Eval("cid") %>"><img src="<%#Eval("img_url") %>" alt="" class="img"></a>
                            <p class="title"><a href="twbsl_detail.aspx?cid=<%#Eval("cid") %>"><%#Eval("title") %></a></p>
                            <p class="title2"><%#Eval("zhaiyao") %></p>
                            <p class="price">¥<%#Eval("sell_price") %>元</p>
                        </li>
                    </ItemTemplate>
                </asp:Repeater>
              </ul>
          </div>
           <div class="H20"></div>
           <div class="shop-title">
                 <span>新品上市</span><em>/ NEW PRODUCT</em>
           </div>
            <div class="twbsl-list PD20">
                <ul class="H225">
                <asp:Repeater runat="server" ID="rptListNew">
                    <ItemTemplate>
                        <li>
                            <a href="twbsl_detail.aspx?cid=<%#Eval("cid") %>"><img src="<%#Eval("img_url") %>" alt="" class="img"></a>
                            <p class="title"><a href="twbsl_detail.aspx?cid=<%#Eval("cid") %>"><%#Eval("title") %></a></p>
                            <p class="title2"><%#Eval("zhaiyao") %></p>
                            <p class="price">¥<%#Eval("sell_price") %>元</p>
                        </li>
                    </ItemTemplate>
                </asp:Repeater>
                </ul>
            </div>
           <div class="H20"></div>
           <div class="shop-title">
                 <span>精品推荐</span><em>/ NPRODUCTS RECOMMENDED</em>
           </div>
            <div class="twbsl-list PD20">
                <ul class="H225">
                <asp:Repeater runat="server" ID="rptListRecommend">
                    <ItemTemplate>
                        <li>
                            <a href="twbsl_detail.aspx?cid=<%#Eval("cid") %>"><img src="<%#Eval("img_url") %>" alt="" class="img"></a>
                            <p class="title"><a href="twbsl_detail.aspx?cid=<%#Eval("cid") %>"><%#Eval("title") %></a></p>
                            <p class="title2"><%#Eval("zhaiyao") %></p>
                            <p class="price">¥<%#Eval("sell_price") %>元</p>
                        </li>
                    </ItemTemplate>
                </asp:Repeater>
                </ul>
            </div>
     </div>
     <div class="page-right2">
        <div class="shop-title"></div>
        <div class="twbsl-img"><a href="<%=WebUI.GetSingleAds("9825c17dfd534127b112480ed438cb8b").link_url %>"><img src="<%=WebUI.GetSingleAds("9825c17dfd534127b112480ed438cb8b").img_url %>" alt="" class="img"></a></div>
        <div class="H20"></div>
        <div class="shop-title"></div>
        <div class="twbsl-img"><a href="<%=WebUI.GetSingleAds("7b90131b1c99443195fbe78500b9e5d4").link_url %>"><img src="<%=WebUI.GetSingleAds("7b90131b1c99443195fbe78500b9e5d4").img_url %>" alt="" class="img"></a></div>
        <div class="H20"></div>
        <div class="shop-title"></div>
        <div class="twbsl-img"><a href="<%=WebUI.GetSingleAds("42d1bf4fcfb44f369cae41e8cf9afd11").link_url %>"><img src="<%=WebUI.GetSingleAds("42d1bf4fcfb44f369cae41e8cf9afd11").img_url %>" alt="" class="img"></a></div>
     </div>
</div>
<div class="H20"></div>
<uc1:footer runat="server" id="footer" />
</body>
</html>



