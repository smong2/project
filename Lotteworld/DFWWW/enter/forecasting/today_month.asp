<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' 프로그램ID : today month
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 입장객 예측 - today month
' 최초작성일 : 2002/10/16
' 최종작성일 : 2002/10/18
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim rsvxt, rsvxte '레코드셋 : 매표입장 예측, 실입장 예측

ArrQuery = array()

'변수의 설정
Set objServer = Server.CreateObject("XTTodayMonthMTS.clsXTTodayMonthNTX")

'컴포넌트 호출 로직의 전개
' ...

'컴포넌트 호출
arrRValue = objServer.Query(ArrQuery)
'레코드셋 어레이를 단일 레코드셋으로 분리

'첫번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rsvxt,1
'두번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rsvxte,2

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
<!-- #include file="../../enter/script/fnnumber_format.inc" -->
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
          <td align="left"><img src="../../enter/images/title_today_month.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--투데이(월) 테이블 시작--> 
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr class="list02_bg"> 
                <td colspan="2">구분</td>
                <td>매표입장객</td>
                <td>실입장객</td>
              </tr>
              <tr> 
                <td width="100" rowspan="4" class="list02_bg2">개인</td>
                <td width="142" class="list03_bg">어른</td>
                <td width="200" class="list01_bg"><% =FnNumberFormat(rsvxt("indivadult")) %></td>
                <td width="200" class="list01_bg"><% =FnNumberFormat(rsvxte("indivadult")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg2">중고생</td>
                <td class="list01_bg2"><% =FnNumberFormat(rsvxt("indivschool")) %></td>
                <td class="list01_bg2"><% =FnNumberFormat(rsvxte("indivschool")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg">어린이</td>
                <td class="list01_bg"><% =FnNumberFormat(rsvxt("indivchild")) %></td>
                <td class="list01_bg"><% =FnNumberFormat(rsvxte("indivchild")) %></td>
              </tr>
              <tr> 
                <td class="list02_bg3">소계</td>
                <td class="list04_bg2"><% =FnNumberFormat(rsvxt("indivtotal")) %></td>
                <td class="list04_bg2"><% =FnNumberFormat(rsvxte("indivtotal")) %></td>
              </tr>
              <tr align="center"> 
                <td colspan="4"><img src="../../enter/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td rowspan="4" class="list02_bg2">단체</td>
                <td class="list03_bg">어른</td>
                <td class="list01_bg"><% =FnNumberFormat(rsvxt("groupadult")) %></td>
                <td class="list01_bg"><% =FnNumberFormat(rsvxte("groupadult")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg2">중고생</td>
                <td class="list01_bg2"><% =FnNumberFormat(rsvxt("groupschool")) %></td>
                <td class="list01_bg2"><% =FnNumberFormat(rsvxte("groupschool")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg">어린이</td>
                <td class="list01_bg"><% =FnNumberFormat(rsvxt("groupchild")) %></td>
                <td class="list01_bg"><% =FnNumberFormat(rsvxte("groupchild")) %></td>
              </tr>
              <tr> 
                <td class="list02_bg3">소계</td>
                <td class="list04_bg2"><% =FnNumberFormat(rsvxt("grouptotal")) %></td>
                <td class="list04_bg2"><% =FnNumberFormat(rsvxte("grouptotal")) %></td>
              </tr>
              <tr align="center"> 
                <td colspan="4"><img src="../../enter/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td rowspan="4" class="list02_bg2">전체</td>
                <td class="list03_bg">어른</td>
                <td class="list01_bg"><% =FnNumberFormat(rsvxt("adult")) %></td>
                <td class="list01_bg"><% =FnNumberFormat(rsvxte("adult")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg2">중고생</td>
                <td class="list01_bg2"><% =FnNumberFormat(rsvxt("school")) %></td>
                <td class="list01_bg2"><% =FnNumberFormat(rsvxte("school")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg">어린이</td>
                <td class="list01_bg"><% =FnNumberFormat(rsvxt("child"))%></td>
                <td class="list01_bg"><% =FnNumberFormat(rsvxte("child")) %></td>
              </tr>
              <tr> 
                <td class="list02_bg3">소계</td>
                <td class="list04_bg2"><% =FnNumberFormat(rsvxt("total")) %></td>
                <td class="list04_bg2"><% =FnNumberFormat(rsvxte("total")) %></td>
              </tr>
              <tr bgcolor="#B0DFFD"> 
                <td height="10" colspan="4"></td>
              </tr>
            </table>
			<!--투데이(월) 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td height="30"><img src="../../enter/images/null.gif" width="1" height="30"></td>
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