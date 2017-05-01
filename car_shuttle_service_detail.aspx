<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="car_shuttle_service_detail.aspx.cs" Inherits="HT.Web.car_shuttle_service_detail" %>

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
        <div class="page-loct"><a href="/index.aspx">首页</a> > <a href="car_shuttle_service.aspx">接送服务</a> > <span><%=model.title %></span> </div>
    </div>
    <div class="container main">
        <div class="page-bg PD20">
            <div class="charter-service-slide service-slide-main">
                <div class="charter-service-slide-img slide-img">
                    <img src="<%=model.img_url %>" alt="">
                </div>

                 <div class="pic_rolling3">
                    <div class="pic_content">
                          <ul>
                            <asp:Repeater runat="server" ID="rptImg">
                                <ItemTemplate>
                                    <li>
                                        <img src="<%#Eval("original_path") %>" alt="">
                                    </li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                    </div>
                </div>
                <%--<div class="charter-service-slide-item slide-item">
                    <ul>
                        <asp:Repeater runat="server" ID="rptImg">
                            <ItemTemplate>
                                <li>
                                    <img src="<%#Eval("original_path") %>" alt=""></li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>--%>
            </div>
            <div class="charter-service-introduct">
                <div class="charter-service-introduct-top">
                    <p class="title"><%=model.title %></p>
                    <p class="title2"><%=model.zhaiyao%></p>
                    <div class="Share">
                        <span class="price">
                            <em><%=model.sell_price %></em> 起/每人  <i>¥<%=model.market_price %></i>
                        </span>
                        <div class="Share-box">
                            <div class="Share-span">
                                <span class="Zambia MR8" onclick="zan_add(this,'<%=model.id %>','<%=(int)HTEnums.DataFKType.Car%>')"><i></i>赞（<%=WebUI.GetZanCount(model.id,(int)HTEnums.DataFKType.Car)%>）</span>
                                <a href="car_shuttle_service_detail.aspx?cid=<%=model.cid %>#detail-content2">
                                    <span class="comment MR8"><i></i>评论（<%=WebUI.GetCommentCount(model.id,(int)HTEnums.DataFKType.Car)%>）</span></a>
                                <span class="collection MR8" onclick="user_collect_add(this,'<%=model.id %>','<%=(int)HTEnums.DataFKType.Car%>')"><i></i>收藏（<%=WebUI.GetCollectCount(model.id,(int)HTEnums.DataFKType.Car)%>）</span>
                                <span class="Share MR8"><i></i>分享<div class="bshare-custom pos"><div class="bsPromo bsPromo2"></div><a title="更多平台" class="bshare-more bshare-more-icon more-style-addthis"></a></div></span>
                                <script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/buttonLite.js#style=-1&amp;uuid=&amp;pophcol=2&amp;lang=zh"></script><script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/bshareC0.js"></script>
                            </div>
                        </div>
                    </div>
                </div>
                <form action="#" id="form1" url="/tools/submit_ajax.ashx?action=user_carServer_reserve">
                    <div class="charter-service-form">
                        <div class="charter-service-form-item">
                            <label class="form-label">机场<span class="red">*</span>：</label>
                            <select class="dropdown" name="airport">
                                <option value="台湾桃园国际机场">台湾桃园国际机场</option>
                                <option value="台北松山机场">台北松山机场</option>
                                <option value="高雄国际机场">高雄国际机场</option>
                                <option value="恒春机场">恒春机场</option>
                                <option value="台中机场">台中机场</option>
                            </select>
                        </div>
                        <div class="charter-service-form-item">
                            <label class="form-label">接机日期：</label>
                            <input type="text" class="k W100" onclick="laydate({ istime: true, format: 'YYYY-MM-DD hh:mm:ss' })" name="beginDate" datatype="/^\s*$|^\d{4}\-\d{1,2}\-\d{1,2}\s{1}(\d{1,2}:){2}\d{1,2}$/" sucmsg=" " />
                        </div>
                        <div class="charter-service-form-item">
                            <label class="form-label">下车地点：</label>
                            <input type="text" class="k W100" name="beginPlace"  />
                        </div>
                        <div class="charter-service-form-item">
                            <label class="form-label">送机日期：</label>
                            <input type="text" class="k W100" onclick="laydate({ istime: true, format: 'YYYY-MM-DD hh:mm:ss' })" name="endDate" datatype="/^\s*$|^\d{4}\-\d{1,2}\-\d{1,2}\s{1}(\d{1,2}:){2}\d{1,2}$/" sucmsg=" " />
                        </div>
                        <div class="charter-service-form-item">
                            <label class="form-label">上车地点：</label>
                            <input type="text" class="k W100" name="endPlace"  >
                        </div>
                        <div class="charter-service-form-item">
                            <label class="form-label">行李件数<span class="red">*</span>：</label>
                            <input type="text" class="k W100" name="baggageNumber" datatype="*1-10" nullmsg="请输入行李件数" sucmsg=" " />
                        </div>
                        <div class="charter-service-form-item">
                            <label class="form-label">乘车人数<span class="red">*</span>：</label>
                            <input type="text" class="k W100" name="rideNumber" datatype="*1-10" nullmsg="请输入乘车人数" sucmsg=" " />
                        </div>
                        <div class="charter-service-form-item">
                            <label class="form-label">姓名<span class="red">*</span>：</label>
                            <input type="text" class="k W100" name="txtName" datatype="*1-50" nullmsg="请输入姓名" sucmsg=" " />
                        </div>
                        <div class="charter-service-form-item">
                            <label class="form-label">联系电话<span class="red">*</span>：</label>
                            <input type="text" class="k W100" placeholder="输入手机号或国际电话" name="txtPhone" datatype="*1-15" nullmsg="请输入联系电话" sucmsg=" " />
                        </div>
                        <div class="charter-service-form-item">
                            <label class="form-label">QQ：</label>
                            <input type="text" class="k W100" name="txtQQ" datatype="*0-15" nullmsg="请输入QQ号" sucmsg=" " />
                        </div>
                        <div class="charter-service-form-item">
                            <label class="form-label">EMAIL<span class="red">*</span>：</label>
                            <input type="text" class="k W100" name="txtEmail" datatype="e" nullmsg="请输入电子邮箱" sucmsg=" " />
                        </div>
                    </div>
                    <span id="msgtip" class="msgtip"></span>
                    <div class="charter-service-introduct-btn">
                        <input type="hidden" name="hdMainId" value="<%=model.id %>" />
                        <button type="submit" class="icon-reserve-btn" id="btnSubmit">立即预定</button>
                        <a href="login.aspx" class="icon-login-btn btn">用户登录</a>
                        <a href="register.aspx" class="icon-login-btn btn">快速注册</a>
                        <span class="showTip-btn" ht-click="show" data-target="#Tip-box">查看提示<i></i></span>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="H20"></div>
    <div class="container tab-box">
        <div class="page-tab-title title location-title">
            <ul>
                <li class="active"><a href="#detail-content1">产品详情</a></li>
                <li><a href="#detail-content2">产品评论</a></li>
            </ul>
        </div>
        <div class="charter-service-content-box">
            <div class="charter-service-content" id="detail-content1">
                <%=model.content %>
            </div>
            <div class="standard-content " id="detail-content2">
                 <div class="news2-detail-comment">
                    <div class="news2-detail-comment-title">评论（<%=WebUI.GetCommentCount(model.id,(int)HTEnums.DataFKType.Car)%>）</div>
                    <form action="#" id="formCmt" url="/tools/submit_ajax.ashx?action=user_comment_add">
                    <div class="news2-detail-comment-form">
                        <textarea name="txtContent" cols="30" rows="10" placeholder="填写评论内容..." datatype="*1-5000" nullmsg="请输入评论内容" sucmsg=" "></textarea>
                        <span id="msgtipCmt" class="msgtip"></span>
                        <input type="hidden" name="fk_id" value="<%=model.id %>" />
                        <input type="hidden" name="fk_type" value="<%=(int)HTEnums.DataFKType.Car %>" />
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
    <div class="H20"></div>
    <div class="container">
        <div class="page-tab-title">
            <ul>
                <li class="active"><span>相关推荐</span></li>
            </ul>
        </div>
        <div class="charter-service-box W1200">
            <ul>
                <asp:Repeater runat="server" ID="rptListXGTJ">
                    <ItemTemplate>
                        <li>
                            <div class="item">
                                <a href="car_charter_service_detail.aspx?cid=<%#Eval("cid") %>">
                                    <img src="<%#Eval("img_url") %>" alt=""></a>
                                <p class="title"><a href="car_charter_service_detail.aspx?cid=<%#Eval("cid") %>"><%#Eval("title") %></a></p>
                                <p class="title2"><%#Eval("zhaiyao") %><span class="price">¥<%#Eval("market_price") %></span></p>
                            </div>
                            <div class="price-btn">
                                <span><em>¥<%#Eval("sell_price") %></em> 起/每人</span>
                                <a href="car_charter_service_detail.aspx?cid=<%#Eval("cid") %>" class="icon-buy-btn btn">购买</a>
                            </div>
                        </li>
                    </ItemTemplate>
                </asp:Repeater>
            </ul>
        </div>
    </div>
    <div class="container">
        <div class="page-tab-title">
            <ul>
                <li class="active"><span>相关标签</span></li>
            </ul>
        </div>
        <div class="charter-service-Label-box">
            <ul>
                <asp:Repeater runat="server" ID="rptListXGBQ">
                    <ItemTemplate>
                        <li><a href="car_charter_service_detail.aspx?cid=<%#Eval("cid") %>"><%#Eval("title") %></a></li>
                    </ItemTemplate>
                </asp:Repeater>
            </ul>
        </div>
    </div>
    <uc1:footer runat="server" ID="footer" />
    <script type="text/javascript">
        $(function () {
            AjaxInitForm('form1', 'btnSubmit', 'msgtip');
            AjaxInitForm('formCmt', 'btnSubmitCmt', 'msgtipCmt');
            AjaxPageList('#comment00', '#pagination', 10, '<%=WebUI.GetCommentCount(model.id,(int)HTEnums.DataFKType.Car)%>', '/tools/submit_ajax.ashx?action=user_comment_list', '<%=model.id%>', '<%=(int)HTEnums.DataFKType.Car%>');
        })
    </script>


    <div class="PopBox hide" id="Tip-box">
    <div class="Pop_upBox_bg"></div>
    <div class="Pop_upBox H190">
        <div class="pop_content">
            <div class="PopBox_title">包车服务提示</div>
            <div class="content">
                 <div class="shadowTip">
                    <p>本服务为拼车活动，请乘者遵守指定时间，如果不能忍受 与人同游或迟到，请互相体谅或勿参加！</p>
                 </div>
            </div>
            <div class="close" ht-click="hide" data-target="#Tip-box">
                <img src="/images/e/close.png" alt="" />
            </div>
        </div>
    </div>
