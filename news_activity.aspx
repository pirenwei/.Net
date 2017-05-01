<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="news_activity.aspx.cs" Inherits="HT.Web.news_activity" %>

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
  <uc1:links runat="server" id="links" />
</head>
<body>
<uc1:header runat="server" id="header" />
<div class="container">
     <div class="page-loct"><a href="index.aspx">首页</a> > <span>活动快讯</span> </div>
     <div class="news-top">
     	  <div class="news-top-title">
     	  	   <ul>
     	  	     	<li><a href="news.aspx">最新讯息</a></li>
                    <li class="active"><a href="news_activity.aspx">活动快讯</a></li>
     	  	   </ul>
     	  </div>
     </div>
</div>
<div class="H20"></div>
<div class="container">
     <div class="page-bg PD0">
          <div class="news-list2 col_22">
               <ul class="list2">
                   <asp:Repeater runat="server" ID="rptList">
                       <ItemTemplate>
                        <li>
                           <label><a href="news_detail.aspx?cid=<%#Eval("cid") %>">
                               <img src="<%#Eval("img_url") %>" alt=""></a></label>
                           <p class="title"><a href="news_detail.aspx?cid=<%#Eval("cid") %>"><%#Eval("title") %></a></p>
                           <p class="introduct"><%#Eval("zhaiyao") %></p>
                           <p class="Share-p">
                               <div class="Share-span">
                                   <span class="Zambia MR8" onclick="zan_add(this,'<%#Eval("id")%>','<%#(int)HTEnums.DataFKType.Article %>')"><i></i>赞（<%#WebUI.GetZanCount(Eval("id"),(int)HTEnums.DataFKType.Article)%>）</span>
                                   <a href="news_detail.aspx?cid=<%#Eval("cid") %>#detail-comment">
                                        <span class="comment"><i></i>评论（<%#WebUI.GetCommentCount(Eval("id"),(int)HTEnums.DataFKType.Article)%>）</span></a>
                                   <span class="collection" onclick="user_collect_add(this,'<%#Eval("id")%>',<%#(int)HTEnums.DataFKType.Article %>)"><i></i>收藏（<%#WebUI.GetCollectCount(Eval("id"),(int)HTEnums.DataFKType.Article)%>）</span>
                                    <span class="Share"><i></i>分享<div class="bshare-custom pos"><div class="bsPromo bsPromo2"></div><a title="更多平台" class="bshare-more bshare-more-icon more-style-addthis"></a></div></span>
                                <script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/buttonLite.js#style=-1&amp;uuid=&amp;pophcol=2&amp;lang=zh"></script><script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/bshareC0.js"></script>
                               </div>
                           </p>
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
