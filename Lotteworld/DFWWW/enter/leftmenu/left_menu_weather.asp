<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' ���α׷�ID : LEFT_MENU - WEATHER
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���尴 ���� ���� �޴� - WEATHER
' �����ۼ��� : 2002/10/16
' �����ۼ��� : 2002/10/18
' ��  ��  �� : �ڼ���(kweather)
' ���    DB : ����
' ========================================================================================================
%>
<!-- #include file="../../enter/script/FnLeftMenu.inc" -->
<html>
 <head>
<title>���� ���ʸ޴�</title>
<STYLE TYPE="TEXT/CSS"> 
  <!-- A:link {text-decoration:none} A:visited {text-decoration:none} 
      A:hover {color: red; text-decoration:underline;}--> 
		#menu1 {display:none; margin-left:0px}
		#menu2 {display:none; margin-left:0px}
  </STYLE>
<SCRIPT language="JavaScript" src=../../enter/script/FnLeftMenuWeather.js></script>
<link rel="stylesheet" href="../../enter/css/cs_tx.css" type="text/css">
</head>
<BODY leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" background="../../enter/images/left_bg.gif" onLoad="MM_preloadImages('images/weather_left_outlook_on.gif');document.all.menu1.style.display='none'">
<h3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../enter/weather/weather_outlook.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../../enter/images/weather_left_outlook_on.gif',1)" target="mainFrame"><img name="Image1" border="0" src="../../enter/images/weather_left_outlook_off.gif" width="129" height="27"></a></h3>
<h3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../enter/weather/weather_land.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','../../enter/images/weather_left_land_on.gif',1)" target="mainFrame"><img name="Image3" border="0" src="../../enter/images/weather_left_land_off.gif" width="129" height="27"></a></h3>
<h3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../enter/weather/weather_sea.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','../../enter/images/weather_left_sea_on.gif',1)" target="mainFrame"><img name="Image4" border="0" src="../../enter/images/weather_left_sea_off.gif" width="129" height="27"></a></h3>
<h3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../enter/weather/weather_week.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','../../enter/images/weather_left_week_on.gif',1)" target="mainFrame"><img name="Image5" border="0" src="../../enter/images/weather_left_week_off.gif" width="129" height="27"></a></h3>
<h3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../enter/weather/weather_lifejisu.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','../../enter/images/weather_left_life_on.gif',1)" target="mainFrame"><img name="Image6" border="0" src="../../enter/images/weather_left_life_off.gif" width="129" height="27"></a></h3>

<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','../../enter/images/weather_left_point_on.gif',1)" onClick="return toggleMenu('menu1')" target="mainFrame"><img name="Image2" border="0" src="../../enter/images/weather_left_point_off.gif" width="129" height="27"></a></H3>
             <p style="line-height:100%; margin-top:0; margin-bottom:0;">
	   <SPAN ID="menu1">
             
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../enter/weather/weather_point.asp?varLocal=����/���" target="mainFrame" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image38','','../../enter/images/weather_left_seoul_on.gif',1)"><img name="Image38" border="0" src="../../enter/images/weather_left_seoul_off.gif" width="129" height="27"></a></H3>
		     <p style="line-height:100%; margin-top:0; margin-bottom:0;">
	         <H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../enter/weather/weather_point.asp?varLocal=����" target="mainFrame" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image42','','../../enter/images/weather_left_songpa_on.gif',1)"><img name="Image42" border="0" src="../../enter/images/weather_left_songpa_off.gif" width="129" height="27"></a></H3>
		     <p style="line-height:100%; margin-top:0; margin-bottom:0;">
	   </SPAN> 
<H3 style="line-height:100%; margin-top:70; margin-bottom:0;"><img name="Image63" border="0" src="../../enter/images/logo_lotte.gif" width="129" height="41"></H3>
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <img name="Image64" border="0" src="../../enter/images/logo_kweather.gif" width="129" height="43"></H3>
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <img name="Image65" border="0" src="../../enter/images/logo_ldcc.gif" width="129" height="39"></H3>
<!--���ó�¥/�����湮�� ���̺� ����-->
<table width="129" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="129" height="48" background="../../enter/images/now1_bg.gif" class="table03">
	<!--���ó�¥ ���̺� ����-->
      <table width="102" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="7" class="table03"><img src="../../enter/images/orange_buret.gif" width="7" height="7"></td>
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
    <td width="129" height="48" background="../../enter/images/now2_bg.gif" class="table03">
	<!--�����湮�� ���̺� ����-->
      <table width="102" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="7" class="table03"><img src="../../enter/images/orange_buret.gif" width="7" height="7"></td>
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
<H3 style="line-height:100%; margin-top:10; margin-bottom:0;"> <a href=../../electric/index.asp target=_blank><img name="Image62" border="0" src="../../enter/images/energy_button.gif" width="129" height="26"></a></H3>
</BODY>
</html>
  <!-- #include file="../../enter/script/FnErrorCatch.inc" -->