<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<%
' ========================================================================================================
' ���α׷�ID : TXBADMINCon
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� �Է� Ȯ�� ����
' �����ۼ��� : 2003/01/03
' �����ۼ��� : 2003/01/03
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

'������ ����
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
Dim intI '��������
Dim rs,rse,rsres,rsrival,rsforeigner,rsvarday,rsvarmonth,rsvaryear '�� ���ڵ�µ�
'��ǥ����, ������, �����, �ܱ���, �Ϻ���, ������, �⺯�� ���ڵ��

ArrQuery = array("enter") '����

'������ ����
Set objServer  = Server.CreateObject("XBAdminConQMTS.clsXBAdminConQNTX")
'������Ʈ ȣ��
arrRValue = objServer.Query(ArrQuery)

'ù��° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rs,1   
'�ι�° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rse,2
'����° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rsres,3
'�׹�° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rsrival,4
'�ټ���° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rsforeigner,5
'������° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rsvarday,6
'�ϰ���° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rsvarmonth,7
'������° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rsvaryear,8

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
<html>
<head>
<title>�Ե����� ���俹���ý���</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../../enter/css/cs_tx.css" type="text/css">
</head>

<body bgcolor="#f5f5f5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#ffffff">
  <tr> 
    <td width="49"><IMG height=1 src="../../enter/images/null.gif" width=49></td>
    <td width="642" valign="top"><!--ū ���̺� ����--> 
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><IMG height=24 src="../../enter/images/null.gif" width=1></td>
        </tr>
        <tr> 
          <td><IMG height=21 src="../../enter/images/title_input_confirm.gif" width=200></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><IMG height=5 src="../../enter/images/title_bar.gif" width=642></td>
        </tr>
        <tr> 
          <td><!--�Է³��� ���̺� ����--> 
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr bgcolor="#b0dffd"> 
                <td height="7" colspan="4"></td>
              </tr>
              <tr class="list13_bg"> 
                <td>���� -  () ���� �Է°�����</td>
                <td width="100">�Է¿���</td>
                <td width='100'>�����Է���</td>
                <td width="100">�Է�</td>
              </tr>
              <tr> 
                <td class="list03_bg2">��ǥ �� ���� �Է�(��)</td>                
                <td class="list14_bg2"><% IF rs("xdate")>=date()-1 THEN Response.Write "�Է�O" ELSE Response.Write "<font color=red>�Է�X</font>" %></td>
                <td class="list14_bg2"><% =YEAR(rs("xdate")) %>�� <% =Month(rs("xdate")) %>�� <% =Day(rs("xdate")) %>��</td>
                <TD class=table04>
                <IMG height=26 src="../../enter/images/input_bu.gif" width=53 onclick=location.href('admin_results_enter_dayinput.asp')></TD>
              </tr>
              <tr> 
                <td class="list03_bg2">������ �� ���� �Է�(��)</td>
                <td class="list14_bg2"><% IF rse("xdate")>=date()-1 THEN Response.Write "�Է�O" ELSE Response.Write "<font color=red>�Է�X</font>" %></td>
                <td class=list14_bg2><% =YEAR(rse("xdate")) %>�� <% =Month(rse("xdate")) %>�� <% =Day(rse("xdate")) %>��</td>
                <TD class=table04>
                <IMG height=26 src="../../enter/images/input_bu.gif" width=53 onclick=location.href('admin_results_enter_dayinput.asp')></TD>
              </tr>
              <tr> 
                <td class="list03_bg2">��ü��������(��)</td>
                <td class="list14_bg2"><% IF rsres("xdate")>=date()+1 THEN Response.Write "�Է�O" ELSE Response.Write "<font color=red>�Է�X</font>" %></td>
                <td class=list14_bg2><% =YEAR(rsres("xdate")) %>�� <% =Month(rsres("xdate")) %>�� <% =Day(rsres("xdate")) %>��</td>
                <td class="table04"><IMG height=26 src="../../enter/images/input_bu.gif" width=53 onclick=location.href('admin_results_reservation.asp')></td>
              </tr>                            
              <tr> 
                <td class="list03_bg2">����� �Է�(��)</td>
                <td class="list14_bg2"><% IF DateDiff("m",rsrival("xdate"),date())<=1  THEN Response.Write "�Է�O" ELSE Response.Write "<font color=red>�Է�X</font>" %></td>
                <td class=list14_bg2><% =YEAR(rsrival("xdate")) %>�� <% =Month(rsrival("xdate")) %>��</td>
                <TD class=table04>
                <IMG height=26 src="../../enter/images/input_bu.gif" width=53 onclick=location.href('admin_results_rival.asp')></TD>
              </tr>
              <tr> 
                <td class="list03_bg2">�ܱ��� �Է�(��)</td>
                <td class="list14_bg2"><% IF DateDiff("m",rsforeigner("xdate"),date())<=1 THEN Response.Write "�Է�O" ELSE Response.Write "<font color=red>�Է�X</font>" %></td>
                <td class=list14_bg2><% =YEAR(rsforeigner("xdate")) %>�� <% =Month(rsforeigner("xdate")) %>��</td>
                <TD class=table04>
                <IMG height=26 src="../../enter/images/input_bu.gif" width=53 onclick=location.href('admin_results_foreigner.asp')></TD>
              </tr>
              <tr> 
                <td class="list03_bg2">�� ���� �Է�(��)</td>
                <td class="list14_bg2"><% IF rsvarday("xdate")>=date()+2 THEN Response.Write "�Է�O" ELSE Response.Write "<font color=red>�Է�X</font>" %></td>
                <td class=list14_bg2><% =YEAR(rsvarday("xdate")) %>�� <% =Month(rsvarday("xdate")) %>�� <% =Day(rsvarday("xdate")) %>��</td>
                <TD class=table04>
                <IMG height=26 src="../../enter/images/input_bu.gif" width=53 onclick=location.href('admin_vari_dayinput.asp')></TD>
              </tr>
              <tr> 
                <td class="list03_bg2">�� ���� �Է�(��)</td>
                <td class="list14_bg2"><% IF DateDiff("m",rsvarmonth("xdate"),date())<=-2 THEN Response.Write "�Է�O" ELSE Response.Write "<font color=red>�Է�X</font>" %></td>
                <td class=list14_bg2><% =YEAR(rsvarmonth("xdate")) %>�� <% =Month(rsvarmonth("xdate")) %>��</td>
                <TD class=table04>
                <IMG height=26 src="../../enter/images/input_bu.gif" width=53 onclick=location.href('admin_vari_monthinput.asp')></TD>
              </tr>
              <tr> 
                <td class="list03_bg2">�� ���� �Է�(��)</td>
                <td class="list14_bg2"><% IF rsvaryear("xdate")>=YEAR(date()) THEN Response.Write "�Է�O" ELSE Response.Write "<font color=red>�Է�X</font>" %></td>
                <td class=list14_bg2><% =rsvaryear("xdate") %>�� </td>
                <TD class=table04>
                <IMG height=26 src="../../enter/images/input_bu.gif" width=53 onclick=location.href('admin_vari_yearinput.asp')></TD>
              </tr>
              <tr bgcolor="#b0dffd"> 
                <td height="7" colspan="4"></td>
              </tr>
            </table><!--�Է³��� ���̺� ��-->
          </td>
        </tr>
        <tr> 
          <td height="30"></td>
        </tr>
      </table><!--ū ���̺� ��-->
    </td>
    <td width="49"><IMG height=1 src="../../enter/images/null.gif" width=49></td>
    <td bgcolor="#a4a4a4"><IMG height=1 src="../../enter/images/outline.gif" width=1></td>
  </tr>
  <tr> 
    <td height="42" colspan="3" align="right" background="../../enter/images/copyright_bg.gif"><IMG height=42 src="../../enter/images/copyright.gif" width=350></td>
    <td bgcolor="#a4a4a4" width="1" height="42"><IMG src="../../enter/images/null.gif"></td>
  </tr>
</table>
</body>
</html>
<!-- #include file="../../enter/script/FnErrorCatch.inc"-->