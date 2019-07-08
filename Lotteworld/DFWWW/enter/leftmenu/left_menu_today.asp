<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' 프로그램ID : LEFT_MENU - TODAY
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 입장객 예측 왼쪽 메뉴 - TODAY
' 최초작성일 : 2002/10/16
' 최종작성일 : 2002/10/18
' 개  발  자 : 박순몽(kweather)
' 사용    DB : 없음
' ========================================================================================================
%>
<!-- #include file="../../enter/script/FnLeftMenu.inc" -->
<html>
<head>
<title>left menu_today</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<script language="JavaScript" src=../../enter/script/FnRolloverReload.js></script>
<link rel="stylesheet" href="../../enter/css/cs_tx.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" text="#000000" background="../../enter/images/left_bg.gif" onLoad="MM_preloadImages('../../enter/images/day_on.gif','../../enter/images/month_on.gif','../../enter/images/year_on.gif','../../enter/images/left_today_on.gif')">
<table width="129" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td><a onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','../../enter/images/left_today_on.gif',1)"><img name="Image7" border="0" src="../../enter/images/left_today_off.gif" width="129" height="27"></a></td>
  </tr>
  <tr> 
    <td><a href="../../enter/forecasting/today_day.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../../enter/images/day_on.gif',1)" target="mainFrame"><img name="Image1" border="0" src="../../enter/images/day.gif" width="129" height="27"></a></td>
  </tr>
  <tr> 
    <td><a href="../../enter/forecasting/today_month.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','../../enter/images/month_on.gif',1)" target="mainFrame"><img name="Image2" border="0" src="../../enter/images/month.gif" width="129" height="27"></a></td>
  </tr>
  <tr> 
    <td><a href="../../enter/forecasting/today_year.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','../../enter/images/year_on.gif',1)" target="mainFrame"><img name="Image3" border="0" src="../../enter/images/year.gif" width="129" height="27"></a></td>
  </tr>
  <tr>
    <td height="70"></td>
  </tr>
  <tr> 
    <td><img src="../../enter/images/logo_lotte.gif" width="129" height="41"></td>
  </tr>
  <tr> 
    <td><img src="../../enter/images/logo_kweather.gif" width="129" height="43"></td>
  </tr>
  <tr> 
    <td><img src="../../enter/images/logo_ldcc.gif" width="129" height="39"></td>
  </tr>
  <tr> 
    <td> 
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
                <td class="list09"> 
                  <% =FnDateFormat(date()) %>
                </td>
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
                <td class="list09"> 
                  <% =FnDateFormat(varlastconnecttime) %>
                </td>
              </tr>
            </table>
            <!--최종방문일 테이블 끝-->
          </td>
        </tr>
      </table>
      <!--오늘날짜/최종방문일 테이블 끝-->
    </td>
  </tr>
  <tr> 
    <td height="10"></td>
  </tr>
  <tr> 
    <td><a href=../../electric/index.asp target=_blank><img name="Image62" border="0" src="../../enter/images/energy_button.gif" width="129" height="26"></a></td>
  </tr>
</table>
</body>
</html>
<!-- #include file="../../enter/script/FnErrorCatch.inc" -->