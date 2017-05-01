<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="HT.Web.login" %>

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
    <div class="login_banner">
        <div class="login">
            <div class="login_tu">
                <h1>用户登录</h1>
                <div class="H20"></div>
                <div class="login_cent">
                    <form id="form1" url="/tools/submit_ajax.ashx?action=user_login">
                        <label>登录名：</label>
                        <div class="H10"></div>
                        <div class="Name">
                            <input type="text" class="txt" name="txtUserName" placeholder="请输入手机号/用户名" datatype="*" nullmsg="请输入手机号/邮箱" sucmsg=" " />
                        </div>
                        <div class="H20"></div>
                        <label>密码：</label>
                        <div class="H10"></div>
                        <div class="password">
                            <input type="password" class="txt" name="txtPassword" placeholder="请输入密码" datatype="*" nullmsg="请输入密码" sucmsg=" " />
                        </div>
                        <div class="login_zd">
                            <span class="loreft">
                                <img src="images/img/pc06.png" />&nbsp;<a href="#">自动登录</a></span>
                            <span class="loright">
                                <a href="back_password.aspx">忘记密码?</a></span>
                        </div>
                        <div class="H10"></div>
                        <span id="msgtip" class="msgtip"></span>
                        <div class="btnlogin">
                            <input type="hidden" name="hdUrlReferrer" value="<%=UrlReferrer %>" />
                            <button type="submit" class="icon-save-btn" id="btnSubmit">登录</button>
                        </div>
                    </form>
                    <div class="H10"></div>
                    <div class="btnzc"><span>还没账号，现在就去<a href="register.aspx">注册！</a></span></div>
                    <div class="login_qq">
                        <ul>
                            <li><a target="_blank" href="/api/oauth/qq/index.aspx">
                                <img src="images/img/pc02.png" /></a><p>腾讯QQ登录</p>
                            </li>
                            <li class="current"><a target="_blank" href="/api/oauth/weixin/index.aspx"></a>
                                <p>微信扫描登录</p>
                            </li>
                            <li><a target="_blank" href="/api/oauth/sina/index.aspx">
                                <img src="images/img/pc04.png" /></a><p>新浪微博登录</p>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
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
