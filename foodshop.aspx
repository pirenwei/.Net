<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="foodshop.aspx.cs" Inherits="HT.Web.foodshop" %>

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
<div class="pageBanner H750"  style="background: url('images/AccommodationBanner.jpg') no-repeat center top">
	  <div class="Accommodation-box">
		  <div class="Accommodation-form">
		  	   <form action="foodshop_list.aspx">
			  	    <h1>吃在台湾</h1>
			  	    <div class="Accommodation-search">
			  	    	 <p class="title_p">输入您想去的目的地：</p>
			  	    	 <input type="text" name="txtArea" id="" class="k W100" placeholder="请输入您想去的城市名或景点名">
			  	    </div>
			  	    <div class="H30"></div>
			  	    <p class="title_p">精选主题：</p>
			  	    <div class="Accommodation-slide">
			  	    	 <span class="left-btn"></span>
			  	    	 <span class="right-btn active"></span>
			  	    	 <div class="slide-content" data-leng="3">
			  	    	 	 <ul>
                                <asp:Repeater runat="server" ID="rptZuti">
                                    <ItemTemplate>
                                    <li>
                                        <a target="_blank" href="tourism_detail.aspx?cid=<%#Eval("cid") %>">
			  	    	 	 		        <img src="<%#Eval("img_url") %>" alt="">
			  	    	 	 		        <div class="Shadow"><%#Eval("title") %></div>
                                        </a>
			  	    	 	 	    </li>
                                    </ItemTemplate>
                                </asp:Repeater>
			  	    	 	 </ul>
			  	    	 </div>
			  	    </div>
			  	    <div class="H20"></div>
			  	    <div class="H20"></div>
			  	    <p class="title_p">热门饭店：</p>
			  	    <div class="Accommodation-slide">
			  	    	 <span class="left-btn"></span>
			  	    	 <span class="right-btn active"></span>
			  	    	 <div class="slide-content" data-leng="3">
			  	    	 	 <ul>
                                <asp:Repeater runat="server" ID="rptHotFood">
                                    <ItemTemplate>
                                    <li>
                                        <a target="_blank" href="foodshop_detail.aspx?cid=<%#Eval("cid") %>">
			  	    	 	 		        <img src="<%#Eval("img_url") %>" alt="">
			  	    	 	 		        <div class="Shadow"><%#Eval("title") %></div>
                                        </a>
			  	    	 	 	    </li>
                                    </ItemTemplate>
                                </asp:Repeater>
			  	    	 	 </ul>
			  	    	 </div>
			  	    </div>
			  	    <div class="H20"></div>
			  	    <div class="H20"></div>
			  	    <div class="Accommodation-btn">
			  	    	 <button type="submit" class="btn">搜索</button>
			  	    </div>
		  	    </form>
		  </div>

	  </div>
</div>
<div class="page-bg PD00"></div>
<uc1:footer runat="server" id="footer" />
</body>
</html>
