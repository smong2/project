<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' 프로그램ID : TODAY_DAY
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 TODAY_DAY
' 최초작성일 : 2002/11/28
' 최종작성일 : 2002/11/28
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
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="24"><img src="../../enter/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
          <td align="left"><img src="../../enter/images/title_today_day.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td> 
            <!--투데이(일) 테이블 시작-->
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr class="list07_bg4"> 
                <td colspan="2">구분</td>
                <td>매표입장객</td>
                <td>실입장객</td>
              </tr>
              <tr> 
                <td width="100" rowspan="4" class="list02_bg2">개인</td>
                <td width="142" class="list03_bg">어른</td>
                <td width="200" class="list01_bg"> 
                  <% =FnNumberFormat(rs("indivadult")) %>
                </td>
                <td width="200" class="list01_bg"> 
                  <% =FnNumberFormat(rse("indivadult")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg2">중고생</td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rs("indivschool")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rse("indivschool")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">어린이</td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rs("indivchild")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rse("indivchild")) %>
                </td>
              </tr>
              <tr> 
                <td class="list02_bg3">소계</td>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rs("indivtotal")) %>
                </td>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rse("indivtotal")) %>
                </td>
              </tr>
              <tr align="center"> 
                <td height="15" colspan="4"><img src="../../enter/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td rowspan="4" class="list02_bg2">단체</td>
                <td class="list03_bg">어른</td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rs("groupadult")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rse("groupadult")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg2">중고생</td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rs("groupschool")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rse("groupschool")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">어린이</td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rs("groupchild")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rse("groupchild")) %>
                </td>
              </tr>
              <tr> 
                <td class="list02_bg3">소계</td>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rs("grouptotal")) %>
                </td>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rse("grouptotal")) %>
                </td>
              </tr>
              <tr align="center"> 
                <td height="15" colspan="4"><img src="../../enter/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td rowspan="4" class="list02_bg2">전체</td>
                <td class="list03_bg">어른</td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(int(FnNumberFormat(rs("indivadult")))+int(FnNumberFormat(rs("groupadult")))) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(int(FnNumberFormat(rse("indivadult")))+int(FnNumberFormat(rse("groupadult")))) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg2">중고생</td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(int(FnNumberFormat(rs("indivschool")))+int(FnNumberFormat(rs("groupschool")))) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(int(FnNumberFormat(rse("indivschool")))+int(FnNumberFormat(rse("groupschool")))) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">어린이</td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(int(FnNumberFormat(rs("indivchild")))+int(FnNumberFormat(rs("groupchild")))) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(int(FnNumberFormat(rse("indivchild")))+int(FnNumberFormat(rse("groupchild")))) %>
                </td>
              </tr>
              <tr> 
                <td class="list02_bg3">소계</td>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(int(FnNumberFormat(rs("indivtotal")))+int(FnNumberFormat(rs("grouptotal")))) %>
                </td>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(int(FnNumberFormat(rse("indivtotal")))+int(FnNumberFormat(rse("grouptotal")))) %>
                </td>
              </tr>
              <tr bgcolor="#B0DFFD"> 
                <td height="10" colspan="4"></td>
              </tr>
            </table>
            <!--투데이(일) 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td height="30"></td>
        </tr>
      </table>
	  <!--큰 테이블 끝-->
    </td>
    <td width="49"><img src="../../enter/images/null.gif" width="49" height="1"></td>
    <td bgcolor="#a4a4a4" height="851"><img src="../../enter/images/outline.gif" width="1" height="1"></td>
  </tr>
  <tr> 
    <td colspan="3" align="right" background="../../enter/images/copyright_bg.gif"><img src="../../enter/images/copyright.gif" width="350" height="42"></td>
    <td bgcolor="#a4a4a4" width="1" height="42"><img src="../../enter/images/null.gif"></td>
  </tr>
</table>
</body>
</html>
<!-- #include file="../../enter/script/FnErrorCatch.inc"-->