<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="bbs_reply_list.aspx.cs" Inherits="HT.Web.admin.bbs.bbs_reply_list" %>

<%@ Import namespace="HT.Common" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<title>帖子管理</title>
<link href="../../scripts/artdialog/ui-dialog.css" rel="stylesheet" type="text/css" />
<link href="../skin/default/style.css" rel="stylesheet" type="text/css" />
<link href="../../css/pagination.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../scripts/jquery/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="../../scripts/artdialog/dialog-plus-min.js"></script>
<script type="text/javascript" charset="utf-8" src="../js/laymain.js"></script>
<script type="text/javascript" charset="utf-8" src="../js/common.js"></script>
<script type="text/javascript" src="../../scripts/layer/layer.js"></script>
<script>
    function layer_OpenEdit(action, id, topic_id) {
        layer.open({
            type: 2,
            title: '帖子回复',
            shadeClose: true,
            shade: 0.8,
            area: ['800px', '90%'],
            content: 'bbs_reply_edit.aspx?action=' + action + '&id=' + id + "&topic_id=" + topic_id
        });
    }
</script>
</head>

<body class="mainbody">
<form id="form1" runat="server">

<!--工具栏-->
<div id="floatHead" class="toolbar-wrap">
  <div class="toolbar">
    <div class="box-wrap">
      <a class="menu-btn"></a>
      <div class="l-list">
        <ul class="icon-list">
          <li><a class="add" onclick="layer_OpenEdit('<%=HTEnums.ActionEnum.Add %>',0,'<%=this.topic_id %>')" href="javascript:;"><i></i><span>新增</span></a></li>
          <li><asp:LinkButton ID="btnAudit" runat="server" CssClass="lock" OnClientClick="return ExePostBack('btnAudit','审核后前台将显示该信息，确定继续吗？');" onclick="btnAudit_Click"><i></i><span>审核</span></asp:LinkButton></li>
          <li><a class="all" href="javascript:;" onclick="checkAll(this);"><i></i><span>全选</span></a></li>
          <li><asp:LinkButton ID="btnDelete" runat="server" CssClass="del" OnClientClick="return ExePostBack('btnDelete');" onclick="btnDelete_Click"><i></i><span>删除</span></asp:LinkButton></li>
        </ul>
      </div>
    </div>
  </div>
</div>
<!--/工具栏--> 

<!--列表-->
<div class="table-container">
  <!--文字列表-->
  <asp:Repeater ID="rptList" runat="server">
  <HeaderTemplate>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ltable">
    <tr>
      <th width="6%">选择</th>
      <th align="left">内容</th>
      <th width="10%">回复者</th>
      <th align="left" width="10%">回复时间</th>      
      <th width="10%">状态</th>
      <th width="10%">操作</th>
    </tr>
  </HeaderTemplate>
  <ItemTemplate>
    <tr>
      <td align="center">
        <asp:CheckBox ID="chkId" CssClass="checkall" runat="server" style="vertical-align:middle;" />
        <asp:HiddenField ID="hidId" Value='<%#Eval("id")%>' runat="server" />
      </td>
      <td><a onclick="layer_OpenEdit('<%=HTEnums.ActionEnum.Edit %>','<%#Eval("id")%>','<%=this.topic_id %>')" href="javascript:;">
          <%#Utils.DropHTML(Eval("content").ToString(),50)%></a></td>
      <td align="center"><%#Eval("user_name")%></td>
      <td><%#string.Format("{0:g}",Eval("add_time"))%></td>      
      <td align="center"><%#Eval("status").ToString()=="0"?"正常":"无效"%></td>
      <td align="center">
        <a onclick="layer_OpenEdit('<%=HTEnums.ActionEnum.Edit %>','<%#Eval("id")%>','<%=this.topic_id %>')" href="javascript:;">修改</a>
      </td>
    </tr>
  </ItemTemplate>
  <FooterTemplate>
  <%#rptList.Items.Count == 0 ? "<tr><td align=\"center\" colspan=\"10\">暂无记录</td></tr>" : ""%>
  </table>
  </FooterTemplate>
  </asp:Repeater>
  <!--/文字列表-->
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



