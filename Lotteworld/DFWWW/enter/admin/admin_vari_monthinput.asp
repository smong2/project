<!-- #include file="../../enter/script/FnLoginAuth_admin.inc" -->
<%
' ========================================================================================================
' ���α׷�ID : Admin_vari_Monthinput
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� �� ���� �Է� - ���Է�
' �����ۼ��� : 2002/11/26
' �����ۼ��� : 2002/11/26
' ��  ��  �� : �ڼ���(kweather)
' ======================================================================================================== 

'������ ����
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
dim varInsert, varview '�� ����
Dim intI '��������
Dim intYear,intMonth '��,��
Dim	intDummyGiantRoof,intDummyGyroDrop,intDummyGyroSwing,intDummyIMF,intDummyCard,intSnowFall '���̺����� / ���̾�Ʈ����,���̷ε��,���̷ν���,IMF,ī�������,����
Dim	lngHOSTS,lngDepartmentDutyMonth,intConstruction 'ȣ��Ʈ��,��ȭ���޹��ϼ�,���������
Dim	lngKOSPI,lngManufacturingKOSPI,lngFinancialKOSPI,lngDistributionKOSPI, lngRepairIndex 'KOSPI,������,������,�����
Dim rs '���ڵ�� ��ȸ����

varView=Request.QueryString("varview")
varInsert=Request.Form("varInsert")

IF varInsert="ok" THEN '������ �Ѿ�Դٸ�..
intYear = Request.Form("sltYear")
intMonth = Request.Form("sltMonth")
intDummyGiantRoof = Request.Form("sltGiantRoof")
intDummyGyroDrop = Request.Form("sltGyroDrop")
intDummyGyroSwing = Request.Form("sltGyroSwing")
intDummyIMF = Request.Form("sltIMF")
intDummyCard = Request.Form("sltCard")
intSnowFall = Request.Form("txtSnowFall")
lngHOSTS = Request.Form("txtHOSTS")
lngDepartmentDutyMonth = Request.Form("txtDepartment")
lngRepairIndex=Request.Form("txtRepairIndex")
intConstruction = Request.Form("txtConstruction")
lngKOSPI = Request.Form("txtKOSPI")
lngManufacturingKOSPI = Request.Form("txtManufacturing")
lngFinancialKOSPI = Request.Form("txtFinancial")
lngDistributionKOSPI = Request.Form("txtDistribution")

IF intDummyGiantRoof="" THEN intDummyGiantRoof=11
IF intDummyGyroDrop="" THEN intDummyGyroDrop=11
IF intDummyGyroSwing="" THEN intDummyGyroSwing=11
IF intDummyIMF="" THEN intDummyIMF=11
IF intDummyCard="" THEN intDummyCard=11
IF intSnowFall="" THEN intSnowFall=11
IF lngHOSTS="" THEN lngHOSTS=9999999999.99999
IF lngDepartmentDutyMonth="" THEN lngDepartmentDutyMonth=9999999999.99999
IF lngRepairIndex="" THEN lngRepairIndex=9999999999.99999
IF intConstruction="" THEN intConstruction=9999999999.99999
IF lngKOSPI="" THEN lngKOSPI=9999999999.99999
IF lngManufacturingKOSPI="" THEN lngManufacturingKOSPI=9999999999.99999
IF lngFinancialKOSPI="" THEN lngFinancialKOSPI=9999999999.99999
IF lngDistributionKOSPI="" THEN lngDistributionKOSPI=9999999999.99999

ArrQuery=array("Insert",intYear,intMonth,intDummyGiantRoof,intDummyGyroDrop,intDummyGyroSwing,intDummyIMF,intDummyCard,intSnowFall,lngHOSTS,lngDepartmentDutyMonth,intConstruction,lngKOSPI,lngManufacturingKOSPI,lngFinancialKOSPI,lngDistributionKOSPI,lngRepairIndex)

'������ ����
Set objServer = Server.CreateObject("XBEnvMonthIMTS.clsXBEnvMonthITX")

'������Ʈ ȣ��
arrRValue = objServer.save(ArrQuery)

'�ڿ��� ����
Set objServer = Nothing

varInsert="" '�� ���� �����..
END IF

IF varview="ok" THEN '��ȸ�� �۵�
intYear=Request.QueryString("sltYear")
intMonth=Request.QueryString("sltMonth")

ArrQuery=array("View",intYear,intMonth)

'������ ����
Set objServer = Server.CreateObject("XBEnvMonthIMTS.clsXBEnvMonthINTX")
'������Ʈ ȣ��
	arrRValue = objServer.Query(ArrQuery)

	'���ڵ�� ��̸� ���� ���ڵ������ �и�
	
	'ù��° ���ڵ���� ��̷� ��ȯ
	FnSplitRSArray arrRValue,rs,1
	
	'�ڿ��� ����
	Set objServer = Nothing
