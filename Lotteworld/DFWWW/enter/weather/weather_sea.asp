<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<%
' ========================================================================================================
' 프로그램ID : TXB Weather Sea
' 업  무  명 : 수요예측
' 프로그램명 : 날씨 해상 정보 출력
' 최초작성일 : 2002/11/29
' 최종작성일 : 2002/12/03
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim rstoday,rstomo,rsafterto '오늘 해상 예보, 내일 해상 예보, 모레 해상 예보 레코드셋
Dim varLocal '지역'

varLocal=Request.QueryString("varLocal") '초기값은 서해
IF varLocal="" THEN varLocal="서해"

ArrQuery = array(varLocal) '지역을 가져오고

'변수의 설정
Set objServer = Server.CreateObject("XBWeatherSeaQMTS.clsXBWeatherSeaQNTX")

'컴포넌트 호출
arrRValue = objServer.Query(ArrQuery)
'레코드셋 어레이를 단일 레코드셋으로 분리

'첫번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rstoday,1
'두번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rstomo,2
'세번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rsafterto,3

'자원의 해제
Set objServer = Nothing

'에러의 처리
IF Err.Number <> 0 THEN 
	Response.Write Err.Number, Err.Source, Err.Description
	Set objServer = Nothing
	objserver.close
END IF
%>
<!-- #include file="../../enter/script/FnProgramProcess.vbs" -->
<!-- #include file="../../enter/script/FnWeather_Icon.inc"-->
<html>
<head>
<title>롯데월드 수요예측시스템</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../../enter/css/cs_tx.css" type="text/css">
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
  <tr> 
    <td width="49"><img src="../../enter/images/null.gif" width="49" height="1"></td>
    <td width="642" valign="top">
	<!-- 큰 테이블 시작-->
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="24"><img src="../../enter/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
          <td align="left" height="21"><img src="../../enter/images/title_weather_sea.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td> 
            <!--날씨 지역 테이블 시작-->
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="15" height="11" class="table03"><img src="../../enter/images/orange_buret.gif" width="7" height="7"></td>
                <td class="title_01">ㅣ<a href="weather_sea.asp?varLocal=서해">서해해상</a>ㅣ<a href="weather_sea.asp?varLocal=남해">남해해상</a>ㅣ<a href="weather_sea.asp?varLocal=동해">동해해상</a> 
                  l</td>
              </tr>
            </table>
            <!--날씨 지역 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td height="10"></td>
        </tr>
        <tr> 
          <td>
		  <!--서해해상지역 타이틀 시작--> 
            <table width="642" border="1" bordercolor="#dadada" cellspacing="0" cellpadding="7">
              <tr> 
                <td class="list07_bg4"><% =varLocal %>해상지역</td>
              </tr>
            </table>
			<!--서해해상지역 타이틀 끝-->
          </td>
        </tr>
        <tr> 
          <td height="5"></td>
        </tr>
        <tr> 
          <td> 
            <!-- 서해해상 날씨 테이블 시작-->
            <table width="642" border="1" bordercolor="#dadada" cellspacing="0" cellpadding="7">
              <tr class="list07_bg"> 
                <td colspan="2" rowspan="3">예보구역</td>
                <td colspan="4">중부</td>
              </tr>
              <tr class="list03_bg"> 
                <td colspan="2">앞바다</td>
                <td colspan="2">먼바다</td>
              </tr>
              <tr class="list03_bg2"> 
                <td>오전</td>
                <td>오후</td>
                <td>오전</td>
                <td>오후</td>
              </tr>
              <tr> 
                <td class="list15_bg" rowspan="4"><% =right(rstoday("sdate"),2) %></td>
                <td class="list05_bg2">날씨</td>
                <td class="list14_1" colspan="2"><img src="../../enter/images/new<% =FnWeatherIcon(rstoday("overview")) %>.gif" width="34" height="34" alt='<% =rstoday("overview") %>'><% rstoday.MOVENEXT %></td>
                <td class="list14_1" colspan="2"><img src="../../enter/images/new<% =FnWeatherIcon(rstoday("overview")) %>.gif" width="34" height="34" alt='<% =rstoday("overview") %>'><% rstoday.MOVEFIRST%></td>
              </tr>
              <tr> 
                <td class="list05_bg2">풍향</td>
                <td class="list14_1"><% =rstoday("winddiram") %></td>
                <td class="list14_1"><% =rstoday("winddirpm") %><% rstoday.MOVENEXT %></td>
                <td class="list14_1"><% =rstoday("winddiram") %></td>
                <td class="list14_1"><% =rstoday("winddirpm") %><% rstoday.MOVEFIRST %></td>
              </tr>
              <tr> 
                <td class="list05_bg2">풍속</td>
                <td class="list14_1"><% =rstoday("windspeedam") %></td>
                <td class="list14_1"><% =rstoday("windspeedpm") %><% rstoday.MOVENEXT %></td>
                <td class="list14_1"><% =rstoday("windspeedam") %></td>
                <td class="list14_1"><% =rstoday("windspeedpm") %><% rstoday.MOVEFIRST %></td>
              </tr>
              <tr> 
                <td class="list05_bg2">파고</td>
                <td class="list14_1"><% =rstoday("wavehigham") %></td>
                <td class="list14_1"><% =rstoday("wavehighpm") %><% rstoday.MOVENEXT %></td>
                <td class="list14_1"><% =rstoday("wavehigham") %></td>
                <td class="list14_1"><% =rstoday("wavehighpm") %><% rstoday.MOVENEXT %></td>
              </tr>
              <tr> 
                <td class="list15_bg" rowspan="4"><% =right(rstomo("sdate"),2) %></td>
                <td class="list05_bg2">날씨</td>
                <td class="list14_1" colspan="2"><img src="../../enter/images/new<% =FnWeatherIcon(rstomo("overview")) %>.gif" width="34" height="34" alt='<% =rstomo("overview") %>'><% rstomo.MOVENEXT %></td>
                <td class="list14_1" colspan="2"><img src="../../enter/images/new<% =FnWeatherIcon(rstomo("overview")) %>.gif" width="34" height="34" alt='<% =rstomo("overview") %>'><% rstomo.MOVEFIRST %></td>
              </tr>
              <tr> 
                <td class="list05_bg2">풍향</td>
                <td class="list14_1"><% =rstomo("winddiram") %></td>
                <td class="list14_1"><% =rstomo("winddirpm") %><% rstomo.MOVENEXT %></td>
                <td class="list14_1"><% =rstomo("winddiram") %></td>
                <td class="list14_1"><% =rstomo("winddirpm") %><% rstomo.MOVEFIRST %></td>
              </tr>
              <tr> 
                <td class="list05_bg2">풍속</td>
                <td class="list14_1"><% =rstomo("windspeedam") %></td>
                <td class="list14_1"><% =rstomo("windspeedpm") %><% rstomo.MOVENEXT %></td>
                <td class="list14_1"><% =rstomo("windspeedam") %></td>
                <td class="list14_1"><% =rstomo("windspeedpm") %><% rstomo.MOVEFIRST %></td>
              </tr>
              <tr> 
                <td class="list05_bg2">파고</td>
                <td class="list14_1"><% =rstomo("wavehigham") %></td>
                <td class="list14_1"><% =rstomo("wavehighpm") %><% rstomo.MOVENEXT %></td>
                <td class="list14_1"><% =rstomo("wavehigham") %></td>
                <td class="list14_1"><% =rstomo("wavehighpm") %><% rstomo.MOVENEXT %></td>
              </tr>
              <tr> 
                <td class="list15_bg" rowspan="4"><% =right(rsafterto("sdate"),2) %></td>
                <td class="list05_bg2">날씨</td>
                <td class="list14_1" colspan="2"><img src="../../enter/images/new<% =FnWeatherIcon(rsafterto("overview")) %>.gif" width="34" height="34" alt='<% =rsafterto("overview") %>'><% rsafterto.MOVENEXT %></td>
                <td class="list14_1" colspan="2"><img src="../../enter/images/new<% =FnWeatherIcon(rsafterto("overview")) %>.gif" width="34" height="34" alt='<% =rsafterto("overview") %>'><% rsafterto.MOVEFIRST%></td>
              </tr>
              <tr> 
                <td class="list05_bg2">풍향</td>
                <td class="list14_1"><% =rsafterto("winddiram") %></td>
                <td class="list14_1"><% =rsafterto("winddirpm") %><% rsafterto.MOVENEXT %></td>
                <td class="list14_1"><% =rsafterto("winddiram") %></td>
                <td class="list14_1"><% =rsafterto("winddirpm") %><% rsafterto.MOVEFIRST %></td>
              </tr>
              <tr> 
                <td class="list05_bg2">풍속</td>
                <td class="list14_1"><% =rsafterto("windspeedam") %></td>
                <td class="list14_1"><% =rsafterto("windspeedpm") %><% rsafterto.MOVENEXT %></td>
                <td class="list14_1"><% =rsafterto("windspeedam") %></td>
                <td class="list14_1"><% =rsafterto("windspeedpm") %><% rsafterto.MOVEFIRST %></td>
              </tr>
              <tr> 
                <td class="list05_bg2">파고</td>
                <td class="list14_1"><% =rsafterto("wavehigham") %></td>
                <td class="list14_1"><% =rsafterto("wavehighpm") %><% rsafterto.MOVENEXT %></td>
                <td class="list14_1"><% =rsafterto("wavehigham") %></td>
                <td class="list14_1"><% =rsafterto("wavehighpm") %><% rsafterto.MOVENEXT %></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td height="5"></td>
        </tr>
        <tr> 
          <td>
            <table width="642" border="1" bordercolor="#dadada" cellspacing="0" cellpadding="7">
              <tr class="list07_bg"> 
                <td colspan="2" rowspan="3">예보구역</td>
                <td colspan="4">남부</td>
              </tr>
              <tr class="list03_bg"> 
                <td colspan="2">앞바다</td>
                <td colspan="2">먼바다</td>
              </tr>
              <tr class="list03_bg2"> 
                <td>오전</td>
                <td>오후</td>
                <td>오전</td>
                <td>오후</td>
              </tr>
              <tr> 
                <td class="list15_bg" rowspan="4"><% =right(rstoday("sdate"),2) %></td>
                <td class="list05_bg2">날씨</td>
                <td class="list14_1" colspan="2"><img src="../../enter/images/new<% =FnWeatherIcon(rstoday("overview")) %>.gif" width="34" height="34" alt='<% =rstoday("overview") %>'><% rstoday.MOVENEXT %></td>
                <td class="list14_1" colspan="2"><img src="../../enter/images/new<% =FnWeatherIcon(rstoday("overview")) %>.gif" width="34" height="34" alt='<% =rstoday("overview") %>'><% rstoday.MOVEFIRST%></td>
              </tr>
              <tr> 
                <td class="list05_bg2">풍향</td>
                <td class="list14_1"><% =rstoday("winddiram") %></td>
                <td class="list14_1"><% =rstoday("winddirpm") %><% rstoday.MOVENEXT %></td>
                <td class="list14_1"><% =rstoday("winddiram") %></td>
                <td class="list14_1"><% =rstoday("winddirpm") %><% rstoday.MOVEFIRST %></td>
              </tr>
              <tr> 
                <td class="list05_bg2">풍속</td>
                <td class="list14_1"><% =rstoday("windspeedam") %></td>
                <td class="list14_1"><% =rstoday("windspeedpm") %><% rstoday.MOVENEXT %></td>
                <td class="list14_1"><% =rstoday("windspeedam") %></td>
                <td class="list14_1"><% =rstoday("windspeedpm") %><% rstoday.MOVEFIRST %></td>
              </tr>
              <tr> 
                <td class="list05_bg2">파고</td>
                <td class="list14_1"><% =rstoday("wavehigham") %></td>
                <td class="list14_1"><% =rstoday("wavehighpm") %><% rstoday.MOVENEXT %></td>
                <td class="list14_1"><% =rstoday("wavehigham") %></td>
                <td class="list14_1"><% =rstoday("wavehighpm") %><% rstoday.MOVENEXT %></td>
              </tr>
              <tr> 
                <td class="list15_bg" rowspan="4"><% =right(rstomo("sdate"),2) %></td>
                <td class="list05_bg2">날씨</td>
                <td class="list14_1" colspan="2"><img src="../../enter/images/new<% =FnWeatherIcon(rstomo("overview")) %>.gif" width="34" height="34" alt='<% =rstomo("overview") %>'><% rstomo.MOVENEXT %></td>
                <td class="list14_1" colspan="2"><img src="../../enter/images/new<% =FnWeatherIcon(rstomo("overview")) %>.gif" width="34" height="34" alt='<% =rstomo("overview") %>'><% rstomo.MOVEFIRST %></td>
              </tr>
              <tr> 
                <td class="list05_bg2">풍향</td>
                <td class="list14_1"><% =rstomo("winddiram") %></td>
                <td class="list14_1"><% =rstomo("winddirpm") %><% rstomo.MOVENEXT %></td>
                <td class="list14_1"><% =rstomo("winddiram") %></td>
                <td class="list14_1"><% =rstomo("winddirpm") %><% rstomo.MOVEFIRST %></td>
              </tr>
              <tr> 
                <td class="list05_bg2">풍속</td>
                <td class="list14_1"><% =rstomo("windspeedam") %></td>
                <td class="list14_1"><% =rstomo("windspeedpm") %><% rstomo.MOVENEXT %></td>
                <td class="list14_1"><% =rstomo("windspeedam") %></td>
                <td class="list14_1"><% =rstomo("windspeedpm") %><% rstomo.MOVEFIRST %></td>
              </tr>
              <tr> 
                <td class="list05_bg2">파고</td>
                <td class="list14_1"><% =rstomo("wavehigham") %></td>
                <td class="list14_1"><% =rstomo("wavehighpm") %><% rstomo.MOVENEXT %></td>
                <td class="list14_1"><% =rstomo("wavehigham") %></td>
                <td class="list14_1"><% =rstomo("wavehighpm") %><% rstomo.MOVENEXT %></td>
              </tr>
              <tr> 
                <td class="list15_bg" rowspan="4"><% =right(rsafterto("sdate"),2) %></td>
                <td class="list05_bg2">날씨</td>
                <td class="list14_1" colspan="2"><img src="../../enter/images/new<% =FnWeatherIcon(rsafterto("overview")) %>.gif" width="34" height="34" alt='<% =rsafterto("overview") %>'><% rsafterto.MOVENEXT %></td>
                <td class="list14_1" colspan="2"><img src="../../enter/images/new<% =FnWeatherIcon(rsafterto("overview")) %>.gif" width="34" height="34" alt='<% =rsafterto("overview") %>'><% rsafterto.MOVEFIRST%></td>
              </tr>
              <tr> 
                <td class="list05_bg2">풍향</td>
                <td class="list14_1"><% =rsafterto("winddiram") %></td>
                <td class="list14_1"><% =rsafterto("winddirpm") %><% rsafterto.MOVENEXT %></td>
                <td class="list14_1"><% =rsafterto("winddiram") %></td>
                <td class="list14_1"><% =rsafterto("winddirpm") %><% rsafterto.MOVEFIRST %></td>
              </tr>
              <tr> 
                <td class="list05_bg2">풍속</td>
                <td class="list14_1"><% =rsafterto("windspeedam") %></td>
                <td class="list14_1"><% =rsafterto("windspeedpm") %><% rsafterto.MOVENEXT %></td>
                <td class="list14_1"><% =rsafterto("windspeedam") %></td>
                <td class="list14_1"><% =rsafterto("windspeedpm") %><% rsafterto.MOVEFIRST %></td>
              </tr>
              <tr> 
                <td class="list05_bg2">파고</td>
                <td class="list14_1"><% =rsafterto("wavehigham") %></td>
                <td class="list14_1"><% =rsafterto("wavehighpm") %><% rsafterto.MOVENEXT %></td>
                <td class="list14_1"><% =rsafterto("wavehigham") %></td>
                <td class="list14_1"><% =rsafterto("wavehighpm") %><% rsafterto.MOVENEXT %></td>
              </tr>
            </table>
			<!--서해해상 날씨 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td height="30"></td>
        </tr>
      </table>
	  <!--큰 테이블 끝-->
    </td>
    <td width="49"><img src="../../enter/images/null.gif" width="49" height="1"></td>
    <td bgcolor="#a4a4a4"><img src="../../enter/images/outline.gif" width="1" height="1"></td>
  </tr>
  <tr> 
    <td height="42" colspan="3" align="right" background="../../enter/images/copyright_bg.gif"><img src="../../enter/images/copyright.gif" width="350" height="42"></td>
    <td bgcolor="#a4a4a4" width="1" height="42"><img src="../../enter/images/null.gif"></td>
  </tr>
</table>
</body>
</html>
<!-- #include file="../../enter/script/FnErrorCatch.inc"-->