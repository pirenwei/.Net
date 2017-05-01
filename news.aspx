<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="news.aspx.cs" Inherits="HT.Web.news" %>

<%@ Register Src="~/ucl/footer.ascx" TagPrefix="uc1" TagName="footer" %>
<%@ Register Src="~/ucl/header.ascx" TagPrefix="uc1" TagName="header" %>
<%@ Register Src="~/ucl/links.ascx" TagPrefix="uc1" TagName="links" %>

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
     <div class="page-loct"><a href="index.aspx">首页</a> > <span>最夯新闻</span> </div>
     <div class="news-top">
     	  <div class="news-top-title">
     	  	   <ul>
     	  	     	<li class="active"><a href="news.aspx">最新讯息</a></li>
                    <li><a href="news_activity.aspx">活动快讯</a></li>
     	  	   </ul>
     	  </div>
     </div>
</div>
<div class="container main">
	 <div class="page-left MR20">
	 	 <div class="news-list">
	 	 	  <ul>
                <asp:Repeater runat="server" ID="rptList">
                    <ItemTemplate>
                    <li>
                        <label><a href="news_detail.aspx?cid=<%#Eval("cid") %>"><img src="<%#Eval("img_url") %>" alt=""></a></label>
                        <p class="title"><a href="news_detail.aspx?cid=<%#Eval("cid") %>"><%#Eval("title") %></a></p>
                        <p class="time">发布时间：<%#string.Format("{0:yyyy-MM-dd}",Eval("add_time"))%></p>
                        <p class="introduct"><%#Eval("zhaiyao") %></p>
                    </li>
                    </ItemTemplate>
                </asp:Repeater>
              </ul>
	 	 </div>  
         <div id="PageContent" runat="server" class="page-class"></div>
	 </div>
	 <div class="page-right">
	 	  <div class="page-bg">
	 	  	   <div class="popular-search-title">
	 	  	   	    <span>热门搜索</span>
	 	  	   </div> 
	 	  	   <div class="popular-search-list">
	 	  	   	   <ul>
                    <asp:Repeater runat="server" ID="rptListHot">
                        <ItemTemplate>
                            <li><a href="news_detail.aspx?cid=<%#Eval("cid") %>"><%#Eval("title") %><em><%#Eval("click") %></em></a></li>
                        </ItemTemplate>
                    </asp:Repeater>
                  </ul>
	 	  	   </div>
	 	  </div>
	 	                                
	 </div>		
</div>
<uc1:footer runat="server" id="footer" />
</body>
</html>
