<!-- #include file="../../enter/script/FnLoginAuth_admin.inc" -->
<%
' ========================================================================================================
' ���α׷�ID : Admin_vari_Yearinput
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� �� ���� �Է� - ���Է�
' �����ۼ��� : 2002/11/26
' �����ۼ��� : 2002/11/26
' ��  ��  �� : �ڼ���(kweather)
' ======================================================================================================== 

'������ ����
Dim objServer, arrRValue, ArrQuery,Arr '�İ��� ������
dim varInsert, varView '�� ����
Dim intI '��������
Dim intYear '��
Dim lngPopNationalAdult,lngPopSeoulSchool,lngPopSeoulChild,PopMetropolisAdult '����� �Է°�
Dim	lngKOSPI,intDummyCard,intDummyIMF,intDummyGyroDrop,intDummyHOSTS
Dim lngManufacturingKOSPI,lngFinancialKOSPI,lngConstructionKOSPI,lngDistributionKOSPI,lngGNI
Dim rs '���ڵ�� ��ȸ����

varview=Request.QueryString("varview")
varInsert=Request.Form("varInsert") '������

IF varInsert="ok" THEN '������ �Ѿ�Դٸ�..
intYear = Request.Form("sltYear")  '�⵵
lngPopNationalAdult= Request.Form("txtPopNationalAdult") '���� �����α�
lngPopSeoulSchool= Request.Form("txtPopSeoulSchool") '���� �߰�� �α�
lngPopSeoulChild= Request.Form("txtPopSeoulChild") '���� ��� �α�
PopMetropolisAdult= Request.Form("txtPopMetropolis") '������ ���� �α�
lngKOSPI= Request.Form("txtKOSPI") 'KOSPI����
intDummyCard= Request.Form("sltDummyCard") 'ī��� ���޿���
intDummyIMF= Request.Form("sltDummyIMF") 'IMF ����
intDummyGyroDrop= Request.Form("sltDummyGyroDrop") '���̷� ���
intDummyHOSTS= Request.Form("txtHOSTS") 'ȣ��Ʈ��
lngManufacturingKOSPI= Request.Form("txtManufacturing") '������
lngFinancialKOSPI= Request.Form("txtFinancial") '������
lngConstructionKOSPI= Request.Form("txtConstruction") '�Ǽ���
lngDistributionKOSPI= Request.Form("txtDistribution") '�����
lngGNI= Request.Form("txtGNI") '��� GNI

IF lngPopNationalAdult ="" THEN lngPopNationalAdult=9999999999.99999
IF lngPopSeoulSchool ="" THEN lngPopSeoulSchool=9999999999.99999
IF lngPopSeoulChild ="" THEN lngPopSeoulChild=9999999999.99999
IF PopMetropolisAdult ="" THEN PopMetropolisAdult=9999999999.99999
IF lngKOSPI ="" THEN lngKOSPI=9999999999.99999
IF intDummyCard ="" THEN intDummyCard=11
IF intDummyIMF ="" THEN intDummyIMF=11
IF intDummyGyroDrop ="" THEN intDummyGyroDrop=11
IF intDummyHOSTS ="" THEN intDummyHOSTS=11
IF lngManufacturingKOSPI ="" THEN lngManufacturingKOSPI=9999999999.99999
IF lngFinancialKOSPI ="" THEN lngFinancialKOSPI=9999999999.99999
IF lngConstructionKOSPI ="" THEN lngConstructionKOSPI=9999999999.99999
IF lngDistributionKOSPI ="" THEN lngDistributionKOSPI=9999999999.99999
IF lngGNI ="" THEN lngGNI=9999999999.99999

ArrQuery=array("Insert",intYear,lngPopNationalAdult,lngPopSeoulSchool,lngPopSeoulChild,PopMetropolisAdult,lngKOSPI,intDummyCard,intDummyIMF,intDummyGyroDrop,intDummyHOSTS,lngManufacturingKOSPI,lngFinancialKOSPI,lngConstructionKOSPI,lngDistributionKOSPI,lngGNI)

'������ ����
Set objServer = Server.CreateObject("XBEnvYearIMTS.clsXBEnvYearITX")  '�Է� ����

'������Ʈ ȣ��
arrRValue = objServer.save(ArrQuery)

'�ڿ��� ����
Set objServer = Nothing

varInsert="" '�� ���� �����..
END IF

