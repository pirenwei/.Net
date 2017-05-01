<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="car_shuttle_service.aspx.cs" Inherits="HT.Web.car_shuttle_service" %>

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
        <div class="page-loct"><a href="/index.aspx">首页</a> > <span>接送服务</span></div>
        <div class="news-search">
              <dl>
                <dd>
                    <label>价格：</label>
                    <select onchange="onSelclick(this)" class="dropdown">
                        <option value="car_shuttle_service.aspx">所有价格</option>
                        <asp:Repeater runat="server" ID="rptListPrice">
                            <ItemTemplate>
                                <option <%#Eval("title").ToString()==this.price?"selected=\"selected\"":"" %> value="car_shuttle_service.aspx?price=<%#Eval("title") %>"><%#Eval("title") %></option>
                            </ItemTemplate>
                        </asp:Repeater>
                    </select>
                    <em>元</em>
                </dd>
                <dd>
                    <label>城市：</label>
                    <select onchange="onSelclick(this)" class="dropdown">
                        <option value="car_shuttle_service.aspx">所有城市</option>
                        <asp:Repeater runat="server" ID="rptListArea">
                            <ItemTemplate>
                                <option <%#Eval("title").ToString()==this.area?"selected=\"selected\"":"" %> value="car_shuttle_service.aspx?area=<%#Eval("title") %>"><%#Eval("title") %></option>
                            </ItemTemplate>
                        </asp:Repeater>
                    </select>
                    <em>市</em>
                </dd>
                <dd>
                    <label>路线区域：</label>
                    <select onchange="onSelclick(this)" class="dropdown">
                        <option value="car_shuttle_service.aspx">所有路线</option>
                        <asp:Repeater runat="server" ID="rptListAreaLine">
                            <ItemTemplate>
                                <option <%#Eval("title").ToString()==this.areaLine?"selected=\"selected\"":"" %> value="car_shuttle_service.aspx?areaLine=<%#Eval("title") %>"><%#Eval("title") %></option>
                            </ItemTemplate>
                        </asp:Repeater>
                    </select>
                </dd>
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
        <div class="page-tab-title">
            <ul>
                <li><a href="car_charter_service.aspx">包车服务</a></li>
                <li class="active"><a href="car_shuttle_service.aspx">接送服务</a></li>
            </ul>
        </div>
    </div>
    <div class="H10"></div>
    <div class="container main">
        <div class="page-left MR20">
            <div class="charter-service-box W880 border">
                <ul>
                    <asp:Repeater runat="server" ID="rptList">
                        <ItemTemplate>
                            <li>
                                <div class="item">
                                    <a href="car_shuttle_service_detail.aspx?cid=<%#Eval("cid") %>">
                                        <img src="<%#Eval("img_url") %>" alt=""></a>
                                    <p class="title"><a href="car_shuttle_service_detail.aspx?cid=<%#Eval("cid") %>"><%#Eval("title") %></a></p>
                                    <p class="title2"><%#Eval("zhaiyao") %><span class="price">¥<%#Eval("sell_price")%></span></p>
                                </div>
                                <div class="price-btn">
                                    <span><em>¥<%#Eval("sell_price")%></em> 起/每人</span>
                                    <a href="car_shuttle_service_detail.aspx?cid=<%#Eval("cid") %>" class="icon-buy-btn btn">购买</a>
                                </div>
                            </li>
                        </ItemTemplate>
                        <FooterTemplate>
                         <%#rptList.Items.Count == 0 ? "<li>暂无记录</li>" : ""%>
                        </FooterTemplate>
                    </asp:Repeater>
                </ul>
            </div>
            <div id="PageContent" runat="server" class="page-class"></div>
        </div>
        <div class="page-right">
            <div class="page-bg">
                <div class="popular-search-title">
                    <span>热门包车</span>
                </div>
                <div class="charter-service-right-list">
                    <ul>
                        <asp:Repeater runat="server" ID="rptListHot">
                            <ItemTemplate>
                                <li>
                                    <label><a href="car_shuttle_service_detail.aspx?cid=<%#Eval("cid") %>">
                                        <img src="<%#Eval("img_url") %>" alt=""></a></label>
                                    <p class="title"><a href="car_shuttle_service_detail.aspx?cid=<%#Eval("cid") %>"><%#Eval("title") %></a></p>
                                    <p class="title2"><%#Eval("zhaiyao") %> </p>
                                    <p class="price"><span>¥<%#Eval("sell_price") %></span> 起/每人</p>
                                    <p class="btn"><a href="car_shuttle_service_detail.aspx?cid=<%#Eval("cid") %>" class="icon-buy-btn">购买</a></p>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
            <div class="H20"></div>
            <div class="page-bg">
                <div class="popular-search-title">
                    <span>优惠包车</span>
                </div>
                <div class="charter-service-right-list">
                    <ul>
                        <asp:Repeater runat="server" ID="rptListYHBC">
                            <ItemTemplate>
                                <li>
                                    <label><a href="car_shuttle_service_detail.aspx?cid=<%#Eval("cid") %>">
                                        <img src="<%#Eval("img_url") %>" alt=""></a></label>
                                    <p class="title"><a href="car_shuttle_service_detail.aspx?cid=<%#Eval("cid") %>"><%#Eval("title") %></a></p>
                                    <p class="title2"><%#Eval("zhaiyao") %> </p>
                                    <p class="price"><span>¥<%#Eval("sell_price") %></span> 起/每人</p>
                                    <p class="btn"><a href="car_shuttle_service_detail.aspx?cid=<%#Eval("cid") %>" class="icon-buy-btn">购买</a></p>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
        </div>
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
            var url = "car_shuttle_service.aspx?keywords=" + $("#txtKeywords").val();
            location.href = url;
        }
    </script>
</body>
</html>


