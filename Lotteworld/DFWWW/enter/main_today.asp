<!-- #include file="../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' 프로그램ID : MAIN today
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 입장객 예측 메인 페이지 - 오늘
' 최초작성일 : 2002/10/16
' 최종작성일 : 2002/10/18
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim rslotte,rsever, rsseoul,rsland '레코드셋 (롯데 행사, 서울랜드 행사, 에버랜드 행사)
Dim rs,rse, rslast, rslaste '레코드셋(매표예측, 실입장예측, 매표 과거 실적, 실입장 과거실적)

intDateadd=0 '날짜 증감 변수값 초기화
ArrQuery = array("Today") '쿼리 변수

'변수의 설정
Set objServer = Server.CreateObject("XTEnterMainDayMTS.clsXTEnterMainDayNTX")

'컴포넌트 호출
arrRValue = objServer.Query(ArrQuery)
'레코드셋 어레이를 단일 레코드셋으로 분리

'첫번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rslotte,1
'두번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rsever,2
'세번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rsseoul,3
'네번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rsland,4
'다섯번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rs,5
'여섯번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rse,6
'일곱번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rslast,7
'여덟번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rslaste,8

'자원의 해제
Set objServer = Nothing

'에러의 처리
IF Err.Number <> 0 THEN 
	Response.Write Err.Number, Err.Source, Err.Description
	Set objServer = Nothing
	objserver.close
END IF
%>

<!-- #include file="../enter/script/fnevent_view.inc" -->
<!-- #include file="../enter/script/FnProgramProcess.vbs" -->
<!-- #include file="../enter/script/fnnumber_format.inc"-->
<!-- #include file="../enter/script/FnWeather_Icon.inc"-->
<html>
<head>
<title>오늘의날씨_main</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<script language="JavaScript" src=../enter/script/FnEnterMain.js></script>
<script>
function FnHidden() {
document.form.submit();
}
</script>
<link rel="stylesheet" href="../enter/css/cs_tx.css" type="text/css">

</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../enter/images/map_tomorrow_on.gif','../enter/images/map_after_tomorrow_on.gif')" onunload=FnHidden()>

<Form method=post name=form>
<input Type=hidden name=hiddenid value=<% =Request.Cookies("ckID") %>>
</Form>
<!--서울 레이어 시작-->
<div id="서울" style="position:absolute; left:126px; top:218px; width:34px; height:44px; z-index:1"> 
  <table width="34" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="34" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../enter/weather/weather_land.asp"><img src="../enter/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../enter/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--서울 레이어 끝-->
<!--강화 레이어 시작-->
<div id="강화" style="position:absolute; left:98px; top:284px; width:34px; height:44px; z-index:1"> 
  <table width="34" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="34" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../enter/weather/weather_land.asp"><img src="../enter/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>'  width="34" height="34" border="0" onClick="top.leftFrame.location.href('../enter/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--강화 레이어 끝-->
<!--동두천 레이어 시작-->
<div id="동두천" style="position:absolute; left:97px; top:154px; width:34px; height:44px; z-index:1"> 
  <table width="34" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="34" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../enter/weather/weather_land.asp"><img src="../enter/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../enter/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--동두천 레이어 끝-->
<!--양평 레이어 시작-->
<div id="양평" style="position:absolute; left:170px; top:199px; width:34px; height:44px; z-index:1"> 
  <table width="34" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="34" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../enter/weather/weather_land.asp"><img src="../enter/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../enter/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--양평 레이어 끝-->
<!--인천 레이어 시작-->
<div id="인천" style="position:absolute; left:62px; top:220px; width:34px; height:44px; z-index:1"> 
  <table width="34" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="34" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../enter/weather/weather_land.asp"><img src="../enter/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../enter/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--인천 레이어 끝-->
<!--수원 레이어 시작-->
<div id="수원" style="position:absolute; left:142px; top:289px; width:34px; height:44px; z-index:1"> 
  <table width="34" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="34" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../enter/weather/weather_land.asp"><img src="../enter/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../enter/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--수원 레이어 끝-->
