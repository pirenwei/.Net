<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="shop_edit.aspx.cs" Inherits="HT.Web.admin.travel.shop_edit" %>

<%@ Import namespace="HT.Common" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,initial-scale=1.0,user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<title>编辑信息</title>
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

        //初始化编辑器
        var editor = KindEditor.create('.editor', {
            width: '100%',
            height: '350px',
            resizeType: 1,
            uploadJson: '../../tools/upload_ajax.ashx?action=EditorFile&IsWater=1',
            fileManagerJson: '../../tools/upload_ajax.ashx?action=ManagerFile',
            allowFileManager: true
        });
        var editorMini = KindEditor.create('.editor-mini', {
            width: '100%',
            height: '250px',
            resizeType: 1,
            uploadJson: '../../tools/upload_ajax.ashx?action=EditorFile&IsWater=1',
            items: [
				'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
				'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
				'insertunorderedlist', '|', 'emoticons', 'image', 'link']
        });

        //初始化上传控件
        $(".upload-img").InitUploader({ filesize: "<%=siteConfig.imgsize %>", sendurl: "../../tools/upload_ajax.ashx", swf: "../../scripts/webuploader/uploader.swf", filetypes: "<%=siteConfig.fileextension %>" });
        $(".upload-album").InitUploader({ btntext: "批量上传", multiple: true, water: true, thumbnail: true, filesize: "<%=siteConfig.imgsize %>", sendurl: "../../tools/upload_ajax.ashx", swf: "../../scripts/webuploader/uploader.swf" });

        //设置封面图片的样式
        $(".photo-list ul li .img-box img").each(function () {
            if ($(this).attr("src") == $("#hidFocusPhoto").val()) {
                $(this).parent().addClass("selected");
            }
        });
    });
</script>
</head>

<body class="mainbody">
<form id="form1" runat="server">
<!--导航栏-->
<div class="location">
  <a href="shop_list.aspx" class="back"><i></i><span>返回列表页</span></a>
  <a href="../center.aspx" class="home"><i></i><span>首页</span></a>
  <i class="arrow"></i>
  <a href="shop_list.aspx"><span>景区管理</span></a>
  <i class="arrow"></i>
  <span>编辑信息</span>
</div>
<div class="line10"></div>
<!--/导航栏-->

<!--内容-->
<div id="floatHead" class="content-tab-wrap">
  <div class="content-tab">
    <div class="content-tab-ul-wrap">
      <ul>
        <li><a class="selected" href="javascript:;">基本信息</a></li>
        <li><a href="javascript:;">详细描述</a></li>
        <li><a href="javascript:;">SEO选项</a></li>
        <li><a href="javascript:;">店铺优惠劵</a></li>
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
    <dt>星级</dt>
    <dd>
      <div class="rule-single-select">
        <asp:DropDownList id="ddlStarLevel" runat="server" datatype="*" sucmsg=" ">
            <asp:ListItem Value="1">一星</asp:ListItem>
            <asp:ListItem Value="2">二星</asp:ListItem>
            <asp:ListItem Value="3">三星</asp:ListItem>
            <asp:ListItem Value="4">四星</asp:ListItem>
            <asp:ListItem Value="5">五星</asp:ListItem>
        </asp:DropDownList>
      </div>
    </dd>
  </dl>
  <dl>
    <dt>地区</dt>
    <dd>
      <div class="rule-single-select">
        <asp:DropDownList id="ddlArea" runat="server"></asp:DropDownList>
      </div>
    </dd>
  </dl>
  <dl>
    <dt>人均价格</dt>
    <dd>
      <asp:TextBox ID="txtAvgPrice" runat="server" CssClass="input small" datatype="/^(([1-9]{1}\d*)|([0]{1}))(\.(\d){1,2})?$/" sucmsg=" ">99</asp:TextBox> 元
      <span class="Validform_checktip">*</span>
    </dd>
  </dl>
  <dl>
    <dt>电话</dt>
    <dd>
      <asp:TextBox ID="txtTelphone" runat="server" CssClass="input normal" datatype="*2-16" sucmsg=" " />
      <span class="Validform_checktip">*</span>
    </dd>
  </dl>
  <dl>
    <dt>地址</dt>
    <dd>
      <asp:TextBox ID="txtAddress" runat="server" CssClass="input normal" datatype="*2-200" sucmsg=" " />
      <span class="Validform_checktip">*</span>
    </dd>
  </dl>
  <dl>
    <dt>纬度</dt>
    <dd>
      <asp:TextBox ID="txtLat" runat="server" CssClass="input normal" datatype="*2-200" sucmsg=" " />
      <span class="Validform_checktip">*</span>
    </dd>
  </dl>
  <dl>
    <dt>经度</dt>
    <dd>
      <asp:TextBox ID="txtLng" runat="server" CssClass="input normal" datatype="*2-200" sucmsg=" " />
      <span class="Validform_checktip">*</span>
    </dd>
  </dl>
  <dl>
    <dt>封面图片</dt>
    <dd>
      <asp:TextBox ID="txtImgUrl" runat="server" CssClass="input normal upload-path" />
      <div class="upload-box upload-img"></div>
        &nbsp;<a  href="javascript:void(0)"  id="linkImgUrl">查看</a>
    </dd>
  </dl>
  <dl>
    <dt>标签</dt>
    <dd>
      <asp:TextBox ID="txtTags" runat="server" CssClass="input normal" datatype="*0-500" sucmsg=" " />
      <span class="Validform_checktip">*关联景区，可多个，以逗号分隔</span>
    </dd>
  </dl>
  <dl>
    <dt>排序数字</dt>
    <dd>
        <asp:TextBox ID="txtSortId" runat="server" CssClass="input small" datatype="n" sucmsg=" ">99</asp:TextBox>
        <span class="Validform_checktip">*数字，越小越向前</span>
    </dd>
  </dl>
  <dl>
    <dt>发布时间</dt>
    <dd>
      <asp:TextBox ID="txtAddTime" runat="server" CssClass="input rule-date-input" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" datatype="/^\s*$|^\d{4}\-\d{1,2}\-\d{1,2}\s{1}(\d{1,2}:){2}\d{1,2}$/" errormsg="请选择正确的日期" sucmsg=" " />
      <span class="Validform_checktip">不选择默认当前发布时间</span>
    </dd>
  </dl>
  <dl>
    <dt>图片相册</dt>
    <dd>
      <div class="upload-box upload-album"></div>
      <input type="hidden" name="hidFocusPhoto" id="hidFocusPhoto" runat="server" class="focus-photo" />
      <div class="photo-list">
        <ul>
          <asp:Repeater ID="rptAlbumList" runat="server">
            <ItemTemplate>
            <li>
              <input type="hidden" name="hid_photo_name" value="<%#Eval("id")%>|<%#Eval("original_path")%>|<%#Eval("thumb_path")%>" />
              <input type="hidden" name="hid_photo_remark" value="<%#Eval("remark")%>" />
              <div class="img-box" onclick="setFocusImg(this);">
                <img src="<%#Eval("thumb_path")%>" bigsrc="<%#Eval("original_path")%>" />
                <span class="remark"><i><%#Eval("remark").ToString() == "" ? "暂无描述..." : Eval("remark").ToString()%></i></span>
              </div>
              <a href="javascript:;" onclick="setRemark(this);">描述</a>
              <a href="javascript:;" onclick="delImg(this);">删除</a>
            </li>
            </ItemTemplate>
          </asp:Repeater>
        </ul>
      </div>
    </dd>
  </dl>
