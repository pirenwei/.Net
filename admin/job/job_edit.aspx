<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="job_edit.aspx.cs" Inherits="HT.Web.admin.job.job_edit" %>

<%@ Import namespace="HT.Common" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<title>编辑招聘信息</title>
<link href="../../scripts/artdialog/ui-dialog.css" rel="stylesheet" type="text/css" />
<link href="../skin/default/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" charset="utf-8" src="../../scripts/jquery/jquery-1.11.2.min.js"></script>
<script type="text/javascript" charset="utf-8" src="../../scripts/jquery/Validform_v5.3.2_min.js"></script>
<script type="text/javascript" charset="utf-8" src="../../scripts/datepicker/WdatePicker.js"></script>
<script type="text/javascript" charset="utf-8" src="../../scripts/artdialog/dialog-plus-min.js"></script>
<script type="text/javascript" charset="utf-8" src="../../scripts/webuploader/webuploader.min.js"></script>
<script type="text/javascript" charset="utf-8" src="../../editor/kindeditor-min.js"></script>
<script type="text/javascript" charset="utf-8" src="../js/uploader.js"></script>
<script type="text/javascript" charset="utf-8" src="../js/laymain.js"></script>
<script type="text/javascript" charset="utf-8" src="../js/common.js"></script>
<script type="text/javascript">
    $(function () {
        //初始化表单验证
        $("#form1").initValidform();

        //初始化编辑器
        var editorMini = KindEditor.create('.editor-mini', {
            width: '100%',
            height: '250px',
            resizeType: 1,
            uploadJson: '../../tools/upload_ajax.ashx?action=EditorFile&IsWater=1',
            items: [
				'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
				'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
				'insertunorderedlist', '|', 'emoticons', 'image', 'link']
        });
    });
</script>
</head>

<body class="mainbody">
<form id="form1" runat="server">
<!--导航栏-->
<div class="location">
  <a href="job_list.aspx" class="back"><i></i><span>返回列表页</span></a>
  <a href="../center.aspx" class="home"><i></i><span>首页</span></a>
  <i class="arrow"></i>
  <a href="job_list.aspx"><span>招聘管理</span></a>
  <i class="arrow"></i>
  <span>编辑招聘信息</span>
</div>
<div class="line10"></div>
<!--/导航栏-->

<!--内容-->
<div id="floatHead" class="content-tab-wrap">
  <div class="content-tab">
    <div class="content-tab-ul-wrap">
      <ul>
        <li><a class="selected" href="javascript:;">基本信息</a></li>
        <li><a href="javascript:;">详细描述</a></li>
      </ul>
    </div>
  </div>
</div>

<div class="tab-content">
  <dl>
    <dt>显示状态</dt>
    <dd>
      <div class="rule-multi-radio">
        <asp:RadioButtonList ID="rblStatus" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
        <asp:ListItem Value="0" Selected="True">正常</asp:ListItem>
        <asp:ListItem Value="2">不显示</asp:ListItem>
        </asp:RadioButtonList>
      </div>
    </dd>
  </dl>
  <dl>
    <dt>职位需求</dt>
    <dd>
      <asp:TextBox ID="txtPosition" runat="server" CssClass="input normal" datatype="*2-100" sucmsg=" " />
      <span class="Validform_checktip">*</span>
    </dd>
  </dl>
  <dl>
    <dt>性别</dt>
    <dd>
      <asp:TextBox ID="txtGender" runat="server" CssClass="input normal" datatype="*1-100" sucmsg=" " />
      <span class="Validform_checktip">*</span>
    </dd>
  </dl>
  <dl>
    <dt>工作年限</dt>
    <dd>
      <asp:TextBox ID="txtWorkLife" runat="server" CssClass="input normal" datatype="*2-100" sucmsg=" " />
      <span class="Validform_checktip">*</span>
    </dd>
  </dl>
  <dl>
    <dt>招聘人数</dt>
    <dd>
      <asp:TextBox ID="txtNumbers" runat="server" CssClass="input normal" datatype="*2-100" sucmsg=" " />
      <span class="Validform_checktip">*</span>
    </dd>
  </dl>
  <dl>
    <dt>学历要求</dt>
    <dd>
      <asp:TextBox ID="txtDegree" runat="server" CssClass="input normal" datatype="*2-100" sucmsg=" " />
      <span class="Validform_checktip">*</span>
    </dd>
  </dl>
  <dl>
    <dt>工作地点</dt>
    <dd>
      <asp:TextBox ID="txtWorkPlace" runat="server" CssClass="input normal" datatype="*2-100" sucmsg=" " />
      <span class="Validform_checktip">*</span>
    </dd>
  </dl>
  <dl>
    <dt>薪资待遇</dt>
    <dd>
      <asp:TextBox ID="txtSalary" runat="server" CssClass="input normal" datatype="*2-100" sucmsg=" " />
      <span class="Validform_checktip">*</span>
    </dd>
  </dl>
  <dl>
    <dt>薪资组成</dt>
    <dd>
      <asp:TextBox ID="txtSalaryForm" runat="server" CssClass="input normal" datatype="*2-100" sucmsg=" " />
      <span class="Validform_checktip">*</span>
    </dd>
  </dl>
  <dl>
    <dt>截止时间</dt>
    <dd>
      <asp:TextBox ID="txtEndTime" runat="server" CssClass="input normal" datatype="*2-100" sucmsg=" " />
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

<div class="tab-content" style="display:none">
  <dl>
    <dt>职务描述</dt>
    <dd>
      <textarea id="txtWorkDepict" class="editor-mini" style="visibility:hidden;" runat="server"></textarea>
    </dd>
  </dl>
  <dl>
    <dt>任职要求</dt>
    <dd>
      <textarea id="txtWorkDemand" class="editor-mini" style="visibility:hidden;" runat="server"></textarea>
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


