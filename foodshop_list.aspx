<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="foodshop_list.aspx.cs" Inherits="HT.Web.foodshop_list" %>

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
    <div class="container">
        <div class="page-loct"><a href="index.aspx">首页</a> > <span>吃在台湾</span> </div>
        <div class="news-search">
            <dl>
                <dd>
                    <label>城市：</label>
                    <select onchange="onSelclick(this)" class="dropdown">
                        <option value="foodshop_list.aspx">所有城市</option>
                        <asp:Repeater runat="server" ID="rptListArea">
                            <ItemTemplate>
                                <option <%#Eval("title").ToString()==this.area?"selected=\"selected\"":"" %> value="foodshop_list.aspx?area=<%#Eval("title") %>"><%#Eval("title") %></option>
                            </ItemTemplate>
                        </asp:Repeater>
                    </select>
                    <em>市</em>
                </dd>
                <dd></dd>
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
    <div class="H20"></div>
    <div class="container">
        <div class="Sort-box">
            <ul>
                <li>
                    <div class="page-Sort">
                        <a <%=sort=="zh"?"class=\"active\"":"" %> href="foodshop_list.aspx?sort=zh">综合<i></i></a>
                        <a <%=sort=="star"?"class=\"active\"":"" %> href="foodshop_list.aspx?sort=star">星级<i></i></a>
                        <a <%=sort=="addtime"?"class=\"active\"":"" %> href="foodshop_list.aspx?sort=addtime">最新<i></i></a>
                    </div>
                </li>
            </ul>
        </div>
    </div>
    <div class="H10"></div>
    <div class="container">
        <div class="Accommodation-wrap" id="AccommodationBox">
        </div>
        <div class="H20"></div>
        <div class="wrap-btn">
            <button class="more" type="button"
                ht-click="rendering"
                data-page="1"
                data-config='{"sort":"<%=sort %>","area":"<%=area %>","keywords":"<%=keywords %>"}'
                data-url="/tools/json_ajax.ashx?action=JsonShopList"
                data-tpl="productTemplate"
                data-warp="#AccommodationBox">
                查看更多 +
            </button>
        </div>
    </div>

    <div class="H20"></div>
    <div class="Back-top">
        <span id="toTop">返回顶部</span>
    </div>

    <uc1:footer runat="server" ID="footer" />
    <script>
        //下拉框页面跳转
        function onSelclick(_this) {
            var url = $(_this).val();
            location.href = url;
        }
        //按钮页面跳转
        function onBtnclick(_this) {
            var url = "foodshop_list.aspx?keywords=" + $("#txtKeywords").val();
            location.href = url;
        }
    </script>
    <!-- 列表页面 -->
    <script type="text/tpl" id="productTemplate">
  {{each list as item}}
         <div class="box">
	  	  	  <div class="img">
                  <a href="{{item.href}}">
    	  	  	  	  <img src="{{item.src}}" alt="" style="width:224px; min-height:60px">
    	  	  	  	  <span class="wjx"></span>
                      {{#item.yhjHtml}}
                  </a>
	  	  	  </div>
	  	  	  <div class="introduct">
	  	  	  	   <p class="title"><a href="{{item.href}}">{{item.title}}</a></p>
	  	  	  	   <p class="dj"><em>星级：</em><span class="span-grade grade">{{#item.star_level}}</span></p>
	  	  	  	   <p class="price"><span><b>¥{{item.price}}</b></span>（人均价格）</p>
	  	  	  </div>
	  	  	  <div class="text">
	  	  	  	   <p>{{item.introduct}}</p>
	  	  	  </div>
	  	  </div>
  {{/each}}
    </script>
</body>
</html>
