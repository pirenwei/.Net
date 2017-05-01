<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="customized_travel_map.aspx.cs" Inherits="HT.Web.customized_travel_map" %>

<%@ Register Src="~/ucl/footer.ascx" TagPrefix="uc1" TagName="footer" %>
<%@ Register Src="~/ucl/header.ascx" TagPrefix="uc1" TagName="header" %>
<%@ Register Src="~/ucl/links.ascx" TagPrefix="uc1" TagName="links" %>

<!DOCTYPE html>
<html lang="zh">
<head>
    <title>台湾行旅游网 Taiwan Go</title>
    <meta name="keywords" content="<%=HT.Web.UI.WebUI.config.webkeyword %>">
  <meta name="description" content="<%=HT.Web.UI.WebUI.config.webdescription %>">
    <uc1:links runat="server" ID="links" />
    <link rel="stylesheet" href="/css/map.css">
      <script type="text/javascript" charset="utf-8" src="/scripts/webuploader/webuploader.min.js"></script>
        <script type="text/javascript" charset="utf-8" src="/admin/js/uploader.js"></script>
    <script src="http://maps.google.cn/maps/api/js?sensor=false&libraries=places&key=AIzaSyA_fSbr4yGpPdxIweEDTIwcu9Epn6jCz2A&callback=initialize" async defer></script>
    <script>
        //地图变量
        var map;
        //旅行时间
        var travel_day_num = <%=travel_day_num%>; 
        var Travel_id = <%=Travel_id%>;
        var keyword='<%=keyword%>';
        var start_airport='<%=start_airport%>';
        var end_airport='<%=end_airport%>';
        function initialize() {
            $(function(){
                var mapOptions = {
                    zoom: 12,
                    mapTypeId: google.maps.MapTypeId.ROADMAP,
                    center: new google.maps.LatLng(25.033493, 121.564101),
                    scaleControl: true //比例控件 
                };
         
                map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);
                google.maps.event.addDomListener(window, 'load', function () {
                    loadMapData(); 
                    //初始化搜索
                    search_travel()
                });
                google.maps.event.addListener(map, 'zoom_changed', function () {
                    loadMapData()
                });
                google.maps.event.addListener(map, 'mouseup', function () {
                    loadMapData()
                });
                $.getScript("http://<%=HT.Common.HTRequest.GetCurrentFullHost()%>/js/map.js", function () {
                    console.log(1)
                    loadUserData();
                })
            })
        }
        $(function(){
            //初始化上传控件
            $(".upload-img").InitUploader({ filesize: "<%=siteConfig.imgsize %>", sendurl: "../../tools/upload_ajax.ashx", swf: "../../scripts/webuploader/uploader.swf", filetypes: "<%=siteConfig.fileextension %>" });
        })
    </script>
  
     <script src="/js/map_function.js" type="text/javascript"></script>
    
