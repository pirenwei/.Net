<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="user_list.aspx.cs" Inherits="HT.Web.admin.users.user_list" %>
<%@ Import namespace="HT.Common" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<title>会员管理</title>
<link href="../../scripts/artdialog/ui-dialog.css" rel="stylesheet" type="text/css" />
<link href="../skin/default/style.css" rel="stylesheet" type="text/css" />
<link href="../../css/pagination.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../scripts/jquery/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="../../scripts/artdialog/dialog-plus-min.js"></script>
<script type="text/javascript" charset="utf-8" src="../js/laymain.js"></script>
<script type="text/javascript" charset="utf-8" src="../js/common.js"></script>
    <script>
        //发送站内信
        function PostMsg() {
            var userids = "";
            $(".checkall :checked").each(function () {
                userids += $(this).parent().next().val() + ",";
            });
            userids = userids.substring(0, userids.length - 1);
            location.href = "message_edit.aspx?action=Edit&userids=" + userids;
        }
        //发送邮件
        function PostMsgEmail() {
            var userids = "";
            $(".checkall :checked").each(function () {
                userids += $(this).parent().next().val() + ",";
            });
            userids = userids.substring(0, userids.length - 1);
            location.href = "post_message_email.aspx?userids=" + userids;
        }
        //发送短信
        function PostMsgSMS() {
            var userids = "";
            $(".checkall :checked").each(function () {
                userids += $(this).parent().next().val() + ",";
            });
            userids = userids.substring(0, userids.length - 1);
            location.href = "post_message_sms.aspx?userids=" + userids;
        }
    </script>
</head>

<body class="mainbody">
<form id="form1" runat="server">
<!--导航栏-->
<div class="location">
  <a href="javascript:history.back(-1);" class="back"><i></i><span>返回上一页</span></a>
  <a href="../center.aspx" class="home"><i></i><span>首页</span></a>
  <i class="arrow"></i>
  <span>会员管理</span>
  <i class="arrow"></i>
  <span>会员列表</span>
</div>
<!--/导航栏-->

<!--工具栏-->
<div id="floatHead" class="toolbar-wrap">
  <div class="toolbar">
    <div class="box-wrap">
      <a class="menu-btn"></a>
      <div class="l-list">
        <ul class="icon-list">
          <li><a class="add" href="user_edit.aspx?action=<%=HTEnums.ActionEnum.Add %>"><i></i><span>新增</span></a></li>
          <li><a class="msg" href="javascript:;" onclick="PostMsg();"><i></i><span>站内信</span></a></li>
          <li><a class="msg" href="javascript:;" onclick="PostMsgEmail();"><i></i><span>邮件</span></a></li>
          <li><a class="msg" href="javascript:;" onclick="PostMsgSMS();"><i></i><span>短信</span></a></li>
          <li><a class="all" href="javascript:;" onclick="checkAll(this);"><i></i><span>全选</span></a></li>
          <li><asp:LinkButton ID="btnDelete" runat="server" CssClass="del" OnClientClick="return ExePostBack('btnDelete');" onclick="btnDelete_Click"><i></i><span>删除</span></asp:LinkButton></li>
        </ul>
        <div class="menu-list">
          <div class="rule-single-select">
            <asp:DropDownList ID="ddlGroupId" runat="server" AutoPostBack="True" onselectedindexchanged="ddlGroupId_SelectedIndexChanged"></asp:DropDownList>
          </div>
        </div>
      </div>
      <div class="r-list">
        <asp:TextBox ID="txtKeywords" runat="server" CssClass="keyword" />
        <asp:LinkButton ID="lbtnSearch" runat="server" CssClass="btn-search" onclick="btnSearch_Click">查询</asp:LinkButton>
      </div>
    </div>
  </div>
</div>
<!--/工具栏-->

<!--列表-->
<div class="table-container">
<asp:Repeater ID="rptList" runat="server">
<HeaderTemplate>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="ltable">
  <tr>
    <th width="8%">选择</th>
    <th align="left" colspan="2">用户名</th>
    <th align="left" width="12%">会员组</th>
    <th align="left" width="12%">手机号</th>
    <th width="8%">G币</th>
    <th width="8%">状态</th>
    <th width="8%">操作</th>
  </tr>
</HeaderTemplate>
<ItemTemplate>
  <tr>
    <td align="center">
      <asp:CheckBox ID="chkId" CssClass="checkall" runat="server" style="vertical-align:middle;" />
      <asp:HiddenField ID="hidId" Value='<%#Eval("id")%>' runat="server" />
      <input name="hidMobile" type="hidden" value="<%#Eval("mobile")%>" />
      <input name="hidUserName" type="hidden" value="<%#Eval("user_name")%>" />
    </td>
    <td width="64">
      <a href="user_edit.aspx?action=<%#HTEnums.ActionEnum.Edit %>&id=<%#Eval("id")%>">
        <%#Eval("avatar").ToString() != "" ? "<img width=\"64\" height=\"64\" src=\"" + Eval("avatar") + "\" />" : "<b class=\"user-avatar\"></b>"%>
      </a>
    </td>
    <td>
      <div class="user-box">
        <h4><b><%#Eval("user_name")%></b> (昵称：<%#Eval("nick_name")%>)</h4>
        <i>注册时间：<%#string.Format("{0:g}",Eval("reg_time"))%></i>
        <span>
          <a class="point" href="point_log.aspx?keywords=<%#Eval("user_name")%>" title="G币记录">G币</a>
          <a class="msg" href="message_list.aspx?keywords=<%#Eval("user_name")%>" title="消息记录">短消息</a>
        </span>
      </div>
    </td>
    <td><%#new HT.BLL.user_groups().GetTitle(Convert.ToInt32(Eval("group_id")))%></td>
    <td><%#Eval("mobile")%></td>
    <td align="center"><%#Eval("point")%></td>
    <td align="center"><%#GetUserStatus(Convert.ToInt32(Eval("status")))%></td>
    <td align="center">
        <a href="user_edit.aspx?action=<%#HTEnums.ActionEnum.Edit %>&id=<%#Eval("id")%>">修改</a>
    </td>
  </tr>
</ItemTemplate>
<FooterTemplate>
  <%#rptList.Items.Count == 0 ? "<tr><td align=\"center\" colspan=\"9\">暂无记录</td></tr>" : ""%>
</table>
</FooterTemplate>
</asp:Repeater>
</div>
<!--/列表-->

<!--内容底部-->
<div class="line20"></div>
<div class="pagelist">
  <div class="l-btns">
    <span>显示</span><asp:TextBox ID="txtPageNum" runat="server" CssClass="pagenum" onkeydown="return checkNumber(event);"
                OnTextChanged="txtPageNum_TextChanged" AutoPostBack="True"></asp:TextBox><span>条/页</span>
  </div>
  <div id="PageContent" runat="server" class="default"></div>
</div>
<!--/内容底部-->
</form>
</body>
</html>