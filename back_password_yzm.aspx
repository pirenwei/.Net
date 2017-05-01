<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="back_password_yzm.aspx.cs" Inherits="HT.Web.back_password_yzm" %>

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
    <div class="container">
        <div class="page-loct"><a href="index.aspx">首页</a> > <span>修改密码</span> </div>
    </div>
    <div class="container">
        <div class="wrapper">
            <div class="change_title">
                <ul>
                    <li>输入账号</li>
                    <li class="current">身份认证</li>
                    <li>重置密码</li>
                </ul>
            </div>
            <div class="clear"></div>
            <div class="back-password-main">
                <form id="form_phone" url="/tools/submit_ajax.ashx?action=user_getpassword">
                    <div class="form-item PDL480">
                        <span class="form-item-label">验证方式<span class="red">*</span>：</span>
                        <select class="select" onchange="fn_changetype(this)">
                            <option value="1">手机号【<%=model.mobile.Replace(model.mobile.Substring(0,7),"*******") %>】</option>
                            <%if(model.email!="")
                              { %>
                                <option value="2">邮箱号【<%=model.email.Replace(model.email.Substring(0,4),"****") %>】</option>
                            <%} %>
                        </select>
                    </div>
                    <div class="form-item PDL480 phoneyz">
                        <label class="form-item-label">校检码<span class="red">*</span>：</label>
                        <dl class="form-item-dl">
                            <dd>
                                <input type="text" class="form-item-input W90" name="vcode_phone" datatype="*" nullmsg="请输入短信验证码" sucmsg=" "></dd>
                            <dd>
                                <button class="get-verification active" type="button" id="btnSendSMG">点此获取校检码</button></dd>
                        </dl>
                    </div>
                    <div class="form-item-btn phoneyz">
                        <input type="hidden" value="<%=model.mobile %>" name="userphone" id="userphone"/>
                        <input type="hidden" value="<%=model.email %>" name="useremail" id="useremail"/>
                        <input type="hidden" value="1" name="yztype" id="yztype"/>
                        <button type="submit" class="icon-save-btn" id="btnSubmit_phone">下一步</button>
                    </div>
                    <div class="form-item-tip phoneyz"><span id="msgtip_phone"></span></div>

                    <div class="form-item-btn emailyz hide">
                        <input type="hidden" value="<%=HT.Common.DESEncrypt.Encrypt(model.id.ToString()) %>" id="usercode"/>
                        <button type="button" class="icon-save-btn" id="btnSubmit_email">发送邮件</button>
                    </div>

                </form>
            </div>
        </div>
        <div class="clear"></div>
    </div>
    <div class="H20"></div>
    <uc1:footer runat="server" ID="footer" />
    <script type="text/javascript">
        var InterValObj; //timer变量，控制时间
        var count = 60; //间隔函数，1秒执行
        var curCount; //当前剩余秒数
        $(function () {
            $("#btnSendSMG").click(function () {
                var userphone = $.trim($("#userphone").val());
                var flagReg = false;
                //验证台湾
                if (userphone.length == 10) {
                    if (userphone.substring(0, 2) == "09") {
                        flagReg = true;
                    }
                }
                //验证大陆
                if (userphone.length == 11) {
                    if (userphone.match(/^1[3|4|5|8]\d{9}$/)) {
                        flagReg = true;
                    }
                }
                if (!flagReg) {
                    alert("手机号格式有错误！");
                } else {
                    curCount = count;
                    $.ajax({
                        async: false,
                        type: "POST",
                        url: '/tools/submit_ajax.ashx?action=user_verify_smscode',
                        data: { "mobile": userphone, "callname": "getpassword" },
                        dataType: "json",
                        success: function (data) {
                            alert(data.msg);
                            if (data.status == 1) {
                                //设置button效果，开始计时
                                $("#btnSendSMG").prop("disabled", "disabled");
                                $("#btnSendSMG").text(curCount + "秒后再点");
                                InterValObj = window.setInterval(SetRemainTime_sms, 1000); //启动计时器，1秒执行一次
                            } else {
                                ToggleCode($("#ToggleCode"), '/tools/verify_code.ashx');
                            }
                        }
                    });
                }
            })

            AjaxInitForm('form_phone', 'btnSubmit_phone', 'msgtip_phone');


            //发送邮件
            $("#btnSubmit_email").click(function(){
                $.ajax({
                    type: "post",
                    url: "/tools/submit_ajax.ashx?action=SendEmailGetPassword",
                    data: { "usercode": $("#usercode").val() },
                    dataType: "json",
                    success: function (data) {
                        layer.msg(data.msg)
                        if (data.status == 1) {
                            obj.attr("disabled", "disabled");
                        }
                    }
                });
            })
        })
        //timer处理函数
        function SetRemainTime_sms(btnobj) {
            if (curCount == 0) {
                window.clearInterval(InterValObj); //停止计时器
                $("#btnSendSMG").removeAttr("disabled"); //启用按钮
                $("#btnSendSMG").text("重新获取");
            } else {
                curCount--;
                $("#btnSendSMG").text(curCount + "秒后再点");
            }
        }
        function fn_changetype(obj) {
            $("#yztype").val($(obj).val());
            if ($(obj).val() == "2") {
                $(".phoneyz").hide();
                $(".emailyz").show();
            } else {
                $(".phoneyz").show();
                $(".emailyz").hide();
            }
        }
    </script>
</body>
</html>
