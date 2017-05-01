<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="travel_strategy_detail.aspx.cs" Inherits="HT.Web.travel_strategy_detail" %>

<%@ Register Src="~/ucl/footer.ascx" TagPrefix="uc1" TagName="footer" %>
<%@ Register Src="~/ucl/header.ascx" TagPrefix="uc1" TagName="header" %>
<%@ Register Src="~/ucl/links.ascx" TagPrefix="uc1" TagName="links" %>

<%@ Import Namespace="HT.Common" %>
<%@ Import Namespace="HT.Web.UI" %>

<!DOCTYPE html>
<html lang="zh">
<head>
    <title><%=model.title %></title>
    <meta name="keywords" content="<%=HT.Web.UI.WebUI.config.webkeyword %>">
  <meta name="description" content="<%=HT.Web.UI.WebUI.config.webdescription %>">
    <uc1:links runat="server" ID="links" />
</head>
<body>
    <uc1:header runat="server" ID="header" />
    <div class="container">
        <div class="page-loct"><a href="index.aspx">首页</a> > <a href="travel_strategy_list.aspx">旅游攻略</a> > <span><%=model.title %></span> </div>
    </div>
    <div class="container main">
        <div class="page-left MR20">
            <div class="page-bg">
                <div class="up-people-detail-title">
                    <label><%=model.title %></label>
                    <div class="H10"></div>
                    <div class="Share-box">
                        <div class="Share-span">
                            <span class="Zambia MR8" onclick="zan_add(this,'<%=model.id %>','<%=(int)HTEnums.DataFKType.Article%>')"><i></i>赞（<%=WebUI.GetZanCount(model.id,(int)HTEnums.DataFKType.Article)%>）</span>
                             <a href="travel_strategy_detail.aspx?cid=<%=model.cid %>#detail-content2"><span class="comment MR8"><i></i>评论（<%=WebUI.GetCommentCount(model.id,(int)HTEnums.DataFKType.Article)%>）</span></a>
                            <span class="collection MR8" onclick="user_collect_add(this,'<%=model.id %>','<%=(int)HTEnums.DataFKType.Article%>')"><i></i>收藏（<%=WebUI.GetCollectCount(model.id,(int)HTEnums.DataFKType.Article)%>）</span>
                             <span class="Share MR8"><i></i>分享<div class="bshare-custom pos"><div class="bsPromo bsPromo2"></div><a title="更多平台" class="bshare-more bshare-more-icon more-style-addthis"></a></div></span>
                                <script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/buttonLite.js#style=-1&amp;uuid=&amp;pophcol=2&amp;lang=zh"></script><script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/bshareC0.js"></script>
                        </div>
                    </div>
                </div>
                <div class="up-people-detail-author">
                    <img src="<%=WebUI.GetUserAvatar(model.user_id) %>" alt="" class="img">
                    发布者：<%=model.user_name==""?"匿名":model.user_name %>
                    <span class="time">发布日期：<%=string.Format("{0:yyyy-MM-dd}",model.add_time)%></span>
                </div>
                <div class="H20"></div>
            </div>
            <div class="tab-box">
                <div class="news1-detail-content travelstext" id="detail-content1" style="background:#FFF; padding:10px 20px">
                    <%=model.content %>
                </div>
                <div class="H20"></div>
                <div class="standard-content" id="detail-content2">
                    <div class="news2-detail-comment">
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

            <div class="H20"></div>
            <div class="page-div-title">
                <span>看了这篇攻略的人也看了</span>
            </div>
            <div class="travel-strategy-box W880">
                <ul>
                    <asp:Repeater runat="server" ID="rptListHistory">
                        <ItemTemplate>
                        <li>
                            <div class="item">
                                <a href="travel_strategy_detail.aspx?cid=<%#Eval("cid") %>">
                                    <img src="<%#Eval("img_url") %>" alt=""></a>
                                <p class="title"><a href="travel_strategy_detail.aspx?cid=<%#Eval("cid") %>"><%#Eval("title")%></a></p>
                                <div class="zan">
                                    <div class="Share-span">
                                        <span class="Zambia MR8" onclick="zan_add(this,'<%=model.id %>','<%=(int)HTEnums.DataFKType.Article %>')"><i></i>赞（<%=WebUI.GetZanCount(model.id,(int)HTEnums.DataFKType.Article)%>）</span>
                                        <span class="Browse right"><i></i>浏览（<%#Eval("click") %>）</span>
                                    </div>
                                </div>
                            </div>
                            <div class="time">
                                更新时间：<%#string.Format("{0:yyyy-MM-dd}",Eval("add_time"))%>
                            </div>
                        </li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>

        </div>
        <div class="page-right">
            <div class="page-bg">
                <div class="scenic-spots-title">
                    <span>热门住宿推荐</span>
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
                <div class="popular-search-title">
                    <span>热门行程推荐</span>
                </div>
                <div class="news2-detail-raiders">
                    <ul>
                        <asp:Repeater runat="server" ID="rptListXctj">
                            <ItemTemplate>
                            <li class="H87">
                                <a href="travel_detail.aspx?id=<%#Eval("id") %>">
                                    <label><img src="<%#Eval("img_url") %>" alt=""></label>
                                    <p class="title2"><%#Eval("title") %></p>
                                    <p class="time">发布者：<%#Eval("user_name") %></p>
                                    <p class="time2">行程日期：<%#string.Format("{0:yyyy-MM-dd}",Eval("begin_date"))%>- <%#string.Format("{0:yyyy-MM-dd}",Eval("end_date"))%></p>
                                </a>
                            </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <uc1:footer runat="server" ID="footer" />
        
    <script type="text/javascript">
        $(function () {
            //$('.travelstext img').attr("data-original", $(this).attr("src"));
            //$('.travelstext img').attr("src", 'http://test.cucfilm.com/sys/images/noPic.gif');
            //$('.travelstext img[data-original]').lazyload({ maxwidth: 982, errorsrc: 'http://test.cucfilm.com/sys/images/noPic.gif' });
            AjaxInitForm('formCmt', 'btnSubmitCmt', 'msgtipCmt');
            AjaxPageList('#comment00', '#pagination', 10, '<%=WebUI.GetCommentCount(model.id,(int)HTEnums.DataFKType.Article)%>', '/tools/submit_ajax.ashx?action=user_comment_list', '<%=model.id%>', '<%=(int)HTEnums.DataFKType.Article %>');
        })
    </script>
</body>
</html>




