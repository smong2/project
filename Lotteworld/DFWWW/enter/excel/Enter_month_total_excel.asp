<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<%
' ========================================================================================================
' ���α׷�ID : Enter_Month_Total_Excel
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���尴 ���� - ��-��ü ���� ���
' �����ۼ��� : 2002/10/30
' �����ۼ��� : 2002/11/21
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

'������ ����
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
Dim rslast, rs '���ڵ�� : ���⵿�� ����, ������
dim varEnterType '���尴 ����
dim varFile,varFileDate '���� ���� ����

varEnterType=Request.QueryString("varEnterType")

ArrQuery = array(varEnterType,"total")

'������ ����
Set objServer = Server.CreateObject("XTEnterMonXlsMTS.clsXTEnterMonthXlsNTX")

'������Ʈ ȣ�� ������ ����
%>
<!-- #include file="../../enter/script/FnExcelFileName.inc"-->
<%
Response.AddHeader "content-disposition","attachment;filename=" & varFile & "_month_total_" & varFileDate & ".xls" 

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
<h2>��ǥ���� �� ��ü</h2><br>
<% ELSE %>
<h2>������ �� ��ü</h2><br>
<% END IF %>
<table border=1>
<tr class="bt_bold01_bg">
<td rowspan=2>��¥
<td colspan=3 align=middle>��ü
<td colspan=3 align=middle>�
<td colspan=3 align=middle>�߰��
<td colspan=3 align=middle>���
<tr class="bt_solid01_bg">
<td>������
<td>���⵿��
<td>�����
<td>������
<td>���⵿��
<td>�����
<td>������
<td>���⵿��
<td>�����
<td>������
<td>���⵿��
<td>�����

<% DO UNTIL rs.EOF %>
<tr class="bt_solid01">
<td><% =rs("year") %>-<%=rs("month") %>
<td><% =FnNumberFormat(rs("total")) %>
<td><% =FnNumberFormat(rslast("total")) %>
<td><% =FnPercentFormat(rs("total"),rslast("total")) %>

<td><% =FnNumberFormat(rs("adult")) %>
<td><% =FnNumberFormat(rslast("adult")) %>
<td><% =FnPercentFormat(rs("adult"),rslast("adult")) %>
<td><% =FnNumberFormat(rs("school")) %>
<td><% =FnNumberFormat(rslast("school")) %>
<td><% =FnPercentFormat(rs("school"),rslast("school")) %>
<td><% =FnNumberFormat(rs("child")) %>
<td><% =FnNumberFormat(rslast("child")) %>
<td><% =FnPercentFormat(rs("child"),rslast("child")) %>
<% rs.MOVENEXT : rslast.MOVENEXT : LOOP %>
</table>
</center>

</BODY>
</html>
<!-- #include file="../../enter/script/FnErrorCatch.inc"-->