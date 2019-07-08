<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' 프로그램ID : Enter_DAY_TOTAL
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 입장객 예측 매표-일-전체
' 최초작성일 : 2002/10/24
' 최종작성일 : 2002/11/13
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim rs,rssum,rslast, rslastsum, rslastweek, rslastweeksum '레코드셋 (전년동일,전년동일합계,전년동요일,전년동요일합계)
dim varEnterType '실입장,매표입장구분
dim intI '증감변수

varEnterType=Request.QueryString("varEnterType")
%>
<!-- #include file="../../enter/script/FnSearch_Date.inc"-->
<%
ArrQuery = array(varEnterType,"total",dtLastday,dtLastWeekday)

'변수의 설정
Set objServer = Server.CreateObject("XTEnterDayMTS.clsXTEnterDayNTX")

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
FnSplitRSArray arrRValue,rssum,4
'다섯번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rslastsum,5
'여섯번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rslastweeksum,6

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
<!-- #include file="../../enter/script/FnEnterTypeImage.vbs" -->
<!-- #include file="../../enter/script/fnnumber_format.inc"-->
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
	<!--큰 테이블 시작-->
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="24"><img src="../../enter/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
          <td align="left"><img src="../../enter/images/<% =FnChangeImage(varEnterType,"day1") %>" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td> 
            <!--표 테이블 시작-->
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr class="list07_bg3"> 
                <td colspan="3">구분</td>
                <% FOR intI=0 to 2 %>
                <td> 
                  <% =FnDateFormat(date()+intI) %>
                </td>
                <% NEXT %>
                <td>누계</td>
              </tr>
              <tr> 
                <td rowspan="5" width="92" class="list02_bg2">전체</td>
                <td colspan="2" class="list03_bg">예측값</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg" title=<% =rs("xdate") %>> 
                  <% =FnNumberFormat(rs("total")) %>
                </td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnNumberForMat(rssum("total"))%>
                </td>
              </tr>
              <tr> 
                <td rowspan="2" width="50" class="list03_bg2" title=<% =FnDateFormat(dtLastday) %>>동일</td>
                <td width="68" class="list03_bg2">전년실적</td>
                <% FOR intI=0 to 2 %>
                <td width="108" class="list01_bg2" title=<% =rslast("xdate") %>> 
                  <% =FnNumberFormat(rslast("total")) %>
                </td>
                <% rslast.MOVENEXT : NEXT :rslast.MOVEFIRST %>
                <td width="108" class="list04_bg2"> 
                  <% =FnNumberFormat(rslastsum("total")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rs("total"),rslast("total")) %>
                </td>
                <% rs.MOVENEXT : rslast.MOVENEXT : NEXT : rs.MOVEFIRST : rslast.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnPercentFormat(rssum("total"),rslastsum("total")) %>
                </td>
              </tr>
              <tr> 
                <td rowspan="2" class="list03_bg2" title=<% =FnDateFormat(dtLastWeekday) %>>동요일</td>
                <td class="list03_bg2">전년실적</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg2" title=<% =rslastweek("xdate") %>> 
                  <% =FnNumberFormat(rslastweek("total")) %>
                </td>
                <% rslastweek.MOVENEXT : NEXT : rslastweek.MOVEFIRST %>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rslastweeksum("total")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rs("total"),rslastweek("total")) %>
                </td>
                <% rs.MOVENEXT : rslastweek.MOVENEXT : NEXT : rs.MOVEFIRST : rslastweek.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnPercentFormat(rssum("total"),rslastweeksum("total")) %>
                </td>
              </tr>
              <tr align="center"> 
                <td colspan="7"><img src="../../enter/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td rowspan="5" class="list02_bg2">어른</td>
                <td colspan="2" class="list03_bg">예측값</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg" title=<% =rs("xdate") %>> 
                  <% =FnNumberFormat(rs("adult")) %>
                </td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnNumberForMat(rssum("adult"))%>
                </td>
              </tr>
              <tr> 
                <td rowspan="2" class="list03_bg2">동일</td>
                <td class="list03_bg2">전년실적</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg2" title=<% =rslast("xdate") %>> 
                  <% =FnNumberFormat(rslast("adult")) %>
                </td>
                <% rslast.MOVENEXT : NEXT : rslast.MOVEFIRST %>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rslastsum("adult")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rs("adult"),rslast("adult")) %>
                </td>
                <% rs.MOVENEXT : rslast.MOVENEXT : NEXT : rs.MOVEFIRST : rslast.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnPercentFormat(rssum("adult"),rslastsum("adult")) %>
                </td>
              </tr>
              <tr> 
                <td rowspan="2" class="list03_bg2">동요일</td>
                <td class="list03_bg2">전년실적</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg2" title=<% =rslastweek("xdate") %>> 
                  <% =FnNumberFormat(rslastweek("adult")) %>
                </td>
                <% rslastweek.MOVENEXT : NEXT : rslastweek.MOVEFIRST %>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rslastweeksum("adult")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rs("adult"),rslastweek("adult")) %>
                </td>
                <% rs.MOVENEXT : rslastweek.MOVENEXT : NEXT : rs.MOVEFIRST : rslastweek.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnPercentFormat(rssum("adult"),rslastweeksum("adult")) %>
                </td>
              </tr>
              <tr align="center"> 
                <td colspan="7"><img src="../../enter/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td rowspan="5" class="list02_bg2">중고생</td>
                <td colspan="2" class="list03_bg">예측값</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg" title=<% =rs("xdate") %>> 
                  <% =FnNumberFormat(rs("school")) %>
                </td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnNumberForMat(rssum("school"))%>
                </td>
              </tr>
              <tr> 
                <td rowspan="2" class="list03_bg2">동일</td>
                <td class="list03_bg2">전년실적</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg2" title=<% =rslast("xdate") %>> 
                  <% =FnNumberFormat(rslast("school")) %>
                </td>
                <% rslast.MOVENEXT : NEXT : rslast.MOVEFIRST %>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rslastsum("school")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rs("school"),rslast("school")) %>
                </td>
                <% rs.MOVENEXT : rslast.MOVENEXT : NEXT : rs.MOVEFIRST : rslast.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnPercentFormat(rssum("school"),rslastsum("school")) %>
                </td>
              </tr>
              <tr> 
                <td rowspan="2" class="list03_bg2">동요일</td>
                <td class="list03_bg2">전년실적</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg2" title=<% =rslastweek("xdate") %>> 
                  <% =FnNumberFormat(rslastweek("school")) %>
                </td>
                <% rslastweek.MOVENEXT : NEXT : rslastweek.MOVEFIRST %>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rslastweeksum("school")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rs("school"),rslastweek("school")) %>
                </td>
                <% rs.MOVENEXT : rslastweek.MOVENEXT : NEXT : rs.MOVEFIRST : rslastweek.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnPercentFormat(rssum("school"),rslastweeksum("school")) %>
                </td>
              </tr>
              <tr align="center"> 
                <td colspan="7"><img src="../../enter/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td rowspan="5" class="list02_bg2">어린이</td>
                <td colspan="2" class="list03_bg">예측값</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg" title=<% =rs("xdate") %>> 
                  <% =FnNumberFormat(rs("child")) %>
                </td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnNumberForMat(rssum("child"))%>
                </td>
              </tr>
              <tr> 
                <td rowspan="2" class="list03_bg2">동일</td>
                <td class="list03_bg2">전년실적</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg2" title=<% =rslast("xdate") %>> 
                  <% =FnNumberFormat(rslast("child")) %>
                </td>
                <% rslast.MOVENEXT : NEXT : rslast.MOVEFIRST %>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rslastsum("child")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rs("child"),rslast("child")) %>
                </td>
                <% rs.MOVENEXT : rslast.MOVENEXT : NEXT : rs.MOVEFIRST : rslast.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnPercentFormat(rssum("child"),rslastsum("child")) %>
                </td>
              </tr>
              <tr> 
                <td rowspan="2"  class="list03_bg2">동요일</td>
                <td class="list03_bg2">전년실적</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg2" title=<% =rslastweek("xdate") %>> 
                  <% =FnNumberFormat(rslastweek("child")) %>
                </td>
                <% rslastweek.MOVENEXT : NEXT : rslastweek.MOVEFIRST %>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rslastweeksum("child")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rs("child"),rslastweek("child")) %>
                </td>
                <% rs.MOVENEXT : rslastweek.MOVENEXT : NEXT : rs.MOVEFIRST : rslastweek.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnPercentFormat(rssum("child"),rslastweeksum("child")) %>
                </td>
              </tr>
              <tr bgcolor="#B0DFFD"> 
                <td height="10" colspan="7"></td>
              </tr>
            </table>
            <!--표 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td height="10"></td>
        </tr>
        <tr> 
          <td height="34" class="table02"> 
            <!-- 하단 버튼 바 테이블 시작-->
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="637" align="right"><a href=../../enter/excel/Enter_day_total_excel.asp?varEnterType=<% =varEnterType %>><img src="../../enter/images/download_button.gif" border=0 width="88" height="26"></a></td>
                <td width="5"></td>
              </tr>
            </table>
            <!-- 하단 버튼 바 테이블 끝-->
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