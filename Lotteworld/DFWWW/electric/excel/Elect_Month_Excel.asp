<!-- #include file="../../electric/script/FnLoginAuth.inc" -->
<%
' ========================================================================================================
' ���α׷�ID : ELECT_EXCEL
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���� ���� - ���� ���
' �����ۼ��� : 2003/1/6
' �����ۼ��� : 2003/1/6
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

'������ ����
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
Dim rs, rslast, rslastweek '���ڵ�� : ����, ���⵿�Ͻ���, ���⵿���Ͻ���
dim varEnterType '���� ����
dim varFile,varFileDate '���� ���ϸ� ����
dim intI '��������

varEnterType="M"
%>
<!-- #include file="../../electric/script/FnSearch_Date.inc"-->
<%
ArrQuery = array(varEnterType,dtLastday,dtLastWeekday)

'������ ����
Set objServer = Server.CreateObject("XEElecExcelQMTS.clsXEElecExcelQNTX")

'������Ʈ ȣ�� ������ ����
%>
<!-- #include file="../../electric/script/FnExcelFileName.inc"-->
<%
Response.AddHeader "content-disposition","attachment;filename=" & varFile & "_" & varFileDate & ".xls" 

'������Ʈ ȣ��
arrRValue = objServer.Query(ArrQuery)
'���ڵ�� ��̸� ���� ���ڵ������ �и�

'ù��° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rs,1
'�ι�° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rslast,2

'������ ó��
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
<h2>���⿹�� ��</h2><br>
<% ELSE %>
<h2>���⿹�� ��</h2><br>
<% END IF %>
<table border=1>
<tr  class="bt_bold01_bg">
<td rowspan=2>��¥
<td colspan=3 align=middle>Total
<td colspan=3 align=middle>MagicIsland
<td colspan=3 align=middle>Adventure
<td colspan=3 align=middle>Sports
<td colspan=3 align=middle>Hotel
<td colspan=3 align=middle>DepartmentStore
<td colspan=3 align=middle>ShoppingMall
<td colspan=3 align=middle>Mart
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
</td>

<% DO UNTIL rslast.EOF %>
<tr class="bt_solid01">
<td><% =rs("Year") %>�� <% =rs("Month") %>��
<td><% =FnnumberFormat(rs("total")) %>
<td><% =FnNumberFormat(rslast("total")) %>
<td><% =FnPercentFormat(rs("total"),rslast("total")) %>

<td><% =FnnumberFormat(rs("MagicIsland")) %>
<td><% =FnNumberFormat(rslast("MagicIsland")) %>
<td><% =FnPercentFormat(rs("MagicIsland"),rslast("MagicIsland")) %>

<td><% =FnnumberFormat(rs("Adventure")) %>&nbsp;
<td><% =FnNumberFormat(rslast("Adventure")) %>
<td><% =FnPercentFormat(rs("Adventure"),rslast("Adventure")) %>

<td><% =FnnumberFormat(rs("Sports")) %>&nbsp;
<td><% =FnNumberFormat(rslast("Sports")) %>
<td><% =FnPercentFormat(rs("Sports"),rslast("Sports")) %>

<td><% =FnnumberFormat(rs("Hotel")) %>&nbsp;
<td><% =FnNumberFormat(rslast("Hotel")) %>
<td><% =FnPercentFormat(rs("Hotel"),rslast("Hotel")) %>

<td><% =FnnumberFormat(rs("Departmentstore")) %>&nbsp;
<td><% =FnNumberFormat(rslast("Departmentstore")) %>
<td><% =FnPercentFormat(rs("Departmentstore"),rslast("Departmentstore")) %>

<td><% =FnnumberFormat(rs("ShoppingMall")) %>&nbsp;
<td><% =FnNumberFormat(rslast("ShoppingMall")) %>
<td><% =FnPercentFormat(rs("ShoppingMall"),rslast("ShoppingMall")) %>

<td><% =FnnumberFormat(rs("Mart")) %>&nbsp;
<td><% =FnNumberFormat(rslast("Mart")) %>
<td><% =FnPercentFormat(rs("Mart"),rslast("Mart")) %>
<% rs.MOVENEXT : rslast.MOVENEXT : LOOP %>
</table>
<P>&nbsp;</P>
</center>
</BODY>
</html>
<!-- #include file="../../electric/script/FnErrorCatch.inc"-->