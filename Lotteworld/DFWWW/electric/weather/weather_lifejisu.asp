<!-- #include file="../../electric/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' 프로그램ID : TXBWEATHERJISU
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 날씨 표출 - 지수
' 최초작성일 : 2002/12/06
' 최종작성일 : 2002/12/06
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim rs,rsjisu, varAreaCode '지역코드
'레코드셋 (날씨지역목록,날씨지수)
dim intI '증가변수

varAreaCode=Request.QueryString("varAreaCode")

ArrQuery = array(varAreaCode) '페이지에 맞는 코드 가져오고

'변수의 설정
Set objServer = Server.CreateObject("XBWeatherViewQMTS.clsXBWeatherViewQNTX")

'컴포넌트 호출
arrRValue = objServer.Query(ArrQuery)
'레코드셋 어레이를 단일 레코드셋으로 분리

'첫번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rs,4
'두번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rsjisu,5

'자원의 해제
Set objServer = Nothing

'IF rs.eof=rs.bof or rsjisu.eof=rsjisu.bof then  '레코드가 없을 경우 중단한다.
'Response.Write "<script language=javascript>alert('해당 자료가 없습니다')</script>"
'Response.End 
'END IF
IF varAreaCode="" THEN varAreaCode="서울경기"

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
          <td><img src="../../electric/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
          <td align="left"><img src="../../electric/images/title_weather_life.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../electric/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td> 
            <!--생활기상정보 지역 테이블 시작-->
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="15" height="11" class="table03"><img src="../../electric/images/orange_buret.gif" width="7" height="7"></td>
                <td class="title_01">ㅣ
                <% DO UNTIL rs.EOF %>
                <a href="weather_lifejisu.asp?varAreaCode=<% =rs("areaname") %>"><% =rs("areaname") %></a>ㅣ
                <% rs.MOVENEXT : LOOP %></td>
              </tr>
            </table>
            <!--생활기상정보 지역 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td height="20"></td>
        </tr>
        <tr> 
          <td height="30" class="list13_bg"><% =varAreaCode %> 지역 생활기상정보</td>
        </tr>
        <tr> 
          <td height="20"></td>
        </tr>
        <tr> 
          <td>
		  <!--생활기상정보 테이블 시작--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td>
				<!--나들이지수 테이블 시작--> 
                  <table width="300" border="1" bordercolor="#dadada" cellspacing="0" cellpadding="5">
                    <tr> 
                      <td rowspan="2" class="table04" width="80"><img src="../../electric/images/newjisu01.gif" width="80" height="80"></td>
                      <td class="table03" height="50">
					  <!--나들이지수 시작--> 
                        <table width="90" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td class="list15_1">나들이지수</td>
                            <td class="list16"><% =rsjisu("picnicjisu") %></td>
                          </tr>
                        </table>
						<!--나들이지수 끝-->
                      </td>
                    </tr>
                    <tr> 
                      <td class="list14_bg2"><% =rsjisu("picnicindex") %></td>
                    </tr>
                  </table>
				  <!--나들이지수 테이블 끝-->
                </td>
                <td width="42"></td>
                <td>
				<!--불조심지수 테이블 시작--> 
                  <table width="300" border="1" bordercolor="#dadada" cellspacing="0" cellpadding="5">
                    <tr> 
                      <td rowspan="2" class="table04" width="80"><img src="../../electric/images/newjisu05.gif" width="80" height="80"></td>
                      <td class="table03" height="50">
					  <!--불조심지수 시작--> 
                        <table width="90" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td class="list15_1">불조심지수</td>
                            <td class="list16"><% =rsjisu("firejisu") %></td>
                          </tr>
                        </table>
						<!--불조심지수 끝-->
                      </td>
                    </tr>
                    <tr> 
                      <td class="list14_bg2"><% =rsjisu("fireindex") %></td>
                    </tr>
                  </table>
				  <!--불조심지수 테이블 끝-->
                </td>
              </tr>
              <tr> 
                <td height="10"></td>
                <td></td>
                <td></td>
              </tr>
              <tr> 
                <td>
				<!--빨래지수 테이블 시작--> 
                  <table width="300" border="1" bordercolor="#dadada" cellspacing="0" cellpadding="5">
                    <tr> 
                      <td rowspan="2" class="table04" width="80"><img src="../../electric/images/newjisu02.gif" width="80" height="80"></td>
                      <td class="table03" height="50">
					  <!--빨래지수 시작--> 
                        <table width="90" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td class="list15_1">빨래지수</td>
                            <td class="list16"><% =rsjisu("clothwashjisu")%></td>
                          </tr>
                        </table>
						<!--빨래지수 끝-->
                      </td>
                    </tr>
                    <tr> 
                      <td class="list14_bg2"><% =rsjisu("clothwashindex") %></td>
                    </tr>
                  </table>
				  <!--빨래지수 테이블 끝-->
                </td>
                <td></td>
                <td>
				<!--난방지수 테이블 시작--> 
                  <table width="300" border="1" bordercolor="#dadada" cellspacing="0" cellpadding="5">
                    <tr> 
                      <td rowspan="2" class="table04" width="80"><img src="../../electric/images/newjisu10.gif" width="80" height="80"></td>
                      <td class="table03" height="50">
					  <!--난방지수 시작--> 
                        <table width="90" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td class="list15_1">난방지수</td>
                            <td class="list16"><% =rsjisu("hotcooljisu") %></td>
                          </tr>
                        </table>
						<!--난방지수 끝-->
                      </td>
                    </tr>
                    <tr> 
                      <td class="list14_bg2"><% =rsjisu("hotcoolindex") %></td>
                    </tr>
                  </table>
				  <!--난방지수 테이블 끝-->
                </td>
              </tr>
              <tr> 
                <td height="10"></td>
                <td></td>
                <td></td>
              </tr>
              <tr> 
                <td>
				<!--세차지수 테이블 시작--> 
                  <table width="300" border="1" bordercolor="#dadada" cellspacing="0" cellpadding="5">
                    <tr> 
                      <td rowspan="2" class="table04" width="80"><img src="../../electric/images/newjisu03.gif" width="80" height="80"></td>
                      <td class="table03" height="50">
					  <!--세차지수 시작--> 
                        <table width="90" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td class="list15_1">세차지수</td>
                            <td class="list16"><% =rsjisu("carwashjisu") %></td>
                          </tr>
                        </table>
						<!--세차지수 끝-->
                      </td>
                    </tr>
                    <tr> 
                      <td class="list14_bg2"><% =rsjisu("carwashindex") %></td>
                    </tr>
                  </table>
				  <!--세차지수 테이블 끝-->
                </td>
                <td></td>
                <td>
				<!--운동지수 테이블 시작--> 
                  <table width="300" border="1" bordercolor="#dadada" cellspacing="0" cellpadding="5">
                    <tr> 
                      <td rowspan="2" class="table04" width="80"><img src="../../electric/images/newjisu06.gif" width="80" height="80"></td>
                      <td class="table03" height="50">
					  <!--운동지수 시작--> 
                        <table width="90" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td class="list15_1">운동지수</td>
                            <td class="list16"><% =rsjisu("playjisu") %></td>
                          </tr>
                        </table>
						<!--운동지수 끝-->
                      </td>
                    </tr>
                    <tr> 
                      <td class="list14_bg2"><% =rsjisu("playindex") %></td>
                    </tr>
                  </table>
				  <!--운동지수 테이블 끝-->
                </td>
              </tr>
            </table>
			<!--생활기상정보 테이블 끝-->
          </td>
        </tr>
        <tr>
          <td height="20"></td>
        </tr>
        <tr> 
          <td height="10" bgcolor="#F1F1FC"></td>
        </tr>
        <tr> 
          <td><img src="../../electric/images/point_line7.gif" width="642" height="1"></td>
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
