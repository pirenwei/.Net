<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="dialog_article.aspx.cs" Inherits="HT.Web.admin.dialog.dialog_article" %>

<%@ Import Namespace="HT.Common" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<title>内容管理</title>
<link href="../../scripts/artdialog/ui-dialog.css" rel="stylesheet" type="text/css" />
<link href="../skin/default/style.css" rel="stylesheet" type="text/css" />
<link href="../../css/pagination.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../scripts/jquery/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="../../scripts/jquery/jquery.lazyload.min.js"></script>
<script type="text/javascript" src="../../scripts/artdialog/dialog-plus-min.js"></script>
<script type="text/javascript" charset="utf-8" src="../js/laymain.js"></script>
<script type="text/javascript" charset="utf-8" src="../js/common.js"></script>
<script type="text/javascript" src="../../scripts/layer/layer.js"></script>
<script type="text/javascript">
    var api = top.dialog.get(window); //获取父窗体对象
    //页面加载完成执行
    $(function () {
        //图片延迟加载
        $(".pic img").lazyload({ effect: "fadeIn" });

        //设置按钮及事件
        api.button([{
            value: '确定',
            callback: function () {
                var liHtml = "";
                $(".checkall").find('input:checked').each(function () {
                    var article_id = $(this).parent().next().val();
                    $.ajax({
                        async:false,
                        type: "post",
                        url: "../../tools/json_ajax.ashx?action=JsonArticleModel",
                        data: { "article_id": article_id },
                        dataType: "json",
                        success: function (data, textStatus) {
                            if (data.status == 1) {
                                liHtml += '<li>'
                                + '<input type="hidden" value="' + data.id + '">'
                                + '<div class="img-box" onclick="setFocusImg(this);">'
                                + '     <img src="' + data.img_url + '" />'
                                + '     <span class="remark"><i>'+ data.title +'</i></span>'
                                + '</div>'
                                + '<a target="_blank" title="点击查看" href="/video_detail.aspx?cid='+data.cid+'">查看</a>'
                                + '<a href="javascript:;" onclick="delImg(this,'+data.id+');">删除</a>'
                                + '</li>';
                            }
                        }
                    });
                });
                api.close(liHtml).remove();
                return false;
            },
            autofocus: true
        }, {
            value: '取消',
            callback: function () { }
        }]);
    });
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
          <li><a class="all" href="javascript:;" onclick="checkAll(this);"><i></i><span>全选</span></a></li>
        </ul>
        <div class="menu-list">
          <div class="rule-single-select">
            <asp:DropDownList ID="ddlProperty" runat="server" AutoPostBack="True" onselectedindexchanged="ddlProperty_SelectedIndexChanged">
              <asp:ListItem Value="" Selected="True">所有属性</asp:ListItem>
              <asp:ListItem Value="isTop">置顶</asp:ListItem>
              <asp:ListItem Value="isRed">推荐</asp:ListItem>
              <asp:ListItem Value="isHot">热门</asp:ListItem>
            </asp:DropDownList>
          </div>
        </div>
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
<div class="table-container" style="height:360px; overflow:auto">
  <!--文字列表-->
  <asp:Repeater ID="rptList1" runat="server">
  <HeaderTemplate>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ltable">
    <tr>
      <th width="6%">选择</th>
      <th align="left">标题</th>
      <th align="left" width="20%">所属类别</th>
      <th align="left" width="16%">发布时间</th>
    </tr>
  </HeaderTemplate>
  <ItemTemplate>
    <tr>
      <td align="center">
        <asp:CheckBox ID="chkId" CssClass="checkall" runat="server" style="vertical-align:middle;"/>
        <asp:HiddenField ID="hidId" Value='<%#Eval("id")%>' runat="server" />
      </td>
      <td><%#Eval("title")%></td>
      <td><%#new HT.BLL.article_category().GetTitle(Convert.ToInt32(Eval("category_id")))%></td>
      <td><%#string.Format("{0:g}",Eval("add_time"))%></td>
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
      <label>
        <div class="details<%#Eval("img_url").ToString() != "" ? "" : " nopic"%>">
          <div class="check">
            <asp:CheckBox ID="chkId" CssClass="checkall" runat="server" />
            <asp:HiddenField ID="hidId" Value='<%#Eval("id")%>' runat="server" />
          </div>
          <%#Eval("img_url").ToString() != "" ? "<div class=\"pic\"><img src=\"../skin/default/loadimg.gif\" data-original=\"" + Eval("img_url") + "\" /></div><i class=\"absbg\"></i>" : ""%>
          <h1><span><%#Eval("title")%></span></h1>
          <div class="remark">
            <%#Eval("zhaiyao").ToString() == "" ? "暂无内容摘要说明..." : Eval("zhaiyao").ToString()%>
          </div>
          <div class="foot">
            <p class="time"><%#string.Format("{0:yyyy-MM-dd HH:mm:ss}", Eval("add_time"))%></p>
          </div>
        </div>
        </label>
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
