<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LRhotel_list.aspx.cs" Inherits="HT.Web.admin.travel.LRhotel_list" %>

<%@ Import namespace="HT.Common" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<title>酒店管理</title>
<link href="../../scripts/artdialog/ui-dialog.css" rel="stylesheet" type="text/css" />
<link href="../skin/default/style.css" rel="stylesheet" type="text/css" />
<link href="../../css/pagination.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../scripts/jquery/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="../../scripts/jquery/jquery.lazyload.min.js"></script>
<script type="text/javascript" src="../../scripts/artdialog/dialog-plus-min.js"></script>
<script type="text/javascript" charset="utf-8" src="../js/laymain.js"></script>
<script type="text/javascript" charset="utf-8" src="../js/common.js"></script>
<script type="text/javascript">
    $(function () {
        //图片延迟加载
        $(".pic img").lazyload({ effect: "fadeIn" });
        //点击图片链接
        $(".pic img").click(function () {
            var linkUrl = $(this).parent().parent().find(".foot a").attr("href");
            if (linkUrl != "") {
                location.href = linkUrl; //跳转到修改页面
            }
        });
    });
</script>
</head>

<body class="mainbody">
<form id="form1" runat="server">
<!--导航栏-->
<div class="location">
  <a href="javascript:history.back(-1);" class="back"><i></i><span>返回上一页</span></a>
  <a href="../center.aspx" class="home"><i></i><span>首页</span></a>
  <i class="arrow"></i>
  <span>酒店列表</span>
</div>
<!--/导航栏-->

<!--工具栏-->
<div id="floatHead" class="toolbar-wrap">
  <div class="toolbar">
    <div class="box-wrap">
      <a class="menu-btn"></a>
      <div class="l-list">
        <ul class="icon-list">
          <li><a class="all" href="javascript:;" onclick="checkAll(this);"><i></i><span>全选</span></a></li>
          <li><asp:LinkButton ID="btnDelete" runat="server" CssClass="del" OnClientClick="return ExePostBack('btnDelete');" onclick="btnDelete_Click"><i></i><span>删除</span></asp:LinkButton></li>
        </ul>
      </div>
      <div class="r-list">
        <asp:TextBox ID="txtKeywords" runat="server" CssClass="keyword" />
        <asp:LinkButton ID="lbtnSearch" runat="server" CssClass="btn-search" onclick="btnSearch_Click">查询</asp:LinkButton>
        <asp:LinkButton ID="lbtnViewImg" runat="server" CssClass="img-view" onclick="lbtnViewImg_Click" ToolTip="图像列表视图" />
        <asp:LinkButton ID="lbtnViewTxt" runat="server" CssClass="txt-view" onclick="lbtnViewTxt_Click" ToolTip="文字列表视图" />
      </div>
    </div>
  </div>
</div>
<!--/工具栏-->

<!--列表-->
<div class="table-container">
  <!--文字列表-->
  <asp:Repeater ID="rptList1" runat="server">
  <HeaderTemplate>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ltable">
    <tr>
      <th width="6%">选择</th>
      <th align="left">标题</th>
      <th align="left">酒店编号</th>
      <th width="18%">地址</th>
      <th align="left" width="16%">发布时间</th>
      <th width="10%">操作</th>
    </tr>
  </HeaderTemplate>
  <ItemTemplate>
    <tr>
      <td align="center">
        <asp:CheckBox ID="chkId" CssClass="checkall" runat="server" style="vertical-align:middle;" />
        <asp:HiddenField ID="hidId" Value='<%#Eval("id")%>' runat="server" />
      </td>
      <td><a href="LRhotel_edit.aspx?action=<%#HTEnums.ActionEnum.Edit %>&id=<%#Eval("id")%>"><%#Eval("hotel_name")%></a></td>
      <td><%#Eval("hotel_ref")%></td>
      <td><%#Eval("hotel_address")%></td>
      <td><%#string.Format("{0:g}",Eval("add_time"))%></td>
      <td align="center">
        <a href="LRhotel_edit.aspx?action=<%#HTEnums.ActionEnum.Edit %>&id=<%#Eval("id")%>">修改</a>
      </td>
    </tr>
  </ItemTemplate>
  <FooterTemplate>
  <%#rptList1.Items.Count == 0 ? "<tr><td align=\"center\" colspan=\"7\">暂无记录</td></tr>" : ""%>
  </table>
  </FooterTemplate>
  </asp:Repeater>
  <!--/文字列表-->

  <!--图片列表-->
  <asp:Repeater ID="rptList2" runat="server">
  <HeaderTemplate>
  <div class="imglist">
    <ul>
  </HeaderTemplate>
  <ItemTemplate>
      <li>
        <div class="details<%#Eval("img_url").ToString() != "" ? "" : " nopic"%>">
          <div class="check">
            <asp:CheckBox ID="chkId" CssClass="checkall" runat="server" />
            <asp:HiddenField ID="hidId" Value='<%#Eval("id")%>' runat="server" />
          </div>
          <%#Eval("img_url").ToString() != "" ? "<div class=\"pic\"><img src=\"../skin/default/loadimg.gif\" data-original=\"" + Eval("img_url") + "\" /></div>" : ""%>
          <h1><span><a href="LRhotel_edit.aspx?action=<%#HTEnums.ActionEnum.Edit %>&id=<%#Eval("id")%>"><%#Eval("hotel_name")%></a></span></h1>
          <div class="remark">
            <%#Eval("hotel_directions").ToString() == "" ? "暂无内容摘要说明..." : Eval("hotel_directions").ToString()%>
          </div>
          <div class="tools">
              【酒店编号：<%#Eval("hotel_ref") %>】
          </div>
          <div class="foot">
            <p class="time"><%#string.Format("{0:yyyy-MM-dd HH:mm:ss}", Eval("add_time"))%></p>
            <a href="LRhotel_edit.aspx?action=<%#HTEnums.ActionEnum.Edit %>&id=<%#Eval("id")%>" title="编辑" class="edit">编辑</a>
          </div>
        </div>
      </li>
  </ItemTemplate>
  <FooterTemplate>
      <%#rptList2.Items.Count == 0 ? "<div align=\"center\" style=\"font-size:12px;line-height:30px;color:#666;\">暂无记录</div>" : ""%>
    </ul>
  </div>
  </FooterTemplate>
  </asp:Repeater>
  <!--/图片列表-->
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


