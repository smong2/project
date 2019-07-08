<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' 프로그램ID : LEFT_MENU_ADMIN - 관리자 메뉴
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 입장객 예측 왼쪽 메뉴 - 관리자
' 최초작성일 : 2002/12/05
' 최종작성일 : 2002/12/05
' 개  발  자 : 박순몽(kweather)
' 사용    DB : 없음
' ========================================================================================================
%>
<!-- #include file="../../enter/script/FnLeftMenu.inc" -->
<html>
 <head>
<title>왼쪽 슬라이딩 메뉴</title>
<STYLE TYPE="TEXT/CSS"> 
  <!-- A:link {text-decoration:none} A:visited {text-decoration:none} 
      A:hover {color: red; text-decoration:underline;}--> 
		#menu1 {display:none; margin-left:0px}
		#menu2 {display:none; margin-left:0px}
</STYLE>
<SCRIPT TYPE="TEXT/JAVASCRIPT" LANGUAGE=JAVASCRIPT src=../../enter/script/FnLeftMenuAdmin.js></SCRIPT>
<link rel="stylesheet" href="../../enter/css/cs_tx.css" type="text/css">
</head>
<BODY leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" background="../../enter/images/left_bg.gif" onLoad="MM_preloadImages('../../enter/images/visitorforecast_left1.gif','../../enter/images/visitorforecast_left2.gif','../../enter/images/visitorforecast_left3.gif','../../enter/images/group_on.gif')">

