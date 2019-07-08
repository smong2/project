<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' 프로그램ID : LEFT_MENU - 입장객
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 입장객 예측 왼쪽 메뉴 - 입장객
' 최초작성일 : 2002/10/16
' 최종작성일 : 2002/10/18
' 개  발  자 : 박순몽(kweather)
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
		#menu1_1 {display:none; margin-left:0px}
		#menu1_2 {display:none; margin-left:0px}
		#menu1_3 {display:none; margin-left:0px}
		#menu2 {display:none; margin-left:0px}
		#menu2_1 {display:none; margin-left:0px}
		#menu2_2{display:none; margin-left:0px}
		#menu2_3 {display:none; margin-left:0px}
		#menu3 {display:none; margin-left:0px}
  </STYLE>
<SCRIPT TYPE="TEXT/JAVASCRIPT" LANGUAGE=JAVASCRIPT src=../../enter/script/FnLeftMenu.js></SCRIPT>
<link rel="stylesheet" href="../../enter/css/cs_tx.css" type="text/css">
</head>
<BODY leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" background="../../enter/images/left_bg.gif" onLoad="MM_preloadImages('../../enter/images/visitorforecast_left1.gif','../../enter/images/visitorforecast_left2.gif','../../enter/images/visitorforecast_left3.gif','../../enter/images/group_on.gif');document.all.menu1.style.display='none'">
<div align="right"></div>
<h3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image22','','../../enter/images/enterforecast_left1.gif',1)" onClick="return toggleMenu('menu1')" target="mainFrame"><img name="Image22" border="0" src="../../enter/images/enterforecast_left1_off.gif" width="129" height="27"></a></h3>
    <p style="line-height:100%; margin-top:0; margin-bottom:0;">
	   
<SPAN ID="menu1"> 
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image26','','../../enter/images/day_on.gif',1)" onclick="return toggleMenu('menu1_1')"><img name="Image26" border="0" src="../../enter/images/day.gif" width="129" height="27"></a></H3>
<p style="line-height:100%; margin-top:0; margin-bottom:0;"> <SPAN ID="menu1_1"> 
  <a href="../../enter/forecasting/Enter_day_total.asp?varEnterType=vxt" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image27','','../../enter/images/whole_on.gif',1)" target='mainFrame'><img name="Image27" border="0" src="../../enter/images/whole.gif" width="129" height="27"></a><BR>
  <a href="../../enter/forecasting/Enter_day_indiv.asp?varEnterType=vxt" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image28','','../../enter/images/individual_on.gif',1)" target='mainFrame'><img name="Image28" border="0" src="../../enter/images/individual.gif" width="129" height="27"></a><BR>
  <a href="../../enter/forecasting/Enter_day_group.asp?varEnterType=vxt" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image29','','../../enter/images/group_on.gif',1)" target='mainFrame'><img name="Image29" border="0" src="../../enter/images/group.gif" width="129" height="27"></a><BR>
  </SPAN> 
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image30','','../../enter/images/month_on.gif',1)" onclick="return toggleMenu('menu1_2')"><img name="Image30" border="0" src="../../enter/images/month.gif" width="129" height="27"></a></H3>
<p style="line-height:100%; margin-top:0; margin-bottom:0;"> <SPAN ID="menu1_2"> 
  <a href="../../enter/forecasting/Enter_month_total.asp?varEnterType=vxt" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image31','','../../enter/images/whole_on.gif',1)" target="mainFrame"><img name="Image31" border="0" src="../../enter/images/whole.gif" width="129" height="27"></a><BR>
  <a href="../../enter/forecasting/Enter_month_indiv.asp?varEnterType=vxt" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image32','','../../enter/images/individual_on.gif',1)" target="mainFrame"><img name="Image32" border="0" src="../../enter/images/individual.gif" width="129" height="27"></a><BR>
  <a href="../../enter/forecasting/Enter_month_group.asp?varEnterType=vxt" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image33','','../../enter/images/group_on.gif',1)" target="mainFrame"><img name="Image33" border="0" src="../../enter/images/group.gif" width="129" height="27"></a><BR>
  </SPAN> 
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image34','','../../enter/images/year_on.gif',1)" onclick="return toggleMenu('menu1_3')"><img name="Image34" border="0" src="../../enter/images/year.gif" width="129" height="27"></a></H3>
<p style="line-height:100%; margin-top:0; margin-bottom:0;"> <SPAN ID="menu1_3"> 
  <a href="../../enter/forecasting/Enter_year_total.asp?varEnterType=vxt" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image35','','../../enter/images/whole_on.gif',1)" target="mainFrame"><img name="Image35" border="0" src="../../enter/images/whole.gif" width="129" height="27"></a><BR>
  <a href="../../enter/forecasting/Enter_year_indiv.asp?varEnterType=vxt" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image36','','../../enter/images/individual_on.gif',1)" target="mainFrame"><img name="Image36" border="0" src="../../enter/images/individual.gif" width="129" height="27"></a><BR>
  <a href="../../enter/forecasting/Enter_year_group.asp?varEnterType=vxt" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image37','','../../enter/images/group_on.gif',1)" target="mainFrame"><img name="Image37" border="0" src="../../enter/images/group.gif" width="129" height="27"></a><BR>
  </SPAN> 
</SPAN> 
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image23','','../../enter/images/enterforecast_left2.gif',1)" onClick="return toggleMenu('menu2')" target="mainFrame"><img name="Image23" border="0" src="../../enter/images/enterforecast_left2_off.gif" width="129" height="27"></a></H3>
    <p style="line-height:100%; margin-top:0; margin-bottom:0;">
	   <SPAN ID="menu2">
            <H3 style="line-height:100%; margin-top:0; margin-bottom:0;">
		    <a  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image38','','../../enter/images/day_on.gif',1)" onclick="return toggleMenu('menu2_1')"><img name="Image38" border="0" src="../../enter/images/day.gif" width="129" height="27"></a></H3>
		    
