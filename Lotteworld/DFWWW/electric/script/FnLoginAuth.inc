<%
' ========================================================================================================
' 프로그램ID : LogAuthscript
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 사용자 권한 및 계정 쿠키 - 전기
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

DIM varTime, varID, varName, varLastConnectTime, varAuthlevel, varConnectTimes '아이디, 이름, 최종접속시각, 권한, 접속횟수

varTime=Request.Cookies("ckTime") '접속 시간 쿠키
varId=Request.Cookies("ckID")
varName=Request.Cookies("ckNAME")
varLastConnectTime=Request.Cookies("ckLastConnectTime")
varConnectTimes=Request.Cookies("ckConnectTimes")
varAuthLevel=Request.Cookies("ckAuthlevel")

IF varID="" THEN
response.write "<script>alert('로그인 하지 않으셨습니다')</script>"
response.write "<script>top.location.replace('http://lwdfs/electric/index.asp')</script>"
END IF

IF VarAuthLevel<>3 AND VarAuthLevel<>4 AND VarAuthLevel<>7 THEN  '등급이 맞지 않는 경우는 접근 불가
response.write "<script>alert('권한이 있는지 확인하십시오')</script>"
response.write "<script>top.location.replace('http://lwdfs/electric/index.asp')</script>"
END IF
%>