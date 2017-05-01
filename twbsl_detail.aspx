<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="twbsl_detail.aspx.cs" Inherits="HT.Web.twbsl_detail" %>

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
        <div class="page-loct"><a href="index.aspx">首页</a> > <a href="twbsl.aspx">台湾伴手礼</a> > <span><%=model.title %></span> </div>
    </div>
    <div class="container main">
        <div class="page-bg">
            <div class="twbsl-detail-slide service-slide-main">
                <div class="twbsl-detail-slide-img slide-img">
                    <img src="<%=model.img_url %>" alt="">
                </div>
                <div class="twbsl-detail-slide-item slide-item">
                    <ul>
                        <asp:Repeater ID="rptImg" runat="server">
                            <ItemTemplate>
                                <li>
                                    <img bimg="<%# Eval("original_path")%>" src="<%#Eval("thumb_path")%>" alt="<%# Eval("remark")%>" />
                                    <div class="opacity"></div>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
            <div class="twbsl-detail-introduct">
                <div class="twbsl-detail-introduct-top">
                    <%=model.title %>
                    <span>商品浏览：<%=model.click %></span>
                </div>
                <div class="twbsl-detail-introduct-text">
                    <p><%=model.zhaiyao %></p>
                </div>
                <div class="Share-box">
                    <div class="Share-span">
                        <span class="collection MR8"><i onclick="user_collect_add(this,'<%=model.id %>','<%=(int)HTEnums.DataFKType.Goods %>')"></i>收藏（<%=WebUI.GetCollectCount(model.id,(int)HTEnums.DataFKType.Goods)%>）</span>
                        <span class="Share MR8"><i></i>分享<div class="bshare-custom pos">
                            <div class="bsPromo bsPromo2"></div>
                            <a title="更多平台" class="bshare-more bshare-more-icon more-style-addthis"></a></div>
                        </span>
                        <script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/buttonLite.js#style=-1&amp;uuid=&amp;pophcol=2&amp;lang=zh"></script>
                        <script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/bshareC0.js"></script>
                    </div>
                </div>
                <div class="twbsl-detail-introduct-from">
                    <div class="item">
                        <label>取货地点：</label><%=model.place %>
                    </div>
                    <div class="item">
                        <label for="">预订数量：</label>
                        <div class="deta-number">
                            <a href="javascript:void(0)" ht-click="minus" class="deta-number-click">-</a>
                            <input type="text" ht-input="number" data-min="1" data-max="999" class="deta-number-input" value="1">
                            <a href="javascript:void(0)" ht-click="plus" class="deta-number-click">+</a>
                        </div>
                    </div>
                </div>
                <div class="twbsl-detail-introduct-price">
                    <span>¥<%=model.sell_price %>元</span>
                    <em>¥<%=model.market_price %>元</em>
                </div>
                <div class="twbsl-detail-introduct-btn">
                    <a href="###" class="icon-reserve-btn" ht-click="show" data-target="#twbsl-box">立即预定</a>
                    <a target="_blank" href="<%=model.link_url %>" class="icon-login-btn">立即购买</a>
                </div>
            </div>
        </div>
    </div>
    <div class="H20"></div>
    <div class="container main">
        <div class="page-left MR20">
            <div class="page-bg PD00 tab-box">
                <div class="page-tab-title title location-title">
                    <ul>
                        <li class="active"><a href="#detail-content1">产品详情</a></li>
                        <li><a href="#detail-content2">产品评论</a></li>
                    </ul>
                </div>
                <div class="twbsl-detail-img" id="detail-content1">
                    <%=model.content %>
                </div>
                <div class="standard-content " id="detail-content2">
                    <div class="news2-detail-comment">
                        <div class="news2-detail-comment-title">评论（<%=WebUI.GetCommentCount(model.id,(int)HTEnums.DataFKType.Goods)%>）</div>
                        <form action="#" id="formCmt" url="/tools/submit_ajax.ashx?action=user_comment_add">
                            <div class="news2-detail-comment-form">
                                <textarea name="txtContent" cols="30" rows="10" placeholder="填写评论内容..." datatype="*1-5000" nullmsg="请输入评论内容" sucmsg=" "></textarea>
                                <span id="msgtipCmt" class="msgtip"></span>
                                <input type="hidden" name="fk_id" value="<%=model.id %>" />
                                <input type="hidden" name="fk_type" value="<%=(int)HTEnums.DataFKType.Goods %>" />
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
            <div class="page-bg PD00">
                <div class="twbsl-detail-sarvice">
                    <h1>商品服务说明</h1>
                    <p>台湾行伴手礼商城采用预约制，您可以在线提交预约申请，然后到商家处体验或购买。</p>
                    <h2>客服电话：8888888</h2>
                </div>
            </div>
            <div class="H20"></div>
            <div class="page-bg">
                <div class="twbsl-detail-title">看过此商品的人还看过</div>
                <div class="twbsl-detail-history">
                    <ul>
                        <asp:Repeater runat="server" ID="rptListLike">
                            <ItemTemplate>
                                <li>
                                    <a href="twbsl_detail.aspx?cid=<%#Eval("cid") %>">
                                        <img src="<%#Eval("img_url") %>" alt="" class="img">
                                        <p class="title"><%#Eval("title") %></p>
                                        <p class="title2"><%#Eval("zhaiyao") %></p>
                                        <p class="price">¥<%#Eval("sell_price") %></p>
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

    <div class="PopBox hide" id="twbsl-box">
        <div class="Pop_upBox_bg"></div>
        <div class="Pop_upBox H330">
            <div class="pop_content">
                <div class="PopBox_title">立即预定</div>
                <div class="content PD20">
                    <form action="#" id="form1" url="/tools/submit_ajax.ashx?action=user_goods_reserve">
                        <div class="twbsl-shodaw-item">
                            <label class="col_1">姓名：</label>
                            <input type="text" class="k W268" name="txtName" placeholder="请输入姓名" datatype="*1-20" nullmsg="请输入姓名" sucmsg=" " />
                        </div>
                        <div class="twbsl-shodaw-item">
                            <label class="col_1">手机：</label>
                            <input type="text" class="k W268" name="txtMobile" placeholder="请输入手机号" datatype="m" nullmsg="请输入手机号" sucmsg=" " />
                        </div>
                        <div class="twbsl-shodaw-item">
                            <label class="col_1">QQ：</label>
                            <input type="text" class="k W268" name="txtQQ" placeholder="请输入QQ号" datatype="n5-15" nullmsg="请输入QQ号" sucmsg=" " />
                        </div>
                        <span id="msgtip" class="msgtip"></span>
                        <div class="twbsl-shodaw-btn">
                            <input type="hidden" name="hdMainId" value="<%=model.id %>" />
                            <input type="hidden" id="hdQuantity" name="hdQuantity" value="1" />
                            <button type="submit" class="icon-submit-btn btn" id="btnSubmit">确认</button>
                            <button type="button" class="icon-cancel-btn btn" ht-click="hide" data-target="#twbsl-box">取消</button>
                        </div>
                    </form>
                </div>
                <div class="close" ht-click="hide" data-target="#twbsl-box">
                    <img src="/images/e/close.png" alt="" />
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            $(".icon-reserve-btn").click(function () {
                $("#hdQuantity").val($(".deta-number-input").val());
            })
            AjaxInitForm('form1', 'btnSubmit', 'msgtip');
            AjaxInitForm('formCmt', 'btnSubmitCmt', 'msgtipCmt');
            AjaxPageList('#comment00', '#pagination', 10, '<%=WebUI.GetCommentCount(model.id,(int)HTEnums.DataFKType.Goods)%>', '/tools/submit_ajax.ashx?action=user_comment_list', '<%=model.id%>', '<%=(int)HTEnums.DataFKType.Goods%>');
        })
    </script>
</body>
</html>
