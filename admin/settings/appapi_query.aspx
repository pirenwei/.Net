<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="appapi_query.aspx.cs" Inherits="HT.Web.admin.settings.appapi_query" %>

<!DOCTYPE html>

<%@ Import Namespace="HT.Common" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <title>内容管理</title>
    <link href="../../scripts/artdialog/ui-dialog.css" rel="stylesheet" type="text/css" />
    <link href="../skin/default/style.css" rel="stylesheet" type="text/css" />
    <link href="../../css/pagination.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../scripts/jquery/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="../../scripts/artdialog/dialog-plus-min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../js/laymain.js"></script>
    <script type="text/javascript" charset="utf-8" src="../js/common.js"></script>
</head>
<body class="mainbody">
    <form id="form1" runat="server">
        <!--导航栏-->
        <div class="location">
            <a href="javascript:history.back(-1);" class="back"><i></i><span>返回上一页</span></a>
            <a href="../center.aspx" class="home"><i></i><span>首页</span></a> <i class="arrow"></i><span>APP接口管理</span>
        </div>
        <!--/导航栏-->
        <!--工具栏-->
        <div id="floatHead" class="toolbar-wrap">
            <div class="toolbar">
                <div class="box-wrap">
                    <a class="menu-btn"></a>

                    <div class="l-list">
                        <ul class="icon-list">
                            <li><a class="add" href="appapi_manage.aspx?action=<%=HTEnums.ActionEnum.Add %>"><i></i>
                                <span>新增</span></a></li>
                            <li>
                                <asp:LinkButton ID="btnSave" runat="server" CssClass="save" OnClick="btnSave_Click"><i></i><span>保存</span></asp:LinkButton></li>
                            <li><a class="all" href="javascript:;" onclick="checkAll(this);"><i></i><span>全选</span></a></li>
                            <li>
                                <asp:LinkButton ID="btnDelete" runat="server" CssClass="del" OnClientClick="return ExePostBack('btnDelete');"
                                    OnClick="btnDelete_Click"><i></i><span>删除</span></asp:LinkButton></li>

                        </ul>
                        <div class="menu-list">


                            <div class="r-list">
                                <asp:TextBox ID="txtKeywords" runat="server" CssClass="keyword" />
                                <asp:LinkButton ID="lbtnSearch" runat="server" CssClass="btn-search" OnClick="btnSearch_Click">查询</asp:LinkButton>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <!--/工具栏-->
            <!--列表-->
            <asp:Repeater ID="rptList" runat="server" OnItemCommand="rptList_ItemCommand">
                <HeaderTemplate>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ltable">
                        <tr>
                            <th width="8%">选择
                            </th>

                            <th align="left" width="20%">标题
                            </th>
                            <th align="left">url
                            </th>
                            <th width="5%">推荐/标记</th>
                            <th>排序字段
                            </th>
                            <th width="15%">发布时间
                            </th>
                            <th width="10%">操作
                            </th>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td align="center">
                            <asp:CheckBox ID="chkId" CssClass="checkall" runat="server" Style="vertical-align: middle;" />
                            <asp:HiddenField ID="hidId" Value='<%#Eval("id")%>' runat="server" />
                        </td>
                        <td>
                            <a href="appapi_manage.aspx?action=<%=HTEnums.ActionEnum.Edit %>&id=<%#Eval("id")%>"><%#Eval("name")%></a>
                        </td>
                        <td><%#Eval("url") %></td>
                        <td>
                            <div class="btn-tools">
                                <asp:LinkButton ID="lbtnIsTop" CommandName="lbtnIsTop" runat="server" CssClass='<%# Convert.ToInt32(Eval("is_top")) == 1 ? "top selected" : "top"%>' ToolTip='<%# Convert.ToInt32(Eval("is_top")) == 1 ? "取消置顶" : "设置置顶"%>' />
                                <asp:LinkButton ID="lbtnIsColor" CommandName="lbtnIsColor" runat="server" CssClass='<%# Convert.ToInt32(Eval("is_color")) == 1 ? "red selected" : "red"%>' ToolTip='<%# Convert.ToInt32(Eval("is_color")) == 1 ? "取消标记" : "设置标记"%>' />
                            </div>
                        </td>
                        <td align="center">
                            <asp:TextBox ID="txtSortId" runat="server" Text='<%#Eval("sort")%>' CssClass="sort" onkeydown="return checkNumber(event);" /></td>
                        <td align="center">
                            <%#Eval("addtime")%>
                        </td>
                        <td align="center">
                            <a href="appapi_manage.aspx?action=<%=HTEnums.ActionEnum.Edit %>&id=<%#Eval("id")%>">编辑</a>
                        </td>
                    </tr>
                </ItemTemplate>

                <FooterTemplate>
                    <%#rptList.Items.Count == 0 ? "<tr><td align=\"center\" colspan=\"10\">暂无记录</td></tr>" : ""%>
            </table>
                </FooterTemplate>
            </asp:Repeater>
            <!--/列表-->

            <!--内容底部-->
            <div class="line20">
            </div>
            <div class="pagelist">
                <div class="l-btns">
                    <span>显示</span><asp:TextBox ID="txtPageNum" runat="server" CssClass="pagenum" onkeydown="return checkNumber(event);"
                        OnTextChanged="txtPageNum_TextChanged" AutoPostBack="True"></asp:TextBox><span>条/页</span>
                </div>
                <div id="PageContent" runat="server" class="default">
                </div>
            </div>
            <!--/内容底部-->
    </form>
</body>
</html>