</head>
<body>
  
    <uc1:header runat="server" ID="header" />
  <form id="form2" runat="server">
    <div class="container">
        <div class="page-loct"><a href="index.asp">首页</a> > <a href="###">定制旅行</a> > <span>自定行程</span> </div>
    </div>
    <div class="container">
        <div class="customized-travel-top">
            <dl>
                <dt><span class="name_edit travel_title_edit"><i></i>名称编辑</span>
                    <label for="" class="ht_travel_title"><%=travel_title %></label>
                    
                    <input type="text" name="ht_travel_title" value="" class="hide" style=" margin:20px 0px 20px 20px;" />
                    <span class="name_edit_true travel_title_true hide" style="margin:20px 2px 20px 0px; "  ><i></i>确定</span>
                    |
                     <span class="name_edit ImgUrl_edit"><i></i>行程图片</span>
                          <asp:TextBox ID="txtImgUrl" runat="server" CssClass="input normal upload-path hide" />
                           <div class="upload-box upload-img hide"></div>
    
                    |  <span class="name_edit begin_date_edit"><i></i>出发时间</span>
                    <label for="" class="ht_travel_begin_date"><%=begin_date %></label>
                  
                    <input type="text" name="begin_date" value="<%=begin_date %>" class="hide" style=" margin:20px 0px 20px 0px;" onfocus=" WdatePicker({minDate:'%y-%M'})"/>
                    <span class="name_edit_true begin_date_true hide" style="margin:20px 0px 20px 0px; "  ><i></i>确定</span>

                  
                   
                    <input type"hidden" name="is_draft" value="0" />
                    <input type="hidden" name="end_date" value="<%=end_date %>" />
                </dt>
               
                  
                <dd style="width:320px;">
                    <div class="customized-travel-search">
                        <input type="text" name="" id="search_t" placeholder="输入您想去的目的地" class="k">
                        <button type="button" id="search_b" ></button>
                    </div>
                </dd>
                <dd>
                    <span class="travel mytravel" ht-click="show" data-target="#my-travel-box"><i></i>我的行程</span>
                    
                    <a href="travel_open_list.aspx" class="Preview"><i></i>预览</a>
                    <span class="create-stroke">创建新行程</span>
                </dd>
            </dl>
        </div>
    </div>
    <div class="H10"></div>
    <div class="container main">
        <div class="sidebar-Trip">
            <h1>行程列表</h1>
            <div class="sidebar-box">
                <div class="sidebar-item">
                   <div class="airport" >
		 	  	   	  <i class="tian"></i><span class="text">入境机场</span>
		 	  	   
		 	  	   </div>
                    <div class="input"></div>
                     <div class="airport">
		 	  	   	   <i class="tian"></i><span class="text">出境机场</span>
		 	  	   	 
		 	  	   </div>
                </div>
            </div>
            <div class="sidebar-bottom">
                <button type="button" class="btn1 save_Yes"  >确定</button>
                <span class="btn2 isDrafts_Yes" >保存草稿</span>
            </div>
        </div>
        <div class="Trip-map">
            <div id="map_canvas" style="width: 613px; height: 730px;">
            </div>
        </div>
        <div class="sidebar-right tab-box">
            <div class="sidebar-right-title title">
                <ul>
                    <li class="col_11 active"><span>景点</span><i></i></li>
                    <li class="col_22"><span>酒店</span><i></i></li>
                    <li class="col_33"><span>店家</span><i></i></li>
                    <li class="col_44"><span>交通</span><i></i></li>
                </ul>
            </div>
            <div class="sidebar-right-content content scenery">
                <div class="content-box scenery-box">
                    <ul>
                       
                    </ul>
                </div>
                <div class="sidebar-page scenery-page">
                    <a href="###" class="pre">上一页</a><a href="###" class="next">下一页</a>
                </div>
            </div>
            <div class="sidebar-right-content content hotel hide">

                   <div class="content-box hotel-box">
                    <ul>
                       
                    </ul>
                </div>
                <div class="sidebar-page hotel-page">
                    <a href="###" class="pre">上一页</a><a href="###" class="next">下一页</a>
                </div>
            </div>
            <div class="sidebar-right-content content shop hide">

                  <div class="content-box shop-box">
                    <ul>
                       
                    </ul>
                </div>
                <div class="sidebar-page shop-page">
                    <a href="###" class="pre">上一页</a><a href="###" class="next">下一页</a>
                </div>
            </div>
            <div class="sidebar-right-content content hide"><div class="traffic"> 
                    <div class="H10"></div> 
                    <ul>
                    <li><a class="traffic_type active"  data="DRIVING"><i class="icon-Private"></i></a></li>
                    <li><a class="traffic_type" data="TRANSIT"><i class="icon-bus"></i></a></li>
                    <li><a class="traffic_type" data="WALKING"><i class="icon-walking"></i></a></li>
                </ul>
                    <div class="clear"></div>
                    <div class="H10"></div>
                 
                        <div class="input1">
                        <label>起点</label>
                     
                            <select class="sel traffic_start">
                              
                            </select>
                        </div>
                        <div class="input1">
                        <label>终点</label>
                             <select class="sel traffic_end">
                            
                            </select>
                             </div>
                        <input type="button" value=""  class="sub1 traffic_submit"   />
                        <div class="jiaohuan traffic_jiaohuan">
                            <i class="icon-jihu"></i>
                        </div>
                
                    <div id="traffic_desc" style="height:510px; overflow-y:scroll; margin-top:40px;"></div>
                </div> 
            </div>
        </div>
    </div>
    <div class="H30"></div>
  
