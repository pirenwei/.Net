<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="article_drjx_edit.aspx.cs" Inherits="HT.Web.admin.article.article_drjx_edit" %>

<!DOCTYPE html>

<%@ Import Namespace="HT.Common" %>

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

            $("#btnSubVideo").click(function () { SelectArticle(this, '#SubVideoHTML', 1, '<%=this.id%>'); });   //选择视频
            $("#btnSubArticle").click(function () { SelectArticle(this, '#SubArticleHTML', 2, '<%=this.id%>'); });   //选择文章
            $("#btnSubJxtt").click(function () { SelectArticle(this, '#SubJxttHTML', 3, '<%=this.id%>'); });   //选择头条
        });

        //选择文章弹出层
        function SelectArticle(obj, objDIV, type_id, main_id) {
            var objNum = arguments.length;
            var winDialog = top.dialog({
                id: 'winDialogId',
                title: '选择',
                width: '980px',
                height: '500px',
                url: 'dialog/dialog_article.aspx?type_id=' + type_id + "&main_id=" + main_id,
                onclose: function () {
                    var liHtml = this.returnValue; //获取返回值
                    var hidValue = "";
                    if (liHtml.length > 0) {
                        $(objDIV).children("ul").append(liHtml);
                        $(objDIV).find("li").each(function () {
                            hidValue += "," + $(this).children(":hidden").val();
                        })
                        $(objDIV).children(":hidden").val(hidValue);
                    }
                }
            }).showModal();
            //如果是修改状态，将对象传进去
            if (objNum == 1) {
                winDialog.data = obj;
            }
        }
        //删除图片LI节点
        function delImg(obj, article_id) {
            var hidValuesNew = "";
            $(obj).parents(".photo-list").find("li").each(function () {
                if ($(this).children(":hidden").val() != article_id) {
                    hidValuesNew += "," + $(this).children(":hidden").val();
                }
            })
            $(obj).parents(".photo-list").children(":hidden").val(hidValuesNew);

            var parentObj = $(obj).parent().parent();
            var focusPhotoObj = parentObj.parent().siblings(".focus-photo");
            var smallImg = $(obj).siblings(".img-box").children("img").attr("src");
            $(obj).parent().remove(); //删除的LI节点
            //检查是否为封面
            if (focusPhotoObj.val() == smallImg) {
                focusPhotoObj.val("");
                var firtImgBox = parentObj.find("li .img-box").eq(0); //取第一张做为封面
                firtImgBox.addClass("selected");
                focusPhotoObj.val(firtImgBox.children("img").attr("src")); //重新给封面的隐藏域赋值
            }
        }
    </script>
</head>