</div>

    <script type="text/javascript">
        var $index_rolling1 = $(".pic_rolling3");
        $index_rolling1.each(function () {
            var _this = $(this);
            var str = '<div class="btn_div left_div"><a href="javascript:" class="leftBtn"></a></div>';
            str += ' <div class="btn_div right_div"><a href="javascript:" class="rightBtn disabled"></a></div>';
            _this.append(str);
            var $pic_content = _this.find('.pic_content');
            var $pic_box = _this.find('ul');
            var $pic = $pic_box.find('li');
            var $li_width = $pic.outerWidth(true);
            var $len = $pic.length;
            var direction = "-";
            var counter = 0;
            $pic_content.find("ul").width($len * $li_width);
            $pic_content.on('pic_contentEvent', function () {
                $pic_box.animate({ 'left': direction + '=' + $li_width },
                    500, function () {
                        _this.trigger('BtnEvent');
                    });
            });

            _this.on('click', '.leftBtn', function () {
                if (counter < 1) {
                    return false;
                }
                else {
                    counter--;
                }
                direction = "+";
                $pic_content.trigger("pic_contentEvent");
            })


            _this.on('click', '.rightBtn', function () {
                if (counter < $len - 3) {
                    counter++;
                }
                else {
                    return false;
                }
                direction = "-";
                $pic_content.trigger("pic_contentEvent");
            })
            _this.on("BtnEvent", function () {
                if (counter == 0) {
                    $(this).find(".leftBtn").removeClass("disabled");
                }
                else {
                    $(this).find(".leftBtn").addClass("disabled");
                }
                if (counter == ($len - 3)) {
                    $(this).find(".rightBtn").removeClass("disabled");
                }
                else {
                    $(this).find(".rightBtn").addClass("disabled");
                }
            })
        })
</script>
</body>
</html>

