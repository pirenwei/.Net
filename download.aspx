<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="download.aspx.cs" Inherits="HT.Web.download" %>

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
    <div class="download_bg">
        <div class="download">
            <div class="download0">
                <img src="images/zyxc/mobile.png"  />
            </div>
            <div class="download5">
                <div class="download1">
                    <img src="images/zyxc/pingguo.png" />iOS下载
                </div>
                <div class="download2">
                    <img src="images/zyxc/anzhuo.png" />安卓下载
                </div>
                <div class="download3">
                    <img src="images/zyxc/code1.png" />
                    <p>（手机扫码下载）</p>
                </div>
            </div>
        </div>
    </div>
    <uc1:footer runat="server" ID="footer" />
</body>
</html>

