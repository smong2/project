<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' 프로그램ID : VISITOR_TICKET_DAY_INDIV_EXCEL
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 입장객 예측 - 매표-일-개인 엑셀 출력
' 최초작성일 : 2002/10/30
' 최종작성일 : 2002/10/30
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim rs, rslast, rslastweek '레코드 셋 : 예측, 전년실적, 전년동요일실적
dim varEnterType '모형 종류
dim varFile,varFileDate '엑셀 파일명, 날짜 변수
dim intI '증감변수

varEnterType=Request.QueryString("varEnterType")
%>
<!-- #include file="../../enter/script/FnSearch_Date.inc"-->
<%
ArrQuery = array(varEnterType,"indiv",dtLastday,dtLastWeekday)

'변수의 설정
Set objServer = Server.CreateObject("XTEnterDayXlsMTS.clsXTEnterDayXlsNTX")

'컴포넌트 호출 로직의 전개
%>
<!-- #include file="../../enter/script/FnExcelFileName.inc"-->
<%
Response.AddHeader "content-disposition","attachment;filename=" & varFile & "_day_indiv_" & varFileDate & ".xls" 

'컴포넌트 호출
arrRValue = objServer.Query(ArrQuery)
'레코드셋 어레이를 단일 레코드셋으로 분리

'첫번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rs,1
'두번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rslast,2
'세번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rslastweek,3

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
<!-- #include file="../../enter/script/fnnumber_format.inc"-->	
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
<h2>매표입장 일 개인 </h2><br>
<% ELSE %>
<h2>실입장 일 개인</h2><br>
<% END IF %>
<table border=1>
<tr class="bt_bold01_bg">
<td rowspan=2>날짜
<td colspan=5 align=middle>전체
<td colspan=5 align=middle>어른
<td colspan=5 align=middle>중고생
<td colspan=5 align=middle>어린이
<tr class="bt_solid01_bg">
<td>예측값
<td>전년동일
<td>전년비
<td>전년동요일
<td>전년비
<td>예측값
<td>전년동일
<td>전년비
<td>전년동요일
<td>전년비
<td>예측값
<td>전년동일
<td>전년비
<td>전년동요일
<td>전년비
<td>예측값
<td>전년동일
<td>전년비
<td>전년동요일
<td>전년비</td>

<% DO UNTIL rs.EOF %>
<tr class="bt_solid01">
<td><% =rs("xdate") %>
<td><% =FnnumberFormat(rs("indivtotal")) %>
<td><% =FnNumberFormat(rslast("indivtotal")) %>
<td><% =FnPercentFormat(rs("indivtotal"),rslast("indivtotal")) %>
<td><% =FnNumberFormat(rslastweek("indivtotal")) %>
<td><% =FnPercentFormat(rs("indivtotal"),rslastweek("indivtotal")) %>

<td><% =FnnumberFormat(rs("indivadult")) %>
<td><% =FnNumberFormat(rslast("indivadult")) %>
<td><% =FnPercentFormat(rs("indivadult"),rslast("indivadult")) %>
<td><% =FnNumberFormat(rslastweek("indivadult")) %>
<td><% =FnPercentFormat(rs("indivadult"),rslastweek("indivadult")) %>
<td><% =FnnumberFormat(rs("indivschool")) %>&nbsp;
<td><% =FnNumberFormat(rslast("indivschool")) %>
<td><% =FnPercentFormat(rs("indivschool"),rslast("indivschool")) %>
<td><% =FnNumberFormat(rslastweek("indivschool")) %>
<td><% =FnPercentFormat(rs("indivschool"),rslastweek("indivschool")) %>
<td><% =FnnumberFormat(rs("indivchild")) %>&nbsp;
<td><% =FnNumberFormat(rslast("indivchild")) %>
<td><% =FnPercentFormat(rs("indivchild"),rslast("indivchild")) %>
<td><% =FnNumberFormat(rslastweek("indivchild")) %>
<td><% =FnPercentFormat(rs("indivchild"),rslast("indivchild")) %></td>
<% rs.MOVENEXT : rslast.MOVENEXT : rslastweek.MOVENEXT : LOOP %>
</table>
</center>

</BODY>
</html>
<!-- #include file="../../enter/script/FnErrorCatch.inc"-->