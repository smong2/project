<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<%
' ========================================================================================================
' ���α׷�ID : Enter_Year_Indiv_Excel
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���尴 ���� - ��-���� ���� ���
' �����ۼ��� : 2002/10/30
' �����ۼ��� : 2002/11/21
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

'������ ����
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
Dim rslast, rs  '���ڵ�� : ���� ����, ������
dim varEnterType '���� ����
dim varFile,varFileDate '���� �̸� ����

varEnterType=Request.QueryString("varEnterType")

ArrQuery = array(varEnterType,"indiv")

'������ ����
Set objServer = Server.CreateObject("XTEnterYearXlsMTS.clsXTEnterYearXlsNTX")

'������Ʈ ȣ�� ������ ����
%>
<!-- #include file="../../enter/script/FnExcelFileName.inc"-->
<%
Response.AddHeader "content-disposition","attachment;filename=" & varFile & "_year_indiv_" & varFileDate & ".xls" 

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
<td align=middle>��ü
<td align=middle>�
<td align=middle>�߰��
<td align=middle>���
<tr>
<td colspan=4 class="bt_solid01_bg">������

<% DO UNTIL rslast.EOF %>
<tr class="bt_solid01">
<td><% =rslast("year") %>
<td><% =FnNumberFormat(rslast("indivtotal")) %>
<td><% =FnNumberFormat(rslast("indivadult")) %>
<td><% =FnNumberFormat(rslast("indivschool")) %>
<td><% =FnNumberFormat(rslast("indivchild")) %>
<% rslast.MOVENEXT : LOOP %>
<% DO UNTIL rs.EOF %>
<tr class="bt_solid01">
<td><% =rs("year") %>
<td><% =FnNumberFormat(rs("indivtotal")) %>
<td><% =FnNumberFormat(rs("indivadult")) %>
<td><% =FnNumberFormat(rs("indivschool")) %>
<td><% =FnNumberFormat(rs("indivchild")) %>
<% rs.MOVENEXT : LOOP %>
</tr>
</table>
</center>
</BODY>
</html>
<!-- #include file="../../enter/script/FnErrorCatch.inc"-->
