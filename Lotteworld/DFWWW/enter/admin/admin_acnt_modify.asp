<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' ���α׷�ID : User List
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ����� ���� ����
' �����ۼ��� : 2002/12/09
' �����ۼ��� : 2002/12/09
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

Dim objServer, arrRValue,arrRValueUI, ArrQuery, ArrQueryU, Arr '�İ��� ������
Dim rs '���� ���� ��������
dim varInsert,intI '���̵�,��������
Dim txtID, txtPASSWD, txtREPASSWD, txtMOBILE, txtTEL, txtDEPT, sltAUTHLEVEL '����ڰ� ������ ��
DIM TxtDelete '�ɼǰ�

Txtdelete=Request.Form("delete1")
varID=Request("varID")
varInsert=Request.Form("varInsert")

IF varAuthlevel<>2 AND varAuthlevel<>7 AND varID<>Request.Cookies("ckID") THEN '���� ���� ���� ����
Response.Write "<script>alert('�ڱ� ������ ���� �����մϴ�');history.go(-1)</script>"
END IF

IF varInsert="ok" THEN  '������ ���� �Ѿ���� �����մϴ�.
txtREPASSWD=Request.Form("txtREPASSWD") '�н����� ����
txtTEL=Request.Form("txtTEL") '��ȭ��ȣ
txtMOBILE=Request.Form("txtMOBILE") '�ڵ���
txtDEPT=Request.Form("txtDEPT") '�μ�
sltAUTHLEVEL=Request.Form("sltAUTHLEVEL") '����
 
 IF varNAME="" THEN varNAME="1" '��ü�� ����
 IF txtPASSWD="" THEN txtPASSWD=NULL
 IF txtID="" THEN txtID="����"
 IF txtREPASSWD="" THEN txtREPASSWD=NULL

IF txtdelete="delete1" THEN
ArrQueryU =array("Delete",varID,varNAME,txtPASSWD,txtREPASSWD,txtTEL,txtMOBILE,txtDEPT,sltAUTHLEVEL) '���� ��������
ELSE
ArrQueryU =array("Update",varID,varNAME,txtPASSWD,txtREPASSWD,txtTEL,txtMOBILE,txtDEPT,sltAUTHLEVEL) '���� ��������
END IF

Set objServer = Server.CreateObject("XBUserUIQMTS.clsXBUSERUIQTX") '���� ����
arrRvalue=objServer.save(ArrQueryU)

'�ڿ��� ����
Set objServer = Nothing

varInsert="" 
Response.Redirect "admin_acnt_list.asp"

END IF

