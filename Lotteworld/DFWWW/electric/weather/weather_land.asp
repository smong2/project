<!-- #include file="../../electric/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' 프로그램ID : TXBWEATHERLANDSEOUL
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 날씨 표출 - 육상예보
' 최초작성일 : 2002/11/28
' 최종작성일 : 2002/11/28
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim rs,rsjisu, varAreaCode, varAreaName '지역코드
'레코드셋 (날씨지역목록,날씨지수)
dim intI '증가변수

varAreaCode=Request.QueryString("varAreaCode")
varAreaName=Request.QueryString("varAreaName")

IF varAreaCode="" THEN varAreaCode=14 '대체값 설정
IF varAreaName="" THEN varAreaName="서울/경기"

ArrQuery = array(varAreaName,varAreaCode) '페이지에 맞는 코드 가져오고

'변수의 설정
Set objServer = Server.CreateObject("XBWeatherViewQMTS.clsXBWeatherViewQNTX")

'컴포넌트 호출
arrRValue = objServer.Query(ArrQuery)
'레코드셋 어레이를 단일 레코드셋으로 분리

'첫번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rs,2

'자원의 해제
Set objServer = Nothing

IF varAreaName="" THEN varAreaName="서울/경기" '초기값 서울/경기

'에러의 처리
IF Err.Number <> 0 THEN 
	Response.Write Err.Number, Err.Source, Err.Description
	Set objServer = Nothing
	objserver.close
END IF
%>	
<!-- #include file="../../electric/script/FnProgramProcess.vbs" -->
<!-- #include file="../../electric/script/fnnumber_format.inc"-->	
<!-- #include file="../../electric/script/FnWeather_Icon.inc"-->
<html>
<head>
<title>롯데월드 수요예측시스템</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../../electric/css/cs_te.css" type="text/css">
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
  <tr> 
    <td width="49"><img src="../../electric/images/null.gif" width="49" height="1"></td>
    <td width="642" valign="top">
	<!-- 큰 테이블 시작-->
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="../../electric/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
          <td><img src="../../electric/images/title_weather_land.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../electric/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--날씨 지역 테이블 시작--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="15" height="11" class="table03"><img src="../../electric/images/orange_buret.gif" width="7" height="7"></td>
                <td class="title_01">ㅣ<a href="weather_land.asp?varAreaCode=14&varAreaName=서울/경기">서울/경기</a>ㅣ
										<a href="weather_land.asp?varAreaCode=19&varAreaName=충남">충남</a>ㅣ
										<a href="weather_land.asp?varAreaCode=14&varAreaName=충북">충북</a>ㅣ
										<a href="weather_land.asp?varAreaCode=11&varAreaName=서해5도">서해5도</a>ㅣ
										<a href="weather_land.asp?varAreaCode=15&varAreaName=영서">영서</a>ㅣ
										<a href="weather_land.asp?varAreaCode=16&varAreaName=영동">영동</a>ㅣ
										<a href="weather_land.asp?varAreaCode=17&varAreaName=울릉/독도">울릉/독도</a>ㅣ
										<a href="weather_land.asp?varAreaCode=1B&varAreaName=전남">전남</a>ㅣ
										<a href="weather_land.asp?varAreaCode=1A&varAreaName=전북">전북</a>ㅣ
										<a href="weather_land.asp?varAreaCode=1F&varAreaName=경남">경남</a>ㅣ
										<a href="weather_land.asp?varAreaCode=1D&varAreaName=경북">경북</a>ㅣ
										<a href="weather_land.asp?varAreaCode=1C&varAreaName=제주">제주</a>ㅣ
                </td>
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
		  <!--충북 날씨 테이블 시작-->
            <table width="642" border="1" bordercolor="#dadada" cellspacing="0" cellpadding="7">
              <tr> 
                <td colspan="11" class="list07_bg4"><% =varAreaName %>(국지예보)</td>
              </tr>
              <tr class="list07_bg"> 
                <td rowspan="3">예보구역</td>
                <td colspan="4"><% =right(rs("sdate"),2) %></td><% rs.MOVENEXT %>
                <td colspan="4"><% =right(rs("sdate"),2) %></td><% rs.MOVENEXT %>
                <td colspan="2"><% =right(rs("sdate"),2) %></td><% rs.MOVEFIRST %>
              </tr>
              <tr class="list03_bg"> 
                <td rowspan="2">날씨</td>
                <td rowspan="2">예상기온(℃)</td>
                <td colspan="2">강수확률</td>
                <td rowspan="2">날씨</td>
                <td rowspan="2">예상기온(℃)</td>
                <td colspan="2">강수확률</td>
                <td rowspan="2">날씨</td>
                <td rowspan="2">예상기온(℃)</td>
              </tr>
              <tr class="list03_bg2"> 
                <td>낮</td>
                <td>밤</td>
                <td>낮</td>
                <td>밤</td>
              </tr>
               <% DO UNTIL rs.eof %>
              <tr> 
                <td class="list13_bg2"><% =rs("codedescript") %></td>
                <td class="table03"><img src="../../electric/images/new<% =FnWeatherIcon(rs("overview")) %>.gif" width="34" height="34" alt='<% =rs("overview") %>'></td>
                <td class="list14_1"><% =rs("tempmax") %></td>
                <td class="list14_1"><% =rs("probrainam") %>&nbsp;</td>
                <td class="list14_1"><% =rs("probrainpm") %>&nbsp;</td><% rs.MOVENEXT %>
                <td class="table03"><img src="../../electric/images/new<% =FnWeatherIcon(rs("overview")) %>.gif" width="34" height="34" alt='<% =rs("overview") %>'></td>
                <td class="list14_1"><% =rs("tempmin") %> / <% =rs("tempmax") %></td>
                <td class="list14_1"><% =rs("probrainam") %>&nbsp;</td>
                <td class="list14_1"><% =rs("probrainpm") %>&nbsp;</td><% rs.MOVENEXT %>
                <td class="table03"><img src="../../electric/images/new<% =FnWeatherIcon(rs("overview")) %>.gif" width="34" height="34" alt='<% =rs("overview") %>'></td>
                <td class="list14_1"><% =rs("tempmin") %> / <% =rs("tempmax") %></td><% rs.MOVENEXT %>
              </tr>
              <% LOOP %>  
              <table>
			<!--충북 날씨 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td height="30"></td>
        </tr>
      </table>
	  <!--큰 테이블 끝-->
    </td>
    <td width="49"><img src="../../electric/images/null.gif" width="49" height="1"></td>
    <td bgcolor="#a4a4a4"><img src="../../electric/images/outline.gif" width="1" height="1"></td>
  </tr>
  <tr> 
    <td height="42" colspan="3" align="right" background="../../electric/images/copyright_bg.gif"><img src="../../electric/images/copyright.gif" width="350" height="42"></td>
    <td bgcolor="#a4a4a4" width="1" height="42"><img src="../../electric/images/null.gif"></td>
  </tr>
</table>
</body>
</html>
<!-- #include file="../../electric/script/FnErrorCatch.inc"-->