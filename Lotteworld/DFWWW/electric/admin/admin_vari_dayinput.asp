<!-- #include file="../../electric/script/FnLoginAuth.inc" -->
<%
' ========================================================================================================
' ���α׷�ID : Admin_vari_dayinput
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� �� ���� �Է� - ���Է�
' �����ۼ��� : 2002/11/26
' �����ۼ��� : 2002/11/26
' ��  ��  �� : �ڼ���(kweather)
' ======================================================================================================== 

'������ ����
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
dim varInsert,varview '�� ����
Dim intI '��������
Dim intYear,intMonth,intDay '��,��,��
Dim	intDummyIMF,intDummyCard '���̺����� / ���̾�Ʈ����,���̷ε��,���̷ν���,IMF,ī�������,����
Dim intduty, intcool, intsaleexist, intvacation '��ȭ�� �޹�, �ù�� ��������, ��������, ���к���
Dim rs '���ڵ�� ��ȸ

varview=Request.QueryString("varview")
varInsert=Request.Form("varInsert")

IF varInsert="ok" THEN '������ �Ѿ�Դٸ�..
intYear = Request.Form("sltYear")
intMonth = Request.Form("sltMonth")
intDay = Request.Form("sltDay")
intDummyIMF = Request.Form("sltIMF")
intDummyCard = Request.Form("sltCard")
intduty=Request.Form("sltduty")
intcool=Request.Form("sltcooler")
intvacation=Request.Form("sltvacation")
intsaleexist=Request.Form("sltsaleexist")

ArrQuery=array("Insert",intYear,intMonth,intDay, intDuty, intCool, intSaleexist, intVacation, intDummyCard, intDummyIMF)

'������ ����
Set objServer = Server.CreateObject("XBEnvDayIMTS.clsXBEnvDayITX")

'������Ʈ ȣ��
arrRValue = objServer.save(ArrQuery)

'�ڿ��� ����
Set objServer = Nothing
END IF

IF varview="ok" THEN '���� ��Ʈ������ �Ѿ�Դٸ� - ��ȸ��
intYear=Request.QueryString("sltYear")
intMonth=Request.QueryString("sltMonth")
intDay=Request.QueryString("sltDay")

ArrQuery=array("View",intYear,intMonth,intDay)

