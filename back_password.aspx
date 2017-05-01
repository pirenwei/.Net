<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="back_password.aspx.cs" Inherits="HT.Web.back_password" %>

<%@ Register Src="~/ucl/footer.ascx" TagPrefix="uc1" TagName="footer" %>
<%@ Register Src="~/ucl/header.ascx" TagPrefix="uc1" TagName="header" %>
<%@ Register Src="~/ucl/links.ascx" TagPrefix="uc1" TagName="links" %>

<!DOCTYPE html>
<html lang="zh">
<head>
    <title><%=HT.Web.UI.WebUI.config.webtitle %></title>
    <meta name="keywords" content="<%=HT.Web.UI.WebUI.config.webkeyword %>">
    <meta name="description" content="<%=HT.Web.UI.WebUI.config.webdescription %>">
    <uc1:links runat="server" ID="links" />
</head>
<body>
    <uc1:header runat="server" ID="header" />
    <div class="container">
        <div class="page-loct"><a href="index.aspx">首页</a> > <span>修改密码</span> </div>
    </div>
    <div class="container">
        <div class="change_title">
            <ul>
                <li class="current">输入账号</li>
                <li>身份认证</li>
                <li>重置密码</li>
            </ul>
        </div>
        <div class="clear"></div>
        <div class="back-password-main">
            <div class="H10"></div>
            <div class="H10"></div>
            <form id="form1" url="/tools/submit_ajax.ashx?action=verifyLoginId">
                <div class="form-item PDL480">
                    <label class="form-item-label">用户名/手机<span class="red">*</span>：</label>
                    <input type="text" class="form-item-input W330" name="txtLoginId" placeholder="请输入用户名/手机" datatype="*2-20" nullmsg="请输入用户名/手机" sucmsg=" ">
                </div>
                <div class="form-item PDL480">
                    <label class="form-item-label">验证码<span class="red">*</span>：</label>
                    <dl class="form-item-dl">
                        <dd>
                            <input type="text" class="form-item-input W200" placeholder="请输入验证码" name="txtCodeYZM" datatype="*4-6" nullmsg="请输入验证码" sucmsg=" " /></dd>
                        <dd><a id="ToggleCode" href="javascript:;" onclick="ToggleCode('/tools/verify_code.ashx');return false;">
                            <img width="80" height="42" src="/tools/verify_code.ashx" /></a></dd>
                        <dd><span><a href="javascript:;" onclick="ToggleCode('/tools/verify_code.ashx');return false;">看不清！换一张</a></span></dd>
                    </dl>
                </div>
                <div class="form-item-btn">
                    <button type="submit" class="icon-save-btn" id="btnSubmit">提交</button>
                </div>
                <div class="form-item-tip"><span id="msgtip"></span></div>
            </form>
            <div class="H40"></div>
        </div>
    </div>
    <div class="H20"></div>
    <uc1:footer runat="server" ID="footer" />
    <script type="text/javascript">
        $(function () {
            AjaxInitForm('form1', 'btnSubmit', 'msgtip');
        })
    </script>
</body>
</html>
