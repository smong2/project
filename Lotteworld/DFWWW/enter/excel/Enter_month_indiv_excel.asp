<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<%
' ========================================================================================================
' 프로그램ID : Enter_Month_Indiv_Excel
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 입장객 예측 - 월-개인 엑셀 출력
' 최초작성일 : 2002/10/30
' 최종작성일 : 2002/11/21
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim rslast, rs '레코드셋 : 전년동월 실적, 예측값
dim varEnterType '입장객 모형
dim varFile,varFileDate '엑셀 파일 이름 결정

varEnterType=Request.QueryString("varEnterType") '입장객 모형

ArrQuery = array(varEnterType,"indiv") '쿼리 변수

'변수의 설정
Set objServer = Server.CreateObject("XTEnterMonXlsMTS.clsXTEnterMonthXlsNTX")

'컴포넌트 호출 로직의 전개
%>
<!-- #include file="../../enter/script/FnExcelFileName.inc"-->
<%
Response.AddHeader "content-disposition","attachment;filename=" & varFile & "_month_indiv_" & varFileDate & ".xls"

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
<% IF varEnterType="vxt" THEN %>
<h2>매표입장 월 개인</h2><br>
<% ELSE %>
<h2>실입장 월 개인</h2><br>
<% END IF %>
<table border=1>
<tr class="bt_bold01_bg">
<td rowspan=2>날짜
<td colspan=3 align=middle>전체
<td colspan=3 align=middle>어른
<td colspan=3 align=middle>중고생
<td colspan=3 align=middle>어린이
<tr class="bt_solid01_bg">
<td>예측값
<td>전년동월
<td>전년비
<td>예측값
<td>전년동월
<td>전년비
<td>예측값
<td>전년동월
<td>전년비
<td>예측값
<td>전년동월
<td>전년비

<% DO UNTIL rs.EOF %>
<tr class="bt_solid01">
<td><% =rs("year") %>-<%=rs("month") %>
<td><% =FnNumberFormat(rs("indivtotal")) %>
<td><% =FnNumberFormat(rslast("indivtotal")) %>
<td><% =FnPercentFormat(rs("indivtotal"),rslast("indivtotal")) %>
<td><% =FnNumberFormat(rs("indivadult")) %>
<td><% =FnNumberFormat(rslast("indivadult")) %>
<td><% =FnPercentFormat(rs("indivadult"),rslast("indivadult")) %>
<td><% =FnNumberFormat(rs("indivschool")) %>
<td><% =FnNumberFormat(rslast("indivschool")) %>
<td><% =FnPercentFormat(rs("indivschool"),rslast("indivschool")) %>
<td><% =FnNumberFormat(rs("indivchild")) %>
<td><% =FnNumberFormat(rslast("indivchild")) %>
<td><% =FnPercentFormat(rs("indivchild"),rslast("indivchild")) %>
<% rs.MOVENEXT : rslast.MOVENEXT : LOOP %>
</table>
</center>

</BODY>
</html>
<!-- #include file="../../enter/script/FnErrorCatch.inc"-->