<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="discussion_area_detail.aspx.cs" Inherits="HT.Web.discussion_area_detail" %>

<%@ Register Src="~/ucl/footer.ascx" TagPrefix="uc1" TagName="footer" %>
<%@ Register Src="~/ucl/header.ascx" TagPrefix="uc1" TagName="header" %>
<%@ Register Src="~/ucl/links.ascx" TagPrefix="uc1" TagName="links" %>

<%@ Import Namespace="HT.Common"%>

<!DOCTYPE html>
<html lang="zh">
<head>
  <title><%=model.title %></title>
    <meta name="keywords" content="<%=HT.Web.UI.WebUI.config.webkeyword %>">
  <meta name="description" content="<%=HT.Web.UI.WebUI.config.webdescription %>">
  <uc1:links runat="server" id="links" />
</head>
<body>
<uc1:header runat="server" id="header" />
<div class="container">
     <div class="page-loct"><a href="index.aspx">首页</a> > <a href="discussion_area.aspx">讨论区</a> > <a href="discussion_area.aspx?category_id=<%=model.category_id %>"><%=new HT.BLL.ht_bbs_category().GetTitle(model.category_id) %></a>   >  <span><%=model.title %></span></div>
</div>
<div class="container">
     <div class="discussion-area-detail-title">
         <span>分类：<%=new HT.BLL.ht_bbs_category().GetTitle(model.category_id) %></span>
         <em><%=model.title %></em>
          <%#model.is_elite==1?"<i class=\"jing\">精</i>":"" %>
          <%#model.is_top==1?"<img src=\"/images/e/pic110.png\">":"" %>
     </div>
     <div class="discussion-area-detail-item">
          <div class="item-user">
               <div class="user">
                   <span class="img"><img src="<%=GetUserModel(model.user_id).avatar %>" alt=""></span>
                   <p class="col_11"><span class="color3">用户名：</span><%=GetUserModel(model.user_id).user_name %></p>
                   <p class="col_11"><span class="color3">G币：</span><%=GetUserModel(model.user_id).point %></p>
                   <p class="col_22"><em class="index1">回应</em><i>/</i><em>浏览数：</em></p>
                   <p class="col_22"><em class="index1"><%=new HT.BLL.ht_bbs_topic().GetCountReply(Utils.ObjToInt(model.id))%></em><i>/</i><em><%=model.click %></em></p>
               </div>
          </div>
          <div class="item-introduct">
               <div class="publish-time">
                  <span class="icon-publish-btn"></span>
                  <em>发表于 <%=string.Format("{0:yyyy-MM-dd HH:mm:ss}",model.add_time)%></em>
                  <i>楼主</i>
               </div>
               <div class="item-introduct-content">
                   <%=model.content %>
               </div>
               <div class="item-introduct-reply">
                  <a href="#PublishRepy" class=""><i class="icon-reply-btn"></i>回复</a>
               </div>
          </div>
     </div>

    <asp:Repeater runat="server" ID="rptList">
        <ItemTemplate>
        <div class="discussion-area-detail-item">
              <div class="item-user">
                   <div class="user">
                       <span class="img"><img src="<%#GetUserModel(Utils.ObjToInt(Eval("user_id"))).avatar %>" alt=""></span>
                       <p class="col_11"><span class="color3">用户名：</span><%#GetUserModel(Utils.ObjToInt(Eval("user_id"))).user_name %></p>
                       <p class="col_11"><span class="color3">G币：</span><%#GetUserModel(Utils.ObjToInt(Eval("user_id"))).point %></p>
                   </div>
              </div>
              <div class="item-introduct">
                   <div class="publish-time">
                      <span class="icon-publish-btn"></span>
                      <em>发表于 <%#string.Format("{0:yyyy-MM-dd HH:mm:ss}",Eval("add_time"))%></em>
                      <i><%# Container.ItemIndex + 1 + (this.page - 1) * pageSize%>楼</i>
                   </div>
                   <div class="item-introduct-reply-content">
                       <div class="reply-content2">
                         <%#Eval("content") %>
                       </div>
                   </div>
                   <div class="item-introduct-reply">
                      <a href="#PublishRepy" class=""><i class="icon-reply-btn"></i>回复</a>
                   </div>
              </div>
         </div>
        </ItemTemplate>
    </asp:Repeater>
    <div id="PageContent" runat="server" class="page-class"></div>

     <div class="H20"></div>
     <div class="page-tab-title" id="PublishRepy">
         <ul>
           <li class="active"><span>发表回复</span></li>
         </ul>
    </div>
    <div class="post-form-box">
        <form action="#" id="form1" url="/tools/submit_ajax.ashx?action=user_bbs_reply_add">  
            <div class="post-form-textarea PDL78">
                <label class="col_1">内容：</label>
                <textarea name="txtContent" class="editor-mini" style="visibility: hidden;" datatype="*" nullmsg="请输入内容" sucmsg=" "></textarea>
                 <%if(GetUser()==null){%>
                <div class="post-tip-box">
                    <div class="post-tip">
                        <p>您需要先登录，才可以发帖</p>
                        <p><a href="login.aspx">登录</a> | <a href="register.aspx">注册</a></p>
                    </div>
                </div>
                <%} %>
            </div>
            <div class="H20"></div>
            <%if(GetUser()!=null){%>
            <div class="post-form-item PDL78">
                <label class="col_1">验证码：</label>
                <input type="text" name="txtCodeYZM" placeholder="6-32个字符" class="k W112" datatype="*" nullmsg="请输入验证码" sucmsg=" "/>
                <a id="ToggleCode" href="javascript:;" onclick="ToggleCode('/tools/verify_code.ashx');return false;">
                    <img width="80" height="30" src="/tools/verify_code.ashx"/></a>
            </div>
            <span id="msgtip" class="msgtip"></span>
            <div class="post-form-btn PDL78">
                <input type="hidden" value="<%=model.id %>" name="hdTopicId"/>
                <button type="submit" class="icon-post2-btn" id="btnSubmit">发 表</button>
            </div>
             <%} %>
       </form>
    </div>
     
</div>
<div class="H20"></div>
<uc1:footer runat="server" id="footer" />
<script type="text/javascript" charset="utf-8" src="/editor/kindeditor-min.js"></script>
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
    })
</script>
</body>
</html>



