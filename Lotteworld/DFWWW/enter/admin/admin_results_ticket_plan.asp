<!-- #include file="../../enter/script/FnLoginAuth_admin.inc" -->
<%
' ========================================================================================================
' ���α׷�ID : TXT Ticket Plan
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���尴 ��ȹ�Է�
' �����ۼ��� : 2002/11/07
' �����ۼ��� : 2002/11/21
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

'������ ����
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
Dim intI,hidInsert '��������, ������
Dim intInput_year,intInput_month,intInput_day,varClass '����� �Է°�
Dim varModel,lngSpecial,lngFree,lngEducinst,lngDutyfree,lngCompany,lngMycustomer,lngEtc '����� �Է°�
DIM varview '�� ����
DIM rs '������ ���ڵ��

varview = Request.QueryString("varview")
hidInsert=Request.Form("hidInsert") '�� ����
intinput_Year=Request.Form("sltinput_year") '�� �Է�
intinput_Month=Request.Form("sltinput_month") '�� �Է�
intinput_Day=Request.Form("sltinput_day") '�� �Է�
lngSpecial=Request.Form("txtspecial") 'Ư�� �Է�
lngFree=Request.Form("txtfree") '�ʴ�� �Է�
lngEducinst=Request.Form("txteducinst") '�п�����ȸ �Է�
lngDutyfree=Request.Form("txtdutyfree") '�鼼�� �Է�
lngCompany=Request.Form("txtcompany") '���üƯ�� �Է�
lngMycustomer=Request.Form("txtmycustomer") '���� �մ� ��ñ� �Է�
lngEtc=Request.Form("txtetc") '��Ÿ �Է�
varModel=Request.Form("rdomodel") '����  �Է�
varClass=Request.Form("rdoClass") '�, �߰��, ��� �Է�


IF intinput_day = "----" THEN intinput_day = 1  '������ �ʱⰪ�� �ش�
IF lngspecial = "" THEN lngspecial = 0
IF lngFree = "" THEN lngFree = 0
IF lngEducinst = "" THEN lngEducinst = 0
IF lngDutyfree = "" THEN lngDutyfree = 0
IF lngCompany = "" THEN lngCompany = 0
IF lngMycustomer = "" THEN lngMycustomer = 0
IF lngEtc = "" THEN lngEtc = 0


if varview = "ok" then
	intInput_Year = Request.QueryString("sltInput_Year")
	intInput_Month = Request.QueryString("sltInput_Month")
	intInput_Day = Request.QueryString("sltInput_Day")
	varmodel = Request.QueryString("rdomodel")
	varclass = Request.QueryString("rdoclass")
	
	ArrQuery = array("VIEW","vxt",varModel,intInput_Year,intInput_Month,intInput_Day,lngSpecial,lngFree,lngEducinst,lngDutyfree,lngCompany,lngMycustomer,lngEtc,varClass)
	'������ ����
	Set objServer = Server.CreateObject("XTEnterPlanIMTS.clsXTEnterPlanINTX")
	'������Ʈ ȣ��
    arrRValue = objServer.Query(ArrQuery)
  
	'ù��° ���ڵ���� ��̷� ��ȯ
	FnSplitRSArray arrRValue,rs,1
  
    '�ڿ��� ����
	Set objServer = Nothing	
	
end if



