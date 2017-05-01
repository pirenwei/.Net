<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="back_password_reset.aspx.cs" Inherits="HT.Web.back_password_reset" %>

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
        <div class="wrapper">
            <div class="change_title">
                <ul>
                    <li>输入账号</li>
                    <li>身份认证</li>
                    <li class="current">重置密码</li>
                </ul>
            </div>
            <div class="clear"></div>
            <div class="H10"></div>
            <div class="back-password-main">
                <form id="form1" url="/tools/submit_ajax.ashx?action=user_repassword">
                    <div class="form-item PDL480">
                        <label class="form-item-label">新密码<span class="red">*</span>：</label>
                        <input type="password" class="form-item-input W330" name="txtPassword" datatype="*6-20" nullmsg="请输入新密码" errormsg="密码范围在6-20位之间" sucmsg=" ">
                    </div>
                    <div class="form-item PDL480">
                        <label class="form-item-label">确认密码<span class="red">*</span>：</label>
                        <input type="password" class="form-item-input W330" name="txtPasswordRep" datatype="*" recheck="txtPassword" nullmsg="请再输入一次密码" errormsg="两次输入的密码不一致" sucmsg=" ">
                    </div>
                    <div class="form-item-btn">
                        <span id="msgtip" class="msgtip"></span>
                        <button type="submit" class="icon-save-btn" id="btnSubmit">确认</button>
                    </div>
                </form>
            </div>
            <div class="H40"></div>
        </div>
        <div class="clear"></div>
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