<body class="mainbody">
    <form id="form1" runat="server">
        <!--导航栏-->
        <div class="location">
            <a href="article_drjx_list.aspx" class="back"><i></i><span>返回列表页</span></a>
            <a href="../center.aspx" class="home"><i></i><span>首页</span></a>
            <i class="arrow"></i>
            <a href="article_drjx_list.aspx"><span>内容管理</span></a>
            <i class="arrow"></i>
            <span>编辑内容</span>
        </div>
        <div class="line10"></div>
        <!--/导航栏-->

        <!--内容-->
        <div id="floatHead" class="content-tab-wrap">
            <div class="content-tab">
                <div class="content-tab-ul-wrap">
                    <ul>
                        <li><a class="selected" href="javascript:;">基本信息</a></li>
                        <li><a href="javascript:;">精选内容</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="tab-content">
            <dl>
                <dt>显示状态</dt>
                <dd>
                    <div class="rule-multi-radio">
                        <asp:RadioButtonList ID="rblStatus" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                            <asp:ListItem Value="0" Selected="True">正常</asp:ListItem>
                            <asp:ListItem Value="1">待审核</asp:ListItem>
                            <asp:ListItem Value="2">不显示</asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                </dd>
            </dl>
            <dl>
                <dt>内容标题</dt>
                <dd>
                    <asp:TextBox ID="txtTitle" runat="server" CssClass="input normal" datatype="*2-100" sucmsg=" " />
                    <span class="Validform_checktip">*标题最多100个字符</span>
                </dd>
            </dl>
            <dl>
                <dt>封面图片</dt>
                <dd>
                    <asp:TextBox ID="txtImgUrl" runat="server" CssClass="input normal upload-path" />
                    <div class="upload-box upload-img"></div>
                    &nbsp;<a href="javascript:void(0)" id="linkImgUrl">查看</a>
                </dd>
            </dl>
            <dl>
                <dt>浏览次数</dt>
                <dd>
                    <asp:TextBox ID="txtClick" runat="server" CssClass="input small" datatype="n" sucmsg=" ">0</asp:TextBox>
                    <span class="Validform_checktip">点击浏览该信息自动+1</span>
                </dd>
            </dl>
            <dl>
                <dt>标签</dt>
                <dd>
                    <asp:TextBox ID="txtTags" runat="server" CssClass="input normal" />
                    <span class="Validform_checktip">以逗号分隔</span>
                </dd>
            </dl>
            <dl>
                <dt>达人介绍</dt>
                <dd>
                    <asp:TextBox ID="txtZhaiyao" runat="server" Width="80%" Height="100" CssClass="input" TextMode="MultiLine" datatype="*0-2000" sucmsg=" "></asp:TextBox>
                    <span class="Validform_checktip">*</span>
                </dd>
            </dl>
            <dl>
                <dt>发布时间</dt>
                <dd>
                    <asp:TextBox ID="txtAddTime" runat="server" CssClass="input rule-date-input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" datatype="/^\s*$|^\d{4}\-\d{1,2}\-\d{1,2}\s{1}(\d{1,2}:){2}\d{1,2}$/" errormsg="请选择正确的日期" sucmsg=" " />
                    <span class="Validform_checktip">不选择默认当前发布时间</span>
                </dd>
            </dl>
        </div>
        <div class="tab-content" style="display: none">
            <dl>
                <dt>达人视频</dt>
                <dd>
                    <div class="table-container" style="height: 215px; overflow: auto">
                        <table border="0" cellspacing="0" cellpadding="0" class="border-table" width="80%">
                            <tr>
                                <th style="text-align: left; padding: 5px">
                                    <input type="button" value="选择内容" id="btnSubVideo" class="btn" /></th>
                            </tr>
                        </table>
                        <div class="photo-list" id="SubVideoHTML">
                            <ul>
                                <asp:Repeater ID="rptVideo" runat="server">
                                    <ItemTemplate>
                                        <li>
                                            <input type="hidden" value="<%#Eval("id")%>" />
                                            <div class="img-box" onclick="setFocusImg(this);">
                                                <img src="<%#Eval("img_url")%>" />
                                                <span class="remark"><i><%#Eval("title").ToString() == "" ? "暂无描述..." : Eval("title").ToString()%></i></span>
                                            </div>
                                            <a target="_blank" title="点击查看" href="/video_detail.aspx?cid=<%#Eval("cid") %>">查看</a>
                                            <a href="javascript:;" onclick="delImg(this,<%#Eval("id")%>);">删除</a>
                                        </li>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </ul>
                            <asp:HiddenField runat="server" ID="hidVideos" />
                        </div>
                    </div>
                </dd>
            </dl>
            <dl>
                <dt>达人文章</dt>
                <dd>
                    <div class="table-container" style="height: 215px; overflow: auto">
                        <table border="0" cellspacing="0" cellpadding="0" class="border-table" width="80%">
                            <tr>
                                <th style="text-align: left; padding: 5px">
                                    <input type="button" value="选择内容" id="btnSubArticle" class="btn" /></th>
                            </tr>
                        </table>
                        <div class="photo-list" id="SubArticleHTML">
                            <ul>
                                <asp:Repeater ID="rptArticle" runat="server">
                                    <ItemTemplate>
                                        <li>
                                            <input type="hidden" value="<%#Eval("id")%>" />
                                            <div class="img-box" onclick="setFocusImg(this);">
                                                <img src="<%#Eval("img_url")%>" />
                                                <span class="remark"><i><%#Eval("title").ToString() == "" ? "暂无描述..." : Eval("title").ToString()%></i></span>
                                            </div>
                                            <a target="_blank" title="点击查看" href="<%#HT.Web.UI.WebUI.GetDataLink(Utils.ObjToInt(Eval("id")),3) %>">查看</a>
                                            <a href="javascript:;" onclick="delImg(this,<%#Eval("id")%>);">删除</a>
                                        </li>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </ul>
                            <asp:HiddenField runat="server" ID="hidArticle" />
                        </div>
                    </div>
                </dd>
            </dl>
            <dl>
                <dt>精选头条</dt>
                <dd>
                    <div class="table-container" style="height: 215px; overflow: auto">
                        <table border="0" cellspacing="0" cellpadding="0" class="border-table" width="80%">
                            <tr>
                                <th style="text-align: left; padding: 5px">
                                    <input type="button" value="选择内容" id="btnSubJxtt" class="btn" /></th>
                            </tr>
                        </table>
                        <div class="photo-list" id="SubJxttHTML">
                            <ul>
                                <asp:Repeater ID="rptJxtt" runat="server">
                                    <ItemTemplate>
                                        <li>
                                            <input type="hidden" value="<%#Eval("id")%>"/>
                                            <div class="img-box" onclick="setFocusImg(this);">
                                                <img src="<%#Eval("img_url")%>" />
                                                <span class="remark"><i><%#Eval("title").ToString() == "" ? "暂无描述..." : Eval("title").ToString()%></i></span>
                                            </div>
                                            <a target="_blank" title="点击查看" href="<%#HT.Web.UI.WebUI.GetDataLink(Utils.ObjToInt(Eval("id")),3) %>">查看</a>
                                            <a href="javascript:;" onclick="delImg(this,<%#Eval("id")%>);">删除</a>
                                        </li>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </ul>
                            <asp:HiddenField runat="server" ID="hidJxtt"/>
                        </div>
                    </div>
                </dd>
            </dl>
        </div>
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




