<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="publish_tourism.aspx.cs" Inherits="HT.Web.publish_tourism" %>

<%@ Register Src="~/ucl/footer.ascx" TagPrefix="uc1" TagName="footer" %>
<%@ Register Src="~/ucl/header.ascx" TagPrefix="uc1" TagName="header" %>
<%@ Register Src="~/ucl/links.ascx" TagPrefix="uc1" TagName="links" %>

<%@ Import Namespace="HT.Common" %>
<%@ Import Namespace="HT.Web.UI" %>

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
<div class="container">
    <div class="page-loct"><a href="index.aspx">首页</a> > <a href="tourism_list.aspx">主题旅游</a> > <span>发布作品</span> </div>
</div>
<div class="container main">
    <div class="page-left MR20">
        <div class="page-bg PD20">
            <div class="release1_title">
                <p>发表作品</p>
            </div>
            <form action="#" id="form1" url="/tools/submit_ajax.ashx?action=user_article_publish">
                <div class="Release-strategy-item">
                    <label class="col_1">标题：</label>
                    <input type="text" class="k W100" name="txtTitle" datatype="*2-100" nullmsg="请输入标题" sucmsg=" "/>
                </div>
                <div class="Release-strategy-item">
                    <label class="col_1">内容：</label>
                    <textarea class="editor-mini" style="visibility: hidden;" name="txtContent" datatype="*1-5000" nullmsg="请输入内容" sucmsg=" "></textarea>
                </div>
                <div class="Release-strategy-item">
                    <label class="col_1">验证码：</label>
	                <dl>
	                    <dd><input type="text" class="k W90" placeholder="验证码" name="txtCodeYZM" datatype="*4-6" nullmsg="请输入验证码" sucmsg=" "/></dd>
	                    <dd><a id="ToggleCode" href="javascript:;" onclick="ToggleCode('/tools/verify_code.ashx');return false;">
                            <img width="80" height="42" src="/tools/verify_code.ashx"/></a></dd>
	                    <dd><span><a href="javascript:;" onclick="ToggleCode('/tools/verify_code.ashx');return false;">看不清！换一张</a></span></dd>
	                </dl>
                    <span id="msgtip" class="msgtip"></span>
                    <div class="Release-btn">
                        <input type="hidden" value="5" name="channel_id"/>
                        <label><input type="checkbox" name="ckbIsOpen"/>不公开</label>
                        <button type="submit" class="Release-btn1" id="btnSubmit">发 表</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <div class="page-right">
        <div class="page-bg">
             <div class="popular-search-title">
                  <span>周边旅游推荐</span>
             </div> 
             <div class="news2-detail-raiders">
               <ul>
                   <asp:Repeater runat="server" ID="rptListXG">
                       <ItemTemplate>
                        <li class="H90">
                            <a href="tourism_detail.aspx?cid=<%#Eval("cid") %>">
                            <label style="cursor:pointer"><img src="<%#Eval("img_url") %>" alt=""></label>
                            <p class="title"><%#Eval("title") %></p>
                            <div class="H20"></div>
                            <p class="time"><%#WebUI.GetCommentCount(Eval("id"),(int)HTEnums.DataFKType.Article)%>人点评</p>
                            </a>
                         </li>
                       </ItemTemplate>
                   </asp:Repeater>
               </ul>
           </div>
        </div>
    </div>
</div>
<div class="H20"></div>
<uc1:footer runat="server" id="footer" />
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
</body>
</html>

