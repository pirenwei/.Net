<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="customized_travel.aspx.cs" Inherits="HT.Web.customized_travel" %>

<%@ Register Src="~/ucl/footer.ascx" TagPrefix="uc1" TagName="footer" %>
<%@ Register Src="~/ucl/header.ascx" TagPrefix="uc1" TagName="header" %>
<%@ Register Src="~/ucl/links.ascx" TagPrefix="uc1" TagName="links" %>

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
<div class="pageBanner H750"  style="background: url('images/customized_travelBanner.jpg') no-repeat center top">
	  <div class="Accommodation-box">
          <% if(IsUserLogin()){%>>
		  <div class="Accommodation-form H593">
		  	   <form url="/tools/map.ashx?action=validate_travel" method="post" id="form1">
		  	   	    <div class="H20"></div>
		  	   	    <div class="H20"></div>
			  	    <div class="Accommodation-search">
			  	    	 <p class="title_p"><span class="color4">输入您想去的目的地：</span></p>
			  	    	 <input type="text" name="travel_title" id="" class="k W100 destination" placeholder="南庄老街" nullmsg="请输入目的地" datatype="*">
			  	    </div>
			  	    <div class="H20"></div>
                    <div class="Accommodation-search">
			  	    	 <p class="title_p"><span class="color4">游玩时间：</span></p>
			  	    	 <dl class="W100">
			  	    	 	<dt><input type="text" name="begin_date" class="k time W100" id="tb_startday" placeholder="选择开始时间" onclick="laydate()" nullmsg="请选择开始时间" datatype="*"/></dt>
			  	    	 	<dd><input type="text"name="end_date" class="k time W100" placeholder="选择结束时间" onclick="laydate()" nullmsg="请选择结束时间" datatype="*"/></dd>
			  	    	 </dl>
			  	    </div>
			  	    <div class="H20"></div>
			  	    <p class="title_p"><span class="color4">热门景点：</span></p>
			  	    <div class="Accommodation-slide Accommodation-slide">
			  	    	 <span class="left-btn"></span>
			  	    	 <span class="right-btn active"></span>
			  	    	 <div class="slide-content H100" data-leng="3">
			  	    	 	 <ul>
                                <asp:Repeater runat="server" ID="rptHotScenery">
                                    <ItemTemplate>
                                    <li>
			  	    	 	 		    <img src="<%#Eval("img_url") %>" alt="">
			  	    	 	 		    <p><%#Eval("title") %></p>
			  	    	 	 	    </li>
                                    </ItemTemplate>
                                </asp:Repeater>
			  	    	 	 </ul>
			  	    	 </div>
			  	    </div>
                      <span id="msgtip" class="msgtip"></span>
			  	    <div class="H20"></div>
			  	    <div class="Accommodation-btn">
			  	    	 <button type="submit" class="btn" id="btnSubmit">开始定制</button>
			  	    </div>
			  	    <div class="Accommodation-text">
			  	    	 <p>你还可以 <a href="travel_open_list.aspx">点击看看</a> 小伙伴们的定制行程</p>
			  	    	 <p>已有行程？  <a href="login.aspx">登陆查看</a></p>
			  	    </div>
			  	    

		  	    </form>
		  </div>
          <%} else{ %>>
          <div class="Accommodation-form H593">
		  	   <form action="login.aspx">
		  	   	    <div class="H20"></div>
		  	   	    <div class="H20"></div>
			  	   <div class="H20"></div>
                     <div class="H20"></div>
                     <div class="H20"></div>
			  	    <div class="H20" style="padding-left:60px; font-size:16px; ">您需要登录后，才能创建更多行程，请先登录或注册.</div>
                       <div class="H20"></div>
                     <div class="H20"></div>
                     <div class="H20"></div>
                     <div class="H20"></div>
			  	    <div class="Accommodation-btn">
			  	    	 <button type="submit" class="btn">登录</button>
			  	    </div>
			  	 

		  	    </form>
		  </div>
          <%} %>
	  </div>
</div>
<div class="page-bg PD00"></div>
    <uc1:footer runat="server" ID="footer" />
</body>
    <script type="text/javascript">
        $(function () {
            AjaxInitForm('form1', 'btnSubmit', 'msgtip');
        })
</script>
</html>


