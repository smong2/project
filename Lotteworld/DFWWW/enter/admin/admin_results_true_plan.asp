<!-- #include file="../../enter/script/FnLoginAuth_admin.inc" -->
<%
' ========================================================================================================
' ���α׷�ID : TXT True Plan
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���尴 ������ ��ȹ�Է�
' �����ۼ��� : 2002/11/07
' �����ۼ��� : 2002/11/22
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

'������ ����
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
Dim intI '��������
Dim intInput_Year,intinput_Month,intInput_Day,hidInsert '�Էº���
Dim varModel,lngspecial,lngfree,lngeducinst,lngdutyfree,lngcompany,lngmycustomer,lngetc '�Էº���

hidInsert=Request.Form("hidInsert")  '�Ѿ���� �� ����
intInput_Year=Request.Form("sltInput_year") '�� �Է�
intInput_Month=Request.Form("sltInput_month") '�� �Է�
intInput_Day=Request.Form("sltInput_day") '�� �Է�
lngSpecial=Request.Form("txtSpecial") 'Ư�� �Է�
lngFree=Request.Form("txtFree") '�ʴ�� �Է�
lngEducinst=Request.Form("txtEducinst") '�п�����ȸ �Է�
lngDutyfree=Request.Form("txtDutyfree") '�鼼�� �Է�
lngCompany=Request.Form("txtCompany") '���üƯ�� �Է�
lngMycustomer=Request.Form("txtMycustomer") '���� �մ� ��ñ� �Է�
lngEtc=Request.Form("txtEtc") '��Ÿ �Է�
varModel=Request.Form("rdoModel") '���� �Է�

IF hidInsert="ok" then '���� ��ư�� ������ ��
	ArrQuery = array("vxte",varModel,intInput_Year,intInput_Month,intInput_Day,lngSpecial,lngFree,lngEducinst,lngDutyfree,lngCompany,lngMycustomer,lngEtc,"a")
	'������ ����
	
	Set objServer = Server.CreateObject("XTEnterPlanIMTS.clsXTEnterPlanITX")
	
	'������Ʈ ȣ��
	arrRValue = objServer.Save(ArrQuery)
	
	'�ڿ��� ����
	Set objServer = Nothing
	
	hidInsert="" '�Է� �ʱ�ȭ
end if

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
<script language="javascript"  src="../../enter/script/fnTEnterPlan.js"></script>
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload=document.form.txtSpecial.focus()>
<form method=post action=admin_results_true_plan.asp name=form>
<input type=hidden name=hidInsert value=ok>
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
  <tr> 
    <td width="49"><img src="../../enter/images/null.gif" width="49" height="1"></td>
    <td width="642" valign="top">
	<!--ū ���̺� ����--> 
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="24"><img src="../../enter/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
          <td align="left"><img src="../../enter/images/title_results_true_plan.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="40" valign="top"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td align="right">
		  <!--�Է¿���/�Է����� ���̺� ����--> 
            <table width="436" border="0" cellspacing="0" cellpadding="0" class="title_01">
              <tr>
                <td width="187"><img src="../../enter/images/yellowgreen_buret.gif" width="7" height="7"> 
                  �Է����� 
                 <input type="radio" name="rdoModel" value="model_day">
                  �� 
                  <input type="radio" name="rdoModel" value="model_month">
                  �� 
                  <input type="radio" name="rdoModel" value="model_year">
                  ��</td>
                <td width="249" class="table05"><img src="../../enter/images/yellowgreen_buret.gif" width="7" height="7"> 
                  �Է�����
                    <select name="sltInput_Year">
                    <option>----</option>
                  <%FOR inti=2000 TO 2010					
							Response.Write "<option value=" & intI & ">" & intI & "��</option>"                    						
					NEXT %>
                  </select>                  
                  <select name="sltInput_Month">
                  <option>----</option>
				  <%FOR intI=1 TO 12                   		
							Response.Write "<option value=" & intI & ">" & intI & "��</option>"                    						
					NEXT %>
                  </select>              
                  <select name="sltInput_Day">
                  <option>----</option>
				  <%FOR intI=1 TO 31                  
							Response.Write "<option value=" & intI & ">" & intI & "��</option>"                    						
					NEXT %>
                  </select>
                </td>
             
              </tr>
            </table>
			<!--�Է¿���/�Է����� ���̺� ��-->
          </td>
        </tr>
        <tr> 
          <td height="7"></td>
        </tr>
        <tr> 
          <td>
		  <!--�����尴 ��ȹ���� ���̺� ����--> 
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr bgcolor="#B0DFFD"> 
                <td height="7" colspan="2"></td>
              </tr>
              <tr class="list02_bg2"> 
                <td width="120">�׸�</td>
                <td>�Է�</td>
              </tr>
              <tr> 
                <td class="list13_bg">Ư��</td>
                <td class="table01"> 
                  <input type="text" name="txtSpecial" size="65" maxlength=10>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">�����ʴ��</td>
                <td class="table01"> 
                  <input type="text" name="txtFree" size="65" maxlength=10>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">�п�����ȸ</td>
                <td class="table01"> 
                  <input type="text" name="txtEducinst" size="65" maxlength=10>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">�鼼��</td>
                <td class="table01"> 
                  <input type="text" name="txtDutyfree" size="65" maxlength=10>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">���üƯ��</td>
                <td class="table01"> 
                  <input type="text" name="txtCompany" size="65" maxlength=10>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">���ǼմԸ�ñ�</td>
                <td class="table01"> 
                  <input type="text" name="txtMycustomer" size="65" maxlength=10>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">��Ÿ</td>
                <td class="table01"> 
                  <input type="text" name="txtEtc" size="65" maxlength=10>
                </td>
              </tr>
              <tr bgcolor="#B0DFFD"> 
                <td height="7" colspan="2"></td>
              </tr>
            </table>
			<!--�����尴 ��ȹ���� ���̺� ��-->
          </td>
        </tr>
        <tr> 
          <td height="10"></td>
        </tr>
        <tr> 
          <td height="34" class="table02">
		  <!--�ϴ� ��ư�� ���̺� ����--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td align="right"><input type=image src="../../enter/images/save.gif" width="53" height="26" border="0" onclick='return fncheck()'></td>
                <td width="5"></td>
              </tr>
            </table>
			<!--�ϴ� ��ư�� ���̺� ��-->
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
</body>
</html>
<!-- #include file="../../enter/script/FnErrorCatch.inc"-->