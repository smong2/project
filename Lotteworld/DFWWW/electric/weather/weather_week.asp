<!-- #include file="../../electric/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' 프로그램ID : TXBWEATHERWEEK
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 날씨 표출 - 주간예보
' 최초작성일 : 2002/12/06
' 최종작성일 : 2002/12/06
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim rs,varAreaCode '지역코드
'레코드셋 (주간예보 리스트)
dim intI '증가변수

varAreaCode=Request.QueryString()

ArrQuery = array() '페이지에 맞는 코드 가져오고

'변수의 설정
Set objServer = Server.CreateObject("XBWeatherViewQMTS.clsXBWeatherViewQNTX")

'컴포넌트 호출
arrRValue = objServer.Query(ArrQuery)
'레코드셋 어레이를 단일 레코드셋으로 분리

'첫번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rs,3

'자원의 해제
Set objServer = Nothing

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
<!-- #include file="../../electric/script/FnWeather_week.vbs"-->
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
          <td height="24"><img src="../../electric/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
          <td align="left"><img src="../../electric/images/title_weather_week.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../electric/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--주간예보 전체 테이블 시작-->
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td>
				<!--주간예보 지역 테이블 시작-->
                  <table width="400" border="1" bordercolor="#dadada" cellspacing="0" cellpadding="7">
                    <tr> 
                      <td class="list07_bg4" colspan="6">주간예보 <% =FnWeather_Date_Title(rs(0)) %> 발표 </td>
                    </tr>
                    <tr> 
                      <td class="list03_bg">지역/날짜</td>
                      <% DO UNTIL rs.eof %>
                      <td class="list18_bg"><% =FnWeather_Week_Date(rs("sdate")) %></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>
                    </tr>
                    <tr> 
                      <td class="list13_bg2">서울/경기/강원영서</td>
                      <% DO UNTIL rs.EOF %>
                      <td class="table03"><img src="../../electric/images/new<% =FnWeatherIcon(rs("region1")) %>.gif" width="34" height="34" alt='<% =rs("region1") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>
                    </tr>
                    <tr> 
                      <td class="list13_bg2">강원영동</td>
                      <% DO UNTIL rs.EOF %>
                      <td class="table03"><img src="../../electric/images/new<% =FnWeatherIcon(rs("region2")) %>.gif" width="34" height="34" alt='<% =rs("region2") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>
                    </tr>
                    <tr> 
                      <td class="list13_bg2">충청남북</td>
                      <% DO UNTIL rs.EOF %>
                      <td class="table03"><img src="../../electric/images/new<% =FnWeatherIcon(rs("region3")) %>.gif" width="34" height="34" alt='<% =rs("region3") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>
                    </tr>
                    <tr> 
                      <td class="list13_bg2">전라남북</td>
                      <% DO UNTIL rs.EOF %>
                      <td class="table03"><img src="../../electric/images/new<% =FnWeatherIcon(rs("region4")) %>.gif" width="34" height="34" alt='<% =rs("region4") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>
                    </tr>
                    <tr> 
                      <td class="list13_bg2">경상남북</td>
                      <% DO UNTIL rs.EOF %>
                      <td class="table03"><img src="../../electric/images/new<% =FnWeatherIcon(rs("region5")) %>.gif" width="34" height="34" alt='<% =rs("region5") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>
                    </tr>
                    <tr> 
                      <td class="list13_bg2">제주도</td>
                      <% DO UNTIL rs.EOF %>
                      <td class="table03"><img src="../../electric/images/new<% =FnWeatherIcon(rs("region6")) %>.gif" width="34" height="34" alt='<% =rs("region6") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>
                    </tr>
                    <tr> 
                      <td class="list13_bg2">동해</td>
                      <% DO UNTIL rs.EOF %>
                      <td class="table03"><img src="../../electric/images/new<% =FnWeatherIcon(rs("eastsea")) %>.gif" width="34" height="34" alt='<% =rs("eastsea") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>
                    </tr>
                    <tr> 
                      <td class="list13_bg2">서해</td>
                      <% DO UNTIL rs.EOF %>
                      <td class="table03"><img src="../../electric/images/new<% =FnWeatherIcon(rs("westsea")) %>.gif" width="34" height="34" alt='<% =rs("westsea") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>
                    </tr>
                    <tr> 
                      <td class="list13_bg2">남해</td>
                      <% DO UNTIL rs.EOF %>
                      <td class="table03"><img src="../../electric/images/new<% =FnWeatherIcon(rs("southsea")) %>.gif" width="34" height="34" alt='<% =rs("southsea") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>
                    </tr>
                  </table>
				  <!--주간예보 지역 테이블 끝-->
                </td>
                <td width="10"></td>
                <td class="table08">
				<!--기상개황 테이블-->
                  <table width="193" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td height="20" valign="top">
					  <!--작은 타이틀 시작--> 
                        <table width="200" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="15" height="11" class="table03"><img src="../../electric/images/orange_buret.gif" width="7" height="7"></td>
                            <td class="title_01">기상개황</td>
                          </tr>
                        </table>
						<!--작은 타이틀 끝-->
                      </td>
                    </tr>
                    <tr> 
                      <td><img src="../../electric/images/point_line.gif" width="193" height="1"></td>
                    </tr>
                    <tr>
                      <td height="10"></td>
                    </tr>
                    <tr> 
                      <td class="list14"><% =rs("weatherforecast") %></td>
                    </tr>
                    <tr>
                      <td height="10"></td>
                    </tr>
                    <tr> 
                      <td><img src="../../electric/images/point_line.gif" width="193" height="1"></td>
                    </tr>
                  </table>
				  <!--기상개황 테이블-->
                </td>
              </tr>
            </table>
			<!--주간예보 전체 테이블 끝-->
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