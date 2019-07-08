<!-- #include file="../../electric/script/FnLoginAuth.inc" -->
<%
' ========================================================================================================
' 프로그램ID : ELECT_EXCEL
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 전기 예측 - 엑셀 출력
' 최초작성일 : 2003/1/6
' 최종작성일 : 2003/1/6
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim rs, rslast, rslastweek '레코드셋 : 예측, 전년동일 실적, 전년동요일 실적
dim varEnterType '모형 결정
dim varFile,varFileDate ' 엑셀 파일명 결정
dim intI '증감변수

varEnterType="D"
%>
<!-- #include file="../../electric/script/FnSearch_Date.inc"-->
<%
ArrQuery = array(varEnterType,dtLastday,dtLastWeekday)

'변수의 설정
Set objServer = Server.CreateObject("XEElecExcelQMTS.clsXEElecExcelQNTX")

'컴포넌트 호출 로직의 전개
%>
<!-- #include file="../../electric/script/FnExcelFileName.inc"-->
<%
Response.AddHeader "content-disposition","attachment;filename=" & varFile & "_" & varFileDate & ".xls" 

'컴포넌트 호출
arrRValue = objServer.Query(ArrQuery)
'레코드셋 어레이를 단일 레코드셋으로 분리

'첫번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rs,1
'두번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rslast,2
'세번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rslastweek,3

'에러의 처리
IF Err.Number <> 0 THEN 
	Response.Write Err.Number, Err.Source, Err.Description
	Set objServer = Nothing
	objserver.close
END IF
%>
<!-- #include file="../../electric/script/FnProgramProcess.vbs" -->
<!-- #include file="../../electric/script/fnnumber_format.inc"-->	
<HTML>
<HEAD>
<meta http-equiv=Content-Type content="text/html; charset=ks_c_5601-1987">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 9">
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<meta http-equiv="refresh" content="0;url=window.close()">
<style type="text/css">
.bt_bold01_bg {mso-style-parent:style0; color:#4B4B4B; font-size:9.0pt; font-weight:700;	 text-align:center;  background:lightyellow}
.bt_solid01_bg {mso-style-parent:style0; color:#4B4B4B;	 font-size:9.0pt; text-align:center;  background:lightyellow}
.bt_solid01 {mso-style-parent:style0; color:#000000;	 font-size:9.0pt; text-align:center}
</style>
</HEAD>
<BODY>
<center>
<% IF varEnterType="D" THEN %>
<h2>전기예측 일</h2><br>
<% ELSE %>
<h2>전기예측 월</h2><br>
<% END IF %>
<table border=1>
<tr  class="bt_bold01_bg">
<td rowspan=2>날짜
<td colspan=5 align=middle>Total
<td colspan=5 align=middle>MagicIsland
<td colspan=5 align=middle>Adventure
<td colspan=5 align=middle>Sports
<td colspan=5 align=middle>Hotel
<td colspan=5 align=middle>DepartmentStore
<td colspan=5 align=middle>ShoppingMall
<td colspan=5 align=middle>Mart
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
<td>전년비
<td>예측값
<td>전년동일
<td>전년비
<td>전년동요일
<td>전년비
</td>

<% DO UNTIL rslast.EOF %>
<tr class="bt_solid01">
<td><% =rs("sdate") %>
<td><% =FnnumberFormat(rs("total")) %>
<td><% =FnNumberFormat(rslast("total")) %>
<td><% =FnPercentFormat(rs("total"),rslast("total")) %>
<td><% =FnNumberFormat(rslastweek("total")) %>
<td><% =FnPercentFormat(rs("total"),rslastweek("total")) %>

<td><% =FnnumberFormat(rs("MagicIsland")) %>
<td><% =FnNumberFormat(rslast("MagicIsland")) %>
<td><% =FnPercentFormat(rs("MagicIsland"),rslast("MagicIsland")) %>
<td><% =FnNumberFormat(rslastweek("MagicIsland")) %>
<td><% =FnPercentFormat(rs("MagicIsland"),rslastweek("MagicIsland")) %>

<td><% =FnnumberFormat(rs("Adventure")) %>&nbsp;
<td><% =FnNumberFormat(rslast("Adventure")) %>
<td><% =FnPercentFormat(rs("Adventure"),rslast("Adventure")) %>
<td><% =FnNumberFormat(rslastweek("Adventure")) %>
<td><% =FnPercentFormat(rs("Adventure"),rslastweek("Adventure")) %>

<td><% =FnnumberFormat(rs("Sports")) %>&nbsp;
<td><% =FnNumberFormat(rslast("Sports")) %>
<td><% =FnPercentFormat(rs("Sports"),rslast("Sports")) %>
<td><% =FnNumberFormat(rslastweek("Sports")) %>
<td><% =FnPercentFormat(rs("Sports"),rslastweek("Sports")) %></td>

<td><% =FnnumberFormat(rs("Hotel")) %>&nbsp;
<td><% =FnNumberFormat(rslast("Hotel")) %>
<td><% =FnPercentFormat(rs("Hotel"),rslast("Hotel")) %>
<td><% =FnNumberFormat(rslastweek("Hotel")) %>
<td><% =FnPercentFormat(rs("Hotel"),rslastweek("Hotel")) %></td>

<td><% =FnnumberFormat(rs("Departmentstore")) %>&nbsp;
<td><% =FnNumberFormat(rslast("Departmentstore")) %>
<td><% =FnPercentFormat(rs("Departmentstore"),rslast("Departmentstore")) %>
<td><% =FnNumberFormat(rslastweek("Departmentstore")) %>
<td><% =FnPercentFormat(rs("Departmentstore"),rslastweek("Departmentstore")) %></td>

<td><% =FnnumberFormat(rs("ShoppingMall")) %>&nbsp;
<td><% =FnNumberFormat(rslast("ShoppingMall")) %>
<td><% =FnPercentFormat(rs("ShoppingMall"),rslast("ShoppingMall")) %>
<td><% =FnNumberFormat(rslastweek("ShoppingMall")) %>
<td><% =FnPercentFormat(rs("ShoppingMall"),rslastweek("ShoppingMall")) %></td>

<td><% =FnnumberFormat(rs("Mart")) %>&nbsp;
<td><% =FnNumberFormat(rslast("Mart")) %>
<td><% =FnPercentFormat(rs("Mart"),rslast("Mart")) %>
<td><% =FnNumberFormat(rslastweek("Mart")) %>
<td><% =FnPercentFormat(rs("Mart"),rslastweek("Mart")) %></td>
<% rs.MOVENEXT : rslast.MOVENEXT : rslastweek.MOVENEXT : LOOP %>
</table>
<P>&nbsp;</P>
</center>
</BODY>
</html>
<!-- #include file="../../electric/script/FnErrorCatch.inc"-->