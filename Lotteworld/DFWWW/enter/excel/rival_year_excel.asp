<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' ���α׷�ID : RIVAL_YEAR_EXCEL
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ����� ���� �� - ���� ���
' �����ۼ��� : 2002/10/30
' �����ۼ��� : 2002/11/21
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================
 
'������ ����
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
Dim rs,rslast '���ڵ�� : ����, �������
Dim varFileDate '���� ���ϸ� ����

ArrQuery = array()

'������ ����
Set objServer = Server.CreateObject("XTEnterRivalYXMTS.clsXTEnterRivalYXNTX")

'������Ʈ ȣ�� ������ ����
%>
<!-- #include file="../../enter/script/FnExcelFileName.inc"-->
<%
Response.AddHeader "content-disposition","attachment;filename=rival_year_" & varFileDate & ".xls"

'������Ʈ ȣ��
arrRValue = objServer.Query(ArrQuery)
'���ڵ�� ��̸� ���� ���ڵ������ �и�

'ù��° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rs,1
'�ι�° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rslast,2

'�ڿ��� ����
Set objServer = Nothing

'������ ó��
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
.bt_solid01 {mso-style-parent:style0; color:#000000;	 font-size:9.0pt; text-align:center}
</style>
</HEAD>
<BODY>
<center>
<table>
<tr>
<td colspan=3 align=center> 
<h2>����� �� ����</h2><br>
</td>
</table>
<table border=1>
<tr class="bt_bold01_bg">
<td>�⵵
<td>��������
<td>���﷣��
<% DO UNTIL rslast.EOF %>
<tr class="bt_solid01">
<td><% =rslast("year") %>
<td><% =FnNumberFormat(rslast("evertotal")) %>
<td><% =FnNumberFormat(rslast("seoultotal")) %>
<% rslast.MOVENEXT :LOOP %>
<% DO UNTIL rs.EOF %>
<tr class="bt_solid01">
<td><%=rs("year") %>
<td><% =FnNumberFormat(rs("evertotal")) %>
<td><% =FnNumberFormat(rs("seoultotal")) %>
</tr>
<% rs.MOVENEXT : LOOP %>
</table>
</center>
</BODY>
</HTML>
<!-- #include file="../../enter/script/FnErrorCatch.inc"-->