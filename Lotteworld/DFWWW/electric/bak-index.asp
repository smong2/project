<%
' ========================================================================================================
' ���α׷�ID : TXERESULTSCONSTRUCTION
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���� �α���
' �����ۼ��� : 2002/12/10
' �����ۼ��� : 2002/12/10
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

'������ ����
Dim objServer, arrRValue, arrRvalueQ, ArrQuery, ArrQueryQ, Arr '�İ��� ������
Dim rs, rsfirst, rsidlist '���ڵ�� : ����Ȯ��, ó���湮�ߴ��� Ȯ��, ���俹�� ���� ����Ʈ ��ȸ
dim intI,varInsert '��������
Dim VarId, VarPwd '�Է°�

varinsert=Request.Form("varinsert") 

IF varinsert="ok" THEN 'Ȯ�� ��ư�� Ŭ������ ���
varID=Request.Form("txtID")
varPWD=Request.Form("txtPWD") 

ArrQuery = array("ELOGIN",varID,varPWD) '�������� �´� �ڵ� ��������

'������ ����
Set objServer  = Server.CreateObject("XBUserUIQMTS.clsXBUserUIQNTX")

'������Ʈ ȣ��
arrRValue = objServer.Query(ArrQuery)
'���ڵ�� ��̸� ���� ���ڵ������ �и�

'ù��° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rs,1
'ù��° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rsfirst,2
'ù��° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rsidlist,3

'�ڿ��� ����
Set objServer = Nothing

IF rs.eof THEN   '�α��ν� ������ ���ٸ� 
	IF NOT rsidlist.eof AND rsfirst.eof THEN   '���ÿ� ���̵� ����Ʈ�� ������ ��й�ȣ�� Ʋ�������
		Response.Write "<script language=javascript>alert(' ��й�ȣ�� Ʋ�Ƚ��ϴ�. ����� ���� �����ø� �Ʒ� ��й�ȣ ã�⸦ �̿����ֽʽÿ� ')</script>"
		Response.Write "<script language=javascript>history.go(-1)</script>"
		
	ELSEIF rsidlist.eof AND rsfirst.eof THEN  '���̵� ����Ʈ�� ���� erp ���� �α��ε� �ƴ� ���
		Response.Write "������ �����ϴ�."
		Response.Write "<script language=javascript>alert(' ������ �����ϴ�. \n\n ID:�����ȣ, PWD:�ֹι�ȣ \n\n �� �α����Ͻð� ��й�ȣ�� �߱޹����ʽÿ�')</script>"
		Response.Write "<script language=javascript>history.go(-1)</script>"		'�ڷ� ���� ��ũ��Ʈ
	END IF		

ELSE '�α��� ������  
  
  '��Ű ����
  Response.Cookies("ckTime")=right(Year(DATE()),2)&"��"& Month(Date()) & "��"&Day(date()) & "�� "& Hour(time()) &"��"& minute(time())&"��" '�ð� ��Ű
  Response.Cookies("ckID")=rs("ID")  '���̵� ��Ű
  Response.Cookies("ckNAME")=rs("NAME") '�̸� ��Ű
  Response.Cookies("ckAuthlevel")=rs("Authlevel") '���� ��Ű
  Response.cookies("ckConnecttimes")=rs("Connecttimes") '����Ƚ�� ���
  Response.Cookies("cklastconnecttime")=rs("Lastconnecttime") '���ӽð� ��Ű
  
  Response.Write "<script language=javascript>alert(' " & Request.Cookies("ckID") & "�� ȯ���մϴ�\n " & Request.Cookies("ckconnecttimes") & "��° �湮�Դϴ� ')</script>"  
  Response.Write "<script language=javascript>location.replace('frame.asp')</script>"	'�ڷ� ���� ��ũ��Ʈ  
END IF 
 
IF NOT rsidlist.eof AND NOT rsfirst.eof THEN  '���̵� ����Ʈ�� ��������鼭 erp ���� �α����� �� ���
  Response.Write "<script language=javascript>alert(' ��й�ȣ�� �̹� �߱޹����̽��ϴ�. �߱޹��� ��й�ȣ�� ������ֽʽÿ� ')</script>"
  Response.Write "<script language=javascript>history.go(-1)</script>"
ENd IF  

IF NOT rsfirst.eof THEN	 'ó�� �湮���� ���
  Response.Write "<script language=javascript>alert('" & rsfirst(1) & "�� ó������ ���̱���. ��й�ȣ�� �߱޹����ʽÿ� ')</script>"'ó������ �α��� ������� erp ��������..
  Response.Write "<script language=javascript>location.href('../electric/admin/admin_acnt_add.asp?varID=" & rsfirst(0) & "&varNAME=" & rsfirst(1) & "')</script>"