</div>

<div class="tab-content" style="display:none">
  <dl>
    <dt>内容摘要</dt>
    <dd>
      <asp:TextBox ID="txtZhaiyao" runat="server" CssClass="input" TextMode="MultiLine" datatype="*0-255" sucmsg=" "></asp:TextBox>
      <span class="Validform_checktip">不填写则自动截取内容前255字符</span>
    </dd>
  </dl>
  <dl>
    <dt>内容描述</dt>
    <dd>
      <textarea id="txtContent" class="editor" style="visibility:hidden;" runat="server"></textarea>
    </dd>
  </dl>
</div>

<div class="tab-content" style="display:none">
  <dl>
    <dt>SEO标题</dt>
    <dd>
      <asp:TextBox ID="txtSeoTitle" runat="server" maxlength="255"  CssClass="input normal" datatype="*0-100" sucmsg=" " />
      <span class="Validform_checktip">255个字符以内</span>
    </dd>
  </dl>
  <dl>
    <dt>SEO关健字</dt>
    <dd>
      <asp:TextBox ID="txtSeoKeywords" runat="server" CssClass="input" TextMode="MultiLine" datatype="*0-255" sucmsg=" "></asp:TextBox>
      <span class="Validform_checktip">以“,”逗号区分开，255个字符以内</span>
    </dd>
  </dl>
  <dl>
    <dt>SEO描述</dt>
    <dd>
      <asp:TextBox ID="txtSeoDescription" runat="server" CssClass="input" TextMode="MultiLine" datatype="*0-255" sucmsg=" "></asp:TextBox>
      <span class="Validform_checktip">255个字符以内</span>
    </dd>
  </dl>
</div>

<div class="tab-content" style="display:none; padding:1px 10px">
    <iframe src="shop_coupon_list.aspx?main_id=<%=this.id %>" id="iframepage" name="iframepage" frameBorder="0" scrolling="no" width="100%" height="530"></iframe>
</div>
<!--/内容-->

<!--工具栏-->
<div class="page-footer">
  <div class="btn-wrap">
    <asp:Button ID="btnSubmit" runat="server" Text="提交保存" CssClass="btn" onclick="btnSubmit_Click" />
    <input name="btnReturn" type="button" value="返回上一页" class="btn yellow" onclick="javascript: history.back(-1);" />
  </div>
</div>
<!--/工具栏-->

</form>
</body>
</html>