if hidInsert="ok" then '�Է¹�ư�� ������ ��
	ArrQuery = array("INSERT","vxt",varModel,intInput_Year,intInput_Month,intInput_Day,lngSpecial,lngFree,lngEducinst,lngDutyfree,lngCompany,lngMycustomer,lngEtc,varClass)
	'������ ����
	Set objServer = Server.CreateObject("XTEnterPlanIMTS.clsXTEnterPlanITX")
	'������Ʈ ȣ��
    arrRValue = objServer.Save(ArrQuery)
  
    '�ڿ��� ����
	Set objServer = Nothing	
	
	hidInsert=""
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
<script language="javascript"  src="../../enter/script/fnTEnterPlan.js">
</script>
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload=document.form.txtSpecial.focus()>
<form method=post action=admin_results_ticket_plan.asp name=form>
<input type=hidden name=hidInsert value=ok>
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
  <tr> 
    <td width="49"><img src="../../enter/images/null.gif" width="49" height="1"></td>
    <td width="642" valign="top">
	<!--ū ���̺� ����--> 
      <table width="642" border="0" cellspacing="0" cellpadding="0" class="title_01">
        <tr> 
          <td height="24"><img src="../../enter/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
          <td align="left"><img src="../../enter/images/title_results_ticket_plan.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="40" valign="top"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--�Է����� ���̺� ����--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="18"></td>
                <td width="70" class="title_01"><img src="../../enter/images/yellowgreen_buret.gif" width="7" height="7"> 
                  �Է�����</td>
                <td width="192">
				<!--��/��/�� �Է� ����--> 
                  <table border="0" cellspacing="0" cellpadding="0" width="182">
                    <tr> 
                      <td><img src="../../enter/images/gray_round_s_edge1.gif" width="6" height="6"></td>
                      <td><img src="../../enter/images/gray_round_s_edge_top.gif" width="170" height="6"></td>
                      <td><img src="../../enter/images/gray_round_s_edge2.gif" width="6" height="6"></td>
                    </tr>
                    <tr> 
                      <td><img src="../../enter/images/gray_round_s_edge_left.gif" width="6" height="20"></td>
                      <td class="title_01_c"> 
                        <% IF varmodel="model_day" THEN %>                      
                        <input type="radio" name="rdoModel" value="model_day" checked>�� 
                        <input type="radio" name="rdoModel" value="model_month">�� 
                        <input type="radio" name="rdoModel" value="model_year">��
						<% ELSEIF varmodel="model_month" THEN %>                      
                        <input type="radio" name="rdoModel" value="model_day">�� 
                        <input type="radio" name="rdoModel" value="model_month" checked>�� 
                        <input type="radio" name="rdoModel" value="model_year">��
						<% ELSEIF varmodel="model_year" THEN %>
                        <input type="radio" name="rdoModel" value="model_day">�� 
                        <input type="radio" name="rdoModel" value="model_month">�� 
                        <input type="radio" name="rdoModel" value="model_year" checked>��
						<% ELSE %>                      
                        <input type="radio" name="rdoModel" value="model_day">�� 
                        <input type="radio" name="rdoModel" value="model_month">�� 
                        <input type="radio" name="rdoModel" value="model_year">��
						<% END IF %>
                        </td>
                      <td><img src="../../enter/images/gray_round_s_edge_right.gif" width="6" height="20"></td>
                    </tr>
                    <tr> 
                      <td><img src="../../enter/images/gray_round_s_edge3.gif" width="6" height="6"></td>
                      <td><img src="../../enter/images/gray_round_s_edge_bottom.gif" width="170" height="6"></td>
                      <td><img src="../../enter/images/gray_round_s_edge4.gif" width="6" height="6"></td>
                    </tr>
                  </table>
				  <!--��/��/�� �Է� ��-->
                </td>
                <td width="362">
				<!--�/�߰��/��� �Է� ����--> 
                  <table border="0" cellspacing="0" cellpadding="0" width="212">
                    <tr> 
                      <td><img src="../../enter/images/gray_round_s_edge1.gif" width="6" height="6"></td>
                      <td><img src="../../enter/images/gray_round_s_edge_top.gif" width="200" height="6"></td>
                      <td><img src="../../enter/images/gray_round_s_edge2.gif" width="6" height="6"></td>
                    </tr>
                    <tr> 
                      <td><img src="../../enter/images/gray_round_s_edge_left.gif" width="6" height="20"></td>
                      <td class="title_01_c"> 
                      <% IF varClass="A" THEN %>
                        <input type="radio" name="rdoClass" value="A" checked>� 
                        <input type="radio" name="rdoClass" value="S">�߰�� 
                        <input type="radio" name="rdoClass" value="C">���
                      <% ELSEIF varClass="S" THEN %>
                        <input type="radio" name="rdoClass" value="A">� 
                        <input type="radio" name="rdoClass" value="S" checked>�߰�� 
                        <input type="radio" name="rdoClass" value="C">���
                      <% ELSEIF varClass="C" THEN %>
                        <input type="radio" name="rdoClass" value="A">� 
                        <input type="radio" name="rdoClass" value="S">�߰�� 
                        <input type="radio" name="rdoClass" value="C" checked>���
                      <% ELSE %>  
                        <input type="radio" name="rdoClass" value="A">� 
                        <input type="radio" name="rdoClass" value="S">�߰�� 
                        <input type="radio" name="rdoClass" value="C">���
                      <% END IF %>
                      </td>
                      <td><img src="../../enter/images/gray_round_s_edge_right.gif" width="6" height="20"></td>
                    </tr>
                    <tr> 
                      <td><img src="../../enter/images/gray_round_s_edge3.gif" width="6" height="6"></td>
                      <td><img src="../../enter/images/gray_round_s_edge_bottom.gif" width="200" height="6"></td>
                      <td><img src="../../enter/images/gray_round_s_edge4.gif" width="6" height="6"></td>
                    </tr>
                  </table>
				  <!--�/�߰��/��� �Է� ��-->
                </td>
              </tr>
            </table>
			<!--�Է����� ���̺� ����-->
          </td>
        </tr>
        <tr>
          <td height="35" valign="bottom">
		  <!--�Է����� ����--> 
            <table width="333" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="18"></td>
                <td width="70" class="title_01"><img src="../../enter/images/yellowgreen_buret.gif" width="7" height="7"> 
                  �Է�����</td>
                <td> 
                  <select name=sltInput_Year>
					<option>----</option>
                    <% FOR intI=2000 TO 2030 	
                        IF intinput_Year-inti=0 THEN
							Response.Write "<option value=" & intI & " selected>" & intI & "��</option>"
						ELSE	
							Response.Write "<option value=" & intI & ">" & intI & "��</option>"
						END IF	
					   NEXT %>
                  </select>                  
                  <select name=sltInput_Month>
                   <option>----</option>
				  <% FOR intI=1 to 12
						IF intInput_Month-inti=0 THEN
							Response.Write "<option value=" & intI & " selected>" & intI & "��</option>"
						ELSE							
							Response.Write "<option value=" & intI & ">" & intI & "��</option>"
						END IF
					NEXT %>
                  </select>              
                  <select name=sltInput_Day onchange=FnDate()>
				   <option>----</option>
				  <% FOR intI=1 to 31
						IF intInput_Day-inti=0 THEN
							Response.Write "<option value=" & intI & " selected>" & intI & "��</option>"
						ELSE	
							Response.Write "<option value=" & intI & ">" & intI & "��</option>"
						END IF
					NEXT %>
				  </select>
                </td>                
              </tr>
            </table>
			<!--�Է����� ��-->
          </td>
        </tr>
        <tr> 
          <td height="15"></td>
        </tr>
        <tr> 
          <td> 
		  <!--��ǥ���尴 ��ȹ���� ���̺� ����-->
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
                  <input type="text" name="txtSpecial" size="65" maxlength=20 value=<% IF varView="ok" THEN Response.Write rs("special") %>>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">�����ʴ��</td>
                <td class="table01"> 
                  <input type="text" name="txtFree" size="65" maxlength=20 value=<% IF varView="ok" THEN Response.Write rs("free") %>>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">�п�����ȸ</td>
                <td class="table01"> 
                  <input type="text" name="txtEducinst" size="65" maxlength=20 value=<% IF varView="ok" THEN Response.Write rs("educinst") %>>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">�ؿܴ�ü</td>
                <td class="table01"> 
                  <input type="text" name="txtDutyfree" size="65" maxlength=20 value=<% IF varView="ok" THEN Response.Write rs("dutyfree") %>>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">���üƯ��</td>
                <td class="table01"> 
                  <input type="text" name="txtCompany" size="65" maxlength=20 value=<% IF varView="ok" THEN Response.Write rs("Company") %>>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">���ǼմԸ�ñ�</td>
                <td class="table01"> 
                  <input type="text" name="txtMycustomer" size="65" maxlength=20 value=<% IF varView="ok" THEN Response.Write rs("Mycustomer") %>>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">��Ÿ</td>
                <td class="table01"> 
                  <input type="text" name="txtEtc" size="65" maxlength=20 value=<% IF varView="ok" THEN Response.Write rs("ETC") %>>
                </td>
              </tr>
              <tr bgcolor="#B0DFFD"> 
                <td height="7" colspan="2"></td>
              </tr>
            </table>
			<!--��ǥ���尴 ��ȹ���� ���̺� ��-->
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
</form>
</html>
<!-- #include file="../../enter/script/FnErrorCatch.inc"-->