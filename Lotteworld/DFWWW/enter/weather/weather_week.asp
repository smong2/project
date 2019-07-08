<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' 프로그램ID : TXBWEATHERJISU
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 날씨 표출 - 주간예보
' 최초작성일 : 2002/12/04
' 최종작성일 : 2002/12/04
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim rs,varAreaCode '레코드셋 : 주간예보, 지역코드
Dim intI '증가변수

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
<!-- #include file="../../enter/script/FnProgramProcess.vbs" -->
<!-- #include file="../../enter/script/FnWeather_Icon.inc"-->
<!-- #include file="../../enter/script/FnWeather_week.vbs"-->
<html>
<head>
<title>롯데월드 수요예측시스템</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../../enter/css/cs_tx.css" type="text/css">
</head>

<body bgcolor="#f5f5f5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#ffffff">
  <tr> 
    <td width="49"><IMG height=1 src="../../enter/images/null.gif" width=49></td>
    <td width="642" valign="top"><!-- 큰 테이블 시작-->
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="24"><IMG height=24 src="../../enter/images/null.gif" width=1></td>
        </tr>
        <tr> 
          <td align="left"><IMG height=21 src="../../enter/images/title_weather_week.gif" width=200></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><IMG height=5 src="../../enter/images/title_bar.gif" width=642></td>
        </tr>
        <tr> 
          <td><!--주간예보 전체 테이블 시작-->
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td><!--주간예보 지역 테이블 시작-->
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
                      <td class="table03"><img src="../../enter/images/new<% =FnWeatherIcon(rs("region1")) %>.gif" width="34" height="34" alt='<% =rs("region1") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %></td>
                    </tr>
                    <tr> 
                      <td class="list13_bg2">강원영동</td>
                      <% DO UNTIL rs.EOF %>
                      <td class="table03"><img src="../../enter/images/new<% =FnWeatherIcon(rs("region2")) %>.gif" width="34" height="34" alt='<% =rs("region2") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>                      
                    </tr>
                    <tr> 
                      <td class="list13_bg2">충청남북</td>
                      <% DO UNTIL rs.EOF %>
                      <td class="table03"><img src="../../enter/images/new<% =FnWeatherIcon(rs("region3")) %>.gif" width="34" height="34" alt='<% =rs("region3") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>
                    </tr>
                    <tr> 
                      <td class="list13_bg2">전라남북</td>
                      <% DO UNTIL rs.EOF %>
                      <td class="table03"><img src="../../enter/images/new<% =FnWeatherIcon(rs("region4")) %>.gif" width="34" height="34" alt='<% =rs("region4") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>
                    </tr>
                    <tr> 
                      <td class="list13_bg2">경상남북</td>
                      <% DO UNTIL rs.EOF %>
                      <td class="table03"><img src="../../enter/images/new<% =FnWeatherIcon(rs("region5")) %>.gif" width="34" height="34" alt='<% =rs("region5") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>                      
                    </tr>
                    <tr> 
                      <td class="list13_bg2">제주도</td>
                      <% DO UNTIL rs.EOF %>
                      <td class="table03"><img src="../../enter/images/new<% =FnWeatherIcon(rs("region6")) %>.gif" width="34" height="34" alt='<% =rs("region6") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>                      
                    </tr>
                    <tr> 
                      <td class="list13_bg2">동해</td>
                      <% DO UNTIL rs.EOF %>
                      <td class="table03"><img src="../../enter/images/new<% =FnWeatherIcon(rs("eastsea")) %>.gif" width="34" height="34" alt='<% =rs("eastsea") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>
                    </tr>
                    <tr> 
                      <td class="list13_bg2">서해</td>
                      <% DO UNTIL rs.EOF %>
                      <td class="table03"><img src="../../enter/images/new<% =FnWeatherIcon(rs("westsea")) %>.gif" width="34" height="34" alt='<% =rs("westsea") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>
                    </tr>
                    <tr> 
                      <td class="list13_bg2">남해</td>
                      <% DO UNTIL rs.EOF %>
                      <td class="table03"><img src="../../enter/images/new<% =FnWeatherIcon(rs("southsea")) %>.gif" width="34" height="34" alt='<% =rs("southsea") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>
                    </tr>
                  </table><!--주간예보 지역 테이블 끝-->
                </td>
                <td width="10"></td>
                <td class="table08"><!--기상개황 테이블-->
                  <table width="193" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td height="20" valign="top"><!--작은 타이틀 시작--> 
                        <table width="200" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="15" height="11" class="table03"><IMG height=7 src="../../enter/images/orange_buret.gif" width=7></td>
                            <td class="title_01">기상개황</td>
                          </tr>
                        </table><!--작은 타이틀 끝-->
                      </td>
                    </tr>
                    <tr> 
                      <td><IMG height=1 src="../../enter/images/point_line.gif" width=193></td>
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
                      <td><IMG height=1 src="../../enter/images/point_line.gif" width=193></td>
                    </tr>
                  </table><!--기상개황 테이블-->
                </td>
              </tr>
            </table><!--주간예보 전체 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td height="30"></td>
        </tr>
      </table><!--큰 테이블 끝-->
    </td>
    <td width="49"><IMG height=1 src="../../enter/images/null.gif" width=49></td>
    <td bgcolor="#a4a4a4"><IMG height=1 src="../../enter/images/outline.gif" width=1></td>
  </tr>
  <tr> 
    <td height="42" colspan="3" align="right" background="../../enter/images/copyright_bg.gif"><IMG height=42 src="../../enter/images/copyright.gif" width=350></td>
    <td bgcolor="#a4a4a4" width="1" height="42"><img src="../../enter/images/null.gif"></td>
  </tr>
</table>
</body>
</html>
<!-- #include file="../../enter/script/FnErrorCatch.inc"-->