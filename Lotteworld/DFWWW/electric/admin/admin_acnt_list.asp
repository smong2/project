<!-- #include file="../../electric/script/FnLoginAuth.inc" -->
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
Dim rs '���ڵ�� : ���� ����Ʈ ���
dim intI '��������

ArrQuery = array("ELIST") '���� ����

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
<!-- #include file="../../electric/script/FnProgramProcess.vbs" -->
<!-- #include file="../../electric/script/FnAcntClassDescript.inc" -->
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
          <td><img src="../../electric/images/title_admin_acnt.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../electric/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td height="15"> 
		  <!--��������ڸ�� Ÿ��Ʋ ����-->
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="15" height="11" class="table03"><img src="../../electric/images/orange_buret.gif" width="7" height="7"></td>
                <td class="title_01">���� ����� ���</td>
              </tr>
            </table>
			<!--��������ڸ�� Ÿ��Ʋ ��-->
          </td>
        </tr>
        <tr> 
          <td height="5"><img src="../../electric/images/null.gif" width="1" height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--��� ���̺� ����--> 
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr bgcolor="#CECFF5"> 
                <td height="7" colspan="6"></td>
              </tr>
              <tr class="list13_bg"> 
                <td width="95">�̸�</td>
                <td width="105">���̵�</td>
                <td width="108">�μ�</td>
                <td width="108">��ȭ</td>
                <td width="126">�������ӽð�</td>
                <td width="100">���</td>
              </tr>
              <% DO UNTIL rs.EOF %>
              <tr> 
                <td class="list13_bg2"><a href=admin_acnt_modify.asp?varID=<% =rs("ID") %>><% =rs("NAME") %></a></td>
                <td class="list11_bg"><% =rs("ID") %></td>
                <td class="list14_bg2"><% =rs("DEPT") %></td>
                <td class="list14_bg2"><% =rs("TEL") %></td>
                <td class="list14_bg2"><% =FnConnecttime(rs("lastconnecttime")) %></td>
                <td class="list13_bg2"><% =FnAcntClassDescript(rs("AUTHLEVEL")) %></td>
              </tr>
              <% rs.MOVENEXT : LOOP %>
              <tr bgcolor="#CECFF5"> 
                <td height="7" colspan="6"></td>
              </tr>
            </table>
			<!--��� ���̺� ��-->
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
<!-- #include file="../../electric/script/FnErrorCatch.inc" -->