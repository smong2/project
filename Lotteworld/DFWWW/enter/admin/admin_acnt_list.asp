<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' ���α׷�ID : User List
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ����� ���� ����Ʈ ����
' �����ۼ��� : 2002/12/09
' �����ۼ��� : 2002/12/09
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
Dim rs '���ڵ��  : ���� ����Ʈ
dim intI '��������

ArrQuery = array("Tlist","View") '���� ����

'������ ����
Set objServer = Server.CreateObject("XBUserUIQMTS.clsXBUSERUIQNTX")

'������Ʈ ȣ��
arrRValue = objServer.Query(ArrQuery)
'���ڵ�� ��̸� ���� ���ڵ������ �и�

'ù��° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rs,1

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
<!-- #include file="../../enter/script/FnAcntClassDescript.inc" -->
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
          <td><IMG height=21 src="../../enter/images/title_admin_acnt.gif" width=200></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><IMG height=5 src="../../enter/images/title_bar.gif" width=642></td>
        </tr>
        <tr> 
          <td height="15"><!--��������ڸ�� Ÿ��Ʋ ����--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="15" height="11" class="table03"><IMG height=7 src="../../enter/images/orange_buret.gif" width=7></td>
                <td class="title_01">���� ����� ���</td>
              </tr>
            </table><!--��������ڸ�� Ÿ��Ʋ ��-->
          </td>
        </tr>
        <tr> 
          <td><IMG height=5 src="../../enter/images/null.gif" width=1></td>
        </tr>
        <tr> 
          <td><!--��� ���̺� ����-->
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr bgcolor="#b0dffd"> 
                <td height="7" colspan="6"></td>
              </tr>
              <tr class="list13_bg"> 
                <td width="95">�̸�</td>
                <td width="105">���̵�</td>
                <td width="108">�μ�</td>
                <td width="108">��ȭ</td>
                <td width="126">�������ӽð�</td>
                <td width="100">���ѵ��</td>
              </tr>
              <% DO UNTIL rs.EOF %>
              <tr> 
                <td class="list13_bg2"><a href=admin_acnt_modify.asp?varID=<% =rs("ID") %>><% =rs("NAME") %></td>
                <td class="list11_bg"><% =rs("ID") %></td>
                <td class="list14_bg2"><% =rs("DEPT") %></td>
                <td class="list14_bg2"><% =rs("TEL") %></td>
                <td class="list14_bg2"><% =FnConnecttime(rs("lastconnecttime")) %></td>
                <td class="list13_bg2"><% =FnAcntClassDescript(rs("AUTHLEVEL")) %></td>
              </tr>
              <% rs.MOVENEXT : LOOP %>
              <tr bgcolor="#b0dffd"> 
                <td height="7" colspan="6"></td>
              </tr>
            </table><!--��� ���̺� ��-->
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