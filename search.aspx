<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="search.aspx.cs" Inherits="HT.Web.search" %>

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
  <style type="text/css">
    .hr-line-dashed{border-top:1px dashed #e7eaec;color:#fff;background-color:#fff;height:1px;margin:20px 0}
    .search-form-b { margin-top: 10px; }
    .search-result h3 { margin-bottom: 0; color: #1E0FBE; font-weight:bold; height:32px; overflow:hidden}
    .search-result .search-link { color: #006621; }
    .search-result p { font-size: 12px; margin-top: 5px; }
    .wrapper { padding: 0 20px; color: #676a6c; font-family: "open sans","Helvetica Neue",Helvetica,Arial,sans-serif;}
    .wrapper-content { padding: 20px; }
    .row { margin-right: -15px; margin-left: -15px; }
    .col-xs-12 { position: relative; min-height: 1px; padding-right: 15px; padding-left: 15px; float: left;width: 100%;}
    .ibox-content { width:100%; background-color: #fff; color: inherit; padding: 15px 20px 20px; border-color: #e7eaec; border-image: none; border-style: solid solid none; border-width: 1px 0; }
    .ibox-content h2 { font-size:16px;}
    .form-control { float:left; width:900px;border: 1px solid #e5e6e7;color: inherit; display:inline-block; padding: 10px 18px;font-size: 14px; }
    .btn-primary {color: #fff;background-color: #06A9ED;border-color: #2e6da4;}
    .btn { font-size: 16px;border-radius: 3px; display: inline-block;padding: 8px 23px;margin-bottom: 0;font-weight: 400;text-align: center;white-space: nowrap;vertical-align: middle;cursor: pointer;border: 1px solid transparent;}
    .text-navy { color: #1ab394; }
    .search-result em {color:red;}
      .input-group-btn { float:left; }
      .search_result_img { width:115px;height:77px;float:left;margin-right:15px; }
      .search_result_img img { width:115px;height:77px; }
  </style>
</head>
<body>
<uc1:header runat="server" id="header" />
<div class="container">
     <div class="page-loct" style=" margin-bottom:0;"><a href="/index.aspx">首页</a> > <span>搜索结果</span></div>
</div>
<div class="container">
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                        <h2>
                                为您找到相关结果约<%=totalCount %>个： <span class="text-navy">“<%=keywords %>”</span>
                            </h2>
                        <small>搜索用时  (<%=totalTime %>秒)</small>

                        <div class="search-form-b">
                            <form action="search.aspx" method="get">
                                <div class="input-group">
                                    <div class="input-group-btn">
                                    <select name="type" class="dropdown">
                                        <option value="">全站</option>
                                        <asp:Repeater runat="server" ID="rptListDataType">
                                            <ItemTemplate>
                                                <option <%#Eval("type").ToString()==this.type?"selected=\"selected\"":"" %> value="<%#Eval("type") %>"><%#Eval("title") %></option>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </select>
                                    </div>
                                    
                                    <div class="input-group-btn">
                                        <input type="text" placeholder="关键词搜索" name="keyword" class="form-control input-lg">
                                        <button class="btn btn-lg btn-primary" type="submit">
                                            搜索
                                        </button>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                            </form>
                        </div>
                        <div class="hr-line-dashed"></div>

                        <asp:Repeater runat="server" ID="rptList">
                           <ItemTemplate>
                            <div class="search_result_img">
                                <a target="_blank" href="<%#WebUI.GetDataLink(Eval("id"),Eval("fk_type")) %>">
                                    <img src="<%#Eval("img_url").ToString()==""?"/images/logo.png":""+Eval("img_url") %>" /></a>
                            </div>
                            <div class="search-result">
                                <h3><a target="_blank" href="<%#WebUI.GetDataLink(Eval("id"),Eval("fk_type")) %>" style="color:#337ab7; font-size:18px;">
【<%#WebUI.GetDataType(Eval("id"),Eval("fk_type")) %>】<%#Eval("title").ToString().Replace(keywords,"<em>"+keywords+"</em>") %></a></h3>
                                <a target="_blank" href="<%#WebUI.GetDataLink(Eval("id"),Eval("fk_type")) %>" class="search-link">http://<%#HTRequest.GetCurrentFullHost()%><%#WebUI.GetDataLink(Eval("id"),Eval("fk_type")) %></a>
                                <p>
                                    <%#Eval("zhaiyao") %>
                                </p>
                            </div>
                            <div class="clear"></div>
                            <div class="hr-line-dashed"></div>
                           </ItemTemplate>
                           <FooterTemplate>
                               <%#rptList.Items.Count == 0 ? "<li>無任何結果</li>" : ""%>
                           </FooterTemplate>
                       </asp:Repeater>

                        <div id="PageContent" runat="server" class="page-class bg"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
<uc1:footer runat="server" id="footer" />
</body>
</html>

