<!-- #include file="../../electric/script/FnLoginAuth.inc" -->
<%
' ========================================================================================================
' ���α׷�ID : TXBADMINCon
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� �Է� Ȯ�� ����
' �����ۼ��� : 2003/01/06
' �����ۼ��� : 2003/01/06
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

'������ ����
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
Dim intI '��������
Dim rs,rsvarday,rsvarmonth,rsvaryear '�� ���ڵ�µ� -����, �Ϻ���, ������, �⺯��


ArrQuery = array("Electric") '����

'������ ����
Set objServer  = Server.CreateObject("XBAdminConQMTS.clsXBAdminConQNTX")
'������Ʈ ȣ��
arrRValue = objServer.Query(ArrQuery)

'ù��° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rs,1
'�ι�° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rsvarday,2
'����° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rsvarmonth,3
'�׹�° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rsvaryear,4

'�ڿ��� ����
Set objServer = Nothing

'������ ó��
IF Err.Number <> 0 THEN 
	Response.Write Err.Number, Err.Source, Err.Description
	Set objServer = Nothing
	objserver.close
END IF
%>
<!-- #include file="../../electric/script/FnProgramProcess.vbs" -->
<html>
<head>
<title>�Ե����� ���俹���ý���</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../../electric/css/cs_te.css" type="text/css">
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
  <tr> 
    <td width="49"><img src="../../electric/images/null.gif" width="49" height="1"></td>
    <td width="642" valign="top">
	<!--ū ���̺� ����--> 
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="../../electric/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
          <td><img src="../../electric/images/title_input_confirm.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../electric/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--�Է³��� ���̺� ����--> 
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr bgcolor="#CECFF5"> 
                <td height="7" colspan="4"></td>
              </tr>
              <tr class="list13_bg"> 
                <td>����</td>
                <td width="100">�Է¿���</td>
                <td width="100">�����Է���</td>
                <td width="100">�Է�</td>
              </tr>
              <tr> 
                <td class="list03_bg2">���̵� �����Է�(��)</td>
                <td class="list14_bg2"><% IF rs("xdate")>=date()-1 THEN Response.Write "�Է�O" ELSE Response.Write "<font color=red>�Է�X</font>" %></td>
                <td class="list14_bg2"><% =Year(rs("xdate")) %>�� <% =Month(rs("xdate")) %>�� <% =Day(rs("xdate")) %>��</td>
                <td class="table04"><img src="../../electric/images/input_bu.gif" width="53" height="26" onclick=location.href('admin_results_input.asp')></td>
              </tr>              
              <tr> 
                <td class="list03_bg2">�����Է�(��)</td>
                <td class="list14_bg2"><% IF rsvarday("xdate")>=date()-1 THEN Response.Write "�Է�O" ELSE Response.Write "<font color=red>�Է�X</font>" %></td>
                <td class="list14_bg2"><% =YEAR(rsvarday("xdate")) %>�� <% =Month(rsvarday("xdate")) %>�� <% =Day(rsvarday("xdate")) %>��</td>
                <td class="table04"><img src="../../electric/images/input_bu.gif" width="53" height="26" onclick=location.href('admin_vari_dayinput.asp')></td>
              </tr>
              <tr> 
                <td class="list03_bg2">�����Է�(��)</td>
                <td class="list14_bg2"><% IF DateDiff("m",rsvarmonth("xdate"),date())<=-2 THEN Response.Write "�Է�O" ELSE Response.Write "<font color=red>�Է�X</font>" %></td>
                <td class="list14_bg2"><% =YEAR(rsvarmonth("xdate")) %>�� <% =Month(rsvarmonth("xdate")) %>��</td>
                <td class="table04"><img src="../../electric/images/input_bu.gif" width="53" height="26" onclick=location.href('admin_vari_monthinput.asp')></td>
              </tr>
              <tr> 
                <td class="list03_bg2">�����Է�(��)</td>
                <td class="list14_bg2"><% IF rsvaryear("xdate")>=YEAR(date()) THEN Response.Write "�Է�O" ELSE Response.Write "<font color=red>�Է�X</font>" %></td>
                <td class="list14_bg2"><% =rsvaryear("xdate") %>��</td>
                <td class="table04"><img src="../../electric/images/input_bu.gif" width="53" height="26" onclick=location.href('admin_vari_yearinput.asp')></td>
              </tr>
              <tr bgcolor="#CECFF5"> 
                <td height="7" colspan="4"></td>
              </tr>
            </table>
			<!--�Է³��� ���̺� ��-->
          </td>
        </tr>
        <tr> 
          <td height="30"></td>
        </tr>
      </table>
	  <!--ū ���̺� ��-->
    </td>
    <td width="49"><img src="../../electric/images/null.gif" width="49" height="1"></td>
    <td bgcolor="#a4a4a4"><img src="../../electric/images/outline.gif" width="1" height="1"></td>
  </tr>
  <tr> 
    <td height="42" colspan="3" align="right" background="../../electric/images/copyright_bg.gif"><img src="../../electric/images/copyright.gif" width="350" height="42"></td>
    <td bgcolor="#a4a4a4" width="1" height="42"><img src="../../electric/images/null.gif"></td>
  </tr>
</table>
</body>
</html>