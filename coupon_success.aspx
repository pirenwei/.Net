<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="coupon_success.aspx.cs" Inherits="HT.Web.coupon_success" %>

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
     <div class="page-loct"><a href="/index.aspx">首页</a> > <a href="foodshop_list.aspx">吃在台湾</a>
</div>
<div class="container">
	 <div class="page-bg PD20">
	 	 <div class="Coupon-success">
		 	  <span></span>
		 	  <p>您的优惠券领取成功！可点击<a href="/member/member.aspx">“会员中心”</a>在我的优惠券栏目进行查看</p>
		 </div>
	 </div>
	 
</div>
<div class="H20"></div>
<uc1:footer runat="server" id="footer" />
</body>
</html>
