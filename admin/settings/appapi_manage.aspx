<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="appapi_manage.aspx.cs" Inherits="HT.Web.admin.settings.appapi_manage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <title>编辑内容</title>
    <link href="../../scripts/artdialog/ui-dialog.css" rel="stylesheet" type="text/css" />
    <link href="../skin/default/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" charset="utf-8" src="../../scripts/jquery/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../../scripts/jquery/Validform_v5.3.2_min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../../scripts/datepicker/WdatePicker.js"></script>
    <script type="text/javascript" charset="utf-8" src="../../scripts/artdialog/dialog-plus-min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../../scripts/webuploader/webuploader.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../../editor/kindeditor-min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../js/uploader.js"></script>
    <script type="text/javascript" charset="utf-8" src="../js/laymain.js"></script>
    <script type="text/javascript" charset="utf-8" src="../js/common.js"></script>
    <script type="text/javascript">
        $(function () {
            //初始化表单验证
            $("#form1").initValidform();

            var editorMini = KindEditor.create('.editor-mini', {
                width: '60%',
                height: '150px',
                resizeType: 1,
                uploadJson: '../../tools/upload_ajax.ashx?action=EditorFile&IsWater=1',
                items: [
                   'source', '|','fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
                   'removeformat', 'lineheight', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
                   'insertunorderedlist', '|', 'emoticons', 'image', 'link', 'fullscreen', 'preview', 'quickformat']
            });

        });
    </script>
</head>
<body class="mainbody">
    <form id="form1" runat="server">

        <!--导航栏-->
        <div class="location">
            <a href="appapi_query.aspx" class="back"><i></i><span>返回列表页</span></a> <a href="../center.aspx"
                class="home"><i></i><span>首页</span></a> <i class="arrow"></i><a href="appapi_query.aspx">
                    <span>APP接口管理</span></a><i class="arrow"></i><span>编辑APP接口</span>
        </div>
        <div class="line10">
        </div>
        <!--/导航栏-->
        <!--内容-->
        <div id="floatHead" class="content-tab-wrap">
            <div class="content-tab">
                <div class="content-tab-ul-wrap">
                    <ul>
                        <li><a href="javascript:;" onclick="tabs(this);" class="selected">基本信息</a></li>

                    </ul>
                </div>
            </div>
        </div>
        <div class="tab-content">

            <dl>
                <dt>APP接口标题</dt>
                <dd>
                    <asp:TextBox ID="txtname" runat="server" Width="400" CssClass="input normal" datatype="*"
                        sucmsg=" "></asp:TextBox>
                    <span class="Validform_checktip">*</span></dd>
            </dl>
            <dl>
                <dt>url</dt>
                <dd>
                    <asp:TextBox ID="txturl" runat="server" TextMode="MultiLine" Width="400" CssClass="input normal" datatype="*"
                        sucmsg=" "></asp:TextBox>
                    <span class="Validform_checktip">*</span></dd>
            </dl>

            <dl>
                <dt>排序字段</dt>
                <dd>
                    <asp:TextBox ID="txtSort" runat="server" CssClass="input small" datatype="n" sucmsg=" ">99</asp:TextBox>
                    <span class="Validform_checktip">*数字，越小越向前</span></dd>
            </dl>
            <dl>
                <dt>推荐类型</dt>
                <dd>
                    <div class="rule-multi-checkbox">
                        <asp:CheckBoxList ID="cblItem" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                            <asp:ListItem Value="1">置顶</asp:ListItem>
                            <asp:ListItem Value="1">标记</asp:ListItem>
                        </asp:CheckBoxList>

                    </div>

                </dd>
            </dl>
            <dl>
                <dt>提交参数</dt>
                <dd>
                    <textarea runat="server" id="txtrequest_parameter" class="editor-mini" style="visibility: hidden;"></textarea>
                </dd>
            </dl>
            <dl>
                <dt>回发参数</dt>
                <dd>
                    <textarea runat="server" id="txtreturn_parameter" class="editor-mini" style="visibility: hidden;"></textarea>
                </dd>
            </dl>
            <dl style="display:none">
                <dt>备注</dt>
                <dd>
                    <textarea runat="server" id="txtremark" class="editor-mini" style="visibility: hidden;"></textarea>
                </dd>
            </dl>

        </div>

        <!--/内容-->
        <!--工具栏-->
        <div class="page-footer">
            <div class="btn-list">
                <asp:Button ID="btnSubmit" runat="server" Text="提交保存" CssClass="btn" OnClick="btnSubmit_Click" />
                <input name="btnReturn" type="button" value="返回上一页" class="btn yellow" onclick="javascript: history.back(-1);" />
            </div>
            <div class="clear">
            </div>
        </div>
        <!--/工具栏-->
    </form>
</body>
</html>
