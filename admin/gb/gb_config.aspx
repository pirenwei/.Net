<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="gb_config.aspx.cs" Inherits="HT.Web.admin.gb.gb_config" ValidateRequest="false" %>

<%@ Import Namespace="HT.Common" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <title>G币任务参数设置</title>
    <link href="../../scripts/artdialog/ui-dialog.css" rel="stylesheet" type="text/css" />
    <link href="../skin/default/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" charset="utf-8" src="../../scripts/jquery/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../../scripts/jquery/Validform_v5.3.2_min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../../scripts/artdialog/dialog-plus-min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../js/laymain.js"></script>
    <script type="text/javascript" charset="utf-8" src="../js/common.js"></script>
    <script type="text/javascript">
        $(function () {
            //初始化表单验证
            $("#form1").initValidform();
        });
    </script>
</head>

<body class="mainbody">
    <form id="form1" runat="server">
        <!--导航栏-->
        <div class="location">
            <a href="javascript:history.back(-1);" class="back"><i></i><span>返回上一页</span></a>
            <a href="../center.aspx" class="home"><i></i><span>首页</span></a>
            <i class="arrow"></i>
            <span>G币任务参数设置</span>
        </div>
        <div class="line10"></div>
        <!--/导航栏-->

        <!--内容-->
        <div id="floatHead" class="content-tab-wrap">
            <div class="content-tab">
                <div class="content-tab-ul-wrap">
                    <ul>
                        <li><a class="selected" href="javascript:;">G币任务参数设置</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <!--参数设置-->
        <div class="tab-content">
            <dl>
                <dt>初级任务G币奖励</dt>
                <dd>
                    <asp:TextBox ID="txtValue1" runat="server" CssClass="input normal" datatype="n" sucmsg=" " />
                    <span class="Validform_checktip">*G币</span>
                </dd>
            </dl>
            <dl>
                <dt>初级任务名称</dt>
                <dd>
                    <asp:TextBox ID="txtTitle1" runat="server" CssClass="input normal" datatype="*1-20" sucmsg=" " />
                    <span class="Validform_checktip">*完善个人信息</span>
                </dd>
            </dl>
            <dl>
                <dt>初级任务备注</dt>
                <dd>
                    <asp:TextBox ID="txtRemark1" runat="server" CssClass="input normal" datatype="*0-100" sucmsg=" " />
                    <span class="Validform_checktip">*</span>
                </dd>
            </dl>
            <hr />
            <dl>
                <dt>分享任务G币奖励</dt>
                <dd>
                    <asp:TextBox ID="txtValue2" runat="server" CssClass="input normal" datatype="n" sucmsg=" " />
                    <span class="Validform_checktip">*G币</span>
                </dd>
            </dl>
            <dl>
                <dt>分享任务名称</dt>
                <dd>
                    <asp:TextBox ID="txtTitle2" runat="server" CssClass="input normal" datatype="*1-20" sucmsg=" " />
                    <span class="Validform_checktip">*将本网站分享到其他平台</span>
                </dd>
            </dl>
            <dl>
                <dt>分享任务备注</dt>
                <dd>
                    <asp:TextBox ID="txtRemark2" runat="server" CssClass="input normal" datatype="*0-100" sucmsg=" " />
                    <span class="Validform_checktip">*</span>
                </dd>
            </dl>
            <hr />
            <dl>
                <dt>日常任务G币奖励</dt>
                <dd>
                    <asp:TextBox ID="txtValue3" runat="server" CssClass="input normal" datatype="n" sucmsg=" " />
                    <span class="Validform_checktip">*G币</span>
                </dd>
            </dl>
            <dl>
                <dt>日常任务名称</dt>
                <dd>
                    <asp:TextBox ID="txtTitle3" runat="server" CssClass="input normal" datatype="*1-20" sucmsg=" " />
                    <span class="Validform_checktip">*发布点评</span>
                </dd>
            </dl>
            <dl>
                <dt>日常任务备注</dt>
                <dd>
                    <asp:TextBox ID="txtRemark3" runat="server" CssClass="input normal" datatype="*0-100" sucmsg=" " />
                    <span class="Validform_checktip">*</span>
                </dd>
            </dl>
            <hr />
            <dl>
                <dt>升级任务G币奖励</dt>
                <dd>
                    <asp:TextBox ID="txtValue4" runat="server" CssClass="input normal" datatype="n" sucmsg=" " />
                    <span class="Validform_checktip">*G币</span>
                </dd>
            </dl>
            <dl>
                <dt>升级任务名称</dt>
                <dd>
                    <asp:TextBox ID="txtTitle4" runat="server" CssClass="input normal" datatype="*1-20" sucmsg=" " />
                    <span class="Validform_checktip">*发布旅游攻略或摄影图片</span>
                </dd>
            </dl>
            <dl>
                <dt>升级任务备注</dt>
                <dd>
                    <asp:TextBox ID="txtRemark4" runat="server" CssClass="input normal" datatype="*0-100" sucmsg=" " />
                    <span class="Validform_checktip">*</span>
                </dd>
            </dl>
        </div>
        <!--/参数设置-->

        <!--/内容-->

        <!--工具栏-->
        <div class="page-footer">
            <div class="btn-wrap">
                <asp:Button ID="btnSubmit" runat="server" Text="提交保存" CssClass="btn" OnClick="btnSubmit_Click" />
                <input name="btnReturn" type="button" value="返回上一页" class="btn yellow" onclick="javascript: history.back(-1);" />
            </div>
        </div>
        <!--/工具栏-->
    </form>
</body>
</html>
