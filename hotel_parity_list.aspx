<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="hotel_parity_list.aspx.cs" Inherits="HT.Web.hotel_parity_list" %>

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
    <uc1:links runat="server" ID="links" />
</head>
<body>
    <uc1:header runat="server" ID="header" />
    <div class="container">
        <div class="page-loct"><a href="index.aspx">首页ppp</a> > <span>住宿比价ppp</span> </div>
    </div>
    <div class="container">
        <div class="Accommodation-parity-top">
            <dl>
                <dt>
                    <div class="page-Sort">
                        <a <%=sort=="zh"?"class=\"active\"":"" %> href="hotel_parity_list.aspx?sort=zh">综合<i></i></a>
                        <a <%=sort=="star"?"class=\"active\"":"" %> href="hotel_parity_list.aspx?sort=star">星级<i></i></a>
                        <a <%=sort=="addtime"?"class=\"active\"":"" %> href="hotel_parity_list.aspx?sort=addtime">最新<i></i></a>
                    </div>
                </dt>
	 	   	    <dd class="right">
	 	   		    <div class="Accommodation-parity-top-search">
	 	   			     <input type="text" class="k" id="txtKeywords" placeholder="请输入关键字">
	 	   			     <button type="submit" class="btn" onclick="onBtnclick(this)">搜索</button>
	 	   		    </div>
	 	   	    </dd>
            </dl>

        </div>
    </div>
    <div class="H20"></div>
    <div class="container main">
        <div class="page-bg">
            <asp:Repeater runat="server" ID="rptList" OnItemDataBound="rptList_ItemDataBound" OnItemCommand="rptList_ItemCommand">
                <ItemTemplate>
                    <div class="Accommodation-parity-item">
                        <label>
                            <a href="hotel_parity_detail.aspx?cid=<%#Eval("cid") %>">
                                <img src="<%#Eval("img_url") %>" alt="" class="item-label"></a></label>
                        <div class="introduct">
                            <p class="title"><a href="hotel_parity_detail.aspx?cid=<%#Eval("cid") %>"><%#Eval("title") %></a></p>
                            <p class="col_1"><span>星级：</span><span class="span-grade grade"><%#WebUI.GetStarLevel(Eval("star_level"))%></span></p>
                            <p class="col_1">地址：<%#Eval("address") %></p>
                            <p class="col_1">点评：<%#WebUI.GetCommentCount(Eval("id"),(int)HTEnums.DataFKType.Hotel)%>人点评</p>
                        </div>
                        <div class="Fangxing">
                            <div class="Accommodation-parity-table-box example">
                                <table class="Accommodation-parity-table">
                                    <colgroup>
                                        <col style="width: 40%"></col>
                                        <col style="width: 30%"></col>
                                        <col style="width: 30%"></col>
                                    </colgroup>
                                    <tr class="th">
                                        <th>信息来源</th>
                                        <th>房型</th>
                                        <th>最低房价</th>
                                    </tr>
                                    <asp:Repeater runat="server" ID="rptListRmtpDN">
                                        <ItemTemplate>
                                            <tr class="tr">
                                                <td>
                                                    <p>
                                                        <img src="images/hotel/set_logo.png" height="25" />
                                                    </p>
                                                </td>
                                                <td>
                                                    <p><%#Eval("roomType") %></p>
                                                </td>
                                                <td>
                                                    <p>￥<%#Eval("price") %></p>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <asp:Repeater runat="server" ID="rptListRmtpLR">
                                        <ItemTemplate>
                                            <tr class="tr">
                                                <td>
                                                    <p>
                                                        <img src="images/hotel/lateroom.png" height="25" />LateRooms
                                                    </p>
                                                </td>
                                                <td>
                                                    <p><%#Eval("roomType") %></p>
                                                </td>
                                                <td>
                                                    <p>￥<%#Eval("price") %></p>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </table>
                            </div>
                        </div>
                        <div class="Operation">
                            <label>
                                <input type="checkbox" name="chkInput" value="<%#Eval("id")%>" id="a<%#Eval("id") %>" onclick="dblist('<%#Eval("id") %>',event)" />加入对比</label>
                            <p><span class="icon-contrast-btn" onclick="comparepro(this)">开始对比</span></p>
                            <div class="bottom">
                                <p class="col_11">NT$ <%#WebUI.GetHotelRmtpMinDN(Eval("DN_ProdNo"))%>起</p>
                                <a href="hotel_parity_detail.aspx?cid=<%#Eval("cid") %>">
                                    <p class="col_22">查看更多>></p>
                                </a>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <div id="PageContent" runat="server" class="page-class"></div>
        </div>
    </div>
    <div class="H20"></div>
    <uc1:footer runat="server" ID="footer" />
        <script>
            //按钮页面跳转
            function onBtnclick(_this) {
                var url = "hotel_parity_list.aspx?keywords=" + $("#txtKeywords").val();
                location.href = url;
            }
    </script>
</body>
</html>