<p style="line-height:100%; margin-top:0; margin-bottom:0;"> <SPAN ID="menu2_1"> 
  <a href="../../enter/forecasting/Enter_day_total.asp?varEnterType=vxte" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image39','','../../enter/images/whole_on.gif',1)" target="mainFrame"><img name="Image39" border="0" src="../../enter/images/whole.gif" width="129" height="27"></a><BR>
  <a href="../../enter/forecasting/Enter_day_indiv.asp?varEnterType=vxte" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image40','','../../enter/images/individual_on.gif',1)" target="mainFrame"><img name="Image40" border="0" src="../../enter/images/individual.gif" width="129" height="27"></a><BR>
  <a href="../../enter/forecasting/Enter_day_group.asp?varEnterType=vxte" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image41','','../../enter/images/group_on.gif',1)" target="mainFrame"><img name="Image41" border="0" src="../../enter/images/group.gif" width="129" height="27"></a><BR>
		    </SPAN>
	        <H3 style="line-height:100%; margin-top:0; margin-bottom:0;">
		    <a  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image42','','../../enter/images/month_on.gif',1)" onclick="return toggleMenu('menu2_2')"><img name="Image42" border="0" src="../../enter/images/month.gif" width="129" height="27"></a></H3>
		    
<p style="line-height:100%; margin-top:0; margin-bottom:0;"> <SPAN ID="menu2_2"> 
  <a href="../../enter/forecasting/Enter_month_total.asp?varEnterType=vxte" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image43','','../../enter/images/whole_on.gif',1)" target="mainFrame"><img name="Image43" border="0" src="../../enter/images/whole.gif" width="129" height="27"></a><BR>
  <a href="../../enter/forecasting/Enter_month_indiv.asp?varEnterType=vxte" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image44','','../../enter/images/individual_on.gif',1)" target="mainFrame"><img name="Image44" border="0" src="../../enter/images/individual.gif" width="129" height="27"></a><BR>
  <a href="../../enter/forecasting/Enter_month_group.asp?varEnterType=vxte" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image45','','../../enter/images/group_on.gif',1)" target="mainFrame"><img name="Image45" border="0" src="../../enter/images/group.gif" width="129" height="27"></a><BR>
		    </SPAN>
	        <H3 style="line-height:100%; margin-top:0; margin-bottom:0;">
		    <a onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image46','','../../enter/images/year_on.gif',1)" onclick="return toggleMenu('menu2_3')"><img name="Image46" border="0" src="../../enter/images/year.gif" width="129" height="27"></a></H3>
		    
<p style="line-height:100%; margin-top:0; margin-bottom:0;"> <SPAN ID="menu2_3"> 
  <a href="../../enter/forecasting/Enter_year_total.asp?varEnterType=vxte" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image47','','../../enter/images/whole_on.gif',1)" target="mainFrame"><img name="Image47" border="0" src="../../enter/images/whole.gif" width="129" height="27"></a><BR>
  <a href="../../enter/forecasting/Enter_year_indiv.asp?varEnterType=vxte" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image48','','../../enter/images/individual_on.gif',1)" target="mainFrame"><img name="Image48" border="0" src="../../enter/images/individual.gif" width="129" height="27"></a><BR>
  <a href="../../enter/forecasting/Enter_year_group.asp?varEnterType=vxte" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image49','','../../enter/images/group_on.gif',1)" target="mainFrame"><img name="Image49" border="0" src="../../enter/images/group.gif" width="129" height="27"></a><BR>
		    </SPAN>
	  
</SPAN> 
	   
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image24','','../../enter/images/enterforecast_left3.gif',1)" onClick="return toggleMenu('menu3')" target="mainFrame"><img name="Image24" border="0" src="../../enter/images/enterforecast_left3_off.gif" width="129" height="27"></a></H3>
     <p style="line-height:100%; margin-top:0; margin-bottom:0;">
	   <SPAN ID="menu3">
            
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../enter/forecasting/rival_main.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image59','','../../enter/images/rival_main_on.gif',1)" target="mainFrame"><img name="Image59" border="0" src="../../enter/images/rival_main_off.gif" width="129" height="27"></a></H3>
		    <p style="line-height:100%; margin-top:0; margin-bottom:0;">
			
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../enter/forecasting/rival_year.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image50','','../../enter/images/year_on.gif',1)" target="mainFrame"><img name="Image50" border="0" src="../../enter/images/year.gif" width="129" height="27"></a></H3>
		    <p style="line-height:100%; margin-top:0; margin-bottom:0;">
			
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../enter/forecasting/rival_month.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image54','','../../enter/images/month_on.gif',1)" target="mainFrame"><img name="Image54" border="0" src="../../enter/images/month.gif" width="129" height="27"></a></H3>
		    <p style="line-height:100%; margin-top:0; margin-bottom:0;">
	        
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <a href="../../enter/forecasting/rival_monthtotal.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image58','','../../enter/images/month_total_on.gif',1)" target="mainFrame"><img name="Image58" border="0" src="../../enter/images/month_total.gif" width="129" height="27"></a></H3>
		    <p style="line-height:100%; margin-top:0; margin-bottom:0;">
</SPAN> 
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
<H3 style="line-height:100%; margin-top:10; margin-bottom:0;">
<a href=../../electric/index.asp target=_blank><img name="Image62" border="0" src="../../enter/images/energy_button.gif" width="129" height="26"></a></H3>
</BODY>
</html>
<!-- #include file="../../enter/script/FnErrorCatch.inc" -->
