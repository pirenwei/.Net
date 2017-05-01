<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="discussion_area.aspx.cs" Inherits="HT.Web.discussion_area" %>

<%@ Register Src="~/ucl/footer.ascx" TagPrefix="uc1" TagName="footer" %>
<%@ Register Src="~/ucl/header.ascx" TagPrefix="uc1" TagName="header" %>
<%@ Register Src="~/ucl/links.ascx" TagPrefix="uc1" TagName="links" %>

<%@ Import Namespace="HT.Common"%>

<!DOCTYPE html>
<html lang="zh">
<head>
  <title><%=HT.Web.UI.WebUI.config.webtitle %></title>
    <meta name="keywords" content="<%=HT.Web.UI.WebUI.config.webkeyword %>">
  <meta name="description" content="<%=HT.Web.UI.WebUI.config.webdescription %>">
  <uc1:links runat="server" id="links" />
</head>
<body>
<uc1:header runat="server" id="header" />
<div class="container">
     <div class="page-loct"><a href="index.aspx">首页</a> > <span>讨论区</span> </div>
</div>
<div class="container">
     <div class="discussion-area-top">
         <h1><span>讨论区</span>（今日更新<%=totalCount %>帖子）</h1>
         <p class="col_22">1.本版块仅限游客讨论，发帖，旅行经验分享</p>
         <p class="col_22">2.本版块不得发布广告等内容</p>
         <p class="col_22">3.本版块不得发布不当言论</p>
     </div>
     <div class="discussion-area-title">
        <a href="discussion_area.aspx" <%=category_id==0?"class=\"active\"":"" %> >所有（<%=GetCountTopic(0) %>）</a>
        <asp:Repeater runat="server" ID="rptListCategory">
            <ItemTemplate>
                <a <%#category_id==Utils.ObjToInt(Eval("id"))?"class=\"active\"":"" %> href="discussion_area.aspx?category_id=<%#Eval("id") %>">
                    <%#Eval("title") %>（<%#GetCountTopic(Utils.ObjToInt(Eval("id"))) %>）</a>
            </ItemTemplate>
        </asp:Repeater>
         <span class="icon-post-btn btn" onclick="layer_OpenEdit(this)">点击发帖</span>
     </div>
     <div class="H10"></div>
     <table class="table table-border">
        <colgroup>
           <col style="width:60%"></col>
           <col style="width:10%"></col>
           <col style="width:15%"></col>
           <col style="width:15%"></col>
        </colgroup>
        <thead>
          <tr class="th">
            <th>筛选： 
                <a href="discussion_area.aspx?type=is_top">置顶帖</a>
                <a href="discussion_area.aspx?type=is_elite">精华帖</a>
                排序： 
                <a href="discussion_area.aspx?sort=1">热门</a>
                <a href="discussion_area.aspx?sort=2">最新发表</a>
            </th>
            <th>回复 / 浏览数</th>
            <th>发表者</th>
            <th>发表时间</th>
          </tr>
        </thead>
        <tbody>
            <asp:Repeater runat="server" ID="rptList">
                <ItemTemplate>
                <tr>
                    <td>
                        <%#Eval("is_elite").ToString()=="1"?"<span class=\"jing\">精</span>":"" %>
                        <%#Eval("is_top").ToString()=="1"?"<span class=\"ding\">顶</span>":"" %>
                        <img src="/images/e/pic108.png" alt="">
                        <a href="discussion_area_detail.aspx?cid=<%#Eval("cid") %>">
                            <%#Eval("title") %></a>
                    </td>
                    <td><p> <%#new HT.BLL.ht_bbs_topic().GetCountReply(Utils.ObjToInt(Eval("id")))%> / <%#Eval("click") %></p></td>
                    <td>
                        <p><%#Eval("user_name").ToString()==""?"匿名":Eval("user_name").ToString()%></p>
                    </td>
                    <td>
                        <p><%#string.Format("{0:yyyy-MM-dd HH:mm}",Eval("add_time"))%></p>
                    </td>
                </tr>
                </ItemTemplate>
            </asp:Repeater>
        </tbody>
      </table>
    <div id="PageContent" runat="server" class="page-class"></div>
</div>

<div class="H20"></div>

<uc1:footer runat="server" id="footer" />
<script type="text/javascript" src="/scripts/layer/layer.js"></script>
<script>
    function layer_OpenEdit(obj) {
        layer.open({
            type: 2,
            title: '我要发帖',
            shadeClose: true,
            shade: 0.8,
            area: ['690px', '70%'],
            content: 'discussion_area_post.aspx' 
        });
    }
</script>
</body>
</html>