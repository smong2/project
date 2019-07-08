<!-- #include file="../../electric/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' 프로그램ID : TXBWEATHERMAIN TODAY
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 날씨 표출 - 날씨 메인 - today
' 최초작성일 : 2002/12/04
' 최종작성일 : 2002/12/04
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim varAreaCode, IntDateNum '날짜 코드
Dim rsoverview, rsland,rssea,rsjisu,rspoint 
'레코드셋 (날씨개황, 육상예보, 해상예보, 날씨지수, 포인트예보-현재시각 예보일기)
dim intI '증가변수

intDateNum=Request.QueryString("intDateNum")

ArrQuery = array("0") '페이지에 맞는 코드 가져오고

'변수의 설정
Set objServer = Server.CreateObject("XBWeatherMainQMTS.clsXBWeatherMainQNTX")

'컴포넌트 호출
arrRValue = objServer.Query(ArrQuery)
'레코드셋 어레이를 단일 레코드셋으로 분리

'첫번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rsoverview,1
'세번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rsland,2
'네번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rsjisu,3
'다섯번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rspoint,4

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
<!-- #include file="../../electric/script/fnWeather_Main_Code.inc"-->
<!-- #include file="../../electric/script/fnWeather_Icon.inc"-->
<html>
<head>
<title>날씨정보 오늘</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<script language="JavaScript" src="../../electric/script/FnRolloverReload.js"></script>
<link rel="stylesheet" href="../../electric/css/cs_te.css" type="text/css">
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../../electric/images/map_tomorrow_on.gif','../../electric/images/map_after_tomorrow_on.gif')">

<!--서울/경기 날씨 레이어 시작-->
<div id="div서울/경기" style="position:absolute; left:144px; top:137px; width:34px; height:44px; z-index:1"> 
  <table width="34" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td bgcolor="#b4b4b4">
        <table width="34" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="weather_land.asp?varAreaCode=14&varAreaName=서울/경기"><img src="../../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif" width="34" height="34" border="0" alt='<%=rsland("overview") %>'></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmax") %><% rsland.MOVENEXT %></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--서울/경기 날씨 레이어 끝-->

<!--영서 날씨 레이어 시작-->
<div id="div영서" style="position:absolute; left:187px; top:105px; width:34px; height:44px; z-index:1"> 
  <table width="34" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td bgcolor="#b4b4b4">
        <table width="34" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="weather_land.asp?varAreaCode=15&varAreaName=영서"><img src="../../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif" width="34" height="34" border="0" alt='<%=rsland("overview") %>'></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmax") %><% rsland.MOVENEXT %></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--영서 날씨 레이어 끝-->

<!--영동 날씨 레이어 시작-->
<div id="div영동" style="position:absolute; left:234px; top:127px; width:34px; height:44px; z-index:1"> 
  <table width="34" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td bgcolor="#b4b4b4">
        <table width="34" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="weather_land.asp?varAreaCode=16&varAreaName=영동"><img src="../../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif" width="34" height="34" border="0" alt='<%=rsland("overview") %>'></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmax") %><% rsland.MOVENEXT %></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--영동 날씨 레이어 끝-->

<!--울릉도 날씨 레이어 시작-->
<div id="div울릉도" style="position:absolute; left:284px; top:148px; width:34px; height:44px; z-index:1"> 
  <table width="34" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td bgcolor="#b4b4b4">
        <table width="34" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="weather_land.asp?varAreaCode=17&varAreaName=울릉/독도"><img src="../../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif" width="34" height="34" border="0" alt='<%=rsland("overview") %>'></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmax") %><% rsland.MOVENEXT %></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--울릉도 날씨 레이어 끝-->

<!--충북 날씨 레이어 시작-->
<div id="div충북" style="position:absolute; left:186px; top:182px; width:34px; height:44px; z-index:1"> 
  <table width="34" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td bgcolor="#b4b4b4">
        <table width="34" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="weather_land.asp?varAreaCode=18&varAreaName=충북"><img src="../../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif" width="34" height="34" border="0" alt='<%=rsland("overview") %>'></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmax") %><% rsland.MOVENEXT %></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--충북 날씨 레이어 끝-->

<!--충남 날씨 레이어 시작-->
<div id="div충남" style="position:absolute; left:120px; top:207px; width:34px; height:44px; z-index:1"> 
  <table width="34" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td bgcolor="#b4b4b4">
        <table width="34" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="weather_land.asp?varAreaCode=19&varAreaName=충남"><img src="../../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif" width="34" height="34" border="0" alt='<%=rsland("overview") %>'></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmax") %><% rsland.MOVENEXT %></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--충남 날씨 레이어 끝-->

<!--전북 날씨 레이어 시작-->
<div id="div전북" style="position:absolute; left:160px; top:248px; width:34px; height:44px; z-index:1"> 
  <table width="34" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td bgcolor="#b4b4b4">
        <table width="34" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="weather_land.asp?varAreaCode=1A&varAreaName=전북"><img src="../../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif" width="34" height="34" border="0" alt='<%=rsland("overview") %>'></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmax") %><% rsland.MOVENEXT %></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--전북 날씨 레이어 끝-->

