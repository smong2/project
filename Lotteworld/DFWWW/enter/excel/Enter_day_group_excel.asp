<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<%
' ========================================================================================================
' ���α׷�ID : Enter_Group_Excel
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ��ǥ �� ���� - ��ü ���� ��� ���α׷�
' �����ۼ��� : 2002/10/30
' �����ۼ��� : 2002/11/20
' ��  ��  �� : �ڼ���(kweather)
' ======================================================================================================== 

'������ ����
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
Dim rs, rslast, rslastweek '���ڵ� �� : ����, �������, ���⵿���Ͻ���
dim varEnterType '���尴 ����
dim varFile, varFileDate '���� �̸� ����
Dim intI '��������

varEnterType=Request.QueryString("varEnterType")

%>
<!-- #include file="../../enter/script/fnSearch_Date.inc"-->
<%
ArrQuery = array(varEnterType,"group",dtLastday,dtLastWeekday)

'������ ����
Set objServer = Server.CreateObject("XTEnterDayXlsMTS.clsXTEnterDayXlsNTX")
%>
<!-- #include file="../../enter/script/FnExcelFileName.inc"-->
<%
Response.AddHeader "content-disposition","attachment;filename=" & varFile & "_day_group_" & varFileDate & ".xls"

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
.bt_bold01_bg {mso-style-parent:style0; color:#4B4B4B; font-size:9.0pt; font-weight:700; text-align:center; background:lightyellow}
.bt_solid01_bg {mso-style-parent:style0; color:#4B4B4B; font-size:9.0pt; text-align:center; background:lightyellow}
.bt_solid01 {mso-style-parent:style0; color:#000000; font-size:9.0pt; text-align:center}
</style>
</HEAD>
<BODY>
<center>
<% IF varEnterType="vxt" THEN %>
<h2>��ǥ���� �� ��ü</h2><br>
<% ELSE %>
<h2>������ �� ��ü</h2><br>
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

<td><% =FnnumberFormat(rs("grouptotal")) %>
<td><% =FnNumberFormat(rslast("grouptotal")) %>
<td><% =FnPercentFormat(rs("grouptotal"),rslast("grouptotal")) %>
<td><% =FnNumberFormat(rslastweek("grouptotal")) %>
<td><% =FnPercentFormat(rs("grouptotal"),rslastweek("grouptotal")) %>

<td><% =FnnumberFormat(rs("groupadult")) %>
<td><% =FnNumberFormat(rslast("groupadult")) %>
<td><% =FnPercentFormat(rs("groupadult"),rslast("groupadult")) %>
<td><% =FnNumberFormat(rslastweek("groupadult")) %>
<td><% =FnPercentFormat(rs("groupadult"),rslastweek("groupadult")) %>

<td><% =FnnumberFormat(rs("groupschool")) %>&nbsp;
<td><% =FnNumberFormat(rslast("groupschool")) %>
<td><% =FnPercentFormat(rs("groupschool"),rslast("groupschool")) %>
<td><% =FnNumberFormat(rslastweek("groupschool")) %>
<td><% =FnPercentFormat(rs("groupschool"),rslastweek("groupschool")) %>

<td><% =FnnumberFormat(rs("groupchild")) %>&nbsp;
<td><% =FnNumberFormat(rslast("groupchild")) %>
<td><% =FnPercentFormat(rs("groupchild"),rslast("groupchild")) %>
<td><% =FnNumberFormat(rslastweek("groupchild")) %>
<td><% =FnPercentFormat(rs("groupchild"),rslastweek("groupchild")) %></td>

<% rs.MOVENEXT : rslast.MOVENEXT : rslastweek.MOVENEXT : LOOP %>
</table>
</center>

</BODY>
</html>
<!-- #include file="../../enter/script/FnErrorCatch.inc"-->
