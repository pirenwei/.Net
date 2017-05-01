<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="video.aspx.cs" Inherits="HT.Web.video" %>

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
    <div class="page-loct"><a href="index.aspx">首页</a> > <span><a href="video.aspx?category_id=<%=category_id %>"><%=new HT.BLL.article_category().GetTitle(category_id) %></a></span></div>
<div class="news-search">
            <dl>
                <dd>
                    <label>城市：</label>
                    <select onchange="onSelclick(this)" class="dropdown">
                        <option value="video.aspx?month=<%=month %>">所有城市</option>
                        <asp:Repeater runat="server" ID="rptListArea">
                            <ItemTemplate>
                                <option <%#Eval("title").ToString()==this.area?"selected=\"selected\"":"" %> value="video.aspx?area=<%#Eval("title") %>&month=<%=this.month%>"><%#Eval("title") %></option>
                            </ItemTemplate>
                        </asp:Repeater>
                    </select>
                    <em>市</em>
                </dd>
                <dd>
                    <label>发布月份：</label>
                    <select onchange="onSelclick(this)" class="dropdown">
                        <option value="video.aspx?area=<%=this.area %>">所有月份</option>
                        <asp:Repeater runat="server" ID="rptListMonth">
                            <ItemTemplate>
                                <option <%#Eval("title").ToString()==this.month?"selected=\"selected\"":"" %> value="video.aspx?month=<%#Eval("title") %>&area=<%=this.area %>"><%#Eval("title") %></option>
                            </ItemTemplate>
                        </asp:Repeater>
                    </select>
                    <em>月</em>
                </dd>
                <dd></dd>
                <dd>
                    <label>关键字：</label>
                    <div class="search-form">
                        <input type="text" id="txtKeywords" placeholder="请输入关键字" class="k">
                        <button type="submit" class="btn" onclick="onBtnclick(this)"><i></i></button>
                    </div>
                </dd>
            </dl>
        </div>
</div>
<div class="container">
    <div class="content_bg">
        <div class="page-tab-title title">
            <ul>
                <li <%=category_id==9?"class=\"active\"":"" %>><a href="video.aspx">影音档案</a></li>
                <li <%=category_id==10?"class=\"active\"":"" %> ><a href="video.aspx?category_id=10">摄影专区</a></li>
                <div class="more">
                    <a href="video_list.aspx?category_id=<%=category_id %>">查看更多
                        <img src="images/zyxc/gengduo.png" /></a>
                </div>
            </ul>
        </div>
        <div class="H10"></div>
    </div>
</div>
<div class="container main">
    <div class="page-left MR20">
        <div class="page-bg">
            <asp:Repeater runat="server" ID="rptList">
                <ItemTemplate>
                 <div class="video1-list">
        	  	        <div class="list_img">
                            <a href="video_detail.aspx?cid=<%#Eval("cid") %>"><img src="<%#Eval("img_url") %>" /></a>
                        </div>
                        <div class="list_text">
                        <p class="p1"><a href="video_detail.aspx?cid=<%#Eval("cid") %>"><%#Eval("title") %></a></p>
                        <p class="p2">发布时间：<%#string.Format("{0:yyyy-MM-dd}",Eval("add_time"))%></p>
                        <div class="H10"></div>
                        <p class="p3"><%#Eval("zhaiyao") %></p>
                    </div>
    	          </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <div id="PageContent" runat="server" class="page-class"></div>
    </div>
    <div class="page-right">
            <div class="fbyy_btn">
                <a href="publish_video.aspx">发布作品</a>
            </div>
            <div class="H15"></div>
            <div class="rmss">
                <div class="H5"></div>
                <div class="rmss_title">
                    <div class="rmss_t1">
                        热门搜索
                    </div>
                </div>
                <ul class="rm">
                    <asp:Repeater runat="server" ID="rptListHot">
                        <ItemTemplate>
                            <li><a href="video_detail.aspx?cid=<%#Eval("cid") %>"><%#Eval("title") %><em><%#Eval("click") %></em></a></li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>
    </div>
</div>
<div class="H20"></div>
<uc1:footer runat="server" id="footer" />
     <script>
         //下拉框页面跳转
         function onSelclick(_this) {
             var url = $(_this).val();
             location.href = url;
         }
         //按钮页面跳转
         function onBtnclick(_this) {
             var url = "video.aspx?keywords=" + $("#txtKeywords").val();
            location.href = url;
        }
    </script>
</body>
</html>
