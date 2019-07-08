<!-- #include file="../../electric/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' 프로그램ID : TXBWEATHEROVERVIEW
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 날씨 표출 - 기상개황
' 최초작성일 : 2002/11/28
' 최종작성일 : 2002/11/28
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim rs '레코드셋 (날씨 개황)
dim intI '증가변수

ArrQuery = array() '페이지에 맞는 코드 가져오고

'변수의 설정
Set objServer = Server.CreateObject("XBWeatherViewQMTS.clsXBWeatherViewQNTX")

'컴포넌트 호출
arrRValue = objServer.Query(ArrQuery)
'레코드셋 어레이를 단일 레코드셋으로 분리

'첫번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rs,1

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
          <td align="left"><img src="../../electric/images/title_weather_outlook.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../electric/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td class="table08">
		  <!--오늘 기상개황 시작--> 
            <table width="628" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="20" valign="top">
				<!--작은 타이틀 시작--> 
                  <table width="312" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="15" height="11" class="table03"><img src="../../electric/images/vermilion_buret.gif" width="7" height="7"></td>
                      <td class="title_01_0">오늘(<% =right(rs("sdate"),2) %>일)</td>
                    </tr>
                  </table>
				  <!--작은 타이틀 끝-->
                </td>
              </tr>
              <tr> 
                <td><img src="../../electric/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td height="10"></td>
              </tr>
              <tr> 
                <td class="list14"><u>기압계동향</u> : <% =rs("airtendency") %> <br>
                <u>육상종합</u> :<% =rs("landoverview") %> <Br>
                <u>해상종합</u> :<% =rs("seaoverview") %> <br>
                <u>강수량</u> :<%=rs("rainsnowamt") %><% rs.MOVENEXT %> </td>
              </tr>
              <tr> 
                <td height="10"></td>
              </tr>
              <tr> 
                <td><img src="../../electric/images/point_line3.gif" width="628" height="1"></td>
              </tr>
            </table>
			<!--오늘 기상개황 끝-->
          </td>
        </tr>
        <tr>
          <td height="40"></td>
        </tr>
        <tr> 
          <td class="table08">
		  <!--내일 기상개황 시작-->
            <table width="628" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="20" valign="top">
				<!--작은 타이틀 시작--> 
                  <table width="312" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="15" height="11" class="table03"><img src="../../electric/images/yellowgreen_buret.gif" width="7" height="7"></td>
                      <td class="title_01_0">내일(<% =right(rs("sdate"),2)%>일)</td>
                    </tr>
                  </table>
				  <!--작은 타이틀 끝-->
                </td>
              </tr>
              <tr> 
                <td><img src="../../electric/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td height="10"></td>
              </tr>
              <tr> 
                <td class="list14"><u>기압계동향</u> : <% =rs("airtendency") %> <br>
                <u>육상종합</u> :<% =rs("landoverview") %> <Br>
                <u>해상종합</u> :<% =rs("seaoverview") %> <br>
                <u>강수량</u> :<%=rs("rainsnowamt") %></td>
              </tr>
              <tr> 
                <td height="10"></td>
              </tr>
              <tr> 
                <td><img src="../../electric/images/point_line3.gif" width="628" height="1"></td>
              </tr>
            </table>
			<!--내일 기상개황 끝-->
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
  <!-- #include file="../../electric/script/FnErrorCatch.inc" -->