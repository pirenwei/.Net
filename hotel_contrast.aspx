<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="hotel_contrast.aspx.cs" Inherits="HT.Web.hotel_contrast" %>

<%@ Register Src="~/ucl/footer.ascx" TagPrefix="uc1" TagName="footer" %>
<%@ Register Src="~/ucl/header.ascx" TagPrefix="uc1" TagName="header" %>
<%@ Register Src="~/ucl/links.ascx" TagPrefix="uc1" TagName="links" %>

<%@ Import namespace="HT.Common" %>
<%@ Import namespace="HT.Web.UI" %>

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
        <div class="page-loct"><a href="/index.aspx">首页</a> > <a href="hotel_parity_list.aspx">住在台湾</a> > <span>住宿比价</span> </div>
    </div>
    <div class="container main">
        <div class="page-bg PD00">
            <div class="contrast-box">
                <div class="contrast-content">
                    <div class="contrast-item col_11">
                        <div class="top">
                            <div class="share"><em>分享</em><i></i><div class="bshare-custom pos"><div class="bsPromo bsPromo2"></div><a title="更多平台" class="bshare-more bshare-more-icon more-style-addthis"></a></div></div>
                            <script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/buttonLite.js#style=-1&amp;uuid=&amp;pophcol=2&amp;lang=zh"></script><script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/bshareC0.js"></script>
                        </div>
                        <div class="price PD14">
                            <div class="H12"></div>
                            <p class="title">价格</p>
                            <p class="time">时间：<input type="text" style="width:80px;" id="dateValue" value="<%=dateValue.ToString("yyyy-MM-dd") %>" onclick="laydate()"/><input type="button" style=" margin-left:20px;" value="确定" id="pickDate" /></p>
                            <p class="col_11"><%=dateValue.ToString("yyyy-MM-dd") %>入住</p>
                            <p class="col_22"><%=dateValue.AddDays(1).ToString("yyyy-MM-dd") %>退房</p>
                        </div>
                        <div class="Facilities">
                            <div class="H10"></div>
                            <p class="title">9项顶级设施</p>
                            <p class="state"><i></i>不可用设施</p>
                            <p class="state"><i class="active"></i>可用设施</p>
                        </div>
                        <div class="information">
                            <div class="H10"></div>
                            <h1 class="title">酒店信息</h1>
                            <div class="information-address">
                                <label for="">地址</label>
                            </div>
                            <div class="information-contact">
                                <label for="">电话</label>
                            </div>
                            <div class="information-destription">
                                <label for="">描述</label>
                            </div>
                        </div>
                        <div class="room-number">
                            <h1>房间数量</h1>
                        </div>
                    </div>
                    <asp:Repeater runat="server" ID="rptList">
                        <ItemTemplate>
                            <div class="contrast-item col_<%#rptList.Items.Count+2 %><%#rptList.Items.Count+2 %>">
                                <div class="top">
                                    <a href="hotel_parity_detail.aspx?cid=<%#Eval("cid") %>">
                                    <p class="title" style="overflow:hidden"><%#Eval("title") %></p>
                                    <p class="dj"><span>星级：</span><span class="span-grade grade"><%#WebUI.GetStarLevel(Utils.ObjToInt(Eval("star_level")))%></span></p>
                                    <p class="img"><img src="<%#Eval("img_url") %>" alt=""></p>
                                    </a>
                                </div>
                                <div class="price PD3" style="overflow:auto">
                                    <div class="H12"></div>
                                    <%#GetHotelRmtp(Eval("DN_ProdNo"))%>
                                </div>
                                <div class="Facilities">
                                    <div class="H10"></div>
                                    <ul class="Facilities-ul">
                                        <li>
                                            <em class="col_11 <%#GetServerDesc(Eval("DN_ProdNo"),"上網")%>"></em>
                                            <p>无线网络</p>
                                        </li>
                                        <li>
                                            <em class="col_22 <%#GetServerDesc(Eval("DN_ProdNo"),"停車")%>"></em>
                                            <p>停车场</p>
                                        </li>
                                        <li>
                                            <em class="col_33 <%#GetServerDesc(Eval("DN_ProdNo"),"電視")%>"></em>
                                            <p>电视</p>
                                        </li>
                                        <li>
                                            <em class="col_44 <%#GetServerDesc(Eval("DN_ProdNo"),"空調")%>"></em>
                                            <p>冷气</p>
                                        </li>
                                        <li>
                                            <em class="col_55 <%#GetServerDesc(Eval("DN_ProdNo"),"陽台")%>"></em>
                                            <p>阳台</p>
                                        </li>
                                        <li>
                                            <em class="col_66 <%#GetServerDesc(Eval("DN_ProdNo"),"游泳池")%>"></em>
                                            <p>游泳池</p>
                                        </li>
                                        <li>
                                            <em class="col_77 <%#GetServerDesc(Eval("DN_ProdNo"),"水療")%>"></em>
                                            <p>水疗</p>
                                        </li>
                                        <li>
                                            <em class="col_88 <%#GetServerDesc(Eval("DN_ProdNo"),"餐廳")%>"></em>
                                            <p>酒吧</p>
                                        </li>
                                        <li>
                                            <em class="col_99 <%#GetServerDesc(Eval("DN_ProdNo"),"保險")%>"></em>
                                            <p>保险箱</p>
                                        </li>
                                    </ul>
                                </div>
                                <div class="information">
                                    <div class="H5"></div>
                                    <div class="H30"></div>
                                    <div class="information-address">
                                        <p><%#Eval("address") %></p>
                                    </div>
                                    <div class="information-contact">
                                       
                                        <p><br /><%#Eval("telphone") %></p>
                                    </div>
                                    <div class="information-destription">
                                        <p><%#Eval("zhaiyao") %></p>
                                    </div>
                                </div>
                                <div class="room-number">
                                    <p> <%#GetHotelRmtpCount(Eval("id"))%>间</p>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </div>
    <div class="H20"></div>
    <div class="H20"></div>
    <uc1:footer runat="server" ID="footer" />
    <script>
        $('#pickDate').click(function () {
            location.href = '/hotel_contrast.aspx?parm=<%=HTRequest.GetQueryString("parm")%>&dateValue=' + $('#dateValue').val();
        })
 
    </script>
</body>
</html>
