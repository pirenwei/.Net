<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="error.aspx.cs" Inherits="HT.Web.error" %>

<%@ Register Src="~/ucl/footer.ascx" TagPrefix="uc1" TagName="footer" %>
<%@ Register Src="~/ucl/header.ascx" TagPrefix="uc1" TagName="header" %>
<%@ Register Src="~/ucl/links.ascx" TagPrefix="uc1" TagName="links" %>

<!DOCTYPE html>
<html lang="zh">
<head>
  <title><%=HT.Web.UI.WebUI.config.webtitle %></title>
    <meta name="keywords" content="<%=HT.Web.UI.WebUI.config.webkeyword %>">
  <meta name="description" content="<%=HT.Web.UI.WebUI.config.webdescription %>">
  <uc1:links runat="server" id="links" />
</head>
<body>
<uc1:header runat="server" id="header" />
    <div style="height:400px">
        <input type="hidden" id="hidMsg" value="<%=msg %>"/>
    </div>
<uc1:footer runat="server" id="footer" />
<script type="text/javascript">
    $(function () {
        layer.msg($("#hidMsg").val());
        setTimeout(function () {
            location.href = "/index.aspx";
        }, 5000);
    })
</script>
</body>
</html>