<div class="date-msg" id="date-msg1">
    <div class="item">
        <em></em>
        <p class="col_11 Remarks insert_note" ><i class="icon-Remarks-btn "></i>今日备注</p>
        <p class="insert" id="insert"><i class="icon-insert-btn "></i>插入一天</p>
        <p class="delete" id="delete_p"><i class="icon-delete-btn "></i>删除一天</p>
        <p class="hide" id="hide_p">隐藏一天</p>
    </div>
</div>
<div class="date-msg" id="date-msg2">
    <div class="item">
        <em></em>
        <p class="col_11 Access-route"><i class="icon-Remarks-btn "></i>获取路线</p>
        <p class="Remarks2 insert_note" id="P1"><i class="icon-insert-btn "></i>备注</p>
        <p class="delete2" id="delete_p2"><i class="icon-delete-btn "></i>删除</p>
    </div>
</div>
<div class="PopBox hide" id="Technological-process-box">
    <div class="Pop_upBox_bg"></div>
    <div class="Pop_upBox H650">
        <div class="pop_content">
            <div class="PopBox_title2">请选择以下流程</div>
            <div class="content PD0">
                <div class="Technological-process-item">
                    <div class="Technological-process-item-hd item-hd active"><i></i>公开行程：让大家都看到你的精彩行程</div>
                    <div class="Technological-process-item-bd item-bd ">
                        <form action="?action=open"  >
                            <input type="hidden" name="userdata"  value="" />
                
                            <div class="Technological-process-btn">
                                <button type="button" class="icon-submit-btn saveUserDataAndPublic">确认</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	            	 	  	   	    <span class="icon-cancel-btn close_box">取消</span>
                            </div>
                        </form>
                    </div>
                </div>
                 <div class="Technological-process-item">
            	 	  <div class="Technological-process-item-hd item-hd "><i></i>我要包车：自由旅行更便捷</div>
            	 	  <div class="Technological-process-item-bd item-bd hide">
            	 	  	   <form action="/tools/map.ashx?action=saveuserdataandcar"  method="post" id="form3">
                                    <input type="hidden" name="userdata"  value="" />
	            	 	  	   <div class="Technological-process-form">
	            	 	  	   	     <label for=""  class="form-label">用车日期<span class="red">*</span>：</label>
	            	 	  	   	     <div class="form-time">
	            	 	  	   	     	 <dl>
	            	 	  	   	     	 	<dd><input type="text" name="beginDate" class="k W100" id="tb_startday" onfocus=" WdatePicker({minDate:'%y-%M'})" nullmsg="请输入用车日期" datatype="*"></dd>
	            	 	  	   	     	 	<dt>~</dt>
	            	 	  	   	     	 	<dd><input type="text" name="endDate" class="k W100" onfocus=" WdatePicker({minDate:'#F{$dp.$D(\'tb_startday\');}',minDate:'%y-%M'})"  nullmsg="请输入用车日期" datatype="*"></dd>
	            	 	  	   	     	 </dl>
	            	 	  	   	     </div>
	            	 	  	   </div>
	            	 	  	   <div class="Technological-process-form">
	            	 	  	   	     <label for="" class="form-label">乘车人数<span class="red">*</span>：</label>
	            	 	  	   	     <input type="text" name="ride_number" class="k W100" nullmsg="请输入乘车人数" datatype="*">
	            	 	  	   </div>
	            	 	  	   <div class="Technological-process-form">
	            	 	  	   	     <label for="" class="form-label">行李件数<span class="red">*</span>：</label>
	            	 	  	   	     <input type="text" name="baggage_number" class="k W100" nullmsg="请输入行李件数" datatype="*">
	            	 	  	   </div>
	            	 	  	   <div class="Technological-process-form">
	            	 	  	   	     <label for="" class="form-label">司机<span class="red">*</span>：</label>
	            	 	  	   	     <div class="form-field form-field-rc">    
		                                 <label class="form-label-rc"><input type="radio" checked="checked" class="form-radio" name="is_driver" value="有"><span>有</span></label>
		                                 <label class="form-label-rc"><input type="radio" class="form-radio" name="is_driver"  value="无"><span>无</span></label>
		                             </div>
	            	 	  	   </div>
	            	 	  	   <div class="Technological-process-form">
	            	 	  	   	     <label for="" class="form-label">乘车地点<span class="red">*</span>：</label>
	            	 	  	   	     <input type="text" class="k W100" name="begin_place" nullmsg="请输入乘车地点" datatype="*">
	            	 	  	   </div>
	            	 	  	   <div class="Technological-process-form">
	            	 	  	   	     <label for="" class="form-label">下车地点<span class="red">*</span>：</label>
	            	 	  	   	     <input type="text" class="k W100" name="end_place" nullmsg="请输入下车地点" datatype="*">
	            	 	  	   </div>
	            	 	  	   <div class="Technological-process-form">
	            	 	  	   	     <label for="" class="form-label">联系电话<span class="red">*</span>：</label>
	            	 	  	   	     <input type="text" class="k W100" name="phone"  nullmsg="请输入联系电话" datatype="*">
	            	 	  	   </div>
	            	 	  	   <div class="Technological-process-form">
	            	 	  	   	     <label for="" class="form-label">QQ：</label>
	            	 	  	   	     <input type="text" class="k W100" name="qq">
	            	 	  	   </div>
                                  <div class="Technological-process-form">
	            	 	  	   	     <label for="" class="form-label">Email：</label>
	            	 	  	   	     <input type="text" class="k W100" name="email">
	            	 	  	   </div>
	            	 	  	   <div class="Technological-process-btn">
	            	 	  	   	    <button type="submit" class="icon-submit-btn" id="btnSubmit3">确认</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	            	 	  	   	    <span class="icon-cancel-btn  close_box" ht-click="hide" data-target="#Technological-process-box">取消</span>
	            	 	  	   </div>
                           </form>
            	 	  </div>
            	 </div>  
                <div class="Technological-process-item">
                    <div class="Technological-process-item-hd item-hd"><i></i>号召组团：多个伴儿路上好出游</div>
                    <div class="Technological-process-item-bd item-bd hide">
                        <form url="/tools/map.ashx?action=saveuserdataandgroup" method="post" id="form1" >
                            <input type="hidden" name="userdata"  value="" />
             
                            <div class="Technological-process-form">
                                <label for="" class="form-label">标题<span class="red">*</span>：</label>
                                <input type="text" name="title" class="k W100" nullmsg="请输入标题" datatype="*">
                            </div>
                            <div class="Technological-process-form">
                                <label for="" class="form-label">组团人数<span class="red">*</span>：</label>
                                <input type="text" name="renshu" class="k W100" nullmsg="请输入组团人数" datatype="*">
                            </div>
                            <div class="Technological-process-form">
                                <label for="" class="form-label">组团性别<span class="red">*</span>：</label>
                                <div class="form-field form-field-rc">
                                    <label class="form-label-rc">
                                        <input type="radio" name="gender" checked="checked" value="男" class="form-radio" name="sex" ><span>男</span></label>
                                    <label class="form-label-rc">
                                        <input type="radio" name="gender" value="女" class="form-radio" name="sex"><span>女</span></label>
                                    <label class="form-label-rc">
                                        <input type="radio"  name="gender" value="皆可" class="form-radio" name="sex"><span>皆可</span></label>

                                </div>
                            </div>
                            <div class="Technological-process-form">
                                <label for="" class="form-label">招募时间<span class="red">*</span>：</label>
                                <div class="form-time">
                                    <dl>
                                        <dd>
                                            <input type="text" name="begin_date" class="k W100" id="Text1" onfocus=" WdatePicker({minDate:'%y-%M'})" nullmsg="请选择开始时间" datatype="*"></dd>
                                        <dt>~</dt>
                                        <dd>
                                            <input type="text" name="end_date" class="k W100" onfocus=" WdatePicker({minDate:'#F{$dp.$D(\'tb_startday\');}',minDate:'%y-%M'})" nullmsg="请选择结束时间" datatype="*"></dd>
                                    </dl>
                                </div>
                            </div>
                            <div class="Technological-process-form">
                                <label for="" class="form-label">集合地点<span class="red">*</span>：</label>
                                <input type="text" name="jihe_place" class="k W100"  nullmsg="请填写集合地点" datatype="*">
                            </div>
                            <div class="Technological-process-form">
                                <label for="" class="form-label">集合时间<span class="red">*</span>：</label>
                                <input type="text" name="jihe_time" class="k W100" onfocus=" WdatePicker({minDate:'%y-%M',dateFmt:'yyyy-MM-dd HH:mm:ss'})"  nullmsg="请选择集合时间" datatype="*">
                            </div>
                            <div class="Technological-process-form">
                                <label for="" class="form-label">备注：</label>
                                <textarea name="remark" id="Textarea1" class="textarea"></textarea>
                            </div>
                             <span id="msgtip" class="msgtip"></span>
                            <div class="Technological-process-btn">
                                <button type="submit" class="icon-submit-btn " id="btnSubmit">确认</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	            	 	  	   	    <span class="icon-cancel-btn close_box" ht-click="hide" data-target="#Technological-process-box">取消</span>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="close2 close_box" ht-click="hide" data-target="#Technological-process-box">
                <img src="images/e/close2.png" alt="" />
            </div>
        </div>
    </div>