IF varview="ok" THEN '��ȸ��
	intYear=Request.QueryString("sltYear")

	ArrQuery=array("View",intYear)

	'������ ����
	Set objServer = Server.CreateObject("XBEnvYearIMTS.clsXBEnvYearINTX")  '�Է� ����

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
<script language='javascript' src=../../enter/script/Fnadmin_vari_yearinput.js></script>
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload=document.form.txtPopNationalAdult.focus()>
<form method=post name=form action=admin_vari_yearinput.asp onsubmit='return Fncheck(this.form)'>
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
          <td colspan="2"><img src="../../enter/images/title_vari_yearinput.gif" width="200" height="21"></td>
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
                <td class="title_01_c"><img src="../images/yellowgreen_buret.gif" width="7" height="7"> 
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
                  �⵵���� 
                  <select name="sltyear" onchange=FnDate()>
						<option>--</option>
                  <% For intI=1995 To 2030 
					IF intYear-intI=0 THEN %>
						<option selected value=<% =intI %>><% =intI %>��</option>
					<% ELSE %>
					    <option value=<% =intI %>><% =intI %>��</option>					
                  <% END IF : NEXT %>
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
                  <td class="list15_bg3">���� �����߰��α� (20~39��)</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtPopNationalAdult" size="20" maxlength="20" value=<% IF varView="ok" THEN Response.Write rs("PopNationalAdult") %>> ��</td>
                </tr>
                <tr> 
                  <td class="list15_bg3">������(����,��õ,���) �����߰��α� (20~39��)</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtPopMetropolis" size="20" maxlength="20" value=<% IF varView="ok" THEN Response.Write rs("PopMetroPolisAdult") %>> ��</td>
                </tr>
                <tr> 
                  <td class="list15_bg3">���� �߰���߰��α� (15~19��)</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtPopSeoulSchool" size="20" maxlength="20" value=<% IF varView="ok" THEN Response.Write rs("PopSeoulSchool") %>> ��</td>
                    
                </tr>
                <tr> 
                  <td class="list15_bg3">���� ����߰��α� (10~14��)</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtPopSeoulChild" size="20" maxlength="20" value=<% IF varView="ok" THEN Response.Write rs("PopSeoulChild") %>> ��</td>                    
                </tr>
                <tr> 
                  <td class="list13_bg">ī��� ���޿���</td>
                  <td class="list01_bg3"> 
                    <select name="sltDummyCard">
                    <% IF varView="ok" THEN 
						IF rs("DummyCard")=1 THEN %>
					  <option value="1" selected>1(��������)</option>
					  <option value="0">0(�������)</option>
					  <% ELSE %>
					  <option value="1">1(��������)</option>
                      <option value="0" Selected>0(�������)</option>
                      <% END IF %>                      
                    <% ELSE %>
                      <option value="1" selected>1(��������)</option>
                      <option value="0">0(�������)</option>                        
                    <% END IF %>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td class="list15_bg3">���ħü����</td>
                  <td class="list01_bg3"> 
                    <select name="sltDummyIMF">
                    <% IF varView="ok" THEN 
						IF rs("DummyIMF")=0 THEN %>
					  <option value="1">1(��������)</option>
                      <option value="0" Selected>0(�������)</option>						  
					  <% ELSE %>
					  <option value="1" selected>1(��������)</option>
					  <option value="0">0(�������)</option>
                      <% END IF %>                      
                    <% ELSE %>
                      <option value="1">1(��������)</option>
                      <option value="0" selected>0(�������)</option>                        
                    <% END IF %>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td class="list13_bg">���̷ε�� ��������</td>
                  <td class="list01_bg3"> 
                    <select name="sltDummyGyroDrop">
                    <% IF varView="ok" THEN 
						IF rs("DummyGyroDrop")=1 THEN %>
					  <option value="1" selected>1(��������)</option>
					  <option value="0">0(�������)</option>
					  <% ELSE %>
					  <option value="1">1(��������)</option>
                      <option value="0" Selected>0(�������)</option>
                      <% END IF %>                      
                    <% ELSE %>
                      <option value="1" selected>1(��������)</option>
                      <option value="0">0(�������)</option>                        
                    <% END IF %>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td class="list15_bg3">���ͳ� ȣ��Ʈ����(���س��/93���)</td>
                  <td class="list01_bg3"> 
                    <input type="txt" name="txtHOSTS" size="20" maxlength="20" value=<% IF varView="ok" THEN Response.Write rs("Hosts") %>>
                  </td>
                </tr>
                <tr> 
                  <td class="list13_bg">�ְ����� �����</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtKOSPI" size="20" maxlength="20" value=<% IF varView="ok" THEN Response.Write rs("Kospi") %>> ����Ʈ</td>                   
                </tr>
                <tr> 
                  <td class="list13_bg">������ �ְ����� �����</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtManufacturing" size="20" maxlength="20" value=<% IF varView="ok" THEN Response.Write rs("ManufacturingKOSPI") %>> ����Ʈ</td>                    
                </tr>
                <tr> 
                  <td class="list13_bg">������ �ְ����� �����</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtFinancial" size="20" maxlength="20" value=<% IF varView="ok" THEN Response.Write rs("FinancialKOSPI") %>> ����Ʈ</td>                    
                </tr>
                <tr> 
                  <td class="list13_bg">����� �ְ����� �����</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtDistribution" size="20" maxlength="20" value=<% IF varView="ok" THEN Response.Write rs("DistributionKOSPI") %>> ����Ʈ</td>                    
                </tr>
                <tr> 
                  <td class="list13_bg">�Ǽ��� �ְ����� �����</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtConstruction" size="20" maxlength="20" value=<% IF varView="ok" THEN Response.Write rs("ConstructionKOSPI") %>> ����Ʈ</td>                    
                </tr>
                <tr> 
                  <td class="list15_bg3">��� �����ѻ���(GNI,����10���)</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtGNI" size="20" maxlength="20" value=<% IF varView="ok" THEN Response.Write rs("GNI") %>> 10���</td>                    
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
<!-- #include file="../../enter/script/FnErrorCatch.inc" -->