<!--전남 날씨 레이어 시작-->
<div id="div전남" style="position:absolute; left:119px; top:290px; width:34px; height:44px; z-index:1"> 
  <table width="34" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td bgcolor="#b4b4b4">
        <table width="34" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="weather_land.asp?varAreaCode=1B&varAreaName=전남"><img src="../../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif" width="34" height="34" border="0" alt='<%=rsland("overview") %>'></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmax") %><% rsland.MOVENEXT %></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--전남 날씨 레이어 끝-->

<!--제주도 날씨 레이어 시작-->
<div id="div제주도" style="position:absolute; left:154px; top:343px; width:34px; height:44px; z-index:1"> 
  <table width="34" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td bgcolor="#b4b4b4">
        <table width="34" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="weather_land.asp?varAreaCode=1C&varAreaName=제주"><img src="../../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif" width="34" height="34" border="0" alt='<%=rsland("overview") %>'></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmax") %><% rsland.MOVENEXT %></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--제주도 날씨 레이어 끝-->

<!--경북 날씨 레이어 시작-->
<div id="div경북" style="position:absolute; left:234px; top:210px; width:34px; height:44px; z-index:1"> 
  <table width="34" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td bgcolor="#b4b4b4">
        <table width="34" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="weather_land.asp?varAreaCode=1D&varAreaName=경북"><img src="../../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif" width="34" height="34" border="0" alt='<%=rsland("overview") %>'></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmax") %><% rsland.MOVENEXT %></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--경북 날씨 레이어 끝-->

<!--경남 날씨 레이어 시작-->
<div id="div경남" style="position:absolute; left:220px; top:280px; width:34px; height:44px; z-index:1"> 
  <table width="34" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td bgcolor="#b4b4b4">
        <table width="34" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="weather_land.asp?varAreaCode=1F&varAreaName=경남"><img src="../../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif" width="34" height="34" border="0" alt='<%=rsland("overview") %>'></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmax") %></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--경남 날씨 레이어 끝-->

