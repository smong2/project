<%
' ========================================================================================================
' 프로그램ID : LogAuthscript
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 사용자 권한 및 계정 쿠키 -입장객 관리자 페이지
' 최초작성일 : 2002/12/11
' 최종작성일 : 2002/12/11
' 개  발  자 : 박순몽(kweather)
' 사용    DB : 없음
' ========================================================================================================

'페이지 속성의 설정
'Response.Expire = 0
Option Explicit
'에러 설치
On Error Resume NEXT

DIM varID, varName, varLastConnectTime, varAuthlevel, varConnectTimes '아이디, 이름, 최종접속시각, 권한, 접속횟수

varId=Request.Cookies("ckID")
varName=Request.Cookies("ckNAME")
varLastConnectTime=Request.Cookies("ckLastConnectTime")
varConnectTimes=Request.Cookies("ckConnectTimes")
varAuthLevel=Request.Cookies("ckAuthlevel")

IF varID="" THEN
response.write "<script>alert('로그인 하지 않으셨습니다')</script>"
response.write "<script>top.location.replace('http://lwdfs/enter/index.asp')</script>"
END IF

IF VarAuthLevel<>2 AND VarAuthLevel<>7 THEN  '등급이 맞지 않는 경우는 접근 불가
response.write "<script>alert('관리자만 접근할 수 있습니다');history.go(-1)</script>"
END IF
%>