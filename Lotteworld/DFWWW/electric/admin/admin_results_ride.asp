<!-- #include file="../../electric/script/FnLoginAuth.inc" -->
<%
' ========================================================================================================
' 프로그램ID : TXERIDE
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 전기 라이드 이력 - 입력
' 최초작성일 : 2002/11/27
' 최종작성일 : 2002/11/27
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer,arrRValue, ArrQuery, Arr '컴관련 변수들
Dim rs '레코드셋 (라이드형식 목록)
dim intI,varInsert '증가변수,폼변수
Dim intInput_Year,intInput_Month,intInput_Day '년,월,일
Dim dtInput_Date '날자
Dim varRideName, varExamRide '라이드 명, 유사라이드

varInsert=Request.Form("varInsert")

varRideName=Request.Form("txtRideName")
intInput_Year=Request.Form("sltInput_Year")
intInput_Month=Request.Form("sltInput_Month")
intInput_Day=Request.Form("sltInput_Day")
dtInput_Date=dateserial(intInput_Year,intInput_Month,intInput_Day)
varExamRide=Request.Form("sltExamRide")

ArrQuery = array(varInsert,dtInput_Date,varRideName,varExamRide) '페이지에 맞는 코드 가져오고

IF varInsert="ok" THEN '입력모드라면 실행
Set objServer = Server.CreateObject("XEERideInputIMTS.clsXEERideInputITX")
arrRValue = objServerI.save(ArrQuery)

'자원의 해제
Set objServer = Nothing
END IF

'변수의 설정
Set objServer = Server.CreateObject("XEERideInputIMTS.clsXEERideInputINTX")

'컴포넌트 호출
arrRValue = objServer.Query(ArrQuery)
'레코드셋 어레이를 단일 레코드셋으로 분리

'첫번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rs,1

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
<html>
<head>
<title>롯데월드 수요예측시스템</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../../electric/css/cs_te.css" type="text/css">
<script>
function fncheck() {
if(document.form.txtRideName.value=="") {
alert("라이드명을 입력해주십시오");
document.form.txtRideName.focus();
return false;
}
if(confirm("전송하시겠습니까?")) 
   return true;
  else	
   return false;
}
</script>
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload=document.form.txtRideName.focus()>
<form method=post name=form action=admin_results_ride.asp onsubmit='return fncheck()'>
<input type=hidden name=varInsert value=ok>
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
  <tr> 
    <td width="49"><img src="../../electric/images/null.gif" width="49" height="1"></td>
    <td width="642" valign="top"> 
	<!--큰 테이블 시작-->
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td colspan="2"><img src="../../electric/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
          <td colspan="2"><img src="../../electric/images/title_results_ride.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="40" valign="top" colspan="2"><img src="../../electric/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td align="right">
		  <!--입력선택 시작--> 
            <table width="410" border="0" cellspacing="0" cellpadding="0" class="title_01">
              <tr> 
                <td width="157" valign="bottom"><img src="../../electric/images/yellowgreen_buret.gif" width="7" height="7"> 
                 입력 : 라이드이력등록</td>
                <td width="253" class="table05"></td>
              </tr>
            </table>
			<!--입력선택 끝-->
          </td>
        </tr>
        <tr> 
          <td height="7" colspan="2"></td>
        </tr>
        <tr> 
          <td colspan="2"> 
		  <!--입력 테이블 시작-->
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr bgcolor="#CECFF5"> 
                <td height="7" colspan="2"></td>
              </tr>
              <tr class="list07_bg"> 
                <td width="120">목록</td>
                <td>입력값</td>
              </tr>
              <tr> 
                <td class="list13_bg">라이드명</td>
                <td class="table01"> 
                  <input type="text" name="txtRideName" size="65" maxlength=70>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">라이드시작일</td>
                <td class="table01"> 
                 <select name=sltInput_Year>
                        <% FOR intI=2002 to 2010 %>
                        <% if intI=year(date()) then %>
                          <option selected value=<% =intI %>><% =intI %>년</option>
                        <% else %>
                          <option value=<% =intI %>><% =intI %>년</option>
                        <% end if : next %>                        
                        </select>
                        <select name="sltInput_Month">
                        <% FOR intI=1 to 12 %>
                        <% if intI=month(date()) then %>
                          <option selected value=<% =intI %>><% =intI %>월</option>
                        <% else %>
                          <option value=<% =intI %>><% =intI %>월</option>                        
                        <% end if :next %>
                        </select>
                        <select name="sltInput_Day">
                        <% FOR intI=1 to 31 %>
                        <% if intI=day(date()) then %>
                          <option selected value=<% =intI %>><% =intI %>일</option>
                        <% else %>
                          <option value=<% =intI %>><% =intI %>일</option>                          
                        <% end if :next %>
                        </select>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">유사라이드</td>
                <td class="table01"> 
                  <select name="sltExamRide">
                   <% do until rs.eof %>
                   <option value=<% =rs("ridetype") %>><% =rs("examride") %></option>                          
                   <% rs.movenext : loop %>    
                   </select>
                </td>
              </tr>
              <tr bgcolor="#CECFF5"> 
                <td height="7" colspan="2"></td>
              </tr>
            </table>
			<!--입력 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td height="10" colspan="2"></td>
        </tr>
        <tr> 
          <td height="34" colspan="2" class="table02">
		  <!--하단 버튼바 시작--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td align="right"><input type=image src="../../electric/images/save.gif" width="53" height="26" border="0"></td>
                <td width="5"></td>
              </tr>
            </table>
			<!--하단 버튼바 끝-->
          </td>
        </tr>
        <tr> 
          <td height="30" colspan="2"></td>
        </tr>
      </table>
	  <!--큰 테이블 끝-->
    </td>
    <td width="49"><img src="../../electric/images/null.gif" width="1" height="1"></td>
    <td bgcolor="#a4a4a4"><img src="../../electric/images/outline.gif" width="1" height="1"></td>
  </tr>
  <tr> 
    <td height="42" colspan="3" align="right" background="../../electric/images/copyright_bg.gif"><img src="../../electric/images/copyright.gif" width="350" height="42"></td>
    <td bgcolor="#a4a4a4" width="1" height="42"><img src="../../electric/images/null.gif" width="1" height="1"></td>
  </tr>
</table>
</form>
</body>
</html>
<!-- #include file="../../electric/script/FnErrorCatch.inc" -->