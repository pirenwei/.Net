<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="discussion_area_post.aspx.cs" Inherits="HT.Web.discussion_area_post" %>

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
  <link href="/js/easydropdown/easydropdown-select.css" rel="stylesheet" />
  <link href="/js/easydropdown/easydropdown.css" rel="stylesheet" />
  <script src="/js/easydropdown/jquery.easydropdown.js"></script>

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
        <form runat="server" action="#" id="form1" url="/tools/submit_ajax.ashx?action=user_bbs_topic_add">
            <div class="post-form-item PDL78">
                <label class="col_1">发帖类型：</label>
                <asp:DropDownList runat="server" ID="ddlCategoryId" CssClass="dropdown" datatype="*" nullmsg="请选择类别" sucmsg=" "></asp:DropDownList>
            </div>
            <div class="post-form-item PDL78">
                <label class="col_1">标题：</label>
                <input type="text" name="txtTitle" placeholder="6-32个字符" class="k W442" datatype="*" nullmsg="请输入标题" sucmsg=" "/>
            </div>
            <div class="post-form-textarea PDL78">
                <label class="col_1">内容：</label>
                <textarea name="txtContent" class="editor-mini" style="visibility: hidden;" datatype="*" nullmsg="请输入内容" sucmsg=" "></textarea>
                <%if(GetUser()==null){%>
                <div class="post-tip-box">
                    <div class="post-tip">
                        <p>您需要先登录，才可以发帖</p>
                        <p><a target="_parent" href="login.aspx">登录</a> | <a target="_parent" href="register.aspx">注册</a></p>
                    </div>
                </div>
                <%} %>
            </div>
            <div class="H20"></div>
            <div class="post-form-item PDL78">
                <label class="col_1">验证码：</label>
                <input type="text" name="txtCodeYZM" placeholder="6-32个字符" class="k W112" datatype="*" nullmsg="请输入验证码" sucmsg=" "/>
                <a id="ToggleCode" href="javascript:;" onclick="ToggleCode('/tools/verify_code.ashx');return false;">
                    <img width="80" height="30" src="/tools/verify_code.ashx"/></a>
            </div>
            <%if(GetUser()!=null){%>
            <span id="msgtip" class="msgtip"></span>
            <div class="submit_btn">
                <input type="submit" value="提交" class="btn" id="btnSubmit"/>
            </div>
            <%} %>
        </form>
    </div>
</body>
</html>
