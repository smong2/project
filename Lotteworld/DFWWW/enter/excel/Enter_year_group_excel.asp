<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<%
' ========================================================================================================
' 프로그램ID : VISITOR_TICKET_YEAR_GROUP_EXCEL
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 입장객 예측 - 연-단체 엑셀출력
' 최초작성일 : 2002/10/30
' 최종작성일 : 2002/11/13
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim rslast, rs '레코드셋 : 전년 실적, 예측값
dim varEnterType '모형 결정
dim varFile,varFileDate '엑셀 파일명 결정변수

varEnterType=Request.QueryString("varEnterType")

ArrQuery = array(varEnterType,"group")

'변수의 설정
Set objServer = Server.CreateObject("XTEnterYearXlsMTS.clsXTEnterYearXlsNTX")

'컴포넌트 호출 로직의 전개
%>
<!-- #include file="../../enter/script/FnExcelFileName.inc"-->
<%
Response.AddHeader "content-disposition","attachment;filename=" & varFile & "_year_group_" & varFileDate & ".xls" 

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
<h2>매표입장 년 단체</h2><br>
<% ELSE %>
<h2>실입장 년 단체</h2><br>
<% END IF %>
<table border=1>
<tr class="bt_bold01_bg">
<td rowspan=2>날짜
<td align=middle>전체
<td align=middle>어른
<td align=middle>중고생
<td align=middle>어린이
<tr>
<td colspan=4 class="bt_solid01_bg">예 측 값
<% DO UNTIL rslast.EOF %>
<tr class="bt_solid01">
<td><% =rslast("year") %>
<td><% =FnNumberFormat(rslast("grouptotal")) %>
<td><% =FnNumberFormat(rslast("groupadult")) %>
<td><% =FnNumberFormat(rslast("groupschool")) %>
<td><% =FnNumberFormat(rslast("groupchild")) %>
<% rslast.MOVENEXT : LOOP %>
<% DO UNTIL rs.EOF %>
<tr class="bt_solid01">
<td><% =rs("year") %>
<td><% =FnNumberFormat(rs("grouptotal")) %>
<td><% =FnNumberFormat(rs("groupadult")) %>
<td><% =FnNumberFormat(rs("groupschool")) %>
<td><% =FnNumberFormat(rs("groupchild")) %>
<% rs.MOVENEXT : LOOP %>
</tr>
</table>
</center>
</BODY>
</html>
<!-- #include file="../../enter/script/FnErrorCatch.inc"-->