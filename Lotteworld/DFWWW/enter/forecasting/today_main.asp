<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' 프로그램ID : TODAY_MAIN
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 TODAY_MAIN
' 최초작성일 : 2002/10/24
' 최종작성일 : 2002/10/24
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim intI
Dim rs,rse,rslast, rslastweek, rslaste, rslastweeke '레코드셋 : 매표예측, 실입장예측,매표입장 전년동일실적, 매표입장 전년동요일실적, 실입장 전년동일실적, 실입장 전년동요일실적
%>
<!-- #include file="../../enter/script/fnsearch_date.inc"-->
<%
ArrQuery = array(dtLastday,dtLastWeekday)

'변수의 설정
Set objServer = Server.CreateObject("XTTodayMainMTS.clsXTTodayMainNTX")

'컴포넌트 호출 로직의 전개
' ...

'컴포넌트 호출
arrRValue = objServer.Query(ArrQuery)
'레코드셋 어레이를 단일 레코드셋으로 분리

'첫번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rs,1 '예측
'두번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rse,2  '실입장 예측
'세번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rslast,3 '전년 동일 실적
'네번째 레코드셋을 어레이로 변환 
FnSplitRSArray arrRValue,rslaste,4 '실입장 전년 동일 실적
'다섯번째 레코드셋을 어레이로 변환 
FnSplitRSArray arrRValue,rslastweek,5 '전년 동요일 실적
'여섯번째 레코드셋을 어레이로 변환 
FnSplitRSArray arrRValue,rslastweeke,6 '실입장 전년 동요일 실적

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
      <table width="642" border="0" cellspacing="0" cellpadding="0" height="100%">
        <tr> 
          <td height="24"><img src="../../enter/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
          <td align="left"><img src="../../enter/images/title_today.gif" width="114" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td> 
            <!--실입장객 타이틀 시작-->
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="15" height="11" class="table03"><img src="../../enter/images/yellowgreen_buret.gif" width="7" height="7"></td>
                <td class="title_01">실 입장객</td>
              </tr>
            </table>
            <!--실입장객 타이틀 끝-->
          </td>
        </tr>
        <tr> 
          <td height="5"><img src="../../enter/images/null.gif" width="1" height="5"></td>
        </tr>
        <tr> 
          <td> 
            <!--실입장객 테이블 시작-->
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr class="list02_bg"> 
                <td colspan="2" rowspan="2">구분</td>
                <td rowspan="2" >예측값</td>
                <td colspan="2">동일기준</td>
                <td colspan="2">동요일기준</td>
              </tr>
              <tr class="list03_bg"> 
                <td title=<% =rslast("xdate") %>>전년</td>
                <td>전년비</td>
                <td title=<% =rslastweek("xdate") %>>전년</td>
                <td>전년비</td>
              </tr>
              <tr> 
                <td rowspan="4" class="list02_bg2">개인</td>
                <td class="list03_bg2">어른</td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rse("indivadult")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rslaste("indivadult")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnPercentFormat(rse("indivadult"),rslaste("indivadult")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rslastweeke("indivadult")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnPercentFormat(rse("indivadult"),rslastweeke("indivadult")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">중고생</td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rse("indivschool")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rslaste("indivschool")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rse("indivschool"),rslaste("indivschool")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rslastweeke("indivschool")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rse("indivschool"),rslastweeke("indivschool")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg2">어린이</td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rse("indivchild")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rslaste("indivchild")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnPercentFormat(rse("indivchild"),rslaste("indivchild")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rslastweeke("indivchild")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnPercentFormat(rse("indivchild"),rslastweeke("indivchild")) %>
                </td>
              </tr>
              <tr> 
                <td class="list02_bg2">소계</td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rse("indivtotal")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rslaste("indivtotal")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rse("indivtotal"),rslaste("indivtotal")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rslastweeke("indivtotal")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rse("indivtotal"),rslaste("indivtotal")) %>
                </td>
              </tr>
              <tr align="center"> 
                <td height="15" colspan="7"><img src="../../enter/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td rowspan="4" class="list02_bg2">단체</td>
                <td class="list03_bg2">어른</td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rse("groupadult")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rslaste("groupadult")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnPercentFormat(rse("groupadult"),rslaste("groupadult")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rslastweeke("groupadult")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnPercentFormat(rse("groupadult"),rslastweeke("groupadult")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">중고생</td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rse("groupschool")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rslaste("groupschool")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rse("groupschool"),rslaste("groupschool")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rslastweeke("groupschool")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rse("groupschool"),rslastweeke("groupschool")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg2">어린이</td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rse("groupchild")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rslaste("groupchild")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnPercentFormat(rse("groupchild"),rslaste("groupchild")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rslastweeke("groupchild")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnPercentFormat(rse("groupchild"),rslastweeke("groupchild")) %>
                </td>
              </tr>
              <tr> 
                <td class="list02_bg2">소계</td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rse("grouptotal")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rslaste("grouptotal")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rse("grouptotal"),rslaste("grouptotal")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rslastweeke("grouptotal")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rse("grouptotal"),rslastweeke("grouptotal")) %>
                </td>
              </tr>
              <tr align="center"> 
                <td height="15" colspan="7"><img src="../../enter/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td colspan="2" class="list02_bg2">총계</td>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rse("total")) %>
                </td>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rslaste("total")) %>
                </td>
                <td class="list04_bg2"> 
                  <% =FnPercentFormat(rse("total"),rslaste("total")) %>
                </td>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rslastweeke("total")) %>
                </td>
                <td class="list04_bg2"> 
                  <% =FnPercentFormat(rse("total"),rslastweeke("total")) %>
                </td>
              </tr>
              <tr bgcolor="#B0DFFD" > 
                <td height="10" colspan="7"></td>
              </tr>
            </table>
            <!--실입장객 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td height="30"><img src="../../enter/images/null.gif" width="1" height="30"></td>
        </tr>
        <tr> 
          <td> 
            <!--매표입장객 타이틀 시작-->
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="15" height="11" class="table03"><img src="../../enter/images/yellowgreen_buret.gif" width="7" height="7"></td>
                <td class="title_01">매표 입장객</td>
              </tr>
            </table>
            <!--매표입장객 타이틀 끝-->
          </td>
        </tr>
        <tr> 
          <td height="5"><img src="../../enter/images/null.gif" width="1" height="5"></td>
        </tr>
        <tr> 
          <td> 
            <!--매표입장객 테이블 시작-->
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr class="list02_bg"> 
                <td colspan="2" rowspan="2">구분</td>
                <td rowspan="2" >예측값</td>
                <td colspan="2">동일기준</td>
                <td colspan="2">동요일기준</td>
              </tr>
              <tr class="list03_bg"> 
                <td>전년</td>
                <td>전년비</td>
                <td>전년</td>
                <td>전년비</td>
              </tr>
              <tr > 
                <td rowspan="4" class="list02_bg2">개인</td>
                <td class="list03_bg2">어른</td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rs("indivadult")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rslast("indivadult")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnPercentFormat(rs("indivadult"),rslast("indivadult")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rslastweek("indivadult")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnPercentFormat(rs("indivadult"),rslastweek("indivadult")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">중고생</td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rs("indivschool")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rslast("indivschool")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rs("indivschool"),rslast("indivschool")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rslastweek("indivschool")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rs("indivschool"),rslastweek("indivschool")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg2">어린이</td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rs("indivchild")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rslast("indivchild")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnPercentFormat(rs("indivchild"),rslast("indivchild")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rslastweek("indivchild")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnPercentFormat(rs("indivchild"),rslastweek("indivchild")) %>
                </td>
              </tr>
              <tr> 
                <td class="list02_bg2">소계</td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rs("indivtotal")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rslast("indivtotal")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rs("indivtotal"),rslast("indivtotal")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rslastweek("indivtotal")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rs("indivtotal"),rslastweek("indivtotal")) %>
                </td>
              </tr>
              <tr align="center"> 
                <td height="15" colspan="7"><img src="../../enter/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td rowspan="4" class="list02_bg2">단체</td>
                <td class="list03_bg2">어른</td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rs("groupadult")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rslast("groupadult")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnPercentFormat(rs("groupadult"),rslast("groupadult")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rslastweek("groupadult")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnPercentFormat(rs("groupadult"),rslastweek("groupadult")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">중고생</td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rs("groupschool")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rslast("groupschool")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rs("groupschool"),rslast("groupschool")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rslastweek("groupschool")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rs("groupschool"),rslastweek("groupschool")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg2">어린이</td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rs("groupchild")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rslast("groupchild")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnPercentFormat(rs("groupchild"),rslast("groupchild")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rslastweek("groupchild")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnPercentFormat(rs("groupchild"),rslastweek("groupchild")) %>
                </td>
              </tr>
              <tr> 
                <td class="list02_bg2">소계</td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rs("grouptotal")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rslast("grouptotal")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rs("grouptotal"),rslast("grouptotal")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rslastweek("grouptotal")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rs("grouptotal"),rslastweek("grouptotal")) %>
                </td>
              </tr>
              <tr align="center"> 
                <td height="15" colspan="7"><img src="../../enter/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td colspan="2" class="list02_bg2">총계</td>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rs("total")) %>
                </td>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rslast("total")) %>
                </td>
                <td class="list04_bg2"> 
                  <% =FnPercentFormat(rs("total"),rslast("total")) %>
                </td>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rslastweek("total")) %>
                </td>
                <td class="list04_bg2"> 
                  <% =FnPercentFormat(rs("total"),rslastweek("total")) %>
                </td>
              </tr>
              <tr bgcolor="#B0DFFD" > 
                <td height="10" colspan="7"></td>
              </tr>
            </table>
            <!--매표입장객 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td height="30"></td>
        </tr>
      </table>
	  <!--큰 테이블 끝-->
    </td>
    <td width="49" bgcolor="#FFFFFF"><img src="../../enter/images/null.gif" width="49" height="1"></td>
    <td bgcolor="#a4a4a4"><img src="../../enter/images/outline.gif" width="1" height="1"></td>
  </tr>
  <tr> 
    <td colspan="3" bgcolor="#FFFFFF" align="right" background="../../enter/images/copyright_bg.gif"><img src="../../enter/images/copyright.gif" width="350" height="42"></td>
    <td bgcolor="#a4a4a4" width="1" height="42"><img src="../../enter/images/null.gif"></td>
  </tr>
</table>
</body>
</html>
<!-- #include file="../../enter/script/FnErrorCatch.inc"-->
