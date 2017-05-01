<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="travel_note_post.aspx.cs" Inherits="HT.Web.travel_note_post" %>

<%@ Register Src="~/ucl/links.ascx" TagPrefix="uc1" TagName="links" %>

<%@ Import Namespace="HT.Common"%>

<!DOCTYPE html>
<html lang="zh">
<head>
  <title><%=HT.Web.UI.WebUI.config.webtitle %></title>
    <meta name="keywords" content="<%=HT.Web.UI.WebUI.config.webkeyword %>">
  <meta name="description" content="<%=HT.Web.UI.WebUI.config.webdescription %>">
  <uc1:links runat="server" id="links" />
  <script src="/js/jquery/jquery-1.11.1.min.js" ></script>
<!------------------------------------------------------------------------------------->
<link rel="stylesheet" href="/css/validform.css" type="text/css"/>
<script src="/scripts/jquery/jquery.form.min.js"></script>
<script src="/scripts/jquery/Validform_v5.3.2_min.js"></script>
<script src="/scripts/layer/layer.js"></script>
<script type="text/javascript" charset="utf-8" src="/editor/kindeditor-min.js"></script>
<script src="/scripts/page/AjaxInitForm.js"></script>

<style>
    .content_upBox {width:90%;margin:20px 30px}
    .submit_btn { width:100%;text-align:center; height:50px; line-height:50px}
    .submit_btn .btn { background:#FE9D12; width:160px; height:28px; border:none; color:#FFF}
</style>
<script>
    $(function () {
        //初始化编辑器
        var editorMini = KindEditor.create('.editor-mini', {
            width: '100%',
            height: '250px',
            resizeType: 1,
            uploadJson: '/tools/upload_ajax.ashx?action=EditorFile&IsWater=1',
            items: [
                'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
                'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
                'insertunorderedlist', '|', 'emoticons', 'image', 'link']
        });

        AjaxInitForm('form1', 'btnSubmit', 'msgtip');
    });
</script>
</head>
<body style="background: #fff;">
    <div class="content_upBox">
        <form action="#" id="form1" url="/tools/submit_ajax.ashx?action=travel_note_edit">
            <div class="post-form-item PDL78">
                <label class="col_1">标题：</label>
                <input type="text" name="txtTitle" class="k W442" value="<%=model.note_title %>" datatype="*1-100" nullmsg="请输入标题" sucmsg=" "/>
            </div>
            <div class="post-form-textarea PDL78">
                <label class="col_1">内容：</label>
                <textarea name="txtContent" class="editor-mini" style="visibility: hidden;" datatype="*1-5000" nullmsg="请输入内容" sucmsg=" "><%=model.note_content %></textarea>
            </div>
            <div class="H20"></div>
            <span id="msgtip" class="msgtip"></span>
            <div class="submit_btn">
                <input type="hidden" name="hidMainId" value="<%=model.id %>"/>
                <input type="submit" value="提交" class="btn" id="btnSubmit"/>
            </div>
        </form>
    </div>
</body>
</html>
