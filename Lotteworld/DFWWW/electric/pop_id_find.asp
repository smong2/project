<%
' ========================================================================================================
' ���α׷�ID : TXBUSER - ID/PASSWORD ã��
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���尴 ���� ���� ���� ID/PWD ã�� ���α׷�
' �����ۼ��� : 2002/10/28
' �����ۼ��� : 2002/10/28
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

'������ ����
Dim objServer, arrRValue, Arr '�İ��� ������
Dim rs '���� Ȯ��
dim intI,varInsert '��������
Dim varID, varPWD, varTEL, varNAME '����� �Է°�

varinsert=Request.Form("varinsert") 

IF varinsert="ok" THEN
varID=Request.Form("txtEmpId")
varTEL=Request.Form("txtTel")
varNAME=Request.Form("txtName")

ArrQuery = array("Find",varID,"����",varTEL,varNAME) '�������� �´� �ڵ� ��������

'������ ����
Set objServer  = Server.CreateObject("XBUserUIQMTS.clsXBUserUIQNTX")

'������Ʈ ȣ��
arrRValue = objServer.Query(ArrQuery)
'���ڵ�� ��̸� ���� ���ڵ������ �и�

'ù��° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rs,1

'�ڿ��� ����
Set objServer = Nothing

IF rs.eof THEN  '�߸� �Է��� ��� �ٷ� ����Ʈ
Response.Redirect "pop_id_find.asp"
END IF
END IF

'������ ó��
IF Err.Number <> 0 THEN 
	Response.Write Err.Number, Err.Source, Err.Description
	Set objServer = Nothing
	objserver.close
END IF
%>
<!-- #include file="../enter/script/FnProgramProcess.vbs" -->
<html>
<head>
<title>���̵�/��й�ȣ ã��</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../enter/css/cs_tx.css" type="text/css">
<script language=javascript>
function Fncheck(){
if (document.form.txtNAME.value=="") {
  alert('�̸��� �Է����ֽʽÿ�');
  document.form.txtNAME.focus();
  return false;
}
 if (document.form.txtEmpId.value=="") {
 alert('�����ȣ�� �Է����ֽʽÿ�');
  document.form.txtEmpId.focus();
  return false;
}
 if (document.form.txtTEL.value=="") {
 alert('��ȭ��ȣ�� �Է����ֽʽÿ�');
  document.form.txtTEL.focus();
  return false;
}
}
</script>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" <% IF varinsert<>"ok" THEN %>onload=document.form.txtNAME.focus()<% END If %>>
<form method=post name=form action=pop_id_find.asp onsubmit='return Fncheck()'>
<input type=hidden name=varinsert value=ok>
<table width="346" border="0" cellspacing="0" cellpadding="0" height="249">
  <tr> 
    <td><img src="../enter/images/poptitle_id_find.gif" width="346" height="59"></td>
  </tr>
  <tr> 
    <td height="150" class="table03">
	<!--�����Է� ���̺� ����-->
      <table width="255" border="0" cellspacing="0" cellpadding="0">
      <% IF varInsert<>"ok" THEN %>
        <tr> 
          <td height="15"><img src="../enter/images/yellowgreen_buret.gif" width="7" height="7"></td>
          <td width="5"></td>
          <td class="list13">�̸�</td>
          <td> 
            <input type="text" name="txtNAME" maxlength=15>
          </td>
        </tr>
        <tr> 
          <td colspan="4" height="5"></td>
        </tr>
        <tr> 
          <td height="15"><img src="../enter/images/yellowgreen_buret.gif" width="7" height="7"></td>
          <td width="5"></td>
          <td class="list13">�����ȣ</td>
          <td> 
            <input type="text" name="txtEmpId" maxlength=20>
          </td>
        </tr>
        <tr> 
          <td colspan="4" height="5"></td>
        </tr>
        <tr> 
          <td height="15"><img src="../enter/images/yellowgreen_buret.gif" width="7" height="7"></td>
          <td width="5"></td>
          <td class="list13">��ȭ��ȣ</td>
          <td> 
            <input type="text" name="txtTEL" maxlength=20>
          </td>
        </tr>
        <tr> 
          <td colspan="4" height="5"></td>
        </tr>
        <% ELSE %>
        <tr> 
          <td height="15"><img src="../enter/images/yellowgreen_buret.gif" width="7" height="7"></td>
          <td width="5"></td>
          <td class="list13">���̵�</td>
          <td> 
            <% =rs("ID") %>
          </td>
        </tr>
        <tr> 
          <td colspan="4" height="5"></td>
        </tr>
        <tr> 
          <td height="15"><img src="../enter/images/yellowgreen_buret.gif" width="7" height="7"></td>
          <td width="5"></td>
          <td class="list13">��й�ȣ</td>
          <td> 
            <% =rs("PASSWORD") %>
          </td>
        </tr>
        <tr> 
          <td colspan="4" height="5"></td>
        </tr>
        <% END IF %>
      </table>
	  <!--�����Է� ���̺� ��-->
    </td>
  </tr>
  <tr> 
    <td height="40" class="table02">
	<!--�ϴ� ��ư�� ����--> 
      <table width="346" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td align="right">
          <% IF varInsert="ok" THEN %>
          <img src="../enter/images/confirm_bu.gif" width="53" height="26" border="0" onclick=window.close()>
          <% ELSE %>
          <input type=image src="../enter/images/confirm_bu.gif" width="53" height="26" border="0"></td>
          <% END IF %>
          <td width="15"></td>
        </tr>
      </table>
	  <!--�ϴ� ��ư�� ��-->
    </td>
  </tr>
</table>
</form>
</body>
</html>
