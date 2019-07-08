<!-- #include file="../../enter/script/FnLoginAuth_admin.inc" -->
<%
' ========================================================================================================
' 프로그램ID : Admin_orgReservation
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 예약정보입력 - 일입력
' 최초작성일 : 2003/01/03
' 최종작성일 : 2003/01/03
' 개  발  자 : 박순몽(kweather)
' ======================================================================================================== 

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim varview, varinsert '폼 변수
Dim txtAdult, txtSchool, txtChild '입력 변수
Dim intYear, intMonth, intDay '날짜 변수
Dim rs '레코드셋 조회
Dim intI

varview=Request.QueryString("varview")
varinsert=Request.Form("varinsert")

IF varInsert="ok" THEN  '폼으로 넘어왔다면
intYear=Request.Form("sltYear")
intMonth=Request.Form("sltMonth")
intDay=Request.Form("sltDay")
txtAdult=Request.Form("txtAdult")
txtSchool=Request.Form("txtSchool")
txtChild=Request.Form("txtChild")

ArrQuery=array("Insert",intYear,intMonth,intDay, txtAdult, txtSchool, txtChild)

'변수의 설정
Set objServer = Server.CreateObject("XTReservationIMTS.clsXTReservationITX")

'컴포넌트 호출
arrRValue = objServer.save(ArrQuery)

'자원의 해제
Set objServer = Nothing

END IF

IF varview="ok" THEN '쿼리스트링으로 넘어왔다면
intYear=Request.QueryString("sltyear")
intMonth=Request.QueryString("sltMonth")
intDay=Request.QueryString("sltDay")

ArrQuery=array("View",intYear,intMonth,intDay)

'변수의 설정
Set objServer = Server.CreateObject("XTReservationIMTS.clsXTReservationINTX")

'컴포넌트 호출
arrRValue = objServer.Query(ArrQuery)

'첫번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rs,1

'자원의 해제
Set objServer = Nothing
END IF

'에러의 처리
IF Err.Number <> 0 THEN 
	Response.Write Err.Number, Err.Source, Err.Description
	Set objServer = Nothing
	objserver.close
END IF
%>
<!-- #include file="../../enter/script/FnProgramProcess.vbs" -->
<html>
<head>
<title>롯데월드 수요예측시스템</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../../enter/css/cs_tx.css" type="text/css">
<script language=javascript src="../../enter/script/FnadminreservationI.js"></script>
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload=document.form.txtAdult.focus()>
<form method=post action=admin_results_reservation.asp name=form onsubmit='return Fncheck()'>
<input type=hidden name=varinsert value=ok>
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
  <tr> 
    <td width="49"><img src="../../enter/images/null.gif" width="49" height="1"></td>
    <td width="642" valign="top">
	<!--큰 테이블 시작--> 
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="../../enter/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
          <td><img src="../../enter/images/title_results_reservation.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
    <td class="title_01_r"><img src="../../enter/images/yellowgreen_buret.gif" width="7" height="7"> 
      입력일자 
      <select name="sltYear">
		<option>----</option>
      <% For intI=2002 TO 2030 %>
		<% IF intYear-intI=0 THEN %>
		<option selected value=<% =intI %>><% =intI %>년</option>
		<% ELSE %>
        <option value=<% =intI %>><% =intI %>년</option>
        <% END IF %>
      <% NEXT %>
      </select>
      <select name="sltMonth">
        <option>----</option>
      <% For intI=1 TO 12 %>
        <% IF intMonth-intI=0 THEN %>
		<option  selected value=<% =intI %>><% =intI %>월</option>
		<% ELSE %>
        <option value=<% =intI %>><% =intI %>월</option>
        <% END IF %>
      <% NEXT %>
      </select>
      <select name="sltDay" onchange=FnDate()>
		<option>----</option>
      <% For intI=1 TO 31 %>            
        <% IF intDay-intI=0 THEN %>
		<option  selected value=<% =intI %>><% =intI %>일</option>
		<% ELSE %>
        <option value=<% =intI %>><% =intI %>일</option>
        <% END IF %>
      <% NEXT %>
      </select>
    </td>
        </tr>
        <tr> 
          <td height="7"></td>
        </tr>
        <tr> 
          <td> 
            <!--입력 테이블 시작-->
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr bgcolor="#B0DFFD"> 
                <td height="7" colspan="2"></td>
              </tr>
              <tr class="list02_bg2"> 
                <td width="200">항목</td>
                <td>입력</td>
              </tr>
              <tr> 
                <td class="list13_bg">어른</td>
                <td class="table01"> 
                  <input type="text" name="txtAdult" size="65" maxlength=70 value=<% IF varview="ok" THEN Response.Write rs("Adult") %>>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">중고생</td>
                <td class="table01"> 
                  <input type="text" name="txtSchool" size="65" maxlength=70 value=<% IF varview="ok" THEN Response.Write rs("School") %>>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">어린이</td>
                <td class="table01"> 
                  <input type="text" name="txtChild" size="65" maxlength=70 value=<% IF varview="ok" THEN Response.Write rs("Child") %>>
                </td>
              </tr>
              <tr bgcolor="#B0DFFD"> 
                <td height="7" colspan="2"></td>
              </tr>
            </table>
            <!--입력 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td height="10"></td>
        </tr>
        <tr> 
          <td height="34" class="table02"> 
            <!--하단 버튼바 시작-->
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td align="right"><input type=image src="../../enter/images/save.gif" width="53" height="26" border="0"></td>
                <td width="5"></td>
              </tr>
            </table>
            <!--하단 버튼바 끝-->
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
</form>
</body>
</html>
