<!-- #include file="../../electric/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' 프로그램ID : LEFT_MENU - 전기관리
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 전기 예측 왼쪽 메뉴 - 관리
' 최초작성일 : 2002/11/27
' 최종작성일 : 2002/11/27
' 개  발  자 : 박순몽(kweather)
' 사용    DB : 없음
' ========================================================================================================
%>
<!-- #include file="../../electric/script/FnLeftMenu.inc" -->
<html>
<head>
<title>관리자 왼쪽메뉴</title>
<SCRIPT TYPE="TEXT/JAVASCRIPT" LANGUAGE=JAVASCRIPT src=../../electric/script/FnLeftMenuAdmin.js></SCRIPT>
<STYLE TYPE="TEXT/CSS">
		#menu1 {display:none; margin-left:0px}
		#menu2 {display:none; margin-left:0px}
		#menu3 {display:none; margin-left:0px}
<!-- A:link {text-decoration:none} A:visited {text-decoration:none} 
     A:hover {color: red; text-decoration:underline;}--> 
</STYLE>
<meta name="generator" content="Namo WebEditor v4.0(Trial)">
<link rel="stylesheet" href="../../electric/css/cs_te.css" type="text/css">
</head>
<BODY leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" background="../../electric/images/left_bg.gif">
<h3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../../electric/images/admin_left_result_on.gif',1)" onClick="return toggleMenu('menu1')" target="mainFrame"><img name="Image1" border="0" src="../../electric/images/admin_left_result_off.gif" width="129" height="27"></a></h3>
    <p style="line-height:100%; margin-top:0; margin-bottom:0;">
	   <SPAN ID="menu1"> 
             <H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../electric/admin/admin_results_input.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image26','','../../electric/images/left_results_input_on.gif',1)" target="mainFrame"><img name="Image26" border="0" src="../../electric/images/left_results_input_off.gif" width="129" height="27"></a></H3>
             <p style="line-height:100%; margin-top:0; margin-bottom:0;">
             <H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../electric/admin/admin_results_construction.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image30','','../../electric/images/left_results_construction_on.gif',1)" target="mainFrame"><img name="Image30" border="0" src="../../electric/images/left_results_construction_off.gif" width="129" height="27"></a></H3>
             <p style="line-height:100%; margin-top:0; margin-bottom:0;">
             <H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../electric/admin/admin_results_ride.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image34','','../../electric/images/left_results_ride_on.gif',1)" target="mainFrame"><img name="Image34" border="0" src="../../electric/images/left_results_ride_off.gif" width="129" height="27"></a></H3>
             <p style="line-height:100%; margin-top:0; margin-bottom:0;">
	    </SPAN> 
             
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','../../electric/images/admin_left_variable_on.gif',1)" onClick="return toggleMenu('menu2')" target="mainFrame"><img name="Image2" border="0" src="../../electric/images/admin_left_variable_off.gif" width="129" height="27"></a></H3>
             <p style="line-height:100%; margin-top:0; margin-bottom:0;">
	   <SPAN ID="menu2">
             <H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../electric/admin/admin_vari_inter.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image43','','../../electric/images/left_vari_inter_on.gif',1)" target="mainFrame"><img name="Image43" border="0" src="../../electric/images/left_vari_inter_off.gif" width="129" height="27"></a></H3>
		     <p style="line-height:100%; margin-top:0; margin-bottom:0;">
             <H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../electric/admin/admin_vari_dayinput.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image38','','../../electric/images/day_input_on.gif',1)" target="mainFrame"><img name="Image38" border="0" src="../../electric/images/day_input_off.gif" width="129" height="27"></a></H3>
		     <p style="line-height:100%; margin-top:0; margin-bottom:0;">
			 <H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../electric/admin/admin_vari_monthinput.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image39','','../../electric/images/month_input_on.gif',1)" target="mainFrame"><img name="Image39" border="0" src="../../electric/images/month_input_off.gif" width="129" height="27"></a></H3>
		     <p style="line-height:100%; margin-top:0; margin-bottom:0;">
			 <H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../electric/admin/admin_vari_yearinput.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image42','','../../electric/images/year_input_on.gif',1)" target="mainFrame"><img name="Image42" border="0" src="../../electric/images/year_input_off.gif" width="129" height="27"></a></H3>
		     <p style="line-height:100%; margin-top:0; margin-bottom:0;">
			 <H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../electric/admin/admin_vari_regist.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image40','','../../electric/images/vari_regist_on.gif',1)" target="mainFrame"><img name="Image40" border="0" src="../../electric/images/vari_regist_off.gif" width="129" height="27"></a></H3>
		     <p style="line-height:100%; margin-top:0; margin-bottom:0;">
			 <H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../electric/admin/admin_vari_modify.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image41','','../../electric/images/vari_modify_on.gif',1)" target="mainFrame"><img name="Image41" border="0" src="../../electric/images/vari_modify_off.gif" width="129" height="27"></a></H3>
		     <p style="line-height:100%; margin-top:0; margin-bottom:0;">
	   </SPAN> 