<h3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../../enter/images/admin_left_result_on.gif',1)" onClick="return toggleMenu('menu1')" target="mainFrame"><img name="Image1" border="0" src="../../enter/images/admin_left_result_off.gif" width="129" height="27"></a></h3>
<p style="line-height:100%; margin-top:0; margin-bottom:0;">
	<SPAN ID="menu1">      
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../enter/admin/admin_results_enter_dayinput.asp" target=mainFrame onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image26','','../../enter/images/left_enter_input_on.gif',1)"><img name="Image26" border="0" src="../../enter/images/left_enter_input_off.gif" width="129" height="27"></a></H3>
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../enter/admin/admin_results_ticket_plan.asp" target=mainFrame onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image30','','../../enter/images/left_planinfo_on.gif',1)"><img name="Image30" border="0" src="../../enter/images/left_planinfo_off.gif" width="129" height="27"></a></H3>
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../enter/admin/admin_results_rival.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image31','','../../enter/images/left_results_rival_on.gif',1)" target='mainFrame'><img name="Image31" border="0" src="../../enter/images/left_results_rival_off.gif" width="129" height="27"></a></H3>
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../enter/admin/admin_results_foreigner.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image32','','../../enter/images/left_results_foreigner_on.gif',1)" target='mainFrame'><img name="Image32" border="0" src="../../enter/images/left_results_foreigner_off.gif" width="129" height="27"></a></H3>
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../enter/admin/admin_results_reservation.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image33','','../../enter/images/left_results_reservation_on.gif',1)" target='mainFrame'><img name="Image33" border="0" src="../../enter/images/left_results_reservation_off.gif" width="129" height="27"></a></H3>
<p style="line-height:100%; margin-top:0; margin-bottom:0;"> 
	 </SPAN>
			  
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','../../enter/images/admin_left_variable_on.gif',1)" onClick="return toggleMenu('menu2')" target="mainFrame"><img name="Image2" border="0" src="../../enter/images/admin_left_variable_off.gif" width="129" height="27"></a></H3>
<p style="line-height:100%; margin-top:0; margin-bottom:0;">
	   <SPAN ID="menu2">
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../enter/admin/admin_vari_inter.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image37','','../../enter/images/left_vari_inter_on.gif',1)" target="mainFrame"><img name="Image37" border="0" src="../../enter/images/left_vari_inter_off.gif" width="129" height="27"></a></H3>
		     <p style="line-height:100%; margin-top:0; margin-bottom:0;">             
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../enter/admin/admin_vari_reforecast.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image38','','../../enter/images/left_vari_reforecast_on.gif',1)" target="mainFrame"><img name="Image38" border="0" src="../../enter/images/left_vari_reforecast_off.gif" width="129" height="27"></a></H3>
		     <p style="line-height:100%; margin-top:0; margin-bottom:0;">
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../enter/admin/admin_vari_dayinput.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image43','','../../enter/images/day_input_on.gif',1)" target="mainFrame"><img name="Image43" border="0" src="../../enter/images/day_input_off.gif" width="129" height="27"></a></H3>
		     <p style="line-height:100%; margin-top:0; margin-bottom:0;">
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../enter/admin/admin_vari_monthinput.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image39','','../../enter/images/month_input_on.gif',1)" target="mainFrame"><img name="Image39" border="0" src="../../enter/images/month_input_off.gif" width="129" height="27"></a></H3>
		     <p style="line-height:100%; margin-top:0; margin-bottom:0;">
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../enter/admin/admin_vari_yearinput.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image42','','../../enter/images/year_input_on.gif',1)" target="mainFrame"><img name="Image42" border="0" src="../../enter/images/year_input_off.gif" width="129" height="27"></a></H3>
		     <p style="line-height:100%; margin-top:0; margin-bottom:0;">
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../enter/admin/admin_vari_regist.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image40','','../../enter/images/vari_regist_on.gif',1)" target="mainFrame"><img name="Image40" border="0" src="../../enter/images/vari_regist_off.gif" width="129" height="27"></a></H3>
		     <p style="line-height:100%; margin-top:0; margin-bottom:0;">
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../enter/admin/admin_vari_modify.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image41','','../../enter/images/vari_modify_on.gif',1)" target="mainFrame"><img name="Image41" border="0" src="../../enter/images/vari_modify_off.gif" width="129" height="27"></a></H3>
		     <p style="line-height:100%; margin-top:0; margin-bottom:0;">
	   </SPAN> 
	         
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"><a href="../../enter/admin/admin_event_lotte.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','../../enter/images/admin_left_event_on.gif',1)" target="mainFrame"><img name="Image3" border="0" src="../../enter/images/admin_left_event_off.gif" width="129" height="27"></a></H3>
             <p style="line-height:100%; margin-top:0; margin-bottom:0;">
	   
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;">
<a href="../../enter/admin/admin_acnt_list.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','../../enter/images/admin_left_acnt_on.gif',1)" target="mainFrame"><img name="Image4" border="0" src="../../enter/images/admin_left_acnt_off.gif" width="129" height="27"></a></H3>
             <p style="line-height:100%; margin-top:0; margin-bottom:0;">

<H3 style="line-height:100%; margin-top:70; margin-bottom:0;"><img name="Image63" border="0" src="../../enter/images/logo_lotte.gif" width="129" height="41"></H3>
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <img name="Image64" border="0" src="../../enter/images/logo_kweather.gif" width="129" height="43"></H3>
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <img name="Image65" border="0" src="../../enter/images/logo_ldcc.gif" width="129" height="39"></H3>
<!--오늘날짜/최종방문일 테이블 시작-->
<table width="129" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="129" height="48" background="../../enter/images/now1_bg.gif" class="table03">
	<!--오늘날짜 테이블 시작-->
      <table width="102" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="7" class="table03"><img src="../../enter/images/orange_buret.gif" width="7" height="7"></td>
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
    <td width="129" height="48" background="../../enter/images/now2_bg.gif" class="table03">
	<!--최종방문일 테이블 시작-->
      <table width="102" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="7" class="table03"><img src="../../enter/images/orange_buret.gif" width="7" height="7"></td>
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
<H3 style="line-height:100%; margin-top:10; margin-bottom:0;"> <a href=../../electric/index.asp target=_blank><img name="Image62" border="0" src="../../enter/images/energy_button.gif" width="129" height="26"></a></H3>
</BODY>
</html>
  <!-- #include file="../../enter/script/FnErrorCatch.inc" -->