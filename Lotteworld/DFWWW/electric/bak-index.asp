<%
' ========================================================================================================
' 프로그램ID : TXERESULTSCONSTRUCTION
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 전기 로그인
' 최초작성일 : 2002/12/10
' 최종작성일 : 2002/12/10
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, arrRvalueQ, ArrQuery, ArrQueryQ, Arr '컴관련 변수들
Dim rs, rsfirst, rsidlist '레코드셋 : 계정확인, 처음방문했는지 확인, 수요예측 계정 리스트 조회
dim intI,varInsert '증가변수
Dim VarId, VarPwd '입력값

varinsert=Request.Form("varinsert") 

IF varinsert="ok" THEN '확인 버튼을 클릭했을 경우
varID=Request.Form("txtID")
varPWD=Request.Form("txtPWD") 

ArrQuery = array("ELOGIN",varID,varPWD) '페이지에 맞는 코드 가져오고

'변수의 설정
Set objServer  = Server.CreateObject("XBUserUIQMTS.clsXBUserUIQNTX")

'컴포넌트 호출
arrRValue = objServer.Query(ArrQuery)
'레코드셋 어레이를 단일 레코드셋으로 분리

'첫번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rs,1
'첫번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rsfirst,2
'첫번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rsidlist,3

'자원의 해제
Set objServer = Nothing

IF rs.eof THEN   '로그인시 계정이 없다면 
	IF NOT rsidlist.eof AND rsfirst.eof THEN   '로컬에 아이디 리스트가 있지만 비밀번호가 틀렸을경우
		Response.Write "<script language=javascript>alert(' 비밀번호가 틀렸습니다. 기억이 나지 않으시면 아래 비밀번호 찾기를 이용해주십시오 ')</script>"
		Response.Write "<script language=javascript>history.go(-1)</script>"
		
	ELSEIF rsidlist.eof AND rsfirst.eof THEN  '아이디 리스트도 없고 erp 계정 로그인도 아닌 경우
		Response.Write "계정이 없습니다."
		Response.Write "<script language=javascript>alert(' 계정이 없습니다. \n\n ID:사원번호, PWD:주민번호 \n\n 로 로그인하시고 비밀번호를 발급받으십시오')</script>"
		Response.Write "<script language=javascript>history.go(-1)</script>"		'뒤로 가기 스크립트
	END IF		

ELSE '로그인 성공시  
  
  '쿠키 생성
  Response.Cookies("ckTime")=right(Year(DATE()),2)&"년"& Month(Date()) & "월"&Day(date()) & "일 "& Hour(time()) &"시"& minute(time())&"분" '시간 쿠키
  Response.Cookies("ckID")=rs("ID")  '아이디 쿠키
  Response.Cookies("ckNAME")=rs("NAME") '이름 쿠키
  Response.Cookies("ckAuthlevel")=rs("Authlevel") '권한 쿠키
  Response.cookies("ckConnecttimes")=rs("Connecttimes") '접속횟수 쿠기
  Response.Cookies("cklastconnecttime")=rs("Lastconnecttime") '접속시각 쿠키
  
  Response.Write "<script language=javascript>alert(' " & Request.Cookies("ckID") & "님 환영합니다\n " & Request.Cookies("ckconnecttimes") & "번째 방문입니다 ')</script>"  
  Response.Write "<script language=javascript>location.replace('frame.asp')</script>"	'뒤로 가기 스크립트  
END IF 
 
IF NOT rsidlist.eof AND NOT rsfirst.eof THEN  '아이디 리스트에 등록했으면서 erp 계정 로그인을 할 경우
  Response.Write "<script language=javascript>alert(' 비밀번호를 이미 발급받으셨습니다. 발급받은 비밀번호를 사용해주십시오 ')</script>"
  Response.Write "<script language=javascript>history.go(-1)</script>"
ENd IF  

IF NOT rsfirst.eof THEN	 '처음 방문했을 경우
  Response.Write "<script language=javascript>alert('" & rsfirst(1) & "님 처음으로 오셨군요. 비밀번호를 발급받으십시오 ')</script>"'처음으로 로그인 했을경우 erp 계정으로..
  Response.Write "<script language=javascript>location.href('../electric/admin/admin_acnt_add.asp?varID=" & rsfirst(0) & "&varNAME=" & rsfirst(1) & "')</script>"