END IF

END IF

'������ ó��
IF Err.Number <> 0 THEN 
	Response.Write Err.Number, Err.Source, Err.Description
	Set objServer = Nothing
	objserver.close
END IF
%>	
<!-- #include file="../electric/script/FnProgramProcess.vbs" -->
<html>
<head>
<title>�α���</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../electric/css/cs_te.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000" background="../electric/images/bg.gif" onload=document.form.txtID.focus()>
<form name=form method=post action=index.asp>
<input type=hidden name=varinsert value=ok>
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
  <tr>
    <td class="table03">
	<!--�α��� ���̺� ����-->
      <table width="496" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td>
		  <!--�α��� �׵θ� ����-->
            <table width="496" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><img src="../electric/images/login_round_edge1.gif" width="23" height="23"></td>
                <td><img src="../electric/images/login_round_top.gif" width="450" height="23"></td>
                <td><img src="../electric/images/login_round_edge2.gif" width="23" height="23"></td>
              </tr>
              <tr>
                <td><img src="../electric/images/login_round_left.gif" width="23" height="269"></td>
                <td>
				<!--�α��� ���� ���̺� ����-->
                  <table width="450" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td><img src="../electric/images/login_main_img.gif" width="450" height="104"></td>
                    </tr>
                    <tr>
                        <td bgcolor="#E6E6E6" height="135" class="table03"> 
                          <!--���̵�/�н����� �Է� ���̺� ����-->
                          <table width="308" border="0" cellspacing="0" cellpadding="0">
                            <tr> 
                              <td> 
                                <table width="231" border="0" cellspacing="0" cellpadding="0">
                                  <tr> 
                                    <td width="85"><img src="../enter/images/login_id.gif" width="79" height="19"></td>
                                    <td width="152" align="center"> 
                                      <input type="text" name="txtID" size="13" tabindex=1>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td colspan="2"><img src="../enter/images/null.gif" width="1" height="10"></td>
                                  </tr>
                                  <tr> 
                                    <td width="79"><img src="../enter/images/login_password.gif" width="79" height="19"></td>
                                    <td width="152" align="center"> 
                                      <input type="password" name="txtPWD" size="13" tabindex=2>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                              <td> 
                                <!--Ȯ��/��� ��ư ����-->
                                <table width="98" border="0" cellspacing="0" cellpadding="0">
                                  <tr> 
                                    <td class="table03"> 
                                      <input type=image src="../enter/images/login_confirm_button.gif" width="46" height="46" border="0" name="image">
                                    </td>
                                    <td width="6"></td>
                                    <td class="table03">
                                    <img src="../enter/images/login_cancel_button.gif" width="46" height="46" border="0" onClick=history.go(-1)></td>
                                  </tr>
                                </table>
                                <!--Ȯ��/��� ��ư ��-->
                              </td>
                            </tr>
                          </table>
                          <!--���̵�/�н����� �Է� ���̺� ��-->
                      </td>
                    </tr>
                    <tr>
                      <td><img src="../electric/images/login_line_img.gif" width="450" height="1"></td>
                    </tr>
                    <tr>
                      <td bgcolor="#E6E6E6" height="29">
					  <!--���̵�/�н����� Ȯ�� ����-->
                        <table width="450" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td width="307"></td>
                            <td width="23" align="center"><img src="../electric/images/login_arrow_icon.gif" width="13" height="13"></td>
                            <td width="120" class="list09"><a href="#"  onclick="window.open('../enter/pop_id_find.asp','idfind','width=346,height=249,left=100,top=200')">ID/Password Ȯ��</a></td>
                          </tr>
                        </table>
						<!--���̵�/�н����� Ȯ�� ��-->
                      </td>
                    </tr>
                  </table>
				  <!--�α��� ���� ���̺� ��-->
                </td>
                <td><img src="../electric/images/login_round_right.gif" width="23" height="269"></td>
              </tr>
              <tr>
                <td><img src="../electric/images/login_round_edge3.gif" width="23" height="23"></td>
                <td><img src="../electric/images/login_round_bottom.gif" width="450" height="23"></td>
                <td><img src="../electric/images/login_round_edge4.gif" width="23" height="23"></td>
              </tr>
            </table>
			<!--�α��� �׵θ� ��-->
          </td>
        </tr>
      </table>
	  <!--�α��� ���̺� ��-->
    </td>
  </tr>
</table>
</form></body>
</html>