</div>

<div class="PopBox hide" id="Technological-process-tip-box">
    <div class="Pop_upBox_bg"></div>
    <div class="Pop_upBox H235">
        <div class="pop_content">
            <div class="PopBox_title">提示</div>
            <div class="content PD20">
                <div class="Technological-process-tip-text">
                    <p>您的行程还未保存，是否保存草稿？</p>
                </div>
                <div class="Technological-process-btn">
                    <button type="submit" class="icon-submit-btn">确认</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    	 	  	   	    <span class="icon-cancel-btn">取消</span>
                </div>
            </div>
            <div class="close" ht-click="hide" data-target="#Technological-process-tip-box">
                <img src="images/e/close.png" alt="" />
            </div>
        </div>
    </div>
</div>

<div class="PopBox hide" id="Add-notes-box">
    <div class="Pop_upBox_bg"></div>
    <div class="Pop_upBox H480">
        <div class="pop_content">
            <div class="PopBox_title">添加笔记</div>
            <div class="content PD45">

                <div class="Technological-process-form">
                    <label for="" class="form-label">内容：</label>
                    <textarea id="note_content" cols="100" rows="8" style="width: 100%; height: 280px; "  ></textarea>
                </div>
                <div class="Technological-process-btn">
                    <button type="button" class="icon-submit-btn note-ok">确认</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    	 	  	   	    <span class="icon-cancel-btn note-cancel" ht-click="hide" data-target="#Add-notes-box">取消</span>
                </div>
            </div>
            <div class="close note-cancel" ht-click="hide" data-target="#Add-notes-box">
                <img src="images/e/close.png" alt="" />
            </div>
        </div>
    </div>
</div>
    <div class="PopBox hide" id="my-travel-box">
    <div class="Pop_upBox_bg"></div>
    <div class="Pop_upBox H480">
        <div class="pop_content">
            <div class="PopBox_title">我的行程</div>
            <div class="content PD45">
                <div class="Technological-process-form">
                     <asp:Repeater runat="server" ID="myTravelList">
                        <ItemTemplate>
                            <a href="customized_travel_map.aspx?Travel_id=<%#Eval("id") %>"><%#Eval("title") %></a>
                    <br />
                  
                        </ItemTemplate>
                    </asp:Repeater>
                  
                </div>
            </div>
            <div class="close note-cancel" ht-click="hide" data-target="#my-travel-box">
                <img src="images/e/close.png" alt="" />
            </div>
        </div>
    </div>
</div>
      <uc1:footer runat="server" ID="footer" />
        <script type="text/javascript">
            $(function () {
                AjaxInitForm('form1', 'btnSubmit', 'msgtip');
                AjaxInitForm('form3', 'btnSubmit3', 'msgtip');
            })
</script>
        </form>
</body>
</html>