'������ ����
Set objServer = Server.CreateObject("XBEnvDayIMTS.clsXBEnvDayINTX")
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
<!-- #include file="../../electric/script/FnProgramProcess.vbs" -->
<html>
<head>
<title>�Ե����� ���俹���ý���</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../../electric/css/cs_te.css" type="text/css">
<script language=javascript src="../../electric/script/FnAdminVariDayI.js"></script>
</head>
<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form method=post name=form action=admin_vari_dayinput.asp onsubmit='return Fncheck()'>
<input type=hidden name=varInsert value=ok>
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
  <tr> 
    <td width="49"><img src="../../electric/images/null.gif" width="49" height="1"></td>
    <td width="642" valign="top"> 
	<!--ū ���̺� ����-->
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td colspan="2"><img src="../../electric/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
            <td colspan="2"><img src="../../electric/images/title_vari_dayinput.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top" colspan="2"><img src="../../electric/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td align="left">
		  <!--�Է����� �ڽ� ����--> 
            <table border="0" cellspacing="0" cellpadding="0" width="142">
              <tr> 
                <td><img src="../../electric/images/gray_round_s_edge1.gif" width="6" height="6"></td>
                <td><img src="../../electric/images/gray_round_s_edge_top.gif" width="130" height="6"></td>
                <td><img src="../../electric/images/gray_round_s_edge2.gif" width="6" height="6"></td>
              </tr>
              <tr> 
                <td><img src="../../electric/images/gray_round_s_edge_left.gif" width="6" height="20"></td>
                  <td class="title_01_c"><img src="../../electric/images/yellowgreen_buret.gif" width="7" height="7"> 
                    �Է�����: ��</td>
                <td><img src="../../electric/images/gray_round_s_edge_right.gif" width="6" height="20"></td>
              </tr>
              <tr> 
                <td><img src="../../electric/images/gray_round_s_edge3.gif" width="6" height="6"></td>
                <td><img src="../../electric/images/gray_round_s_edge_bottom.gif" width="130" height="6"></td>
                <td><img src="../../electric/images/gray_round_s_edge4.gif" width="6" height="6"></td>
              </tr>
            </table>
			<!--�Է����� �ڽ� ��-->
          </td>
          <td class="table05">
		  <!--�Է����� ����--> 
            <table width="320" border="0" cellspacing="0" cellpadding="0" class="title_01_r">
              <tr> 
                <td><img src="../../electric/images/yellowgreen_buret.gif" width="7" height="7"> 
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
                  <select name="sltMonth">
							<option>--</option>
					<% FOR intI=1 TO 12 %>						
						<% IF intMonth-intI=0 THEN %>
							<option selected value=<% =intI %>><% =intI %>��</option>
						<% ELSE %>	
							<option value=<% =intI %>><% =intI %>��</option>
						<% END IF %>
                    <% NEXT %>
                  </select>
                  <select name="sltDay" onchange=FnDate()>
							<option>--</option>
					<% FOR intI=1 TO 31 %>						
						<% IF intDay-intI=0 THEN %>
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
                <tr bgcolor="#CECFF5"> 
                  <td height="7" colspan="2"></td>
                </tr>
                <tr class="list02_bg2"> 
                  <td width="300">�׸�</td>
                  <td>�Է�</td>
                </tr>
                <tr> 
                  <td class="list13_bg">�ù�� ��������</td>
                  <td class="list01_bg3"> 
                    <select name="sltCooler">
                      <% IF varView="ok" THEN 
						IF rs("COOL")=1 THEN %>
					  <option value="1" selected>1(����)</option>
					  <option value="0">0(�񰡵�)</option>
					  <% ELSE %>
					  <option value="1">1(����)</option>
                      <option value="0" Selected>0(�񰡵�)</option>
                      <% END IF %><% ELSE %>
                      <option value="1" selected>1(����)</option>
                      <option value="0">0(�񰡵�)</option>                        
                      <% END IF %>                      
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td class="list13_bg">��ȭ�� ��������</td>
                  <td class="list01_bg3"> 
                    <select name="sltSaleexist">
                      <% IF varView="ok" THEN 
						IF rs("SaleExist")=1 THEN %>
					  <option value="1" selected>1(����)</option>
					  <option value="0">0(����)</option>
					  <% ELSE %>
					  <option value="1">1(����)</option>
                      <option value="0" Selected>0(����)</option>
                      <% END IF %><% ELSE %>
                      <option value="1">1(����)</option>
                      <option value="0" selected>0(����)</option>                        
                    <% END IF %>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td class="list13_bg">��ȭ�� �޹�����</td>
                  <td class="list01_bg3"> 
                    <select name="sltDuty">
                      <% IF varView="ok" THEN 
						IF rs("Duty")=1 THEN %>
					  <option value="1" selected>1(�޹�)</option>
					  <option value="0">0(���޹�)</option>
					  <% ELSE %>
					  <option value="1">1(�޹�)</option>
                      <option value="0" Selected>0(���޹�)</option>
                      <% END IF %><% ELSE %>
                      <option value="1">1(�޹�)</option>
                      <option value="0" selected>0(���޹�)</option>                        
                    <% END IF %>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td class="list15_bg3">���� ����(2��,7��,8��)</td>
                  <td class="list01_bg3"> 
                    <select name="sltVacation">
                      <% IF varView="ok" THEN 
						IF rs("VACATION")=1 THEN %>
					  <option value="1" selected>1(����)</option>
					  <option value="0">0(�����)</option>
					  <% ELSE %>
					  <option value="1">1(����)</option>
                      <option value="0" Selected>0(�����)</option>
                      <% END IF %><% ELSE %>
                      <option value="1">1(����)</option>
                      <option value="0" selected>0(�����)</option>                        
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
					  <option value="1" selected>����(1)</option>
					  <option value="0">���޾ƴ�(0)</option>
					  <% ELSE %>
					  <option value="1">����(1)</option>
                      <option value="0" Selected>���޾ƴ�(0)</option>
                      <% END IF %><% ELSE %>
                      <option value="1" selected>����(1)</option>
                      <option value="0">���޾ƴ�(0)</option>                        
                    <% END IF %>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td class="list15_bg3">���ħü����</td>
                  <td class="list01_bg3"> 
                    <select name="sltIMF">
                      <% IF varView="ok" THEN 
						IF rs("DummyIMF")=1 THEN %>
					  <option value="1" selected>��������(1)</option>
					  <option value="0">��������ƴ�(0)</option>
					  <% ELSE %>
					  <option value="1">��������(1)</option>
                      <option value="0" Selected>�������(0)</option>
                      <% END IF %><% ELSE %>
                      <option value="1">��������(1)</option>
                      <option value="0" selected>�������(0)</option>                        
                    <% END IF %>
                    </select>
                  </td>
                </tr>
                <tr bgcolor="#CECFF5"> 
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
                <td align="right"><input type=image src="../../electric/images/save.gif" width="53" height="26" border="0"></td>
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
    <td width="49"><img src="../../electric/images/null.gif" width="49" height="1"></td>
    <td bgcolor="#a4a4a4"><img src="../../electric/images/outline.gif" width="1" height="1"></td>
  </tr>
  <tr> 
    <td height="42" colspan="3" align="right" background="../../electric/images/copyright_bg.gif"><img src="../../electric/images/copyright.gif" width="350" height="42"></td>
    <td bgcolor="#a4a4a4" width="1" height="42"><img src="../../electric/images/null.gif"></td>
  </tr>
</table>
</form>
</body>
</html>
<!-- #include file="../../electric/script/FnErrorCatch.inc" -->