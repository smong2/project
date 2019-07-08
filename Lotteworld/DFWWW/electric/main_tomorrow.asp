<!-- #include file="../electric/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' 프로그램ID : MAIN tomorrow
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 전기 예측 메인 페이지 - 내일
' 최초작성일 : 2002/11/27
' 최종작성일 : 2002/11/27
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim rs, rslast, rslastsum, rslastweek, rslastweeksum, rsland,rsoverview, rspoint'레코드셋 (전년동일,전년동일합계,전년동요일,전년동요일합계,육상예보,기상개황)
dim intI '증가변수

%>
<!-- #include file="../electric/script/FnSearch_Date.inc"-->
<%
ArrQuery = array("tomorrow",dtLastDay,dtLastWeekDay) '쿼리 변수

'변수의 설정
Set objServer = Server.CreateObject("XEElectMainQMTS.clsXEElectMainQNTX")

'컴포넌트 호출
arrRValue = objServer.Query(ArrQuery)
'레코드셋 어레이를 단일 레코드셋으로 분리

'첫번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rs,1
'두번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rslast,2
'세번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rslastweek,3
'네번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rsland,4
'다섯번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rsoverview,5
'여섯번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rspoint,6

'자원의 해제
Set objServer = Nothing

'에러의 처리
IF Err.Number <> 0 THEN 
	Response.Write Err.Number, Err.Source, Err.Description
	Set objServer = Nothing
	objserver.close
END IF
%>
<!-- #include file="../electric/script/FnProgramProcess.vbs" -->
<!-- #include file="../electric/script/fnnumber_format.inc"-->
<!-- #include file="../electric/script/FnWeather_Icon.inc"-->
<!-- #include file="../electric/script/fnWeather_Main_Code.inc"-->
<html>
<head>
<title>내일의날씨_main</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<script language="JavaScript" src=../electric/script/FnRolloverReload.js></script>
<link rel="stylesheet" href="../electric/css/cs_te.css" type="text/css">
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../electric/images/map_today_on.gif','../electric/images/map_after_tomorrow_on.gif')">

<!--서울 레이어 시작-->
<div id="서울" style="position:absolute; left:123px; top:218px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../electric/weather/weather_land.asp"><img src="../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../electric/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--서울 레이어 끝-->
<!--강화 레이어 시작-->
<div id="강화" style="position:absolute; left:95px; top:284px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../electric/weather/weather_land.asp"><img src="../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../electric/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--강화 레이어 끝-->
<!--동두천 레이어 시작-->
<div id="동두천" style="position:absolute; left:95px; top:154px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../electric/weather/weather_land.asp"><img src="../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../electric/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--동두천 레이어 끝-->
<!--양평 레이어 시작-->
<div id="양평" style="position:absolute; left:168px; top:199px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../electric/weather/weather_land.asp"><img src="../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../electric/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--양평 레이어 끝-->
<!--인천 레이어 시작-->
<div id="인천" style="position:absolute; left:60px; top:220px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../electric/weather/weather_land.asp"><img src="../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../electric/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--인천 레이어 끝-->
<!--수원 레이어 시작-->
<div id="수원" style="position:absolute; left:140px; top:289px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../electric/weather/weather_land.asp"><img src="../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../electric/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--수원 레이어 끝-->
<!--이천 레이어 시작-->
<div id="이천" style="position:absolute; left:185px; top:264px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../electric/weather/weather_land.asp"><img src="../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../electric/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--이천 레이어 끝-->
<!--철원 레이어 시작-->
<div id="철원" style="position:absolute; left:160px; top:126px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../electric/weather/weather_land.asp?varAreaCode=15&varAreaName=영서"><img src="../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../electric/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--철원 레이어 끝-->
<!--춘천 레이어 시작-->
<div id="춘천" style="position:absolute; left:211px; top:158px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../electric/weather/weather_land.asp?varAreaCode=15&varAreaName=영서"><img src="../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../electric/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--춘천 레이어 끝-->
<!--홍천 레이어 시작-->
<div id="홍천" style="position:absolute; left:254px; top:172px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../electric/weather/weather_land.asp?varAreaCode=15&varAreaName=영서"><img src="../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../electric/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--홍천 레이어 끝-->
<!--원주 레이어 시작-->
<div id="원주" style="position:absolute; left:230px; top:237px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../electric/weather/weather_land.asp?varAreaCode=15&varAreaName=영서"><img src="../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../electric/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--원주 레이어 끝-->

