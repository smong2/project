<!-- #include file="../../electric/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' 프로그램ID : LEFT_MENU - 전기보고서
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 전기 예측 왼쪽 메뉴 - 보고서
' 최초작성일 : 2002/11/27
' 최종작성일 : 2002/11/27
' 개  발  자 : 박순몽(kweather)
' 사용    DB : 없음
' ========================================================================================================
%>
<!-- #include file="../../electric/script/FnLeftMenu.inc" -->
<html>
<head>
<title>전기보고서 왼쪽메뉴</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<script language="JavaScript" src=../../electric/script/FnRolloverReload.js></script>
<link rel="stylesheet" href="../../electric/css/cs_te.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" text="#000000" background="../../electric/images/left_bg.gif">
<table width="129" border="0" cellspacing="0" cellpadding="0">
  <!--<tr> 
    <td><a href="../../electric/report/report_week.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','../../electric/images/report_left_weekreport_on.gif',1)" target="mainFrame"><img name="Image7" border="0" src="../../electric/images/report_left_weekreport_off.gif" width="129" height="27"></a></td>
  </tr>
  <tr> 
    <td><a href="../../electric/report/report_varyweek.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../../electric/images/report_left_week_on.gif',1)" target="mainFrame"><img name="Image1" border="0" src="../../electric/images/report_left_week_off.gif" width="129" height="27"></a></td>
  </tr>
  <tr> 
    <td><a href="../../electric/report/report_varymonth.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','../../electric/images/report_left_month_on.gif',1)" target="mainFrame"><img name="Image2" border="0" src="../../electric/images/report_left_month_off.gif" width="129" height="27"></a></td>
  </tr>-->
  <tr>
    <td height="70"></td>
  </tr>
  <tr> 
    <td><img src="../../electric/images/logo_lotte.gif" width="129" height="41"></td>
  </tr>
  <tr> 
    <td><img src="../../electric/images/logo_kweather.gif" width="129" height="43"></td>
  </tr>
  <tr> 
    <td><img src="../../electric/images/logo_ldcc.gif" width="129" height="39"></td>
  </tr>
  <tr> 
    <td> 
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
                <td class="list09"> 
                  <% =FnDateFormat(date()) %>
                </td>
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
    <td><a href=../../enter/index.asp target=_blank><img name="Image62" border="0" src="../../electric/images/visitor_button.gif" width="129" height="26"></a></td>
  </tr>
</table>
</body>
</html>
<!-- #include file="../../electric/script/FnErrorCatch.inc" -->