END IF

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
<script language=javascript src="../../enter/script/FnAdminvariMonth.js"></script>
</head>
<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload=document.form.txtHosts.focus()>
<form method=post name=form action=admin_vari_monthinput.asp onsubmit='return Fncheck(form)'>
<input type=hidden name=varInsert value=ok>
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
  <tr> 
    <td width="49"><img src="../../enter/images/null.gif" width="49" height="1"></td>
    <td width="642" valign="top"> 
	<!--ū ���̺� ����-->
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td colspan="2"><img src="../../enter/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
          <td colspan="2"><img src="../../enter/images/title_vari_monthinput.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top" colspan="2"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td align="left">
		  <!--�Է����� �ڽ� ����--> 
            <table border="0" cellspacing="0" cellpadding="0" width="142">
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge1.gif" width="6" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge_top.gif" width="130" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge2.gif" width="6" height="6"></td>
              </tr>
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge_left.gif" width="6" height="20"></td>
                <td class="title_01_c"><img src="../../enter/images/yellowgreen_buret.gif" width="7" height="7"> 
                  �Է�����: ��</td>
                <td><img src="../../enter/images/gray_round_s_edge_right.gif" width="6" height="20"></td>
              </tr>
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge3.gif" width="6" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge_bottom.gif" width="130" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge4.gif" width="6" height="6"></td>
              </tr>
            </table>
			<!--�Է����� �ڽ� ��-->
          </td>
          <td class="table05">
		  <!--�Է����� ����--> 
            <table width="320" border="0" cellspacing="0" cellpadding="0" class="title_01_r">
              <tr> 
                <td><img src="../../enter/images/yellowgreen_buret.gif" width="7" height="7"> 
                  ��¥���� 
                  <select name="sltYear">
						<option>--</option>						
					<% FOR intI=2000 TO 2030 %>						
						<% IF intYear-intI=0 THEN %>
						<option selected value=<% =intI %>><% =intI %>��</option>
						<% ELSE %>
						<option value=<% =intI %>><% =intI %>��</option>
						<% END IF %>
					<% NEXT %>
                  </select>
                  <select name="sltMonth" onchange=FnDate()>
						<option>--</option>
					<% FOR intI=1 TO 12 %>
						<% IF intMonth-intI=0 THEN %>						
						<option selected value=<% =intI %>><% =intI %>��</option>
						<% ELSE %>
						<option value=<% =intI %>><% =intI %>��</option>
						<% END IF %>
                    <% NEXT %>
                  </select>
                </td>
              </tr>
            </table>
			<!--�Է����� ��-->
          </td>
        </tr>
        <tr> 
          <td height="7" colspan="2"></td>
        </tr>
        <tr> 
          <td colspan="2">
		  <!--�����Է� ���̺� ����--> 
              <table width="642" border="0" cellspacing="1" cellpadding="7">
                <tr bgcolor="#B0DFFD"> 
                  <td height="7" colspan="2"></td>
                </tr>
                <tr class="list02_bg2"> 
                  <td width="300">�׸�</td>
                  <td>�Է�</td>
                </tr>
                <tr> 
                  <td class="list13_bg">���̾�Ʈ���� ��������</td>
                  <td class="list01_bg3"> 
                    <select name="sltGiantRoof">
                    <% IF varView="ok" THEN 
						IF rs("DummyGiantRoof")=1 THEN %>
					  <option value="1" selected>1(��������)</option>
					  <option value="0">0(�������)</option>
					  <% ELSE %>
					  <option value="1">1(��������)</option>
                      <option value="0" Selected>0(�������)</option>
                      <% END IF %><% ELSE %>
                      <option value="1" selected>1(��������)</option>
                      <option value="0">0(�������)</option>                        
                    <% END IF %>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td class="list13_bg">���̷ε�� ��������</td>
                  <td class="list01_bg3"> 
                    <select name="sltGyroDrop">
                      <% IF varView="ok" THEN 
						IF rs("DummyGyroDrop")=1 THEN %>
					  <option value="1" selected>1(��������)</option>
					  <option value="0">0(�������)</option>
					  <% ELSE %>
					  <option value="1">1(��������)</option>
                      <option value="0" Selected>0(�������)</option>
                      <% END IF %><% ELSE %>
                      <option value="1" selected>1(��������)</option>
                      <option value="0">0(�������)</option>                        
                    <% END IF %>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td class="list13_bg">���̷ν��� ��������</td>
                  <td class="list01_bg3"> 
                    <select name="sltGyroSwing">
                      <% IF varView="ok" THEN 
						IF rs("DummyGyroSwing")=1 THEN %>
					  <option value="1" selected>1(��������)</option>
					  <option value="0">0(�������)</option>
					  <% ELSE %>
					  <option value="1">1(��������)</option>
                      <option value="0" Selected>0(�������)</option>
                      <% END IF %><% ELSE %>
                      <option value="1" selected>1(��������)</option>
                      <option value="0">0(�������)</option>                        
                    <% END IF %>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td class="list15_bg3">���ħü����</td>
                  <td class="list01_bg3"> 
                    <select name="sltIMF">
                      <% IF varView="ok" THEN 
                         IF rs("DummyIMF")=0 THEN %>
					  <option value="1">1(��������)</option>
                      <option value="0" Selected>0(�������)</option>
					  <% ELSE %>
					  <option value="1" selected>1(��������)</option>
					  <option value="0">0(�������)</option>					  
                      <% END IF %><% ELSE %>
                      <option value="1">1(��������)</option>
                      <option value="0" selected>0(�������)</option>                        
                    <% END IF %>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td class="list13_bg">ī��� ���޿���</td>
                  <td class="list01_bg3"> 
                    <select name="sltCard">
                      <% IF varView="ok" THEN 
						 IF rs("DummyCard")=1 THEN %>
					  <option value="1" selected>1(��������)</option>
					  <option value="0">0(�������)</option>
					  <% ELSEIF rs("DummyCard")=0 THEN %>
					  <option value="1">1(��������)</option>
                      <option value="0" Selected>0(�������)</option>
                      <% END IF %><% ELSE %>
                      <option value="1" selected>1(��������)</option>
                      <option value="0">0(�������)</option>                        
                    <% END IF %>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td class="list15_bg3">���ͳ� ȣ��Ʈ����(���س��/93���)</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtHosts" size="20" maxlength="20" value=<% IF varview="ok" THEN Response.Write rs("hosts") %>>
                  </td>
                </tr>
                <tr> 
                  <td class="list15_bg3">�����ϼ�(������10cm�̻�)</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtSnowfall" size="20" maxlength="20" value=<% IF varview="ok" THEN Response.Write rs("snowfall") %>>
                    ȸ/��</td>
                </tr>
                <tr> 
                  <td class="list13_bg">��ȭ�� �޹��ϼ�</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtDepartment" size="20" maxlength="20" value=<% IF varview="ok" THEN Response.Write rs("departmentdutymonth") %>>
                    ȸ/��</td>
                </tr>
                <tr> 
                  <td class="list13_bg">���� ��������</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtRepairIndex" size="20" maxlength="20" value=<% IF varview="ok" THEN Response.Write rs("repairMonthlyIndex") %>>
                    ����Ʈ</td>
                </tr>
                <tr> 
                  <td class="list13_bg">�ְ����� �����</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtKOSPI" size="20" maxlength="20" value=<% IF varview="ok" THEN Response.Write rs("KOSPI") %>>
                    ����Ʈ</td>
                </tr>
                <tr> 
                  <td class="list13_bg">������ �ְ����� �����</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtManufacturing" size="20" maxlength="20" value=<% IF varview="ok" THEN Response.Write rs("manufacturingKOSPI") %>>
                    ����Ʈ</td>
                </tr>
                <tr> 
                  <td class="list13_bg">������ �ְ����� �����</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtFinancial" size="20" maxlength="20" value=<% IF varview="ok" THEN Response.Write rs("FinancialKOSPI") %>>
                    ����Ʈ</td>
                </tr>
                <tr> 
                  <td class="list13_bg">����� �ְ����� �����</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtDistribution" size="20" maxlength="20" value=<% IF varview="ok" THEN Response.Write rs("DistributionKOSPI") %>>
                    ����Ʈ </td>
                </tr>
                <tr> 
                  <td class="list13_bg">�Ǽ��� �ְ����� �����</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtConstruction" size="20" maxlength="20" value=<% IF varview="ok" THEN Response.Write rs("ConstructionKOSPI") %>>
                    ����Ʈ </td>
                </tr>
                <tr bgcolor="#B0DFFD"> 
                  <td height="7" colspan="2"></td>
                </tr>
              </table>
			<!--�����Է� ���̺� ��-->
          </td>
        </tr>
        <tr> 
          <td height="10" colspan="2"></td>
        </tr>
        <tr> 
          <td height="34" colspan="2" class="table02">
		  <!--�ϴ� ��ư �� ���̺� ����--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td align="right"><input type=image src="../../enter/images/save.gif" width="53" height="26" border="0"></td>
                <td width="5"></td>
              </tr>
            </table>
			<!--�ϴ� ��ư �� ���̺� ��-->
          </td>
        </tr>
        <tr> 
          <td height="30" colspan="2"></td>
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
<!-- #include file="../../electric/script/FnErrorCatch.inc" -->