<!--이천 레이어 시작-->
<div id="이천" style="position:absolute; left:188px; top:264px; width:34px; height:44px; z-index:1"> 
  <table width="34" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="34" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../enter/weather/weather_land.asp"><img src="../enter/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../enter/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--이천 레이어 끝-->
<!--철원 레이어 시작-->
<div id="철원" style="position:absolute; left:164px; top:126px; width:34px; height:44px; z-index:1"> 
  <table width="34" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="34" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../enter/weather/weather_land.asp?varAreaCode=15&varAreaName=영서"><img src="../enter/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../enter/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--철원 레이어 끝-->
<!--춘천 레이어 시작-->
<div id="춘천" style="position:absolute; left:214px; top:158px; width:34px; height:44px; z-index:1"> 
  <table width="34" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="34" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../enter/weather/weather_land.asp?varAreaCode=15&varAreaName=영서"><img src="../enter/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../enter/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--춘천 레이어 끝-->
<!--홍천 레이어 시작-->
<div id="홍천" style="position:absolute; left:257px; top:172px; width:34px; height:44px; z-index:1"> 
  <table width="34" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="34" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../enter/weather/weather_land.asp?varAreaCode=15&varAreaName=영서"><img src="../enter/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../enter/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--홍천 레이어 끝-->
<!--원주 레이어 시작-->
<div id="원주" style="position:absolute; left:233px; top:237px; width:34px; height:44px; z-index:1"> 
  <table width="34" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="34" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../enter/weather/weather_land.asp?varAreaCode=15&varAreaName=영서"><img src="../enter/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../enter/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--원주 레이어 끝-->
<!--영월 레이어 시작-->
<div id="영월" style="position:absolute; left:291px; top:232px; width:34px; height:44px; z-index:1"> 
  <table width="34" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="34" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../enter/weather/weather_land.asp?varAreaCode=18&varAreaName=충북"><img src="../enter/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../enter/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--영월 레이어 끝-->
<!--충주 레이어 시작-->
<div id="충주" style="position:absolute; left:230px; top:303px; width:34px; height:44px; z-index:1"> 
  <table width="34" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="34" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../enter/weather/weather_land.asp?varAreaCode=18&varAreaName=충북"><img src="../enter/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../enter/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--충주 레이어 끝-->
<!--제천 레이어 시작-->
<div id="제천" style="position:absolute; left:275px; top:304px; width:34px; height:44px; z-index:1"> 
  <table width="34" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="34" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../enter/weather/weather_land.asp?varAreaCode=18&varAreaName=충북"><img src="../enter/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../enter/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--제천 레이어 끝-->
