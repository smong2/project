<%
' ========================================================================================================
' 프로그램ID : TXB USER
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 로그인 계정 추가
' 최초작성일 : 2002/12/11
' 최종작성일 : 2002/12/11
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================
Option Explicit
'에러 설치
On Error Resume NEXT
'변수의 선언

Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
dim intI,varInsert '증가변수
Dim VarId, VarName, varPWD, varDEPT, varTEL, varMOBILE '사용자 입력값
DIM VarAuthLevel

varID=Request("varID")
varPwd=Request("varPwd")
varInsert=Request("varInsert")


IF VarId<>"adminadd" AND VarPwd<>"rhksfl" THEN
Response.Write "<script language=javascript>alert(' 정상적인 방법으로 로그인하십시오 ')</script>"
Response.Write "<script language=javascript>history.go(-1)</script>" 
END IF


IF varInsert="ok" THEN '저장버튼을 누르면.
varID=Request.Form("txtID")
varNAME=Request.Form("txtNAME")
varPWD=Request.Form("txtPWD")
varDEPT=Request.Form("txtDEPT")
varAUTHLEVEL=Request.Form("txtAUTHLEVEL")
varTEL=Request.Form("txtTEL")
varMOBILE=Request.Form("txtMOBILE")

ArrQuery = array("first",varID,varNAME,varPWD,"없음",varTEL,varMOBILE,varDEPT,varAUTHLEVEL) '페이지에 맞는 코드 가져오고

'변수의 설정
Set objServer  = Server.CreateObject("XBUserUIQMTS.clsXBUserUIQTX")

'컴포넌트 호출
arrRValue = objServer.save(ArrQuery)

'자원의 해제
Set objServer = Nothing

Response.Write "<script language=javascript>alert(' 계정이 생성되었습니다. \n 생성된 계정으로 로그인하십시오')</script>"
Response.Write "<script language=javascript>location.href('../../electric/index.asp')</script>"
END IF

'에러의 처리
IF Err.Number <> 0 THEN 
	Response.Write Err.Number, Err.Source, Err.Description
	Set objServer = Nothing
	objserver.close
END IF
%>
<html>
<head>
<title>롯데월드 수요예측시스템</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../../electric/css/cs_te.css" type="text/css">
<script language=javascript src=../../electric/script/FnAdminAcntAdd.js></script>
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload=document.form.txtName.focus()>
<form method=post name=form action=admin_acnt_add.asp onsubmit='return FnCheck()'>
<input type=hidden name=varInsert value=ok>
<input type=hidden name=varid value=adminadd>
<input type=hidden name=varpwd value=rhksfl>
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
  <tr> 
    <td width="49"><img src="../../electric/images/null.gif" width="49" height="1"></td>
    <td width="642" valign="top">
	<!--큰 테이블 시작--> 
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="../../electric/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
          <td><img src="../../electric/images/title_admin_acnt.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../electric/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--타이틀 시작--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="15" height="11" class="table03"><img src="../../electric/images/orange_buret.gif" width="7" height="7"></td>
                <td class="title_01">계정 추가</td>
              </tr>
            </table>
			<!--타이틀 끝-->
          </td>
        </tr>
        <tr> 
          <td><img src="../../electric/images/null.gif" width="1" height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--계정추가 테이블 시작--> 
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr bgcolor="#CECFF5"> 
                <td height="7" colspan="2"></td>
              </tr>
              <tr> 
                <td width="100" class="list13_bg">이름</td>
                <td class="table01">
                  <input type="text" name="txtName" size="20" maxlength=12>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">아이디</td>
                <td class="table01">
                  <input type="text" name="txtID" size="20">
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">비밀번호</td>
                <td class="table01">
                  <input type="text" name="txtPWD" size="20" maxlength=8>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">부서</td>
                <td class="table01">
                  <input type="text" name="txtDEPT" size="20" maxlength=15>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">등급</td>
                <td class="table01">
				<SELECT name="txtAuthlevel">
				<option value=3>전기 일반</option>
				<option value=4>전기 관리</option>
                </select>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">전화</td>
                <td class="table01">
                  <input type="text" name="txtTel" size="20" maxlength=20>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">핸드폰</td>
                <td class="table01">
                  <input type="text" name="txtMobile" size="20" maxlength=20>
                </td>
              </tr>
              <tr bgcolor="#CECFF5">
                <td height="7" colspan="2"></td>
              </tr>
            </table>
			<!--계정추가 테이블 끝-->
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
			    <td width="498"></td>
			    <td><input type=image src="../../electric/images/add_bu.gif" width="53" height="26" border="0"></td>
			    <td width="10"></td>
                <td><img src="../../electric/images/return_bu.gif" width="76" height="26" border="0" onclick=history.go(-1)></td>
                <td width="5"></td>
              </tr>
            </table>
			<!--하단 버튼바 시작-->
			</td>
			</tr>
			<tr> 
          <td height="30"></td>
        </tr>
      </table>
	  <!--큰 테이블 끝-->
    </td>
    <td width="49"><img src="../../electric/images/null.gif" width="49" height="1"></td>
    <td bgcolor="#a4a4a4"><img src="../../electric/images/outline.gif" width="1" height="1"></td>
  </tr>
  <tr> 
    <td height="42" colspan="3" align="right" background="../../electric/images/copyright_bg.gif"><img src="../../electric/images/copyright.gif" width="350" height="42"></td>
    <td bgcolor="#a4a4a4" width="1" height="42"><img src="../../electric/images/null.gif"></td>
  </tr>
</table>
</form>
</body>
</html>
<!-- #include file="../../electric/script/FnErrorCatch.inc" -->