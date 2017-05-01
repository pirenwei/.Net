<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ads_edit.aspx.cs" Inherits="HT.Web.admin.ads.ads_edit" %>

<!DOCTYPE html>

<%@ Import Namespace="HT.Common" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <title>编辑广告</title>
    <link href="../../scripts/artdialog/ui-dialog.css" rel="stylesheet" type="text/css" />
    <link href="../skin/default/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" charset="utf-8" src="../../scripts/jquery/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../../scripts/jquery/Validform_v5.3.2_min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../../scripts/datepicker/WdatePicker.js"></script>
    <script type="text/javascript" charset="utf-8" src="../../scripts/artdialog/dialog-plus-min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../../scripts/webuploader/webuploader.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../js/uploader.js"></script>
    <script type="text/javascript" charset="utf-8" src="../js/laymain.js"></script>
    <script type="text/javascript" charset="utf-8" src="../js/common.js"></script>
    <script type="text/javascript" charset="utf-8" src="../../scripts/layer/layer.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#linkImgUrl").click(function () {
                layer.open({
                    type: 1,
                    title: '查看图片',
                    shadeClose: true,
                    shade: 0.8,
                    area: ['800px', '90%'],
                    content: '<img src=' + $("#txtImgUrl").val() + ' width="100%"  />'
                });
            })
            //初始化表单验证
            $("#form1").initValidform();
            //初始化上传控件
            $(".upload-img").InitUploader({ filesize: "<%=siteConfig.imgsize %>", sendurl: "../../tools/upload_ajax.ashx", swf: "../../scripts/webuploader/uploader.swf", filetypes: "<%=siteConfig.fileextension %>" });
        });
    </script>
</head>

<body class="mainbody">
    <form id="form1" runat="server">
        <!--导航栏-->
        <div class="location">
          <a href="ads_list.aspx" class="back"><i></i><span>返回列表页</span></a>
          <a href="../center.aspx" class="home"><i></i><span>首页</span></a>
          <i class="arrow"></i>
          <a href="ads_list.aspx"><span>广告设置</span></a>
          <i class="arrow"></i>
          <span>编辑广告</span>
        </div>
        <div class="line10"></div>
        <!--/导航栏-->

        <!--内容-->
        <div id="floatHead" class="content-tab-wrap">
          <div class="content-tab">
            <div class="content-tab-ul-wrap">
              <ul>
                <li><a class="selected" href="javascript:;">编辑广告</a></li>
              </ul>
            </div>
          </div>
        </div>

        <div class="tab-content">
            <dl>
                <dt>是否启用</dt>
                <dd>
                    <div class="rule-multi-radio">
                        <asp:RadioButtonList runat="server" ID="rblState" RepeatDirection="Horizontal">
                            <asp:ListItem Value="0" Selected="True">是</asp:ListItem>
                            <asp:ListItem Value="1">否</asp:ListItem>
                        </asp:RadioButtonList>        
                    </div>
                    <span class="Validform_checktip">*</span>
                </dd>
            </dl>
            <dl>
                <dt>广告位</dt>
                <dd>
                    <div class="rule-single-select">
                        <asp:DropDownList id="ddlCode" runat="server" datatype="*" errormsg="请选择广告位" sucmsg=" "></asp:DropDownList>
                    </div>
                </dd>
            </dl>
            <dl>
                <dt>标题</dt>
                <dd>
                    <asp:TextBox ID="txtTitle" runat="server" CssClass="input normal" datatype="*" sucmsg=" " ignore="ignore"></asp:TextBox>
                </dd>
            </dl>
            <dl>
                <dt>图片</dt>
                <dd>
                    <asp:TextBox ID="txtImgUrl" runat="server" CssClass="input normal upload-path"></asp:TextBox>
                    <div class="upload-box upload-img"></div>
                    &nbsp;<a  href="javascript:void(0)"  id="linkImgUrl">查看</a>
                </dd>
            </dl>
            <dl>
                <dt>链接</dt>
                <dd>
                    <asp:TextBox ID="txtLink_url" runat="server" CssClass="input normal" datatype="*" sucmsg=" ">#</asp:TextBox>
                </dd>
            </dl>
            <dl>
                <dt>排序数字</dt>
                <dd>
                    <asp:TextBox ID="txtSortId" runat="server" CssClass="input small" datatype="n" sucmsg=" ">99</asp:TextBox>
                    <span class="Validform_checktip">*数字，越小越向前</span></dd>
            </dl>
        </div>
        <!--/内容-->

        <!--工具栏-->
        <div class="page-footer">
            <div class="btn-list">
                <asp:Button ID="btnSubmit" runat="server" Text="提交保存" CssClass="btn" OnClick="btnSubmit_Click" />
                <input name="btnReturn" type="button" value="返回上一页" class="btn yellow" onclick="javascript: history.back(-1);" />
            </div>
            <div class="clear"></div>
        </div>
        <!--/工具栏-->

    </form>
</body>
</html>





