<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="HT.Web.register" %>

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
<div class="enroll_tu">
	<div class="enroll_page">
	    <div class="enroll_center">
	        <h1>用户注册</h1>
	        <div class="enroll_fo">
	        	 <form id="form1" url="/tools/submit_ajax.ashx?action=user_register">
	            	  <div class="enroll-fo-item hide">
	            	  	    <label class="enroll-label">邀请码：</label>
	                        <input id="yqm" name="inviteCode" type="text" class="k" />
	            	  </div>
	            	  <div class="enroll-fo-item">
	            	  	    <label class="enroll-label">用户名<span class="red">*</span>：</label>
	                        <input type="text" class="k" name="txtUserName" ajaxurl="tools/submit_ajax.ashx?action=validate_username" datatype="*2-20" nullmsg="请输入用户名" sucmsg=" " placeholder="用户名"/>
	            	  </div>
	            	  <div class="enroll-fo-item">
	            	  	    <label class="enroll-label">手机号<span class="red">*</span>：</label>
	                        <input type="text" class="k" id="txtMobile" name="txtMobile" ajaxurl="/tools/submit_ajax.ashx?action=validate_userphone" datatype="*9-11" nullmsg="请输入手机号" errormsg="手机号格式不正确" sucmsg=" " placeholder="手机号"/>
                           <button class="yzm icon-yzm-btn" type="button" id="btnSendSMG">获取验证码</button>
	            	  </div>
	            	  <div class="enroll-fo-item">
	            	  	    <label class="enroll-label">验证码<span class="red">*</span>：</label>
	                        <input type="text" class="k" placeholder="手机验证码（请先填写验证码再设定密码跟辨识码）" name="txtCodeSMS" datatype="*" nullmsg="请输入手机验证码" sucmsg=" "/>
                           
	            	  </div>
	            	  <div class="enroll-fo-item">
	            	  	    <label class="enroll-label">密码<span class="red">*</span>：</label>
	                        <input type="password" class="k" name="txtPassword" datatype="*6-16" nullmsg="请输入密码" sucmsg=" " placeholder="密码"/>
	            	  </div>
	            	  <div class="enroll-fo-item">
	            	  	    <label class="enroll-label">确认密码<span class="red">*</span>：</label>
	                        <input type="password" class="k" name="passwordRep" datatype="*" recheck="txtPassword" nullmsg="请再输入一次密码" errormsg="两次输入的密码不一致" sucmsg=" " placeholder="确认密码"/>
	            	  </div>
	                  <div class="enroll-fo-item">
	                        <label class="enroll-label">辨识码<span class="red">*</span>：</label>
	                        <dl>
	                        	<dd><input type="text" class="k W90" placeholder="辨识码" name="txtCodeYZM" datatype="*" nullmsg="请输入辨识码" sucmsg=" "/></dd>
	                        	<dd><a id="ToggleCode" href="javascript:;" onclick="ToggleCode('/tools/verify_code.ashx');return false;">
                                    <img width="80" height="42" src="/tools/verify_code.ashx"/></a></dd>
	                        	<dd><span><a href="javascript:;" onclick="ToggleCode('/tools/verify_code.ashx');return false;">看不清！换一张</a></span></dd>
	                        </dl>
	                  </div>
	                  <div class="btnzc">
                          <button type="submit" class="icon-save-btn" id="btnSubmit">注册</button>
	                  </div>
	                  <div class="dl">已经有账号，现在就去<a href="login.aspx">登录！</a></div>
                      <span id="msgtip" class="msgtip" style="margin-left:90px;height:30px"></span>
	            </form>
	        </div>
	    </div>
	</div>
</div>
<div class="H20"></div>
<uc1:footer runat="server" id="footer" />
<script type="text/javascript">
    var InterValObj; //timer变量，控制时间
    var curCount; //当前剩余秒数
    var count1 = 60; //间隔函数，1秒执行
    $(function () {
        $("#btnSendSMG").click(function () {
            var $btnobj = $(this);
            var userphone = $.trim($("#txtMobile").val());

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
                if (VerifyExisMobile(userphone)) {
                    curCount = count1;
                    $.ajax({
                        async: false,
                        type: "POST",
                        url: '/tools/submit_ajax.ashx?action=user_verify_smscode',
                        data: { "mobile": userphone, "callname": "usercode" },
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
            }
        })
        AjaxInitForm('form1', 'btnSubmit', 'msgtip');
    })

    //timer处理函数
    function SetRemainTime_sms() {
        if (curCount == 0) {
            window.clearInterval(InterValObj); //停止计时器
            $("#btnSendSMG").removeAttr("disabled"); //启用按钮
            $("#btnSendSMG").text("重新获取");
        } else {
            curCount--;
            $("#btnSendSMG").text(curCount + "秒后再点");
        }
    }
    //验证手机号
    function VerifyExisMobile(userphone) {
        var flag = false;
        $.ajax({
            async: false,
            type: "GET",
            url: '/tools/submit_ajax.ashx?action=validate_userphone',
            data: "param=" + userphone,
            success: function (d) {
                var data = JSON.parse(d);
                if (data.status == "n") {
                    alert(data.info)
                } else if (data.status == "y") {
                    flag = true;
                }
            }
        });
        return flag;
    }
</script>
</body>
</html>
