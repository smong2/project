<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<%
' ========================================================================================================
' 프로그램ID : TXTRIVAL MONTH
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 경쟁사 예측 - 월
' 최초작성일 : 2002/10/24
' 최종작성일 : 2002/11/13
' 개  발  자 : 박순몽(kweather)
' 사용    DB : txtrivalmonth, txtrivalenter
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim rs,rslast '레코드셋 : 월 예측, 전년 자료

ArrQuery = array()

'변수의 설정
Set objServer = Server.CreateObject("XTEnterRivalMXMTS.clsXTEnterRivalMXNTX")

'컴포넌트 호출 로직의 전개
%>
<!-- #include file="../../enter/script/FnExcelFileName.inc"-->
<%
Response.AddHeader "content-disposition","attachment;filename=rival_month_" & varFileDate & ".xls" 

'컴포넌트 호출
arrRValue = objServer.Query(ArrQuery)
'레코드셋 어레이를 단일 레코드셋으로 분리

'첫번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rs,1
'두번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rslast,2

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
<HTML>
<HEAD>
<meta http-equiv=Content-Type content="text/html; charset=ks_c_5601-1987">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 9">
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<style type="text/css">
.bt_bold01_bg {mso-style-parent:style0; color:#4B4B4B; font-size:9.0pt; font-weight:700;	 text-align:center;  background:lightyellow}
.bt_solid01_bg {mso-style-parent:style0; color:#4B4B4B;	 font-size:9.0pt; text-align:center;  background:lightyellow}
.bt_solid01 {mso-style-parent:style0; color:#000000;	 font-size:9.0pt; text-align:center}
</style>
</HEAD>
<BODY>
<center>
<h2>경쟁사 월 예측</h2><br>
<table border=1>
<tr class="bt_bold01_bg">
<td rowspan=2>날짜<td colspan=3>에버랜드<td colspan=3>서울랜드</td>
<tr class="bt_solid01_bg">
<td>전년실적<td>예측값<td>전년비<td>전년실적<td>예측값<td>전년비
<tr class="bt_solid01">
<% DO UNTIL rs.EOF %>
<td class="bt_solid01"><% =rs("year") %>-<% =rs("month") %>
<td class="bt_solid01"><% =FnNumberFormat(rslast("evertotal")) %>
<td class="bt_solid01"><% =FnNumberFormat(rs("evertotal")) %>
<td class="bt_solid01"><% =FnPercentFormat(rs("evertotal"),rslast("evertotal")) %>
<td class="bt_solid01"><% =FnNumberFormat(rslast("seoultotal")) %>
<td class="bt_solid01"><% =FnNumberFormat(rs("seoultotal")) %>
<Td class="bt_solid01"><% =FnPercentFormat(rs("seoultotal"),rslast("seoultotal")) %>
</tr>
<% rs.MOVENEXT : rslast.MOVENEXT : LOOP %>
</table>
</center>
</BODY>
</HTML>
<!-- #include file="../../enter/script/FnErrorCatch.inc"-->
