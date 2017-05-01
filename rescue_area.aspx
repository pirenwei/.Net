<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="rescue_area.aspx.cs" Inherits="HT.Web.rescue_area" %>

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
    
    <%=HT.Web.UI.WebUI.GetSingleText("f29317eafaba42ef997327a120254b98").content %>



<%--    <div class="pageBanner H400" style="background: url('images/Rescue_areaBanner.jpg') no-repeat center top;">
    </div>
    <div class="Rescue-area-bg">
        <div class="Rescue-area-top">
            <span><i class="left"></i><em>旅游救援咨询服务</em> <i class="right"></i></span>
        </div>
        <div class="container main">
            <div class="Rescue-area-qq-left MR20">
                <h1>QQ 在线
                </h1>
                <div class="item">
                    <p>
                        <i></i>1234567890
                    </p>
                    <p>
                        <i></i>1234567890
                    </p>
                    <p>
                        <i></i>1234567890
                    </p>
                    <p>
                        <i></i>1234567890
                    </p>
                </div>
            </div>
            <div class="Rescue-area-qq-right">
                <div class="title">
                    请选择
                </div>
                <div class="Rescue-area-table">
                    <table>
                        <tbody>
                            <tr class="th">
                                <th>标题
                                </th>
                                <th>发布时间
                                </th>
                            </tr>
                            <tr class="tr">
                                <td>
                                    <p>
                                        <br />
                                    </p>
                                </td>
                                <td>
                                    <p>
                                        <br />
                                    </p>
                                </td>
                            </tr>
                            <tr class="tr">
                                <td>
                                    <p>
                                        <br />
                                    </p>
                                    <p class="MsoNormal">
                                        旅客入、出境，携带新台币以6万元、人民币以2万元、外币以等值美金1万元为限，超过部份请依相关规定申报或申请核准。 &nbsp;&nbsp;
                                    </p>
                                    <p>
                                        <br />
                                    </p>
                                </td>
                                <td>
                                    <p>
                                        <span style="font-size: 13.3333px;">2015-11-04</span>
                                    </p>
                                </td>
                            </tr>
                            <tr class="tr">
                                <td>
                                    <p>
                                        如果看到有人溺水，应该遵守“叫、叫、伸、抛、划”的溺水救援口诀步骤来行动
                                    </p>
                                </td>
                                <td>
                                    <p>
                                        2015-11-04
                                    </p>
                                </td>
                            </tr>
                            <tr class="tr">
                                <td>
                                    <p>
                                        如果看到有人溺水，应该遵守“叫、叫、伸、抛、划”的溺水救援口诀步骤来行动
                                    </p>
                                </td>
                                <td>
                                    <p>
                                        2015-4-01
                                    </p>
                                </td>
                            </tr>
                            <tr class="tr">
                                <td>
                                    <p>
                                        如果看到有人溺水，应该遵守“叫、叫、伸、抛、划”的溺水救援口诀步骤来行动
                                    </p>
                                </td>
                                <td>
                                    <p>
                                        2015-4-01
                                    </p>
                                </td>
                            </tr>
                            <tr class="tr">
                                <td>
                                    <p>
                                        如果看到有人溺水，应该遵守“叫、叫、伸、抛、划”的溺水救援口诀步骤来行动
                                    </p>
                                </td>
                                <td>
                                    <p>
                                        2015-4-01
                                    </p>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="H20">
        </div>
        <div class="H20">
        </div>
    </div>
    <div class="Rescue-area-bg2">
        <div class="H20">
        </div>
        <div class="H10">
        </div>
        <div class="container tab-box">
            <div class="Rescue-area-tab-title title">
                <ul>
                    <li class="active">
                        <span>服务中心</span>
                    </li>
                    <li>
                        <span>借问站</span>
                    </li>
                </ul>
            </div>
            <p>
                <br />
            </p>
            <p>
                <br />
            </p>
            <ul class="title">
                <li class="col_11">服务中心
                </li>
                <li class="col_22">在线网址
                </li>
                <li class="col_33">客服热线
                </li>
                <li class="col_44">地理位置
                </li>
            </ul>
            <ul>
                <li class="col_11">
                    <span style="font-size: 12px; line-height: 1.5;">24小时旅游咨询服务专线(陆客自由行联合服务中心):</span>
                </li>
                <li class="col_22">
                    <p class="MsoNormal">
                        <span style="font-size: 13.3333px;">0800-011-765 (2717-3737)</span>
                    </p>
                </li>
            </ul>
            <ul>
                <li class="col_11">紧急报案:110、紧急救护 &nbsp;:119<br />
                    <!--[if !supportLineBreakNewLine]-->
                    <br />
                    <!--[endif]-->
                </li>
                <li class="col_22">www.guanguangju.com
                </li>
                <li class="col_33">400-000-0000
                </li>
                <li class="col_44">106臺北市忠孝東路4段290號9樓
                </li>
            </ul>
            <ul>
                <li class="col_11">观光局旅遊服务中心
                </li>
                <li class="col_22">www.guanguangju.com
                </li>
                <li class="col_33">400-000-0000
                </li>
                <li class="col_44">106臺北市忠孝東路4段290號9樓
                </li>
            </ul>
            <ul>
                <li class="col_11">观光局旅遊服务中心
                </li>
                <li class="col_22">www.guanguangju.com
                </li>
                <li class="col_33">400-000-0000
                </li>
                <li class="col_44">106臺北市忠孝東路4段290號9樓
                </li>
            </ul>
            <p>
                <br />
            </p>
            <p>
                <br />
            </p>
        </div>
        <div class="H20">
        </div>
        <div class="H10">
        </div>
    </div>
    <div class="Rescue-area-bg3">
        <p>
            <br />
        </p>
        <p>
            <br />
        </p>
        <ul>
            <li>
                <div class="hd">
                    问
				<p>
                    <span style="font-size: 12px; line-height: 1.5;">紧急联络专线是?</span>
                </p>
                    <p class="MsoNormal">
                        <b></b>
                    </p>
                    <p>
                        <br />
                    </p>
                </div>
                <div class="bd">
                    答
				<p>
                    <br />
                </p>
                    <p class="MsoNormal">
                        入台证遗失请向入出国及移民署申请补发，<span style="font-size: 12px; line-height: 1.5;">24小时服务专线：02-23757372</span>
                    </p>
                    <p>
                        <br />
                    </p>
                </div>
            </li>
            <li>
                <p class="MsoNormal">
                    <span style="font-size: 12px; line-height: 1.5;">
                        <br />
                    </span>
                </p>
            </li>
            <li>
                <div class="hd">
                    问
				<p>
                    大陸旅客如何申訴旅遊及購物糾紛？
                </p>
                </div>
                <div class="bd">
                    答
				<p>
                    旅遊糾紛：財團法人台灣海峽兩岸觀光旅遊協會 http://tst.org.tw/
                </p>
                    <p>
                        購物糾紛：中華民國旅行業品質保障協會 http://www.travel.org.tw/
                    </p>
                </div>
            </li>
            <li>
                <div class="hd">
                    问
				<p>
                    如何查詢臺灣觀光活動？
                </p>
                </div>
                <div class="bd">
                    答
				<p>
                    本局臺灣觀光資訊網-最新消息 http://taiwan.net.tw/m1.aspx?sNo=0000101
                </p>
                </div>
            </li>
            <li>
                <div class="hd">
                    问
				<p>
                    大陸旅客如何申訴旅遊及購物糾紛？
                </p>
                </div>
                <div class="bd">
                    答
				<p>
                    旅遊糾紛：財團法人台灣海峽兩岸觀光旅遊協會 http://tst.org.tw/
                </p>
                    <p>
                        購物糾紛：中華民國旅行業品質保障協會 http://www.travel.org.tw/
                    </p>
                </div>
            </li>
            <li>
                <div class="hd">
                    问
				<p>
                    如何查詢臺灣觀光活動？
                </p>
                </div>
                <div class="bd">
                    答
				<p>
                    本局臺灣觀光資訊網-最新消息 http://taiwan.net.tw/m1.aspx?sNo=0000101
                </p>
                </div>
            </li>
            <li>
                <div class="hd">
                    问
				<p>
                    大陸旅客如何申訴旅遊及購物糾紛？
                </p>
                </div>
                <div class="bd">
                    答
				<p>
                    旅遊糾紛：財團法人台灣海峽兩岸觀光旅遊協會 http://tst.org.tw/
                </p>
                    <p>
                        購物糾紛：中華民國旅行業品質保障協會 http://www.travel.org.tw/
                    </p>
                </div>
            </li>
            <li>
                <div class="hd">
                    问
				<p>
                    如何查詢臺灣觀光活動？
                </p>
                </div>
                <div class="bd">
                    答
				<p>
                    本局臺灣觀光資訊網-最新消息 http://taiwan.net.tw/m1.aspx?sNo=0000101
                </p>
                </div>
            </li>
            <li>
                <div class="hd">
                    问
				<p>
                    大陸旅客如何申訴旅遊及購物糾紛？
                </p>
                </div>
                <div class="bd">
                    答
				<p>
                    旅遊糾紛：財團法人台灣海峽兩岸觀光旅遊協會 http://tst.org.tw/
                </p>
                    <p>
                        購物糾紛：中華民國旅行業品質保障協會 http://www.travel.org.tw/
                    </p>
                </div>
            </li>
            <li>
                <div class="hd">
                    问
				<p>
                    如何查詢臺灣觀光活動？
                </p>
                </div>
                <div class="bd">
                    答
				<p>
                    本局臺灣觀光資訊網-最新消息 http://taiwan.net.tw/m1.aspx?sNo=0000101
                </p>
                </div>
            </li>
            <li>
                <div class="hd">
                    问
				<p>
                    大陸旅客如何申訴旅遊及購物糾紛？
                </p>
                </div>
                <div class="bd">
                    答
				<p>
                    旅遊糾紛：財團法人台灣海峽兩岸觀光旅遊協會 http://tst.org.tw/
                </p>
                    <p>
                        購物糾紛：中華民國旅行業品質保障協會 http://www.travel.org.tw/
                    </p>
                </div>
            </li>
        </ul>
        <p>
            <br />
        </p>
        <p>
            <br />
        </p>
    </div>
    <div class="pageBanner H300" style="background: url('images/e/pic143.png') no-repeat center top;">
    </div>
    <div class="H30">
    </div>--%>

    <uc1:footer runat="server" ID="footer" />
</body>
</html>