<!--청주 레이어 시작-->
<div id="청주" style="position:absolute; left:188px; top:334px; width:34px; height:44px; z-index:1"> 
  <table width="34" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="34" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../enter/weather/weather_land.asp?varAreaCode=18&varAreaName=충북"><img src="../enter/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../enter/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmax") %></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--청주 레이어 끝-->
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
  <tr> 
    <td width="49"><img src="../enter/images/null.gif" width="49" height="1"></td>
    <td valign="top">
	<!--큰 테이블 시작--> 
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td colspan="3"><img src="../enter/images/null.gif" width="1" height="25"></td>
        </tr>
        <tr> 
          <td><img src="../enter/images/title_weatherinfo.gif" width="290" height="21"></td>
          <td rowspan="3" width="49"></td>
          <td><img src="../enter/images/title_forecastinfo.gif" width="304" height="21"></td>
        </tr>
        <tr> 
          <td>
		  <!--오늘의 날씨/내일의 날씨/모레의 날씨 전체테이블 시작--> 
            <table width="290" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="29">
				<!--오늘의 날씨/내	일의 날씨/모레의 날씨 탭 시작--> 
                  <table width="290" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td colspan="3"><img src="../enter/images/null.gif" width="1" height="6"></td>
                    </tr>
                    <tr> 
                      <td><img src="../enter/images/map_today_on.gif" width="96" height="23"></td>
                      <td><a href="main_tomorrow.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image127','','../enter/images/map_tomorrow_on.gif',1)"><img name="Image127" border="0" src="../enter/images/map_tomorrow.gif" width="98" height="23"></a></td>
                      <td><a href="main_afterto.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image128','','../enter/images/map_after_tomorrow_on.gif',1)"><img name="Image128" border="0" src="../enter/images/map_after_tomorrow.gif" width="96" height="23"></a></td>
                    </tr>
                  </table>
				  <!--오늘의 날씨/내일의 날씨/모레의 날씨 탭 끝-->
                </td>
              </tr>
              <tr> 
                <td><img src="../enter/images/today_map.gif" width="290" height="322"></td>
              </tr>
            </table>
			<!--오늘의 날씨/내일의 날씨/모레의 날씨 전체테이블 끝-->
          </td>
          <td>
		  <!--실입장객/매표입장객 전체 테이블 시작-->
            <table width="304" border="0" cellspacing="0" cellpadding="0" height="351">
              <tr>
                <td bgcolor="#E6E6E6"><img src="../enter/images/null.gif" width="1" height="5"></td>
              </tr>
              <tr>
                <td><img src="../enter/images/null.gif" width="1" height="30"></td>
              </tr>
			  <tr>
                <td valign="top">
				<!-- 실입장객/매표입장객 테이블 시작--> 
                  <table width="304" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td>
					  <!--실입장객 타이틀바 시작-->
                        <table width="304" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td width="22" class="table03"><img src="../enter/images/human_icon1.gif" width="14" height="14"></td>
                            <td width="282" class="title_01_b">실입장객</td>
                          </tr>
                        </table>
						<!--실입장객 타이틀바 끝-->
                      </td>
                    </tr>
                    <tr>
                      <td><img src="../enter/images/null.gif" width="1" height="5"></td>
                    </tr>
                    <tr>
                      <td>
					  <!--실입장객 예측 테이블 시작--> 
                        <table width="304" border="0" cellspacing="1" cellpadding="7">
                          <tr class="list02_bg"> 
                            <td width="84">구분</td>
                            <td width="50">개인</td>
                            <td width="50">단체</td>
                            <td width="50">계</td>
                            <td width="60">전년비</td>
                          </tr>
                          <tr> 
                            <td class="list03_bg">예측값</td>
                            <td class="list14_bg"><% =FnNumberFormat(rse("indivtotal")) %></td>
                            <td class="list14_bg"><% =FnNumberFormat(rse("grouptotal")) %></td>
                            <td class="list14_bg"><% =FnNumberFormat(rse("total")) %></td>
                            <td rowspan="2" class="list15_bg3"><% =FnPercentFormat(rse("total"), rslaste("total")) %></td>
                          </tr>
                          <tr> 
                            <td class="list03_bg2">전년실적</td>
                            <td class="list14_bg2"><% =FnNumberFormat(rslaste("indivtotal")) %></td>
                            <td class="list14_bg2"><% =FnNumberFormat(rslaste("grouptotal")) %></td>
                            <td class="list14_bg2"><% =FnNumberFormat(rslaste("total")) %></td>
                          </tr>
                          <tr bgcolor="#B0DFFD"> 
                            <td height="8" colspan="5"></td>
                          </tr>
                        </table>
						<!--실입장객 예측 테이블 끝-->
                      </td>
                    </tr>
                    <tr>
                      <td><img src="../enter/images/null.gif" width="1" height="30"></td>
                    </tr>
                    <tr>
                      <td>
					  <!--매표입장객 타이틀바 시작-->
                        <table width="304" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="22" class="table03"><img src="../enter/images/human_icon2.gif" width="14" height="14"></td>
                            <td width="282" class="title_01_b">매표입장객</td>
                          </tr>
                        </table>
						<!--매표입장객 타이틀바 끝-->
                      </td>
                    </tr>
                    <tr>
                      <td><img src="../enter/images/null.gif" width="1" height="5"></td>
                    </tr>
                    <tr>
                      <td>
					  <!--매표입장객 예측 테이블 시작--> 
                        <table width="304" border="0" cellspacing="1" cellpadding="7">
                          <tr class="list02_bg"> 
                            <td width="84">구분</td>
                            <td width="50">개인</td>
                            <td width="50">단체</td>
                            <td width="50">계</td>
                            <td width="60">전년비</td>
                          </tr>
                          <tr> 
                            <td class="list03_bg">예측값</td>
                            <td class="list14_bg"><% =FnNumberFormat(rs("indivtotal")) %></td>
                            <td class="list14_bg"><% =FnNumberFormat(rs("grouptotal")) %></td>
                            <td class="list14_bg"><% =FnNumberFormat(rs("total")) %></td>
                            <td rowspan="2" class="list15_bg3"><% =FnPercentFormat(rs("total"),rslast("total")) %></td>
                          </tr>
                          <tr> 
                            <td class="list03_bg2">전년실적</td>
                            <td class="list14_bg2"><% =FnNumberFormat(rslast("indivtotal")) %></td>
                            <td class="list14_bg2"><% =FnNumberFormat(rslast("grouptotal")) %></td>
                            <td class="list14_bg2"><% =FnNumberFormat(rslast("total")) %></td>
                          </tr>
                          <tr bgcolor="#B0DFFD"> 
                            <td height="8" colspan="5"></td>
                          </tr>
                        </table>
						<!--매표입장객 예측 테이블 끝-->
                      </td>
                    </tr>
                  </table>
				  <!-- 실입장객/매표입장객 테이블 끝-->
                </td>
              </tr>
              <tr>
                <td height="23" class="table02">
				<!--하단 버튼바 테이블 시작-->
                  <table width="304" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td align="right"><a href="../enter/forecasting/enter_main.asp"><img src="../enter/images/more.gif" width="44" height="15" border="0"></a></td>
                      <td width="4"></td>
                    </tr>
                  </table>
				  <!--하단 버튼바 테이블 끝-->
                </td>
              </tr>
            </table>
			<!--실입장객/매표입장객 전체 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td height="40"></td>
          <td height="40"></td>
        </tr>
        <tr> 
          <td colspan="3"><img src="../enter/images/title_event.gif" width="290" height="21"></td>
        </tr>
        <tr> 
          <td colspan="3"><img src="../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td colspan="3"><img src="../enter/images/null.gif" width="1" height="16"></td>
        </tr>
        <tr> 
          <td colspan="3">
		  <!--이벤트 전체 테이블 시작--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="4"></td>
                <td>
				<!--롯데월드 이벤트 테이블 시작--> 
                  <table width="193" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td colspan="3"><img src="../enter/images/lotteworld1.gif" width="193" height="53"></td>
                    </tr>
                    <tr> 
                      <td height="18" colspan="3"></td>
                    </tr>
                    <% do until rslotte.EOF %>
                    <tr> 
                      <td width="19" height="19" class="table03"><img src="../enter/images/vermilion_buret.gif" width="7" height="7"></td>
                      <td width="128" class="list05"><a href="../enter/event/event_lotte_view.asp?intIdx=<% =rslotte("IDX") %>"><% =left(rslotte("title"),10) %>......</a></td>
                      <td align="right" width="46">
						<% if FnDateInter(rslotte("startdate"),rslotte("enddate"))=1 then %>    
						<img src="../enter/images/today_minibutton.gif" width="42" height="9"> 
						<% elseif FnDateInter(rslotte("startdate"),rslotte("enddate"))=2 then %>
						<img src="../enter/images/month_minibutton.gif" width="42" height="9">    
						<% end if %>
					</td>
                    </tr>
                    <tr> 
                      <td colspan="3"><img src="../enter/images/point_line.gif" width="193" height="1"></td>
                    </tr>
                    <tr> 
                      <td colspan="3" height="10"></td>
                    </tr>
                    <% rslotte.MOVENEXT
                    loop %>                                        
                    <tr class="table05"> 
                      <td colspan="3" height="7"><a href="../enter/event/event_lotte_list.asp"><img src="../enter/images/more.gif" width="44" height="15" border="0"></a></td>
                    </tr>
                  </table>
				  <!--롯데월드 이벤트 테이블 끝-->
                </td>
                <td width="27"></td>
                <td>
				<!--에버랜드 이벤트 테이블 시작--> 
                  <table width="193" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td colspan="3"><img src="../enter/images/everland1.gif" width="193" height="53"></td>
                    </tr>
                    <tr> 
                      <td height="18" colspan="3"></td>
                    </tr>
                    <% do until rsever.EOF %>
                    <tr> 
                      <td width="19" height="19" class="table03"><img src="../enter/images/yellowgreen_buret.gif" width="7" height="7"></td>
                      <td width="128" class="list05"><a href="../enter/event/event_ever_view.asp?intIdx=<% =rsever("IDX") %>"><% =left(rsever("title"),10) %>......</a></td>
                      <td align="right" width="46">
                      	<% if FnDateInter(rsever("startdate"),rsever("enddate"))=1 then %>    
						<img src="../enter/images/today_minibutton.gif" width="42" height="9"> 
						<% elseif FnDateInter(rsever("startdate"),rsever("enddate"))=2 then %>
						<img src="../enter/images/month_minibutton.gif" width="42" height="9">    
						<% end if %>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="3"><img src="../enter/images/point_line.gif" width="193" height="1"></td>
                    </tr>
                    <tr> 
                      <td colspan="3" height="10"></td>
                    </tr>
                    <% rsever.MOVENEXT 
                    loop %>                   
                    <tr class="table05"> 
                      <td colspan="3" height="7"><a href="../enter/event/event_ever_list.asp"><img src="../enter/images/more.gif" width="44" height="15" border="0"></a></td>
                    </tr>
                  </table>
				  <!--에버랜드 이벤트 테이블 끝-->
                </td>
                <td width="27"></td>
                <td>
				<!--서울랜드 이벤트 테이블 시작--> 
                  <table width="193" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td colspan="3"><img src="../enter/images/seoulland1.gif" width="193" height="53"></td>
                    </tr>
                    <tr> 
                      <td height="18" colspan="3"></td>
                    </tr>
                    <% do until rsseoul.EOF %>
                    <tr> 
                      <td width="19" height="19" class="table03"><img src="../enter/images/green_buret.gif" width="7" height="7"></td>
                      <td width="128" class="list05"><a href="../enter/event/event_seoul_view.asp?intIdx=<% =rsseoul("IDX") %>"><% =left(rsseoul("title"),10) %>......</a></td>
                      <td align="right" width="46">
						<% if FnDateInter(rsseoul("startdate"),rsseoul("enddate"))=1 then %>    
						<img src="../enter/images/today_minibutton.gif" width="42" height="9"> 
						<% elseif FnDateInter(rsseoul("startdate"),rsseoul("enddate"))=2 then %>
						<img src="../enter/images/month_minibutton.gif" width="42" height="9">    
						<% end if %>                      
                    </tr>
                    <tr> 
                      <td colspan="3"><img src="../enter/images/point_line.gif" width="193" height="1"></td>
                    </tr>
                    <tr> 
                      <td colspan="3" height="10"></td>
                    </tr>
                    <% rsseoul.MOVENEXT
                    loop 
                    %>
                    <tr class="table05"> 
                      <td colspan="3" height="7"><a href="../enter/event/event_seoul_list.asp"><img src="../enter/images/more.gif" width="44" height="15" border="0"></a></td>
                    </tr>
                  </table>
				  <!--서울랜드 이벤트 테이블 끝-->
                </td>
                <td width="5"></td>
              </tr>
            </table>
			<!--이벤트 전체 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td colspan="3" height="30"></td>
        </tr>
      </table>
	  <!--큰 테이블 끝-->
    </td>
    <td width="49"><img src="../enter/images/null.gif" width="49" height="1"></td>
    <td bgcolor="#a4a4a4"><img src="../enter/images/outline.gif" width="1" height="1"></td>
  </tr>
  <tr> 
    <td height="42" colspan="3" background="../enter/images/copyright_bg.gif" align="right"><img src="../enter/images/copyright.gif" width="350" height="42"></td>
    <td bgcolor="#a4a4a4" width="1" height="42"><img src="../enter/images/null.gif"></td>
  </tr>
</table>
</body>
</html>
<!-- #include file="../enter/script/FnErrorCatch.inc"-->