<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
  <tr> 
    <td width="49"><img src="../../electric/images/null.gif" width="49" height="1"></td>
    <td valign="top">
	<!--큰 테이블 시작--> 
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td colspan="3"><img src="../../electric/images/null.gif" width="1" height="25"></td>
        </tr>
        <tr> 
          <td><img src="../../electric/images/title_weatherinfo.gif" width="290" height="21"></td>
          <td rowspan="12" width="41"></td>
          <td height="21"></td>
        </tr>
        <tr>
          <td rowspan="11"> 
            <!--오늘의 날씨/내일의 날씨/모레의 날씨 전체테이블 시작-->
            <table width="290" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="29"> 
                  <!--오늘의 날씨/내일의 날씨/모레의 날씨 탭 시작-->
                  <table width="290" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td colspan="3" height="6"></td>
                    </tr>
                    <tr> 
                      <td><img src="../../electric/images/map_today_on.gif" width="96" height="23" alt=<% =rsoverview("sdate") %>></td>
                      <td><a href="weather_main_tomorrow.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image127','','../../electric/images/map_tomorrow_on.gif',1)"><img name="Image127" border="0" src="../../electric/images/map_tomorrow.gif" width="98" height="23"></a></td>
                      <td><a href="weather_main_afterto.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image128','','../../electric/images/map_after_tomorrow_on.gif',1)"><img name="Image128" border="0" src="../../electric/images/map_after_tomorrow.gif" width="96" height="23"></a></td>
                    </tr>
                  </table>
                  <!--오늘의 날씨/내일의 날씨/모레의 날씨 탭 끝-->
                </td>
              </tr>
              <tr> 
                <td><img src="../../electric/images/today_national_map.gif" width="290" height="322"></td>
              </tr>
            </table>
            <!--오늘의 날씨/내일의 날씨/모레의 날씨 전체테이블 끝-->
          </td>
          <td height="6"></td>
        </tr>
        <tr>
          <td height="26" background="../../electric/images/temperature_bg.gif" class="list17_1">서울 
            <% =hour(time()) %>시 &nbsp; <% =rspoint(hour(time())+25) %>℃  &nbsp; <% =FnWeatherCode(rspoint(hour(time()))) %></td>
        </tr>
        <tr> 
          <td height="10"></td>
        </tr>
        <tr> 
          <td height="15" valign="top"> 
            <!--기상개황 타이틀 시작-->
            <table width="312" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="15" height="11" class="table03"><img src="../../electric/images/yellowgreen_buret.gif" width="7" height="7"></td>
                <td class="title_01">기상개황</td>
              </tr>
            </table>
            <!--기상개황 타이틀 끝-->
          </td>
        </tr>
        <tr> 
          <td><img src="../../electric/images/point_line8.gif" width="312" height="1"></td>
        </tr>
        <tr> 
          <td class="list14" height="123"><% =rsoverview("landoverview") %></td>
        </tr>
        <tr> 
          <td><img src="../../electric/images/point_line8.gif" width="312" height="1"></td>
        </tr>
        <tr> 
          <td height="10"></td>
        </tr>
        <tr> 
          <td height="15" valign="top"> 
            <!--생활기상정보 타이틀 시작-->
            <table width="312" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="15" height="11" class="table03"><img src="../../electric/images/yellowgreen_buret.gif" width="7" height="7"></td>
                <td class="title_01">생활기상정보</td>
              </tr>
            </table>
            <!--생활기상정보 타이틀 끝-->
          </td>
        </tr>
        <tr> 
          <td bgcolor="#E6E6E6"> 
            <!--생활기상정보 테이블 시작-->
            <table width="312" border="0" cellspacing="6" cellpadding="0" height="144">
              <tr> 
                <td bgcolor="#FFFFFF"> 
                  <!--나들이지수 테이블 시작-->
                  <table width="147" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="40"><img src="../../electric/images/newjisu01_s.gif" width="40" height="40"></td>
                      <td align="center"> 
                        <!--나들이지수 시작-->
                        <table width="80" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td class="list14_1">나들이지수</td>
                            <td class="list16"><% =rsjisu("picnicjisu")%></td>
                          </tr>
                        </table>
                        <!--나들이지수 끝-->
                      </td>
                    </tr>
                  </table>
                  <!--나들이지수 테이블 끝-->
                </td>
                <td bgcolor="#FFFFFF"> 
                  <!--불조심지수 테이블 시작-->
                  <table width="147" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="40"><img src="../../electric/images/newjisu05_s.gif" width="40" height="40"></td>
                      <td align="center"> 
                        <!--불조심지수 시작-->
                        <table width="80" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td class="list14_1">불조심지수</td>
                            <td class="list16"><% =rsjisu("firejisu")%></td>
                          </tr>
                        </table>
                        <!--불조심지수 끝-->
                      </td>
                    </tr>
                  </table>
                  <!--불조심지수 테이블 끝-->
                </td>
              </tr>
              <tr> 
                <td bgcolor="#FFFFFF"> 
                  <!--빨래지수 테이블 시작-->
                  <table width="147" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="40"><img src="../../electric/images/newjisu02_s.gif" width="40" height="40"></td>
                      <td align="center"> 
                        <!--빨래지수 시작-->
                        <table width="80" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td class="list14_1">빨래지수</td>
                            <td class="list16"><% =rsjisu("clothwashjisu")%></td>
                          </tr>
                        </table>
                        <!--빨래지수 끝-->
                      </td>
                    </tr>
                  </table>
                  <!--빨래지수 테이블 끝-->
                </td>
                <td bgcolor="#FFFFFF"> 
                  <!--난방지수 테이블 시작-->
                  <table width="147" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="40"><img src="../../electric/images/newjisu10_s.gif" width="40" height="40"></td>
                      <td align="center"> 
                        <!--난방지수 시작-->
                        <table width="80" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td class="list14_1">난방지수</td>
                            <td class="list16"><% =rsjisu("hotcooljisu")%></td>
                          </tr>
                        </table>
                        <!--난방지수 끝-->
                      </td>
                    </tr>
                  </table>
                  <!--난방지수 테이블 끝-->
                </td>
              </tr>
              <tr> 
                <td bgcolor="#FFFFFF"> 
                  <!--세차지수 테이블 시작-->
                  <table width="147" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="40"><img src="../../electric/images/newjisu03_s.gif" width="40" height="40"></td>
                      <td align="center"> 
                        <!--세차지수 시작-->
                        <table width="80" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td class="list14_1">세차지수</td>
                            <td class="list16"><% =rsjisu("carwashjisu")%></td>
                          </tr>
                        </table>
                        <!--세차지수 끝-->
                      </td>
                    </tr>
                  </table>
                  <!--세차지수 테이블 끝-->
                </td>
                <td bgcolor="#FFFFFF"> 
                  <!--운동지수 테이블 시작-->
                  <table width="147" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="40"><img src="../../electric/images/newjisu06_s.gif" width="40" height="40"></td>
                      <td align="center"> 
                        <!--운동지수 시작-->
                        <table width="80" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td class="list14_1">운동지수</td>
                            <td class="list16"><% =rsjisu("playjisu")%></td>
                          </tr>
                        </table>
                        <!--운동지수끝-->
                      </td>
                    </tr>
                  </table>
                  <!--운동지수 테이블 끝-->
                </td>
              </tr>
            </table>
            <!--생활기상정보 테이블 끝-->
          </td>
        </tr>
        <tr> </tr>
        <tr> 
          <td colspan="3" height="30"></td>
        </tr>
      </table>
	  <!--큰 테이블 끝-->
    </td>
    <td width="49"><img src="../../electric/images/null.gif" width="49" height="1"></td>
    <td bgcolor="#a4a4a4"><img src="../../electric/images/outline.gif" width="1" height="1"></td>
  </tr>
  <tr> 
    <td height="42" colspan="3" background="../../electric/images/copyright_bg.gif" align="right"><img src="../../electric/images/copyright.gif" width="350" height="42"></td>
    <td bgcolor="#a4a4a4" width="1" height="42"><img src="../../electric/images/null.gif"></td>
  </tr>
</table>
</body>
</html>