END IF

END IF

'에러의 처리
IF Err.Number <> 0 THEN 
	Response.Write Err.Number, Err.Source, Err.Description
	Set objServer = Nothing
	objserver.close
END IF
%>	
<!-- #include file="../electric/script/FnProgramProcess.vbs" -->
<html>
<head>
<title>로그인</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../electric/css/cs_te.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000" background="../electric/images/bg.gif" onload=document.form.txtID.focus()>
<form name=form method=post action=index.asp>
<input type=hidden name=varinsert value=ok>
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <tr>
    <td class="table03">
	<!--로그인 테이블 시작-->
      <table width="496" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td>
		  <!--로그인 테두리 시작-->
            <table width="496" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><img src="../electric/images/login_round_edge1.gif" width="23" height="23"></td>
                <td><img src="../electric/images/login_round_top.gif" width="450" height="23"></td>
                <td><img src="../electric/images/login_round_edge2.gif" width="23" height="23"></td>
              </tr>
              <tr>
                <td><img src="../electric/images/login_round_left.gif" width="23" height="269"></td>
                <td>
				<!--로그인 내용 테이블 시작-->
                  <table width="450" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td><img src="../electric/images/login_main_img.gif" width="450" height="104"></td>
                    </tr>
                    <tr>
                        <td bgcolor="#E6E6E6" height="135" class="table03"> 
                          <!--아이디/패스워드 입력 테이블 시작-->
                          <table width="308" border="0" cellspacing="0" cellpadding="0">
                            <tr> 
                              <td> 
                                <table width="231" border="0" cellspacing="0" cellpadding="0">
                                  <tr> 
                                    <td width="85"><img src="../enter/images/login_id.gif" width="79" height="19"></td>
                                    <td width="152" align="center"> 
                                      <input type="text" name="txtID" size="13" tabindex=1>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td colspan="2"><img src="../enter/images/null.gif" width="1" height="10"></td>
                                  </tr>
                                  <tr> 
                                    <td width="79"><img src="../enter/images/login_password.gif" width="79" height="19"></td>
                                    <td width="152" align="center"> 
                                      <input type="password" name="txtPWD" size="13" tabindex=2>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td> 
                                <!--확인/취소 버튼 시작-->
                                <table width="98" border="0" cellspacing="0" cellpadding="0">
                                  <tr> 
                                    <td class="table03"> 
                                      <input type=image src="../enter/images/login_confirm_button.gif" width="46" height="46" border="0" name="image">
                                    </td>
                                    <td width="6"></td>
                                    <td class="table03">
                                    <img src="../enter/images/login_cancel_button.gif" width="46" height="46" border="0" onClick=history.go(-1)></td>
                                  </tr>
                                </table>
                                <!--확인/취소 버튼 끝-->
                              </td>
                            </tr>
                          </table>
                          <!--아이디/패스워드 입력 테이블 끝-->
                      </td>
                    </tr>
                    <tr>
                      <td><img src="../electric/images/login_line_img.gif" width="450" height="1"></td>
                    </tr>
                    <tr>
                      <td bgcolor="#E6E6E6" height="29">
					  <!--아이디/패스워드 확인 시작-->
                        <table width="450" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td width="307"></td>
                            <td width="23" align="center"><img src="../electric/images/login_arrow_icon.gif" width="13" height="13"></td>
                            <td width="120" class="list09"><a href="#"  onclick="window.open('../enter/pop_id_find.asp','idfind','width=346,height=249,left=100,top=200')">ID/Password 확인</a></td>
                          </tr>
                        </table>
						<!--아이디/패스워드 확인 끝-->
                      </td>
                    </tr>
                  </table>
				  <!--로그인 내용 테이블 끝-->
                </td>
                <td><img src="../electric/images/login_round_right.gif" width="23" height="269"></td>
              </tr>
              <tr>
                <td><img src="../electric/images/login_round_edge3.gif" width="23" height="23"></td>
                <td><img src="../electric/images/login_round_bottom.gif" width="450" height="23"></td>
                <td><img src="../electric/images/login_round_edge4.gif" width="23" height="23"></td>
              </tr>
            </table>
			<!--로그인 테두리 끝-->
          </td>
        </tr>
      </table>
	  <!--로그인 테이블 끝-->
    </td>
  </tr>
</table>
</form></body>
</html>
