<%
' ========================================================================================================
' 프로그램ID : TXBUSER - ID/PASSWORD 찾기
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 입장객 예측 계정 관리 ID/PWD 찾기 프로그램
' 최초작성일 : 2002/10/28
' 최종작성일 : 2002/10/28
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, Arr '컴관련 변수들
Dim rs '계정 확인
dim intI,varInsert '증가변수
Dim varID, varPWD, varTEL, varNAME '사용자 입력값

varinsert=Request.Form("varinsert") 

IF varinsert="ok" THEN
varID=Request.Form("txtEmpId")
varTEL=Request.Form("txtTel")
varNAME=Request.Form("txtName")

ArrQuery = array("Find",varID,"없음",varTEL,varNAME) '페이지에 맞는 코드 가져오고

'변수의 설정
Set objServer  = Server.CreateObject("XBUserUIQMTS.clsXBUserUIQNTX")

'컴포넌트 호출
arrRValue = objServer.Query(ArrQuery)
'레코드셋 어레이를 단일 레코드셋으로 분리

'첫번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rs,1

'자원의 해제
Set objServer = Nothing

IF rs.eof THEN  '잘못 입력한 경우 바로 리디렉트
Response.Redirect "pop_id_find.asp"
END IF
END IF

'에러의 처리
IF Err.Number <> 0 THEN 
	Response.Write Err.Number, Err.Source, Err.Description
	Set objServer = Nothing
	objserver.close
END IF
%>
<!-- #include file="../enter/script/FnProgramProcess.vbs" -->
<html>
<head>
<title>아이디/비밀번호 찾기</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../enter/css/cs_tx.css" type="text/css">
<script language=javascript>
function Fncheck(){
if (document.form.txtNAME.value=="") {
  alert('이름을 입력해주십시오');
  document.form.txtNAME.focus();
  return false;
}
 if (document.form.txtEmpId.value=="") {
 alert('사원번호를 입력해주십시오');
  document.form.txtEmpId.focus();
  return false;
}
 if (document.form.txtTEL.value=="") {
 alert('전화번호를 입력해주십시오');
  document.form.txtTEL.focus();
  return false;
}
}
</script>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" <% IF varinsert<>"ok" THEN %>onload=document.form.txtNAME.focus()<% END If %>>
<form method=post name=form action=pop_id_find.asp onsubmit='return Fncheck()'>
<input type=hidden name=varinsert value=ok>
<table width="346" border="0" cellspacing="0" cellpadding="0" height="249">
  <tr> 
    <td><img src="../enter/images/poptitle_id_find.gif" width="346" height="59"></td>
  </tr>
  <tr> 
    <td height="150" class="table03">
	<!--내용입력 테이블 시작-->
      <table width="255" border="0" cellspacing="0" cellpadding="0">
      <% IF varInsert<>"ok" THEN %>
        <tr> 
          <td height="15"><img src="../enter/images/yellowgreen_buret.gif" width="7" height="7"></td>
          <td width="5"></td>
          <td class="list13">이름</td>
          <td> 
            <input type="text" name="txtNAME" maxlength=15>
          </td>
        </tr>
        <tr> 
          <td colspan="4" height="5"></td>
        </tr>
        <tr> 
          <td height="15"><img src="../enter/images/yellowgreen_buret.gif" width="7" height="7"></td>
          <td width="5"></td>
          <td class="list13">사원번호</td>
          <td> 
            <input type="text" name="txtEmpId" maxlength=20>
          </td>
        </tr>
        <tr> 
          <td colspan="4" height="5"></td>
        </tr>
        <tr> 
          <td height="15"><img src="../enter/images/yellowgreen_buret.gif" width="7" height="7"></td>
          <td width="5"></td>
          <td class="list13">전화번호</td>
          <td> 
            <input type="text" name="txtTEL" maxlength=20>
          </td>
        </tr>
        <tr> 
          <td colspan="4" height="5"></td>
        </tr>
        <% ELSE %>
        <tr> 
          <td height="15"><img src="../enter/images/yellowgreen_buret.gif" width="7" height="7"></td>
          <td width="5"></td>
          <td class="list13">아이디</td>
          <td> 
            <% =rs("ID") %>
          </td>
        </tr>
        <tr> 
          <td colspan="4" height="5"></td>
        </tr>
        <tr> 
          <td height="15"><img src="../enter/images/yellowgreen_buret.gif" width="7" height="7"></td>
          <td width="5"></td>
          <td class="list13">비밀번호</td>
          <td> 
            <% =rs("PASSWORD") %>
          </td>
        </tr>
        <tr> 
          <td colspan="4" height="5"></td>
        </tr>
        <% END IF %>
      </table>
	  <!--내용입력 테이블 끝-->
    </td>
  </tr>
  <tr> 
    <td height="40" class="table02">
	<!--하단 버튼바 시작--> 
      <table width="346" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td align="right">
          <% IF varInsert="ok" THEN %>
          <img src="../enter/images/confirm_bu.gif" width="53" height="26" border="0" onclick=window.close()>
          <% ELSE %>
          <input type=image src="../enter/images/confirm_bu.gif" width="53" height="26" border="0"></td>
          <% END IF %>
          <td width="15"></td>
        </tr>
      </table>
	  <!--하단 버튼바 끝-->
    </td>
  </tr>
</table>
</form>
</body>
</html>
