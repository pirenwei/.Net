<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="car_apply_list1.aspx.cs" Inherits="HT.Web.admin.car.car_apply_list1" %>

<%@ Import namespace="HT.Common" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<title>包车服务预订</title>
<link href="../../scripts/artdialog/ui-dialog.css" rel="stylesheet" type="text/css" />
<link href="../skin/default/style.css" rel="stylesheet" type="text/css" />
<link href="../../css/pagination.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../scripts/jquery/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="../../scripts/jquery/jquery.lazyload.min.js"></script>
<script type="text/javascript" src="../../scripts/artdialog/dialog-plus-min.js"></script>
<script type="text/javascript" charset="utf-8" src="../js/laymain.js"></script>
<script type="text/javascript" charset="utf-8" src="../js/common.js"></script>
</head>

<body class="mainbody">
<form id="form1" runat="server">
<!--导航栏-->
<div class="location">
  <a href="javascript:history.back(-1);" class="back"><i></i><span>返回上一页</span></a>
  <a href="../center.aspx" class="home"><i></i><span>首页</span></a>
  <i class="arrow"></i>
  <span>包车服务预订</span>
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
      </div>
    </div>
  </div>
</div>
<!--/工具栏-->

<!--列表-->
<div class="table-container">
  <!--文字列表-->
  <asp:Repeater ID="rptList" runat="server" OnItemCommand="rptList_ItemCommand">
  <HeaderTemplate>
  <table style="overflow:auto; width:180%" border="0" cellspacing="0" cellpadding="0" class="ltable">
    <tr>
        <th width="6%"><nobr>选择</th>
        <th align="left"><nobr>标题</nobr></th>
        <th><nobr>用车日期</nobr></th>
        <th><nobr>乘车人数</nobr></th>
        <th><nobr>行李件数</nobr></th>
        <th><nobr>有无司机</nobr></th>
        <th><nobr>乘车地点</nobr></th>
        <th><nobr>下车地点</nobr></th>
        <th><nobr>车位</nobr></th>
        <th><nobr>姓名</nobr></th>
        <th><nobr>联系电话</nobr></th>
        <th><nobr>QQ</nobr></th>
        <th><nobr>邮箱</nobr></th>
        <th><nobr>提交时间</nobr></th>
        <th><nobr>状态</nobr></th>
        <th width="100"><nobr>操作</nobr></th>
    </tr>
  </HeaderTemplate>
  <ItemTemplate>
    <tr>
        <td align="center">
        <asp:CheckBox ID="chkId" CssClass="checkall" runat="server" style="vertical-align:middle;" />
        <asp:HiddenField ID="hidId" Value='<%#Eval("id")%>' runat="server" />
        </td>
        <td><nobr><%#Eval("car_title")%></nobr></td>
        <td align="center"><nobr><%#Eval("begin_date")%>~<%#Eval("end_date")%></nobr></td>
        <td align="center"><nobr><%#Eval("ride_number")%></nobr></td>
        <td align="center"><nobr><%#Eval("baggage_number")%></nobr></td>
        <td align="center"><nobr><%#Eval("is_driver")%></nobr></td>
        <td align="center"><nobr><%#Eval("begin_place")%></nobr></td>
        <td align="center"><nobr><%#Eval("end_place")%></nobr></td>
        <td align="center"><nobr><%#Eval("carpark")%></nobr></td>
        <td align="center"><nobr><%#Eval("name")%></nobr></td>
        <td align="center"><nobr><%#Eval("phone")%></nobr></td>
        <td align="center"><nobr><%#Eval("qq")%></nobr></td>
        <td align="center"><nobr><%#Eval("email")%></nobr></td>
        <td align="center"><nobr><%#string.Format("{0:g}",Eval("add_time"))%></nobr></td>
        <td align="center"><nobr><%#Eval("status").ToString()=="1"?"已处理":"待处理"%></nobr></td>
        <td align="center">
            <asp:LinkButton ID="lbtnAudit" CommandName="lbtnAudit" runat="server"  Text='<%#Convert.ToInt32(Eval("status")) == 1 ? "取消" : "确定"%>'/>
        </td>
    </tr>
  </ItemTemplate>
  <FooterTemplate>
  <%#rptList.Items.Count == 0 ? "<tr><td align=\"center\" colspan=\"15\">暂无记录</td></tr>" : ""%>
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