<!--영월 레이어 시작-->
<div id="영월" style="position:absolute; left:288px; top:232px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../electric/weather/weather_land.asp?varAreaCode=15&varAreaName=영서"><img src="../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../electric/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--영월 레이어 끝-->
<!--충주 레이어 시작-->
<div id="충주" style="position:absolute; left:228px; top:303px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../electric/weather/weather_land.asp?varAreaCode=18&varAreaName=충북"><img src="../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../electric/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--충주 레이어 끝-->
<!--제천 레이어 시작-->
<div id="제천" style="position:absolute; left:272px; top:304px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../electric/weather/weather_land.asp?varAreaCode=18&varAreaName=충북"><img src="../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../electric/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--제천 레이어 끝-->
<!--청주 레이어 시작-->
<div id="청주" style="position:absolute; left:184px; top:334px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../electric/weather/weather_land.asp?varAreaCode=18&varAreaName=충북"><img src="../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../electric/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--청주 레이어 끝-->
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
  <tr> 
    <td width="49"><img src="../electric/images/null.gif" width="49" height="1"></td>
    <td valign="top"> 
	<!--큰 테이블 시작-->
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td colspan="3"><img src="../electric/images/null.gif" width="1" height="25"></td>
        </tr>
        <tr> 
          <td><img src="../electric/images/title_weatherinfo.gif" width="290" height="21"></td>
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
                      <td colspan="3"><img src="../electric/images/null.gif" width="1" height="6"></td>
                    </tr>
                    <tr> 
                      <td><a href="main_today.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image143','','../electric/images/map_today_on.gif',1)"><img name="Image143" border="0" src="../electric/images/map_today.gif" width="96" height="23"></a></td>
                      <td><img src="../electric/images/map_tomorrow_on.gif" width="98" height="23"></td>
                      <td><a href="main_afterto.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1281','','../electric/images/map_after_tomorrow_on.gif',1)"><img name="Image1281" border="0" src="../electric/images/map_after_tomorrow.gif" width="96" height="23"></a></td>
                    </tr>
                  </table>
                  <!--오늘의 날씨/내일의 날씨/모레의 날씨 탭 끝-->
                </td>
              </tr>
              <tr> 
                <td><img src="../electric/images/tomorrow_map.gif" width="290" height="322"></td>
              </tr>
            </table>
            <!--오늘의 날씨/내일의 날씨/모레의 날씨 전체테이블 끝-->
          </td>
          <td width="312" height="6"></td>
        </tr>
        <tr> 
          <td> 
            <!--현재온도 타이틀 시작-->
            <table width="312" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="15" height="11" class="table03"><img src="../electric/images/yellowgreen_buret.gif" width="7" height="7"></td>
                <td class="title_01">현재온도</td>
              </tr>
            </table>
            <!--현재온도 타이틀 끝-->
          </td>
        </tr>
        <tr> 
          <td height="10" width="312"></td>
        </tr>
        <tr> 
          <td height="26" background="../electric/images/temperature_bg.gif" class="list17_1" width="312">서울 
            <% =hour(time()) %>시 &nbsp; <% =rspoint(hour(time())+25) %>℃ &nbsp; <% =FnWeatherCode(rspoint(hour(time()))) %>
          </td>
        </tr>
        <tr> 
          <td height="26"></td>
        </tr>
        <tr> 
          <td height="20" valign="top"> 
            <!--기상개황 타이틀 시작-->
            <table width="312" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="15" height="11" class="table03"><img src="../electric/images/yellowgreen_buret.gif" width="7" height="7"></td>
                <td class="title_01">기상개황</td>
              </tr>
            </table>
            <!--기상개황 타이틀 끝-->
          </td>
        </tr>
        <tr> 
          <td><img src="../electric/images/point_line8.gif" width="312" height="1"></td>
        </tr>
        <tr> 
          <td width="312" height="10" bgcolor="#f5f5f5"></td>
        </tr>
        <tr> 
          <td class="list14" height="207" width="312">&nbsp; 
            <% =rsoverview("airtendency") %><br>&nbsp; 
            <% =rsoverview("landoverview") %><br>&nbsp; 
            <% =rsoverview("seaoverview") %>
          </td>
        </tr>
        <tr> 
          <td width="312" height="10" bgcolor="#f5f5f5"></td>
        </tr>
        <tr> 
          <td><img src="../electric/images/point_line8.gif" width="312" height="1"></td>
        </tr>
        <tr> 
          <td colspan="3" height="30"></td>
        </tr>
        <tr> 
          <td colspan="3"> 
            <!--메인 예측 테이블 시작-->
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr class="list02_bg"> 
                <td colspan="2">목록</td>
                <td>M/I</td>
                <td>ADV</td>
                <td>스포츠</td>
                <td>호텔</td>
                <td>백화점</td>
                <td>쇼핑</td>
                <td>마트</td>
                <td>총계</td>
              </tr>
              <tr> 
                <td class="list07_bg" colspan="2">예측값</td>
                <td class="list14_bg"><% =FnNumberFormat(rs("magicisland")) %></td>
                <td class="list14_bg"><% =FnNumberFormat(rs("adventure")) %></td>
                <td class="list14_bg"><% =FnNumberFormat(rs("sports")) %></td>
                <td class="list14_bg"><% =FnNumberFormat(rs("hotel")) %></td>
                <td class="list14_bg"><% =FnNumberFormat(rs("departmentstore")) %></td>
                <td class="list14_bg"><% =FnNumberFormat(rs("shoppingmall")) %></td>
                <td class="list14_bg"><% =FnNumberFormat(rs("mart")) %></td>
                <td class="list15_bg3"><% =FnNumberFormat(rs("total")) %></td>
              </tr>
              <tr> 
                <td rowspan="2" class="list07_bg2" title='<% =rslast("sdate") %>'>동일</td>
                <td class="list03_bg2">전년실적</td>
                <td class="list14_bg2"><% =FnNumberFormat(rslast("magicisland")) %></td>
                <td class="list14_bg2"><% =FnNumberFormat(rslast("adventure")) %></td>
                <td class="list14_bg2"><% =FnNumberFormat(rslast("sports")) %></td>
                <td class="list14_bg2"><% =FnNumberFormat(rslast("hotel")) %></td>
                <td class="list14_bg2"><% =FnNumberFormat(rslast("departmentstore")) %></td>
                <td class="list14_bg2"><% =FnNumberFormat(rslast("shoppingmall")) %></td>
                <td class="list14_bg2"><% =FnNumberFormat(rslast("mart")) %></td>
                <td class="list15_bg"><% =FnNumberFormat(rslast("total")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <td class="list14_bg"><% =FnPercentFormat(rs("magicisland"), rslast("magicisland")) %></td>
                <td class="list14_bg"><% =FnPercentFormat(rs("adventure"), rslast("adventure")) %></td>
                <td class="list14_bg"><% =FnPercentFormat(rs("sports"), rslast("sports")) %></td>
                <td class="list14_bg"><% =FnPercentFormat(rs("hotel"), rslast("hotel")) %></td>
                <td class="list14_bg"><% =FnPercentFormat(rs("departmentstore"), rslast("departmentstore")) %>-</td>
                <td class="list14_bg"><% =FnPercentFormat(rs("shoppingmall"), rslast("shoppingmall")) %></td>
                <td class="list14_bg"><% =FnPercentFormat(rs("mart"), rslast("mart")) %></td>
                <td class="list15_bg3"><% =FnPercentFormat(rs("total"), rslast("total")) %></td>
              </tr>
              <tr> 
                <td rowspan="2" class="list07_bg2" title='<% =rslastweek("sdate") %>'>동요일</td>
                <td class="list03_bg2">전년실적</td>
                <td class="list14_bg2"><% =FnNumberFormat(rslastweek("magicisland")) %></td>
                <td class="list14_bg2"><% =FnNumberFormat(rslastweek("adventure")) %></td>
                <td class="list14_bg2"><% =FnNumberFormat(rslastweek("sports")) %></td>
                <td class="list14_bg2"><% =FnNumberFormat(rslastweek("hotel")) %></td>
                <td class="list14_bg2"><% =FnNumberFormat(rslastweek("departmentstore")) %></td>
                <td class="list14_bg2"><% =FnNumberFormat(rslastweek("shoppingmall")) %></td>
                <td class="list14_bg2"><% =FnNumberFormat(rslastweek("mart")) %></td>
                <td class="list15_bg"><% =FnNumberFormat(rslastweek("total")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <td class="list14_bg"><% =FnPercentFormat(rs("magicisland"), rslastweek("magicisland")) %></td>
                <td class="list14_bg"><% =FnPercentFormat(rs("adventure"), rslastweek("adventure")) %></td>
                <td class="list14_bg"><% =FnPercentFormat(rs("sports"), rslastweek("sports")) %></td>
                <td class="list14_bg"><% =FnPercentFormat(rs("hotel"), rslastweek("hotel")) %></td>
                <td class="list14_bg"><% =FnPercentFormat(rs("departmentstore"), rslastweek("departmentstore")) %>-</td>
                <td class="list14_bg"><% =FnPercentFormat(rs("shoppingmall"), rslastweek("shoppingmall")) %></td>
                <td class="list14_bg"><% =FnPercentFormat(rs("mart"), rslastweek("mart")) %></td>
                <td class="list15_bg3"><% =FnPercentFormat(rs("total"), rslastweek("total")) %></td>
              </tr>
              <tr bgcolor="#CECFF5"> 
                <td colspan="10" height="6"></td>
              </tr>
            </table>
            <!--메인 예측 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td colspan="3" height="30"></td>
        </tr>
      </table>
	  <!--큰 테이블 끝-->
    </td>
    <td width="49"><img src="../electric/images/null.gif" width="49" height="1"></td>
    <td bgcolor="#a4a4a4"><img src="../electric/images/outline.gif" width="1" height="1"></td>
  </tr>
  <tr> 
    <td height="42" colspan="3" background="../electric/images/copyright_bg.gif" align="right"><img src="../electric/images/copyright.gif" width="350" height="42"></td>
    <td bgcolor="#a4a4a4" width="1" height="42"><img src="../electric/images/null.gif"></td>
  </tr>
</table>
</body>
</html>
<!-- #include file="../electric/script/FnErrorCatch.inc"-->