<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="tourism_detail.aspx.cs" Inherits="HT.Web.tourism_detail" %>

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
        <div class="page-loct"><a href="index.aspx">首页</a> > <a href="tourism_list.aspx">旅遊攻略</a> > <span><%=model.title %></span> </div>
    </div>
    <div class="container main">
        <div class="page-left MR20">
            <div class="page-bg tab-box">
                <div class="video_detail1">
                    <div class="video_detail1_1">
                        <span><%=model.title %></span>
                        <div class="zan">
                            <span onclick="zan_add(this,'<%=model.id %>','<%=(int)HTEnums.DataFKType.Article%>')">
                                <img src="images/zyxc/zan.png" />赞（<%=WebUI.GetZanCount(model.id,(int)HTEnums.DataFKType.Article)%>）</span>
                            <a href="tourism_detail.aspx?cid=<%=model.cid %>#detail-comment">
                                <span>
                                    <img src="images/zyxc/pinglun.png" />评论（<%=WebUI.GetCommentCount(model.id,(int)HTEnums.DataFKType.Article)%>） </span></a>
                            <span onclick="user_collect_add(this,'<%=model.id %>','<%=(int)HTEnums.DataFKType.Article%>')">
                                <img src="images/zyxc/shoucang.png" />收藏（<%=WebUI.GetCollectCount(model.id,(int)HTEnums.DataFKType.Article)%>）</span>
                            <span>
                                <img src="images/zyxc/fenxiang.png" />分享
                                <div class="bshare-custom pos">
                                    <div class="bsPromo bsPromo2"></div>
                                    <a title="更多平台" class="bshare-more bshare-more-icon more-style-addthis"></a></div>
                            </span>
                            <script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/buttonLite.js#style=-1&amp;uuid=&amp;pophcol=2&amp;lang=zh"></script>
                            <script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/bshareC0.js"></script>
                        </div>
                    </div>
                    <div class="video_detail1_2">
                        <span>
                            <img src="<%=WebUI.GetUserAvatar(model.user_id) %>" width="30" />发布者：<%=model.user_name==""?"匿名":model.user_name %></span>
                        <div class="pinglun">
                            发布日期：<%=string.Format("{0:yyyy-MM-dd}",model.add_time)%>
                        </div>
                    </div>
                </div>
                <div class="H20"></div>
                <div class="page-tab-title title location-title">
                    <ul>
                        <li class="active"><a href="#detail-content1">内容详情</a></li>
                        <li><a href="#detail-content2">用户评论</a></li>
                    </ul>
                </div>
                <div class="H10"></div>
                <div id="detail-content1">
                    <div class="news1-detail-content">
                        <%=model.content %>
                    </div>
                    <div class="news1-detail-pre-next">
                        <dl>
                            <dt><span></span>上一篇：<%=Previous() %></dt>
                            <dd>下一篇：<%=Next() %>&nbsp;<span></span></dd>
                        </dl>
                    </div>
                </div>
                <div class="H20"></div>
                <div id="detail-content2">
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
            </div>
        </div>
        <div class="page-right">
            <div class="H20"></div>
            <div class="page-bg">
                <div class="scenic-spots-title">
                    <span>热门酒店推荐</span>
                </div>
                <div class="scenic-spots-recommend content">
                    <ul>
                        <asp:Repeater runat="server" ID="rptListTJHotel">
                            <ItemTemplate>
                                <li>
                                    <a href="hotel_parity_detail.aspx?cid=<%#Eval("cid")%>">
                                        <img src="<%#Eval("img_url") %>" alt="">
                                        <p class="title"><%#Eval("title") %></p>
                                        <p class="dj"><span class="score"><%#WebUI.GetStarLevel(Eval("star_level"))%></span></p>
                                        <p class="dp"><%#WebUI.GetCommentCount(Eval("id"),(int)HTEnums.DataFKType.Hotel)%>人点评</p>
                                    </a>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
                <div class="H20"></div>
            </div>
            <div class="H20"></div>
            <div class="page-bg">
                <div class="scenic-spots-title">
                    <span>热门饮食推荐</span>
                </div>
                <div class="scenic-spots-recommend content">
                    <ul>
                        <asp:Repeater runat="server" ID="rptListTJShop">
                            <ItemTemplate>
                                <li>
                                    <a href="foodshop_detail.aspx?cid=<%#Eval("cid")%>">
                                        <img src="<%#Eval("img_url") %>" alt="">
                                        <p class="title"><%#Eval("title") %></p>
                                        <p class="dj"><span class="score"><%#WebUI.GetStarLevel(Eval("star_level"))%></span></p>
                                        <p class="dp"><%#WebUI.GetCommentCount(Eval("id"),(int)HTEnums.DataFKType.Shop)%>人点评</p>
                                    </a>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
                <div class="H20"></div>
            </div>
            <div class="H20"></div>
            <div class="page-bg">
                <div class="scenic-spots-title">
                    <span>热门景点推荐</span>
                </div>
                <div class="scenic-spots-recommend content">
                    <ul>
                        <asp:Repeater runat="server" ID="rptHotJD">
                            <ItemTemplate>
                                <li>
                                    <a href="scenery_spot_detail.aspx?cid=<%#Eval("cid")%>">
                                        <img src="<%#Eval("img_url") %>" alt="">
                                        <p class="title"><%#Eval("title") %></p>
                                        <p class="dj"><span class="score"><%#WebUI.GetStarLevel(Eval("star_level"))%></span></p>
                                        <p class="dp"><%#WebUI.GetCommentCount(Eval("id"),(int)HTEnums.DataFKType.Scenery)%>人点评</p>
                                    </a>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
                <div class="H20"></div>
            </div>
        </div>
    </div>
    <div class="H20"></div>
    <uc1:footer runat="server" ID="footer" />
    <script type="text/javascript">
        $(function () {
            AjaxInitForm('formCmt', 'btnSubmitCmt', 'msgtipCmt');
            AjaxPageList('#comment00', '#pagination', 10, '<%=WebUI.GetCommentCount(model.id,(int)HTEnums.DataFKType.Article)%>', '/tools/submit_ajax.ashx?action=user_comment_list', '<%=model.id%>', '<%=(int)HTEnums.DataFKType.Article%>');
        })
    </script>
</body>
</html>
