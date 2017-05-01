<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="xqxz_detail.aspx.cs" Inherits="HT.Web.xqxz_detail" %>

<%@ Register Src="~/ucl/footer.ascx" TagPrefix="uc1" TagName="footer" %>
<%@ Register Src="~/ucl/header.ascx" TagPrefix="uc1" TagName="header" %>
<%@ Register Src="~/ucl/links.ascx" TagPrefix="uc1" TagName="links" %>

<%@ Import Namespace="HT.Common" %>
<%@ Import Namespace="HT.Web.UI" %>

<!DOCTYPE html>
<html lang="zh">
<head>
    <title><%=model.title %></title>
    <meta name="keywords" content="<%=model.seo_keywords+""==""? HT.Web.UI.WebUI.config.webkeyword : model.seo_keywords %>">
    <meta name="description" content="<%=model.seo_description+""==""? HT.Web.UI.WebUI.config.webdescription : model.seo_description %>">
    <uc1:links runat="server" ID="links" />
</head>
<body>
    <uc1:header runat="server" ID="header" />
    <div class="container">
        <div class="page-loct"><a href="index.aspx">首页</a> > <a href="xqxz.aspx">行前须知</a> > <span><%=new HT.BLL.article_category().GetTitle(model.category_id)%></span> </div>
    </div>
    <div class="container">
        <div class="wrapper">
            <div class="left_page">
                <div class="left_center">
                    <h2>行前须知</h2>
                    <ul>
                        <asp:Repeater runat="server" ID="rptListCategory">
                            <ItemTemplate>
                                <li <%#model.category_id==Utils.ObjToInt(Eval("id"))?"class=\"current\"":"" %>>
                                    <a href="xqxz.aspx?category_id=<%#Eval("id") %>"><%#Eval("title") %></a></li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
            <div class="right_page">
                <div class="page_title">
                    <h1><%=new HT.BLL.article_category().GetTitle(model.category_id)%></h1>
                </div>
                <div class="product_page">
                    <div class="pro_center">
                        <h3><%=model.title %></h3>
                        <div class="pro_title">
                            <div class="pro_ti">
                                <ul>
                                    <li class="pro_width">资料来源：<%=model.source %></li>
                                    <li class="pro_width">发布时间：<%=string.Format("{0:yyyy-MM-dd}",model.add_time)%></li>
                                    <li>
                                        <img src="images/img/llan.png" />&nbsp;&nbsp;浏览(<%=model.click %>)</li>
                                    <li>
                                        <img src="images/img/wxin.png" onclick="user_collect_add(this,'<%=model.id %>','<%=(int)HTEnums.DataFKType.Article %>')" />&nbsp;&nbsp;收藏(<%=WebUI.GetCollectCount(model.id,(int)HTEnums.DataFKType.Article)%>)</li>
                                    <li>
                                        <img src="images/img/fex.png" />&nbsp;&nbsp;分享
                                        <div class="bshare-custom pos">
                                            <div class="bsPromo bsPromo2"></div>
                                            <a title="更多平台" class="bshare-more bshare-more-icon more-style-addthis"></a></div>
                                        <script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/buttonLite.js#style=-1&amp;uuid=&amp;pophcol=2&amp;lang=zh"></script>
                                        <script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/bshareC0.js"></script>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="pro_page">
                        <%=model.content %>
                    </div>
                    <div class="H10"></div>
                    <div class="pro_footer">
                        <span class="pro_left">
                            <img src="images/img/picc09.png" />&nbsp;上一篇：
                            <%=Previous() %></span>
                        <span class="pro_right">下一篇：<%=Next() %>
                            &nbsp;<img src="images/img/picc10.png" /></span>
                    </div>
                </div>
                <div class="H30"></div>
            </div>
        </div>
        <div class="clear"></div>
    </div>

    <div class="H20"></div>
    <uc1:footer runat="server" ID="footer" />
</body>
</html>

