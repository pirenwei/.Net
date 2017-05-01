<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="lottery_gift_edit.aspx.cs" Inherits="HT.Web.admin.gb.lottery_gift_edit" %>

<%@ Import namespace="HT.Common" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<title>编辑信息</title>
<link href="../../scripts/artdialog/ui-dialog.css" rel="stylesheet" type="text/css" />
<link href="../skin/default/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" charset="utf-8" src="../../scripts/jquery/jquery-1.11.2.min.js"></script>
<script type="text/javascript" charset="utf-8" src="../../scripts/jquery/Validform_v5.3.2_min.js"></script>
<script type="text/javascript" charset="utf-8" src="../../scripts/datepicker/WdatePicker.js"></script>
<script type="text/javascript" charset="utf-8" src="../../scripts/artdialog/dialog-plus-min.js"></script>
<script type="text/javascript" charset="utf-8" src="../../scripts/webuploader/webuploader.min.js"></script>
<script type="text/javascript" charset="utf-8" src="../js/uploader.js"></script>
<script type="text/javascript" charset="utf-8" src="../js/laymain.js"></script>
<script type="text/javascript" charset="utf-8" src="../js/common.js"></script>
<script type="text/javascript" charset="utf-8" src="../../scripts/layer/layer.js"></script>
<script type="text/javascript">
    $(function () {
        $("#linkImgUrl").click(function () {
            layer.open({
                type: 1,
                title: '查看图片',
                shadeClose: true,
                shade: 0.8,
                area: ['800px', '90%'],
                content: '<img src=' + $("#txtImgUrl").val() + ' width="100%"  />'
            });
        })

        //初始化表单验证
        $("#form1").initValidform();

        //初始化上传控件
        $(".upload-img").InitUploader({ filesize: "<%=siteConfig.imgsize %>", sendurl: "../../tools/upload_ajax.ashx", swf: "../../scripts/webuploader/uploader.swf", filetypes: "<%=siteConfig.fileextension %>" });

    });
</script>
</head>

<body class="mainbody">
<form id="form1" runat="server">
<!--导航栏-->
<div class="location">
  <a href="lottery_gift_list.aspx" class="back"><i></i><span>返回列表页</span></a>
  <a href="../center.aspx" class="home"><i></i><span>首页</span></a>
  <i class="arrow"></i>
  <a href="lottery_gift_list.aspx"><span>G币抽奖</span></a>
  <i class="arrow"></i>
  <span>编辑信息</span>
</div>
<div class="line10"></div>
<!--/导航栏-->

<!--内容-->
<div id="floatHead" class="content-tab-wrap">
  <div class="content-tab">
    <div class="content-tab-ul-wrap">
      <ul>
        <li><a class="selected" href="javascript:;">基本信息</a></li>
      </ul>
    </div>
  </div>
</div>

<div class="tab-content">
  <dl>
    <dt>奖项等级</dt>
    <dd>
        <div class="rule-single-select">
          <asp:DropDownList runat="server" ID="ddlPrizeCode" datatype="*" sucmsg=" ">
              <asp:ListItem Value="0" Selected="True">谢谢参与</asp:ListItem>
              <asp:ListItem Value="1">一等奖</asp:ListItem>
              <asp:ListItem Value="2">二等奖</asp:ListItem>
              <asp:ListItem Value="3">三等奖</asp:ListItem>
              <asp:ListItem Value="4">四等奖</asp:ListItem>
              <asp:ListItem Value="5">五等奖</asp:ListItem>
              <asp:ListItem Value="6">六等奖</asp:ListItem>
          </asp:DropDownList>
        </div>
    </dd>
  </dl>
  <dl>
    <dt>奖品标题</dt>
    <dd>
      <asp:TextBox ID="txtTitle" runat="server" CssClass="input normal" datatype="*2-100" sucmsg=" " />
      <span class="Validform_checktip">*标题最多100个字符</span>
    </dd>
  </dl>
  <dl>
    <dt>奖品图片</dt>
    <dd>
      <asp:TextBox ID="txtImgUrl" runat="server" CssClass="input normal upload-path" />
      <div class="upload-box upload-img"></div>
        &nbsp;<a  href="javascript:void(0)"  id="linkImgUrl">查看</a>
    </dd>
  </dl>
  <dl>
    <dt>奖品数量</dt>
    <dd>
      <asp:TextBox ID="txtQuantity" runat="server" CssClass="input normal" datatype="n" sucmsg=" " />
      <span class="Validform_checktip">*</span>
    </dd>
  </dl>
  <dl>
    <dt>中奖提示</dt>
    <dd>
      <asp:TextBox ID="txtTips" runat="server" CssClass="input normal" datatype="*2-100" sucmsg=" " />
      <span class="Validform_checktip">*</span>
    </dd>
  </dl>
  <dl>
    <dt>发布时间</dt>
    <dd>
      <asp:TextBox ID="txtAddTime" runat="server" CssClass="input rule-date-input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" datatype="/^\s*$|^\d{4}\-\d{1,2}\-\d{1,2}\s{1}(\d{1,2}:){2}\d{1,2}$/" errormsg="请选择正确的日期" sucmsg=" " />
      <span class="Validform_checktip">不选择默认当前发布时间</span>
    </dd>
  </dl>
</div>

<!--/内容-->

<!--工具栏-->
<div class="page-footer">
  <div class="btn-wrap">
    <asp:Button ID="btnSubmit" runat="server" Text="提交保存" CssClass="btn" onclick="btnSubmit_Click" />
    <input name="btnReturn" type="button" value="返回上一页" class="btn yellow" onclick="javascript: history.back(-1);" />
  </div>
</div>
<!--/工具栏-->

</form>
</body>
</html>


