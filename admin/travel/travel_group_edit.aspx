<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="travel_group_edit.aspx.cs" Inherits="HT.Web.admin.travel.travel_group_edit" %>

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
  <a href="travel_group_list.aspx" class="back"><i></i><span>返回列表页</span></a>
  <a href="../center.aspx" class="home"><i></i><span>首页</span></a>
  <i class="arrow"></i>
  <a href="travel_group_list.aspx"><span>组团信息</span></a>
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
        <li><a href="travel_group_apply.aspx?group_id=<%=this.id %>">报名人员</a></li>
      </ul>
    </div>
  </div>
</div>

<div class="tab-content">
  <dl>
    <dt>活动状态</dt>
    <dd>
      <div class="rule-multi-radio">
        <asp:RadioButtonList ID="rblStatus" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
        <asp:ListItem Value="0" Selected="True">招募中</asp:ListItem>
        <asp:ListItem Value="1">已结束</asp:ListItem>
        </asp:RadioButtonList>
      </div>
    </dd>
  </dl>
  <dl>
    <dt>标题</dt>
    <dd>
      <asp:TextBox ID="txtTitle" runat="server" CssClass="input normal" datatype="*2-100" sucmsg=" " />
      <span class="Validform_checktip">*标题最多100个字符</span>
    </dd>
  </dl>
  <dl>
    <dt>组团人数</dt>
    <dd>
      <asp:TextBox ID="txtRenshu" runat="server" CssClass="input normal" TextMode="Number" datatype="n" sucmsg=" " />
      <span class="Validform_checktip">*</span>
    </dd>
  </dl>
  <dl>
    <dt>组团性别</dt>
    <dd>
      <div class="rule-multi-radio">
        <asp:RadioButtonList ID="rblGender" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
            <asp:ListItem Value="男" Selected="True">男</asp:ListItem>
            <asp:ListItem Value="女">女</asp:ListItem>
            <asp:ListItem Value="皆可">皆可</asp:ListItem>
        </asp:RadioButtonList>
      </div>
    </dd>
  </dl>
  <dl>
    <dt>招募开始时间</dt>
    <dd>
        <asp:TextBox ID="txtBeginTime" runat="server" CssClass="input rule-date-input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd 00:00:00'})" datatype="/^\s*$|^\d{4}\-\d{1,2}\-\d{1,2}\s{1}(\d{1,2}:){2}\d{1,2}$/" errormsg="请选择正确的日期" sucmsg=" " />
        <span class="Validform_checktip">不选择默认当前发布时间</span>
    </dd>
  </dl>
  <dl>
    <dt>招募结束时间</dt>
    <dd>
        <asp:TextBox ID="txtEndTime" runat="server" CssClass="input rule-date-input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd 00:00:00'})" datatype="/^\s*$|^\d{4}\-\d{1,2}\-\d{1,2}\s{1}(\d{1,2}:){2}\d{1,2}$/" errormsg="请选择正确的日期" sucmsg=" " />
        <span class="Validform_checktip">不选择默认当前发布时间</span>
    </dd>
  </dl>
  <dl>
    <dt>集合地点</dt>
    <dd>
      <asp:TextBox ID="txtJihePlace" runat="server" CssClass="input normal" datatype="*2-100" sucmsg=" " />
      <span class="Validform_checktip">*</span>
    </dd>
  </dl>
  <dl>
    <dt>集合时间</dt>
    <dd>
      <asp:TextBox ID="txtJiheTime" runat="server" CssClass="input rule-date-input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" datatype="/^\s*$|^\d{4}\-\d{1,2}\-\d{1,2}\s{1}(\d{1,2}:){2}\d{1,2}$/" errormsg="请选择正确的日期" sucmsg=" " />
      <span class="Validform_checktip">不选择默认当前发布时间</span>
    </dd>
  </dl>
  <dl>
    <dt>备注</dt>
    <dd>
      <asp:TextBox ID="txtRemark" runat="server" CssClass="input normal" TextMode="MultiLine" datatype="*0-255" sucmsg=" " />
      <span class="Validform_checktip">*</span>
    </dd>
  </dl>
    <!--工具栏-->
<div class="page-footer">
  <div class="btn-wrap">
    <asp:Button ID="btnSubmit" runat="server" Text="提交保存" CssClass="btn" onclick="btnSubmit_Click" />
    <input name="btnReturn" type="button" value="返回上一页" class="btn yellow" onclick="javascript: history.back(-1);" />
  </div>
</div>
<!--/工具栏-->
</div>
<!--/内容-->



</form>
</body>
</html>


