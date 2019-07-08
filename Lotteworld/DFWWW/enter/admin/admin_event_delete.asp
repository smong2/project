<!-- #include file="../../enter/script/FnLoginAuth_admin.inc" -->
<% 
' ========================================================================================================
' 프로그램ID : TXBBULLETIN - delete
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 행사 삭제
' 최초작성일 : 2002/10/16
' 최종작성일 : 2002/10/18
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim intIdx '글번호
DIM txtcode '어떤 페이지에서 지우는 명령을 내렸는지 확인

intIdx=Request.QueryString("intIdx")
txtcode=Request.QueryString("code")


ArrQuery = array("delete","없음",intIdx,"없음","없음") '글번호에 해당되는 레코드 삭제

'변수의 설정
Set objServer = Server.CreateObject("XBbulletinUIQMTS.clsXBbulletinUIQTX")

'컴포넌트 호출
arrRValue = objServer.save(ArrQuery)
'레코드셋 어레이를 단일 레코드셋으로 분리

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
<%
IF txtcode="seoul" THEN
Response.Redirect "admin_event_seoul.asp"  '페이지 이동
ELSEIF txtcode="ever" THEN
Response.Redirect "admin_event_ever.asp"  '페이지 이동
ELSE
Response.Redirect "admin_event_lotte.asp"  '페이지 이동
END IF
%>
<!-- #include file="../../enter/script/FnErrorCatch.inc"-->