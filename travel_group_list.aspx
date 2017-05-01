<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="travel_group_list.aspx.cs" Inherits="HT.Web.travel_group_list" %>

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
        <div class="page-loct"><a href="index.aspx">首页</a> > <a href="travel_group_list.aspx">定制旅行</a> > <span>组团行程</span></div>
        <div class="news-search">
            <dl>
                <dd>
                    <label>行程天数：</label>
                    <select onchange="onSelclick(this)" class="dropdown">
                        <option value="travel_group_list.aspx">所有天数</option>
                        <asp:Repeater runat="server" ID="rptListDays">
                            <ItemTemplate>
                                <option <%#Eval("title").ToString()==this.days?"selected=\"selected\"":"" %> value="travel_group_list.aspx?days=<%#Eval("title") %>"><%#Eval("title") %></option>
                            </ItemTemplate>
                        </asp:Repeater>
                    </select>
                    <em>天</em>
                </dd>
                <dd>
                    <label>城市：</label>
                    <select onchange="onSelclick(this)" class="dropdown">
                        <option value="travel_group_list.aspx">所有城市</option>
                        <asp:Repeater runat="server" ID="rptListArea">
                            <ItemTemplate>
                                <option <%#Eval("title").ToString()==this.area?"selected=\"selected\"":"" %> value="travel_group_list.aspx?area=<%#Eval("title") %>"><%#Eval("title") %></option>
                            </ItemTemplate>
                        </asp:Repeater>
                    </select>
                    <em>市</em>
                </dd>
                <dd>
                    <label>出发月份：</label>
                    <select onchange="onSelclick(this)" class="dropdown">
                        <option value="travel_group_list.aspx">所有月份</option>
                        <asp:Repeater runat="server" ID="rptListMonth">
                            <ItemTemplate>
                                <option <%#Eval("title").ToString()==this.month?"selected=\"selected\"":"" %> value="travel_group_list.aspx?month=<%#Eval("title") %>"><%#Eval("title") %></option>
                            </ItemTemplate>
                        </asp:Repeater>
                    </select>
                    <em>月</em>
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
        <div class="page-tab-title title">
            <ul>
                <li><a href="travel_open_list.aspx">全部行程</a></li>
                <li class="active"><a href="travel_group_list.aspx">组团进行中</a></li>
            </ul>
            <div class="page-Sort-box">
                <div class="page-Sort">
                    <a <%=sort=="pl"?"class=\"active\"":"" %> href="travel_group_list.aspx?sort=pl">评论最多<i></i></a>
                    <a <%=sort=="zan"?"class=\"active\"":"" %> href="travel_group_list.aspx?sort=zan">点赞最多<i></i></a>
                    <a <%=sort=="addtime"?"class=\"active\"":"" %> href="travel_group_list.aspx?sort=addtime">最近更新<i></i></a>
                </div>
            </div>
        </div>
        <div class="Open-travel-top">
            <a href="travel_group_list.aspx?gt=1">即将成行</a>
            <a href="travel_group_list.aspx?gt=2">人数最多</a>
            <a href="travel_group_list.aspx?gt=3">最新组团</a>
            <a href="travel_group_list.aspx?gt=4">还差一个</a>
        </div>
    </div>
    <div class="container">
        <div class="page-bg PD00">
            <div class="Open-travel-list">
                <ul>
                    <asp:Repeater runat="server" ID="rptList">
                        <ItemTemplate>
                            <li>
                                <a href="travel_detail_group.aspx?id=<%#Eval("id") %>">
                                    <label>
                                        <img src="<%#Eval("img_url") %>" alt="" width="100%"></label></a>
                                <p class="title">
                                    <a href="travel_detail_group.aspx?id=<%#Eval("id") %>">
                                        <%#Eval("title") %></a>
                                    <span class="Group-tip">
                                        <i></i>正在组团
                                    </span>
                                </p>
                                <p class="introduct">发布者：<%#Eval("user_name") %></p>
                                <p class="introduct">游玩景点：<%#WebUI.GetTravelPlace(Eval("id")) %></p>
                                <p class="introduct">
                                    行程日期：
                               <%#string.Format("{0:yyyy.MM.dd}",Eval("begin_date"))%>-<%#string.Format("{0:yyyy.MM.dd}",Eval("end_date"))%>
                                </p>
                                <p class="zan">
                                    <div class="Share-span">
                                        <span class="Zambia" onclick="zan_add(this,'<%#Eval("id")%>','<%#(int)HTEnums.DataFKType.Travel%>')"><i></i>赞（<%#WebUI.GetZanCount(Utils.ObjToInt(Eval("id")),(int)HTEnums.DataFKType.Travel)%>）</span>
                                        <a href="travel_detail.aspx?id=<%#Eval("id") %>"><span class="comment"><i></i>评论（<%#WebUI.GetCommentCount(Eval("id"),(int)HTEnums.DataFKType.Travel)%>）</span></a>
                                        <span class="collection" onclick="user_collect_add(this,'<%#Eval("id") %>','<%#(int)HTEnums.DataFKType.Travel%>')"><i></i>收藏（<%#WebUI.GetCollectCount(Utils.ObjToInt(Eval("id")),(int)HTEnums.DataFKType.Travel)%>）</span>
                                        <span class="Share"><i></i>分享<div class="bshare-custom pos">
                                            <div class="bsPromo bsPromo2"></div>
                                            <a title="更多平台" class="bshare-more bshare-more-icon more-style-addthis"></a></div>
                                        </span>
                                        <script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/buttonLite.js#style=-1&amp;uuid=&amp;pophcol=2&amp;lang=zh"></script>
                                        <script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/bshareC0.js"></script>
                                    </div>
                                </p>
                            </li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>
            <div id="PageContent" runat="server" class="page-class"></div>
        </div>
    </div>
    <div class="H20"></div>
    <uc1:footer runat="server" ID="footer" />
    <script>
        //下拉框页面跳转
        function onSelclick(_this) {
            var url = $(_this).val();
            location.href = url;
        }
        //按钮页面跳转
        function onBtnclick(_this) {
            var url = "travel_group_list.aspx?keywords=" + $("#txtKeywords").val();
            location.href = url;
        }
    </script>

    <div class="PopBox hide" id="Personnel-tip-box">
        <div class="Pop_upBox_bg"></div>
        <div class="Pop_upBox H260">
            <div class="pop_content">
                <div class="PopBox_title">人员已满提示</div>
                <div class="content PD20">
                    <div class="Technological-process-tip-text">
                        <p>您所查看的组团活动人员已经满额，</p>
                        <p>请在其他组团旅游中选择合适的行程进行报名！</p>
                    </div>
                    <div class="Technological-process-btn">
                        <button type="submit" class="icon-submit-btn" ht-click="hide" data-target="#Personnel-tip-box">确认</button>
                    </div>
                </div>
                <div class="close" ht-click="hide" data-target="#Personnel-tip-box">
                    <img src="images/e/close.png" alt="" />
                </div>
            </div>
        </div>
    </div>

</body>
</html>



