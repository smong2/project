<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' 프로그램ID : Enter_Day_Group
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 입장객 예측 - 매표-일-단체
' 최초작성일 : 2002/10/24
' 최종작성일 : 2002/11/20
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim rs,rssum,rslast, rslastsum, rslastweek, rslastweeksum '레코드셋 (전년동일,전년동일합계,전년동요일,전년동요일합계)
dim varEnterType '실입장,매표입장구분
dim intI '증가변수

varEnterType=Request.QueryString("varEnterType") '실입장,매표입장 구분
%>
<!-- #include file="../../enter/script/fnSearch_Date.inc"-->
<%
ArrQuery = array(varEnterType,"group",dtLastDay,dtLastWeekDay) '페이지에 맞는 코드 가져오고

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
          <td align="left"><img src="../../enter/images/<% =FnChangeImage(varEnterType,"day3") %>" width="200" height="21"></td>
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
                <td rowspan="5"  width="92" class="list02_bg2">전체</td>
                <td colspan="2" class="list03_bg">예측값</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg" title=<% =rs("xdate") %>> 
                  <% =FnNumberFormat(rs("grouptotal")) %>
                </td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnNumberFormat(rssum("grouptotal")) %>
                </td>
              </tr>
              <tr> 
                <td rowspan="2" width="50" class="list03_bg2">동일</td>
                <td width="68" class="list03_bg2">전년실적</td>
                <% FOR intI=0 to 2 %>
                <td width="108" class="list01_bg2" title=<% =rslast("xdate") %>> 
                  <% =FnNumberFormat(rslast("grouptotal")) %>
                </td>
                <% rslast.MOVENEXT : NEXT : rslast.MOVEFIRST %>
                <td width="108" class="list04_bg2"> 
                  <% =FnNumberFormat(rslastsum("grouptotal")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rs("grouptotal"),rslast("grouptotal")) %>
                </td>
                <% rs.MOVENEXT : rslast.MOVENEXT : NEXT : rs.MOVEFIRST : rslast.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnPercentFormat(rssum("grouptotal"),rslastsum("grouptotal")) %>
                </td>
              </tr>
              <tr> 
                <td rowspan="2" class="list03_bg2">동요일</td>
                <td class="list03_bg2">전년실적</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg2" title=<% =rslastweek("xdate") %>> 
                  <% =FnNumberFormat(rslastweek("grouptotal")) %>
                </td>
                <% rslastweek.MOVENEXT : NEXT : rslastweek.MOVEFIRST %>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rslastweeksum("grouptotal")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rs("grouptotal"),rslastweek("grouptotal")) %>
                </td>
                <% rs.MOVENEXT : rslastweek.MOVENEXT : NEXT : rs.MOVEFIRST  : rslastweek.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnPercentFormat(rssum("grouptotal"),rslastweeksum("grouptotal")) %>
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
                  <% =FnNumberFormat(rs("groupadult")) %>
                </td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnNumberFormat(rssum("groupadult")) %>
                </td>
              </tr>
              <tr> 
                <td rowspan="2" class="list03_bg2">동일</td>
                <td class="list03_bg2">전년실적</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg2" title=<% =rslast("xdate") %>> 
                  <% =FnNumberFormat(rslast("groupadult")) %>
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
                  <% =FnPercentFormat(rs("groupadult"),rslast("groupadult")) %>
                </td>
                <% rs.MOVENEXT : rslast.MOVENEXT : NEXT : rs.MOVEFIRST : rslast.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnPercentFormat(rssum("groupadult"),rslastsum("adult")) %>
                </td>
              </tr>
              <tr> 
                <td rowspan="2" class="list03_bg2">동요일</td>
                <td class="list03_bg2">전년실적</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg2" title=<% =rslastweek("xdate") %>> 
                  <% =FnNumberFormat(rslastweek("groupadult")) %>
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
                  <% =FnPercentFormat(rs("groupadult"),rslastweek("groupadult")) %>
                </td>
                <% rs.MOVENEXT : rslastweek.MOVENEXT : NEXT : rs.MOVEFIRST : rslastweek.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnPercentFormat(rssum("groupadult"),rslastweeksum("adult")) %>
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
                  <% =FnNumberFormat(rs("groupschool")) %>
                </td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnNumberFormat(rssum("groupschool")) %>
                </td>
              </tr>
              <tr> 
                <td rowspan="2" class="list03_bg2">동일</td>
                <td class="list03_bg2">전년실적</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg2" title=<% =rslast("xdate") %>> 
                  <% =FnNumberFormat(rslast("groupschool")) %>
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
                  <% =FnPercentFormat(rs("groupschool"),rslast("groupschool")) %>
                </td>
                <% rs.MOVENEXT : rslast.MOVENEXT : NEXT : rs.MOVEFIRST : rslast.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnPercentFormat(rssum("groupschool"),rslastsum("school")) %>
                </td>
              </tr>
              <tr> 
                <td rowspan="2" class="list03_bg2">동요일</td>
                <td class="list03_bg2">전년실적</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg2" title=<% =rslastweek("xdate") %>> 
                  <% =FnNumberFormat(rslastweek("groupschool")) %>
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
                  <% =FnPercentFormat(rs("groupschool"),rslastweek("groupschool")) %>
                </td>
                <% rs.MOVENEXT : rslastweek.MOVENEXT : NEXT : rs.MOVEFIRST : rslastweek.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnPercentFormat(rssum("groupschool"),rslastweeksum("school")) %>
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
                  <% =FnNumberFormat(rs("groupchild")) %>
                </td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnNumberFormat(rssum("groupchild")) %>
                </td>
              </tr>
              <tr> 
                <td rowspan="2" class="list03_bg2">동일</td>
                <td class="list03_bg2">전년실적</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg2" title=<% =rslast("xdate") %>> 
                  <% =FnNumberFormat(rslast("groupchild")) %>
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
                  <% =FnPercentFormat(rs("groupchild"),rslast("groupchild")) %>
                </td>
                <% rs.MOVENEXT : rslast.MOVENEXT : NEXT : rs.MOVEFIRST : rslast.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnPercentFormat(rssum("groupchild"),rslastsum("child")) %>
                </td>
              </tr>
              <tr> 
                <td rowspan="2" class="list03_bg2">동요일</td>
                <td class="list03_bg2">전년실적</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg2" title=<% =rslastweek("xdate") %>> 
                  <% =FnNumberFormat(rslastweek("groupchild")) %>
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
                  <% =FnPercentFormat(rs("groupchild"),rslastweek("groupchild")) %>
                </td>
                <% rs.MOVENEXT : rslastweek.MOVENEXT : NEXT : rs.MOVEFIRST : rslastweek.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnPercentFormat(rssum("groupchild"),rslastweeksum("child")) %>
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
            <!--하단 버튼 바 테이블 시작-->
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="637" align="right"><a href=../../enter/excel/Enter_day_group_excel.asp?varEnterType=<% =varEnterType %>><img src="../../enter/images/download_button.gif" width="88" height="26" border=0></a></td>
                <td width="5"></td>
              </tr>
            </table>
            <!--하단 버튼 바 테이블 끝-->
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
<!-- #include file="../../enter/script/FnErrorCatch.inc" -->