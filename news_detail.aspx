<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="news_detail.aspx.cs" Inherits="HT.Web.news_detail" %>

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
        <div class="page-loct"><a href="index.aspx">首页</a> > <a href="news.aspx">最夯新闻</a> > <span><%=model.title %></span> </div>
    </div>
    <div class="container main">
        <div class="page-left MR20">
            <div class="page-bg">
                <div class="H10"></div>
                <div class="news1-detail-title">
                    <%=model.title %>
                </div>
                <div class="news1-detail-title2">
                    <ul>
                        <li>资料来源：<%=model.source %></li>
                        <li>发布时间：<%=string.Format("{0:yyyy-MM-dd}",model.add_time)%></li>
                        <li>
                            <div class="Share-span">
                                <span class="Zambia MR8" onclick="zan_add(this,'<%=model.id %>','<%=(int)HTEnums.DataFKType.Article %>')"><i></i>赞（<%=WebUI.GetZanCount(model.id,(int)HTEnums.DataFKType.Article)%>）</span>
                                <a href="news_detail.aspx?cid=<%=model.cid %>#detail-comment">
                                    <span class="comment MR8"><i></i>评论（<%=WebUI.GetCommentCount(model.id,(int)HTEnums.DataFKType.Article)%>）</span></a>
                                <span class="collection MR8" onclick="user_collect_add(this,'<%=model.id %>','<%=(int)HTEnums.DataFKType.Article %>')"><i></i>收藏（<%=WebUI.GetCollectCount(model.id,(int)HTEnums.DataFKType.Article)%>）</span>
                                 <span class="Share MR8"><i></i>分享<div class="bshare-custom pos"><div class="bsPromo bsPromo2"></div><a title="更多平台" class="bshare-more bshare-more-icon more-style-addthis"></a></div></span>
                                <script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/buttonLite.js#style=-1&amp;uuid=&amp;pophcol=2&amp;lang=zh"></script><script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/bshareC0.js"></script>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="H20"></div>
                <div class="news1-detail-content">
                    <%=Utils.Htmls(model.content) %>
                </div>
                <div class="news1-detail-pre-next">
                    <dl>
                        <dt><span></span>上一篇：<%=Previous() %></dt>
                        <dd><span></span>下一篇：<%=Next() %></dd>
                    </dl>
                </div>
                <div class="H10"></div>
            </div>
            <div class="H20"></div>
            <div class="news2-detail-comment" id="detail-comment">
                <div class="news2-detail-comment-title">评论（<%=WebUI.GetCommentCount(model.id,(int)HTEnums.DataFKType.Article)%>）</div>
                <form action="#" id="formCmt" url="/tools/submit_ajax.ashx?action=user_comment_add">
                    <div class="news2-detail-comment-form">
                        <textarea name="txtContent" cols="30" rows="10" placeholder="填写评论内容..." datatype="*1-5000" nullmsg="请输入评论内容" sucmsg=" "></textarea>
                        <span id="msgtipCmt" class="msgtip"></span>
                        <input type="hidden" name="fk_id" value="<%=model.id %>" />
                        <input type="hidden" name="fk_type" value="<%=(int)HTEnums.DataFKType.Article %>" />
                        <input type="hidden" name="parent_id" value="0" />
                        <button type="submit" id="btnSubmitCmt" class="btn">发表评论</button>
                    </div>
                </form>
                <div class="comment-bot-list" id="comment00">
                    <div id="pagination" class="flickr paging"></div>
                </div>
            </div>
        </div>
        <div class="page-right">
            <div class="page-bg">
                <div class="popular-search-title">
                    <span>你赞得这篇文章</span>
                </div>
                <div class="news2-detail-zan">
                    <ul>
                        <li>
                            <span class="icon-collectin-btn" onclick="user_collect_add(this,'<%=model.id %>','<%=(int)HTEnums.DataFKType.Article %>')"></span>
                            <p>收藏一个</p>
                        </li>
                        <li style="visibility:hidden">
                            <span class="icon-share-btn"></span>
                            <p>分享一个</p>
                        </li>
                        <li>
                            <span class="icon-zan-btn" onclick="zan_add(this,'<%=model.id %>','<%=(int)HTEnums.DataFKType.Article %>')"></span>
                            <p>点赞一个</p>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="H20"></div>
            <div class="page-bg">
                <div class="popular-search-title">
                    <span>相关推荐</span>
                </div>
                <div class="H10"></div>
                <div class="popular-search-list">
                    <ul>
                        <asp:Repeater runat="server" ID="rptListXgtj">
                            <ItemTemplate>
                                <li><a href="news_detail.aspx?cid=<%#Eval("cid") %>">• <%#Eval("title") %> 
                                    <em><%#string.Format("{0:yyyy-MM-dd}",Eval("add_time"))%></em></a></li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
                <div class="H10"></div>
            </div>
            <div class="H20"></div>
            <div class="page-bg">
                <div class="popular-search-title">
                    <span>热门攻略推荐</span>
                </div>
                <div class="news2-detail-raiders">
                    <ul>
                        <asp:Repeater runat="server" ID="rptHotLygl">
                            <ItemTemplate>
                                <li class="H87">
                                    <a href="travel_strategy_detail.aspx?cid=<%#Eval("cid") %>">
                                        <label style="cursor: pointer">
                                            <img src="<%#Eval("img_url") %>" alt=""></label>
                                        <p class="title"><%#Eval("title") %></p>
                                        <p class="time">更新日期：<%#string.Format("{0:yyyy-MM-dd}",Eval("add_time"))%></p>
                                    </a>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
            <div class="H20"></div>
            <div class="page-bg">
                <div class="popular-search-title">
                    <span>热门达人精选</span>
                </div>
                <div class="news2-detail-raiders">
                    <ul>
                        <asp:Repeater runat="server" ID="rptHotDrjx">
                            <ItemTemplate>
                                <li class="H65">
                                    <a href="drjx_detail.aspx?cid=<%#Eval("cid") %>">
                                        <label style="cursor: pointer">
                                            <img src="<%#Eval("img_url") %>" alt=""></label>
                                        <p class="title"><%#Eval("title") %></p>
                                        <p class="time">更新日期：<%#string.Format("{0:yyyy-MM-dd}",Eval("add_time"))%></p>
                                    </a>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="H20"></div>
    <uc1:footer runat="server" ID="footer" />
    <script type="text/javascript">
        $(function () {
            AjaxInitForm('formCmt', 'btnSubmitCmt', 'msgtipCmt');
            AjaxPageList('#comment00', '#pagination', 10, '<%=WebUI.GetCommentCount(model.id,(int)HTEnums.DataFKType.Article)%>', '/tools/submit_ajax.ashx?action=user_comment_list', '<%=model.id%>', '<%=(int)HTEnums.DataFKType.Article %>');
        })
    </script>
</body>
</html>

