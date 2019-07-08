<!-- #include file="../../electric/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' 프로그램ID : LEFT_MENU - 전기날씨
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 전기 예측 왼쪽 메뉴 - 날씨
' 최초작성일 : 2002/11/27
' 최종작성일 : 2002/11/27
' 개  발  자 : 박순몽(kweather)
' 사용    DB : 없음
' ========================================================================================================
%>
<!-- #include file="../../electric/script/FnLeftMenu.inc" -->
<html>
 <head>
<title>날씨 왼쪽메뉴</title>
<STYLE TYPE="TEXT/CSS"> 
  <!-- A:link {text-decoration:none} A:visited {text-decoration:none} 
      A:hover {color: red; text-decoration:underline;}--> 
		#menu1 {display:none; margin-left:0px}
		#menu2 {display:none; margin-left:0px}
  </STYLE>
<SCRIPT TYPE="TEXT/JAVASCRIPT" LANGUAGE=JAVASCRIPT src=../../electric/script/FnLeftMenuWeather.js></SCRIPT>
<link rel="stylesheet" href="../../electric/css/cs_te.css" type="text/css">
</head>
<BODY leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" background="../../electric/images/left_bg.gif" onLoad="MM_preloadImages('../../electric/images/weather_left_outlook_on.gif')">
<h3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../electric/weather/weather_outlook.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../../electric/images/weather_left_outlook_on.gif',1)" target="mainFrame"><img name="Image1" border="0" src="../../electric/images/weather_left_outlook_off.gif" width="129" height="27"></a></h3>
<h3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../electric/weather/weather_land.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','../../electric/images/weather_left_land_on.gif',1)" target="mainFrame"><img name="Image3" border="0" src="../../electric/images/weather_left_land_off.gif" width="129" height="27"></a></h3>
<h3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../electric/weather/weather_sea.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','../../electric/images/weather_left_sea_on.gif',1)" target="mainFrame"><img name="Image4" border="0" src="../../electric/images/weather_left_sea_off.gif" width="129" height="27"></a></h3>
<h3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../electric/weather/weather_week.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','../../electric/images/weather_left_week_on.gif',1)" target="mainFrame"><img name="Image5" border="0" src="../../electric/images/weather_left_week_off.gif" width="129" height="27"></a></h3>
<h3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../electric/weather/weather_lifejisu.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','../../electric/images/weather_left_life_on.gif',1)" target="mainFrame"><img name="Image6" border="0" src="../../electric/images/weather_left_life_off.gif" width="129" height="27"></a></h3>

<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','../../electric/images/weather_left_point_on.gif',1)" onClick="return toggleMenu('menu1')" target="mainFrame"><img name="Image2" border="0" src="../../electric/images/weather_left_point_off.gif" width="129" height="27"></a></H3>
<p style="line-height:100%; margin-top:0; margin-bottom:0;">
	   <SPAN ID="menu1">
             <H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../electric/weather/weather_point.asp?varlocal=서울/경기" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image38','','../../electric/images/weather_left_seoul_on.gif',1)" target="mainFrame"><img name="Image38" border="0" src="../../electric/images/weather_left_seoul_off.gif" width="129" height="27"></a></H3>
		     <p style="line-height:100%; margin-top:0; margin-bottom:0;">
	         <H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../electric/weather/weather_point.asp?varlocal=송파" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image42','','../../electric/images/weather_left_songpa_on.gif',1)" target="mainFrame"><img name="Image42" border="0" src="../../electric/images/weather_left_songpa_off.gif" width="129" height="27"></a></H3>
		     <p style="line-height:100%; margin-top:0; margin-bottom:0;">
	   </SPAN> 
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