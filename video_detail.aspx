<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="video_detail.aspx.cs" Inherits="HT.Web.video_detail" %>

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
    <link href="./js/video-js.css" rel="stylesheet" type="text/css">
    <script src="./js/video.js"></script>
    <script>
        videojs.options.flash.swf = "./js/video-js.swf";
    </script>
</head>
<body>
    <uc1:header runat="server" ID="header" />
    <div class="container">
        <div class="page-loct"><a href="index.aspx">首页</a> > <a href="video_list.aspx?category_id=<%=model.category_id %>"><%=new HT.BLL.article_category().GetTitle(model.category_id) %></a> > <span><%=model.title %></span></div>
    </div>
    <div class="container main">
        <div class="page-left MR20">
            <div class="page-bg">
                <div class="video_detail1">
                    <div class="video_detail1_1">
                        <span><%=model.title %></span>
                        <div class="zan">
                            <span onclick="zan_add(this,'<%=model.id %>','<%=(int)HTEnums.DataFKType.Article%>')">
                                <img src="images/zyxc/zan.png" />赞（<%=WebUI.GetZanCount(model.id,(int)HTEnums.DataFKType.Article)%>）</span>
                            <a href="video_detail.aspx?cid=<%=model.cid%>#detail-comment"><span>
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
                            <img src="/images/niming.png" width="30" />发布者：<%=model.user_name==""?"匿名":model.user_name %></span>
                        <div class="pinglun">
                            发布日期：<%=string.Format("{0:yyyy-MM-dd}",model.add_time) %>
                        </div>
                    </div>
                    <%if(model.category_id==9){ %>
                    <div style="width:640px;margin:30px 0 0 0">
	                    <video id="example_video_1" class="video-js vjs-default-skin" controls preload="none" width="840" height="472" poster="oceans-clip.png" data-setup="{}">
		                    <source src="<%=model.video_src %>" type='video/mp4' />
		                    <source src="<%=model.video_src %>" type='video/webm' />
		                    <source src="<%=model.video_src %>" type='video/ogg' />
		                    <track kind="captions" src="demo.captions.vtt" srclang="en" label="English"></track><!-- Tracks need an ending tag thanks to IE9 -->
		                    <track kind="subtitles" src="demo.captions.vtt" srclang="en" label="English"></track><!-- Tracks need an ending tag thanks to IE9 -->
	                    </video>
                    </div><%} %>
                   <%-- <div class="video_detail1_3">
                        <!--网页flv,mp4视频播放器PlayerLite/代码开始-->
                        <script src="/scripts/52player/flowplayer-3.2.11.min.js" type="text/javascript"></script>
                        <div id="my52player" style="width: 840px; height: 472px;"></div>
                        <script>
                            flowplayer("my52player", "/scripts/52player/flowplayer-3.2.12.swf", { clip: { url: "<%=model.video_src %>", autoPlay: false, autoBuffering: true } });
                        </script>
                        <!--网页flv,mp4视频播放器PlayerLite/代码结束-->
                    </div>--%>
                    <%--<div class="video_detail1_4">
                        <div class="syp">
                            <img src="images/zyxc/syp.png" />上一篇：<%=Previous() %>
                        </div>
                        <div class="xyp">
                            <%=Next() %><img src="images/zyxc/xyp.png" />
                        </div>
                    </div>--%>
                   <%-- <embed src="<%=model.video_src %>" width="800" height="300"/>--%>
                </div>
            </div>
            <div class="H10"></div>
            <div class="video_detail1" style="background: #FFF; padding: 20px">
                <%if(model.category_id==9){ %> <p class="p7">视频介绍</p><%} %>
                <%=model.content %>
            </div>
            <div class="H10"></div>
            <div class="page-bg PD20">
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
        <div class="page-right">
            <div class="page-bg">
                <div class="popular-search-title">
                    <span>影音档案</span>
                </div>
                <div class="news2-detail-raiders">
                    <ul>
                        <asp:Repeater runat="server" ID="rptListXG">
                            <ItemTemplate>
                                <li class="H90">
                                    <label>
                                        <a href="video_detail.aspx?cid=<%#Eval("cid") %>">
                                            <img src="<%#Eval("img_url") %>" alt=""></a></label>
                                    <p class="title"><a href="video_detail.aspx?cid=<%#Eval("cid") %>"><%#Eval("title") %></a></p>
                                    <div class="H20"></div>
                                    <p class="time"><%#WebUI.GetCommentCount(Eval("id"),(int)HTEnums.DataFKType.Article)%>人点评</p>
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
            AjaxPageList('#comment00', '#pagination', 10, '<%=WebUI.GetCommentCount(model.id,(int)HTEnums.DataFKType.Article)%>', '/tools/submit_ajax.ashx?action=user_comment_list', '<%=model.id%>', '<%=(int)HTEnums.DataFKType.Article%>');
        })
    </script>
    <script type="text/javascript">
        var myPlayer = videojs('example_video_1');
        videojs("example_video_1").ready(function () {
            var myPlayer = this;
            myPlayer.play();
        });
</script>
</body>
</html>


