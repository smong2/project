<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' ���α׷�ID : VISITOR_TICKET_DAY_INDIV_EXCEL
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���尴 ���� - ��ǥ-��-���� ���� ���
' �����ۼ��� : 2002/10/30
' �����ۼ��� : 2002/10/30
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

'������ ����
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
Dim rs, rslast, rslastweek '���ڵ� �� : ����, �������, ���⵿���Ͻ���
dim varEnterType '���� ����
dim varFile,varFileDate '���� ���ϸ�, ��¥ ����
dim intI '��������

varEnterType=Request.QueryString("varEnterType")
%>
<!-- #include file="../../enter/script/FnSearch_Date.inc"-->
<%
ArrQuery = array(varEnterType,"indiv",dtLastday,dtLastWeekday)

'������ ����
Set objServer = Server.CreateObject("XTEnterDayXlsMTS.clsXTEnterDayXlsNTX")

'������Ʈ ȣ�� ������ ����
%>
<!-- #include file="../../enter/script/FnExcelFileName.inc"-->
<%
Response.AddHeader "content-disposition","attachment;filename=" & varFile & "_day_indiv_" & varFileDate & ".xls" 

'������Ʈ ȣ��
arrRValue = objServer.Query(ArrQuery)
'���ڵ�� ��̸� ���� ���ڵ������ �и�

'ù��° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rs,1
'�ι�° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rslast,2
'����° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rslastweek,3

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
<h2>��ǥ���� �� ���� </h2><br>
<% ELSE %>
<h2>������ �� ����</h2><br>
<% END IF %>
<table border=1>
<tr class="bt_bold01_bg">
<td rowspan=2>��¥
<td colspan=5 align=middle>��ü
<td colspan=5 align=middle>�
<td colspan=5 align=middle>�߰��
<td colspan=5 align=middle>���
<tr class="bt_solid01_bg">
<td>������
<td>���⵿��
<td>�����
<td>���⵿����
<td>�����
<td>������
<td>���⵿��
<td>�����
<td>���⵿����
<td>�����
<td>������
<td>���⵿��
<td>�����
<td>���⵿����
<td>�����
<td>������
<td>���⵿��
<td>�����
<td>���⵿����
<td>�����</td>

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