<!-- #include file="../../electric/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' ���α׷�ID : LEFT_MENU - ���⳯��
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���� ���� ���� �޴� - ����
' �����ۼ��� : 2002/11/27
' �����ۼ��� : 2002/11/27
' ��  ��  �� : �ڼ���(kweather)
' ���    DB : ����
' ========================================================================================================
%>
<!-- #include file="../../electric/script/FnLeftMenu.inc" -->
<html>
 <head>
<title>���� ���ʸ޴�</title>
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
             <H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../electric/weather/weather_point.asp?varlocal=����/���" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image38','','../../electric/images/weather_left_seoul_on.gif',1)" target="mainFrame"><img name="Image38" border="0" src="../../electric/images/weather_left_seoul_off.gif" width="129" height="27"></a></H3>
		     <p style="line-height:100%; margin-top:0; margin-bottom:0;">
	         <H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../electric/weather/weather_point.asp?varlocal=����" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image42','','../../electric/images/weather_left_songpa_on.gif',1)" target="mainFrame"><img name="Image42" border="0" src="../../electric/images/weather_left_songpa_off.gif" width="129" height="27"></a></H3>
		     <p style="line-height:100%; margin-top:0; margin-bottom:0;">
	   </SPAN> 
<H3 style="line-height:100%; margin-top:70; margin-bottom:0;"><img name="Image63" border="0" src="../../electric/images/logo_lotte.gif" width="129" height="41"></H3>
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <img name="Image64" border="0" src="../../electric/images/logo_kweather.gif" width="129" height="43"></H3>
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <img name="Image65" border="0" src="../../electric/images/logo_ldcc.gif" width="129" height="39"></H3>
<!--���ó�¥/�����湮�� ���̺� ����-->
<table width="129" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="129" height="48" background="../../electric/images/now1_bg.gif" class="table03">
	<!--���ó�¥ ���̺� ����-->
      <table width="102" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="7" class="table03"><img src="../../electric/images/orange_buret.gif" width="7" height="7"></td>
          <td width="5"></td>
          <td class="title_02">������</td>
        </tr>
        <tr> 
          <td width="7"></td>
          <td width="5"></td>
          <td class="list09"><% =FnDateFormat(date()) %></td>
        </tr>
      </table>
	  <!--���ó�¥ ���̺� ��-->
    </td>
  </tr>
  <tr>
    <td width="129" height="48" background="../../electric/images/now2_bg.gif" class="table03">
	<!--�����湮�� ���̺� ����-->
      <table width="102" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="7" class="table03"><img src="../../electric/images/orange_buret.gif" width="7" height="7"></td>
          <td width="5"></td>
          <td class="title_02">�����湮��</td>
        </tr>
        <tr> 
          <td width="7"></td>
          <td width="5"></td>
          <td class="list09"><% =FnDateFormat(varlastconnecttime) %></td>
        </tr>
      </table>
	  <!--�����湮�� ���̺� ��-->
    </td>
  </tr>
</table>
<!--���ó�¥/�����湮�� ���̺� ��-->
<H3 style="line-height:100%; margin-top:10; margin-bottom:0;"> <a href=../../enter/index.asp target=_blank><img name="Image62" border="0" src="../../electric/images/visitor_button.gif" width="129" height="26"></a></H3>
</BODY>
</html>
<!-- #include file="../../electric/script/FnErrorCatch.inc" -->