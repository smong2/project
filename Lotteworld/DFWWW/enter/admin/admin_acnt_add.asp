<%
' ========================================================================================================
' ���α׷�ID : TXB USER
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� �α��� ���� �߰�
' �����ۼ��� : 2002/12/11
' �����ۼ��� : 2002/12/11
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

'������ ����
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
dim intI,varInsert '��������
Dim varPWD, varDEPT, varTEL, varMOBILE '����� �Է°�

varID=Request.QueryString("varID")  'ó�� �湮�� ����� �����ȣ
varNAME=Request.QueryString("varNAME") '�̸�
varInsert=Request.Form("varInsert")

IF varInsert="ok" THEN '���� ��ư�� ������ ��
varID=Request.Form("txtID")
varNAME=Request.Form("txtNAME")
varPWD=Request.Form("txtPWD")
varDEPT=Request.Form("txtDEPT")
varAUTHLEVEL=Request.Form("txtAUTHLEVEL")
varTEL=Request.Form("txtTEL")
varMOBILE=Request.Form("txtMOBILE")

ArrQuery = array("first",varID,varNAME,varPWD,"����",varTEL,varMOBILE,varDEPT,varAUTHLEVEL) '�������� �´� �ڵ� ��������

'������ ����
Set objServer  = Server.CreateObject("XBUserUIQMTS.clsXBUserUIQTX")

'������Ʈ ȣ��
arrRValue = objServer.save(ArrQuery)

'�ڿ��� ����
Set objServer = Nothing

Response.Write "<script language=javascript>alert(' ������ �����Ǿ����ϴ�. \n ������ �������� �α����Ͻʽÿ�')</script>"
Response.Write "<script language=javascript>location.href('../../enter/index.asp')</script>"
END IF

'������ ó��
IF Err.Number <> 0 THEN 
	Response.Write Err.Number, Err.Source, Err.Description
	Set objServer = Nothing
	objserver.close
END IF
%>
<html>
<head>
<title>�Ե����� ���俹���ý���</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../../enter/css/cs_tx.css" type="text/css">
<script language=javascript src=../../enter/script/FnAdminAcntAdd.js></script>
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload=document.form.txtPWD.focus()>
<form method=post name=form action=admin_acnt_add.asp onsubmit='return FnCheck()'>
<input type=hidden name=varInsert value=ok>
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
  <tr> 
    <td width="49"><img src="../../enter/images/null.gif" width="49" height="1"></td>
    <td width="642" valign="top">
	<!--ū ���̺� ����--> 
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="../../enter/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
          <td><img src="../../enter/images/title_admin_acnt.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td height="15">
		  <!--�����߰� Ÿ��Ʋ ����--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="15" height="11" class="table03"><img src="../../enter/images/orange_buret.gif" width="7" height="7"></td>
                <td class="title_01">���� �߰�</td>
              </tr>
            </table>
			<!--�����߰� Ÿ��Ʋ ��-->
          </td>
        </tr>
        <tr> 
          <td height="5"><img src="../../enter/images/null.gif" width="1" height="5"></td>
        </tr>
        <tr> 
          <td> 
		  <!--�����߰� ���̺� ����-->
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr bgcolor="#B0DFFD"> 
                <td height="7" colspan="2"></td>
              </tr>
              <tr> 
                <td width="100" class="list13_bg">�̸�</td>
                <td class="table01">
                  <input type="text" name="txtName" size="20" value='<% =varNAME %>' maxlength=12 onfocus=blur()>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">���̵�</td>
                <td class="table01">
                  <input type="text" name="txtID" size="20" value='<% =varID %>'  onfocus=blur()>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">��й�ȣ</td>
                <td class="table01">
                  <input type="text" name="txtPWD" size="20" maxlength=8>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">�μ�</td>
                <td class="table01">
                  <input type="text" name="txtDEPT" size="20" maxlength=15>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">���</td>
                <td class="table01">
                  <input type="text" name="txtAuthlevel" size="20" value=1  onfocus=blur()>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">��ȭ</td>
                <td class="table01">
                  <input type="text" name="txtTel" size="20" maxlength=20>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">�ڵ���</td>
                <td class="table01">
                  <input type="text" name="txtMobile" size="20" maxlength=20>
                </td>
              </tr>
              <tr bgcolor="#B0DFFD"> 
                <td height="7" colspan="2"></td>
              </tr>
            </table>
			<!--�����߰� ���̺� ��-->
          </td>
        </tr>
        <tr> 
          <td height="10"></td>
        </tr>
        <tr> 
          <td height="34" class="table02"> 
		  <!--�ϴ� ��ư�� ����-->
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
			    <td width="498"></td>
			    <td><input type=image src="../../enter/images/add_bu.gif" width="53" height="26" border="0"></td>
			    <td width="10"></td>
                <td><img src="../../enter/images/return_bu.gif" width="76" height="26" border="0" onclick=history.go(-1)></td>
                <td width="5"></td>
              </tr>
            </table>
			<!--�ϴ� ��ư�� ����-->
			</td>
			</tr>
			<tr> 
          <td height="30"></td>
        </tr>
      </table>
	  <!--ū ���̺� ��-->
    </td>
    <td width="49"><img src="../../enter/images/null.gif" width="49" height="1"></td>
    <td bgcolor="#a4a4a4"><img src="../../enter/images/outline.gif" width="1" height="1"></td>
  </tr>
  <tr> 
    <td height="42" colspan="3" align="right" background="../../enter/images/copyright_bg.gif"><img src="../../enter/images/copyright.gif" width="350" height="42"></td>
    <td bgcolor="#a4a4a4" width="1" height="42"><img src="../../enter/images/null.gif"></td>
  </tr>
</table>
</form>
</body>
</html>
<!-- #include file="../../enter/script/FnErrorCatch.inc"-->