<H3 style="line-height:100%; margin-top:0; margin-bottom:0;">
<a href="../../electric/admin/admin_reportinput.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','../../electric/images/admin_left_reportinput_on.gif',1)" nClick="return toggleMenu('menu3')" target="mainFrame"><img name="Image7" border="0" src="../../electric/images/admin_left_reportinput_off.gif" width="129" height="27"></a></H3>
             <p style="line-height:100%; margin-top:0; margin-bottom:0;">
	   <SPAN ID="menu3">
            <H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../electric/admin/admin_report_dayinput.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','../../electric/images/report_left_dayinput_on.gif',1)" target="mainFrame"><img name="Image8" border="0" src="../../electric/images/report_left_dayinput_off.gif" width="129" height="27"></a></H3>
		    <p style="line-height:100%; margin-top:0; margin-bottom:0;">
	        <H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../electric/admin/admin_report_weekinput.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image9','','../../electric/images/report_left_weekinput_on.gif',1)" target="mainFrame"><img name="Image9" border="0" src="../../electric/images/report_left_weekinput_off.gif" width="129" height="27"></a></H3>
		    <p style="line-height:100%; margin-top:0; margin-bottom:0;">
       </SPAN> 
	   
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;">
<a href="../../electric/admin/admin_acnt_list.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','../../electric/images/admin_left_acnt_on.gif',1)" target="mainFrame"><img name="Image4" border="0" src="../../electric/images/admin_left_acnt_off.gif" width="129" height="27"></a></H3>
             <p style="line-height:100%; margin-top:0; margin-bottom:0;">

<H3 style="line-height:100%; margin-top:70; margin-bottom:0;"><img name="Image63" border="0" src="../../electric/images/logo_lotte.gif" width="129" height="41"></H3>
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <img name="Image64" border="0" src="../../electric/images/logo_kweather.gif" width="129" height="43"></H3>
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <img name="Image65" border="0" src="../../electric/images/logo_ldcc.gif" width="129" height="39"></H3>
		  
<!--오늘날짜/최종방문일 테이블 시작-->
<table width="129" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="129" height="48" background="../../electric/images/now1_bg.gif" class="table03">
	<!--오늘날짜 테이블 시작-->
      <table width="102" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="7" class="table03"><img src="../../electric/images/orange_buret.gif" width="7" height="7"></td>
          <td width="5"></td>
          <td class="title_02">오늘은</td>
        </tr>
        <tr> 
          <td width="7"></td>
          <td width="5"></td>
          <td class="list09"><% =FnDateFormat(date()) %></td>
        </tr>
      </table>
	  <!--오늘날짜 테이블 끝-->
    </td>
  </tr>
  <tr>
    <td width="129" height="48" background="../../electric/images/now2_bg.gif" class="table03">
	<!--최종방문일 테이블 시작-->
      <table width="102" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="7" class="table03"><img src="../../electric/images/orange_buret.gif" width="7" height="7"></td>
          <td width="5"></td>
          <td class="title_02">최종방문일</td>
        </tr>
        <tr> 
          <td width="7"></td>
          <td width="5"></td>
          <td class="list09"><% =FnDateFormat(varlastconnecttime) %></td>
        </tr>
      </table>
	  <!--최종방문일 테이블 끝-->
    </td>
  </tr>
</table>
<!--오늘날짜/최종방문일 테이블 끝-->
<H3 style="line-height:100%; margin-top:10; margin-bottom:0;"> <a href=../../enter/index.asp target=_blank><img name="Image62" border="0" src="../../electric/images/visitor_button.gif" width="129" height="26"></a></H3>
</BODY>
</html>
<!-- #include file="../../electric/script/FnErrorCatch.inc" -->