ArrQuery = array("PerView",varID) '���� ����

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
<html>
<head>
<title>�Ե����� ���俹���ý���</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../../enter/css/cs_tx.css" type="text/css">
<script language='javascript'>
function Fncheck() {
if (document.form.txtDept.value=="") {
 alert("�μ��� �Է����ֽʽÿ�");
 document.form.txtDept.focus();
 return false;
 }
if (document.form.txtTel.value=="") {
 alert("��ȭ�� �Է����ֽʽÿ�");
 document.form.txtTel.focus();
 return false;
 } 
if(confirm("�����Ͻðڽ��ϱ�?")) 
  return true;
 else	
  return false;
}
function Fndelete() {
document.form.delete1.checked = true ;
}
</script>
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload=document.form.txtREPASSWD.focus()>
<form method=post action=admin_acnt_modify.asp name=form onsubmit='return Fncheck()'>
<input type=hidden name=varInsert value=ok>
<input type=hidden name=varID value=<% =varID %>>
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
          <td>
		  <!--��������� ����,���� Ÿ��Ʋ ����-->
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="15" height="11" class="table03"><img src="../../enter/images/orange_buret.gif" width="7" height="7"></td>
                <td class="title_01">���� ����� ����,����</td>
              </tr>
            </table>
			<!--��������� ����,���� Ÿ��Ʋ ��-->
          </td>
        </tr>
        <tr> 
          <td height="5"><img src="../../enter/images/null.gif" width="1" height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--���� ���̺� ����--> 
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr bgcolor="#B0DFFD"> 
                <td height="7" colspan="2"></td>
              </tr>              
              <tr> 
                <td width="100" class="list13_bg">�̸�</td>
                <td class="list01_bg3"><% =rs("NAME") %></td>
              </tr>
              <tr> 
                <td class="list13_bg">���̵�</td>
                <td class="list01_bg3"><% =rs("ID") %></td>
              </tr>              
              <tr> 
                <td class="list13_bg">�����Һ�й�ȣ</td>
                <td class="list01_bg3"><input type=password name=txtREPASSWD maxlength=8> (������й�ȣ�� ���ǰ�쿣 �������� �μ���)</td> 
              </tr>
              <tr> 
                <td class="list13_bg">�μ�</td>
                <td class="table01"> 
                  <input type="text" name="txtDept" size="20" value='<% =rs("DEPT") %>'>
                </td>
              </tr>              
              <tr> 
                <td class="list13_bg">���</td>
                <td class="list01_bg3">
                <% IF varAuthLevel=2 THEN %>                 
                <% IF rs("Authlevel")=1 THEN %>
                <select name=sltAuthlevel>
                <option value=1 selected>���尴 �Ϲ�</option>
                <option value=2>���尴 ����</option>                
                <option value=5>��� ����</option>                
                </select>                 
                <% ELSEIF rs("Authlevel")=2 THEN %>
                <select name=sltAuthlevel>
                <option value=1>���尴 �Ϲ�</option>
                <option value=2 selected>���尴 ����</option>                                
                <option value=5>��� ����</option>
                </select>                 
                <% ELSEIF rs("Authlevel")=5 THEN %>
                <select name=sltAuthlevel>
                <option value=1>���尴 �Ϲ�</option>
                <option value=2>���尴 ����</option>                                
                <option value=5 selected>��� ����</option>
                </select>                                         
                <% END IF %>
                
                <% ELSEIF varAuthLevel=7 THEN %>                 
                <% IF rs("Authlevel")=1 THEN %>
                <select name=sltAuthlevel>
                <option value=1 selected>���尴 �Ϲ�</option>
                <option value=2>���尴 ����</option>
                <option value=3>���� �Ϲ�</option>
                <option value=4>���� ����</option>
                <option value=5>��� ����</option>                
                </select>                 
                <% ELSEIF rs("Authlevel")=2 THEN %>
                <select name=sltAuthlevel>
                <option value=1>���尴 �Ϲ�</option>
                <option value=2 selected>���尴 ����</option>
                <option value=3>���� �Ϲ�</option>
                <option value=4>���� ����</option>
                <option value=5>��� ����</option>
                </select>                 
                <% ELSEIF rs("Authlevel")=5 THEN %>
                <select name=sltAuthlevel>
                <option value=1>���尴 �Ϲ�</option>
                <option value=2>���尴 ����</option>
                <option value=3>���� �Ϲ�</option>
                <option value=4>���� ����</option>
                <option value=5 selected>��� ����</option>
                </select>                                                         
                <% ELSEIF rs("Authlevel")=7 THEN %>
                <select name=sltAuthlevel>
                <option value=1>���尴 �Ϲ�</option>
                <option value=2>���尴 ����</option>
                <option value=3>���� �Ϲ�</option>
                <option value=4>���� ����</option>
                <option value=5>��� ����</option>
                <option value=7 selected>��ü ����</option>
                </select>                                         
                <% END IF %>                                
                <% ELSE %>
                 ���尴 �Ϲ�
                <input type=hidden name=sltAuthlevel value=<% =rs("Authlevel") %>>
                <% END IF %>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">��ȭ</td>
                <td class="table01"> 
                  <input type="text" name="txtTel" size="20" value='<% =rs("TEL") %>'>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">�ڵ���</td>
                <td class="table01">
                  <input type="text" name="txtMobile" size="20" value='<% =rs("MOBILE") %>'>
                </td>
              </tr>
              <tr bgcolor="#B0DFFD"> 
                <td height="7" colspan="2"></td>
              </tr>
            </table>
			<!--���� ���̺� ��-->
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
			    <td width="362"></td>
			    <% IF varAuthLevel=2 or VarAuthlevel=7 THEN %>    
			    <td width="73"><input type=checkbox name=delete1 value=delete1><img src="../../enter/images/delete_bu.gif" width="53" height="26" border="0" align=absmiddle onclick=Fndelete()></td>
			    <% END IF %>
			    <td width="53"><input type=image src="../../enter/images/modity_bu.gif" width="53" height="26" border="0"></td>	
                <td width="76"><img src="../../enter/images/return_bu.gif" width="76" height="26" border="0" onclick=history.go(-1)></td>
                <td width="5"></td>
              </tr>
            </table>
			<!--�ϴ� ��ư�� ��-->
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