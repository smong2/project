<!-- #include file="../../enter/script/FnLoginAuth_admin.inc" -->
<%
' ========================================================================================================
' ���α׷�ID : TXT Rival Input
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���尴 ����� ���Է�
' �����ۼ��� : 2002/11/07
' �����ۼ��� : 2002/11/21
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

'������ ����
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
Dim intI
Dim intInput_Year,intInput_Month '��¥ ����
Dim hidInsert,VarView '���� ����, ��ȸ����
Dim lngIndivAdultEver,lngIndivAdultSeoul,lngGroupAdultEver,lngGroupAdultSeoul,lngIndivSchoolEver,lngIndivSchoolSeoul,lngGroupSchoolEver,lngGroupSchoolSeoul,lngIndivChildEver,lngIndivChildSeoul,lngGroupChildEver,lngGroupChildSeoul '������ ������
Dim rsa,rss,rsc '���ڵ��: ������ ��ȸ , �, �߰��, ���

VarView=Request.QueryString("VarView") '��ȸ ���� 
hidInsert = Request.Form("hidInsert") '�� ����
intInput_Year=Request.Form("sltinput_year") '�� �Է�
intInput_Month=Request.Form("sltinput_month") '�� �Է�
lngIndivAdultEver=Request.Form("txtIndivAdultEver") '�������� ����-� �Է�
lngIndivAdultSeoul=Request.Form("txtIndivAdultSeoul") '���﷣�� ����-� �Է�
lngIndivSchoolEver=Request.Form("txtIndivSchoolEver") '�������� ����-�߰�� �Է�
lngIndivSchoolSeoul=Request.Form("txtIndivSchoolSeoul") '���﷣�� ����-�߰�� �Է�
lngIndivChildEver=Request.Form("txtIndivChildEver") '�������� ����-��� �Է�
lngIndivChildSeoul=Request.Form("txtIndivChildSeoul") '���﷣�� ����-��� �Է�

lngGroupAdultEver=Request.Form("txtGroupAdultEver") '�������� ��ü-� �Է�
lngGroupAdultSeoul=Request.Form("txtGroupAdultSeoul") '���﷣�� ��ü-� �Է�
lngGroupSchoolEver=Request.Form("txtGroupSchoolEver") '�������� ��ü-�߰�� �Է�
lngGroupSchoolSeoul=Request.Form("txtGroupSchoolSeoul") '���﷣�� ��ü-�߰�� �Է�
lngGroupChildEver=Request.Form("txtGroupChildEver") '�������� ��ü-��� �Է�
lngGroupChildSeoul=Request.Form("txtGroupChildSeoul") '���﷣�� ��ü-��� �Է�

if hidInsert="ok" then '������ �Ѿ���� �Էµ�
	ArrQuery = array("Insert",intInput_Year,intInput_Month,lngIndivAdultEver,lngIndivAdultSeoul,lngGroupAdultEver,lngGroupAdultSeoul,lngIndivSchoolEver,lngIndivSchoolSeoul,lngGroupSchoolEver,lngGroupSchoolSeoul,lngIndivChildEver,lngIndivChildSeoul,lngGroupChildEver,lngGroupChildSeoul)

	'������ ����
	Set objServer = Server.CreateObject("XTEnterRivalMIMTS.clsXTEnterRivalMITX")

	'������Ʈ ȣ��
	arrRValue = objServer.Save(ArrQuery)
	'���ڵ�� ��̸� ���� ���ڵ������ �и�

	'�ڿ��� ����
	Set objServer = Nothing

	hidInsert=""
end if

IF VarView="ok" THEN
	intInput_Year=Request.QueryString("sltYear")
	intInput_Month=Request.QueryString("sltMonth") 
	
	ArrQuery = array("View",intInput_Year,intInput_Month)

	'������ ����
	Set objServer = Server.CreateObject("XTEnterRivalMIMTS.clsXTEnterRivalMINTX")

	'������Ʈ ȣ��
	arrRValue = objServer.Query(ArrQuery)
	'���ڵ�� ��̸� ���� ���ڵ������ �и�
	
	'ù��° ���ڵ���� ��̷� ��ȯ
	FnSplitRSArray arrRValue,rsa,1
	'�ι�° ���ڵ���� ��̷� ��ȯ
	FnSplitRSArray arrRValue,rss,2
	'����° ���ڵ���� ��̷� ��ȯ
	FnSplitRSArray arrRValue,rsc,3
	
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
<script language="JavaScript" src="../../enter/script/fnTrivalmonth.js"></script>
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload=document.form.txtIndivadultever.focus()>
<form method=post name=form action=admin_results_rival.asp  onsubmit='return Fncheck()'>
<input type=hidden name=hidInsert value=ok>
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
  <tr> 
    <td width="49"><img src="../../enter/images/null.gif" width="49" height="1"></td>
    <td width="642" valign="top">
	<!--ū ���̺� ����--> 
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="24" colspan="2"><img src="../../enter/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
          <td align="left" colspan="2"><img src="../../enter/images/title_results_rival_monthinput.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top" colspan="2"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--�Է�����:�� Ÿ��Ʋ�ڽ� ����-->
            <table border="0" cellspacing="0" cellpadding="0" width="142" height="32">
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
			<!--�Է�����:�� Ÿ��Ʋ�ڽ� ��-->
          </td>
          <td class="table05">
		  <!--�Է����� ���̺� ����--> 
            <table width="260" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td class="title_01_r"><img src="../../enter/images/yellowgreen_buret.gif" width="7" height="7"> 
                  �Է����� 
                   <select name="sltInput_year">
                   <option>----</option>
                  <%FOR intI=2000 TO 2030 
						IF intInput_Year-intI=0 THEN
							Response.Write "<option selected value=" & intI & ">" & intI & "��</option>"
						ELSE
							Response.Write "<option value=" & intI & ">" & intI & "��</option>"                    
						END IF 
					NEXT %>
                  </select>                  
                  <select name="sltInput_month" onchange=FnDate()>
                  <option>----</option>
				  <%FOR intI=1 TO 12
						IF intInput_Month-intI=0 THEN
							Response.Write "<option selected value=" & intI & ">" & intI & "��</option>"
						ELSE
							Response.Write "<option value=" & intI & ">" & intI & "��</option>"                    
						END IF
					NEXT %>
                  </select>
                </td>                
              </tr>
            </table>
			<!--�Է����� ���̺� ��-->
          </td>
        </tr>
        <tr> 
          <td height="7" colspan="2"></td>
        </tr>
        <tr> 
          <td colspan="2"> 
		  <!--����� ���Է� ���̺� ����-->
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr> 
                <td colspan="4" class="list02_bg4">��������</td>
              </tr>
              <tr class="list02_bg2"> 
                <td width="100">�׸�</td>
                <td>�</td>
                <td>�߰��</td>
                <td>���</td>
              </tr>
              <tr> 
                <td class="list13_bg">����</td>
                <td class="table04"> 
                  <input type="text" name="txtIndivadultever" size="20" maxlength=20 value=<% IF VarView="ok" THEN Response.write rsa("everindiv") %>>
                </td>
                <td class="table04"> 
                  <input type="text" name="txtIndivschoolever" size="20" maxlength=20 value=<% IF VarView="ok" THEN  Response.write rss("everindiv") %>>
                </td>
                <td class="table04"> 
                  <input type="text" name="txtIndivchildever" size="20" maxlength=20 value=<% IF VarView="ok" THEN  Response.write rsc("everindiv") %>>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">��ü</td>
                <td class="table04"> 
                  <input type="text" name="txtGroupadultever" size="20" maxlength=20 value=<% IF VarView="ok" THEN  Response.write rsa("everorg") %>>
                </td>
                <td class="table04"> 
                  <input type="text" name="txtGroupschoolever" size="20" maxlength=20 value=<% IF VarView="ok" THEN Response.write  rss("everorg") %>>
                </td>
                <td class="table04"> 
                  <input type="text" name="txtGroupchildever" size="20" maxlength=20 value=<% IF VarView="ok" THEN  Response.write rsc("everorg") %>>
                </td>
              </tr>
              <tr class="table03"> 
                <td height="15" colspan="7"><img src="../../enter/images/point_line3.gif" width="628" height="1" disabled></td>
              </tr>
              <tr> 
                <td colspan="4" class="list02_bg4">���﷣��</td>
              <tr class="list02_bg2"> 
                <td width="100">�׸�</td>
                <td>�</td>
                <td>�߰��</td>
                <td>���</td>
              </tr>
              <tr> 
                <td class="list13_bg">����</td>
                <td class="table04"> 
                  <input type="text" name="txtIndivadultseoul" size="20" maxlength=20 value=<% IF VarView="ok" THEN  Response.write rsa("seoulindiv") %>>
                </td>
                <td class="table04"> 
                  <input type="text" name="txtIndivschoolseoul" size="20" maxlength=20 value=<% IF VarView="ok" THEN  Response.write rss("seoulindiv") %>>
                </td>
                <td class="table04"> 
                  <input type="text" name="txtIndivchildseoul" size="20" maxlength=20 value=<% IF VarView="ok" THEN  Response.write rsc("seoulindiv") %>>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">��ü</td>
                <td class="table04"> 
                  <input type="text" name="txtGroupadultseoul" size="20" maxlength=20 value=<% IF VarView="ok" THEN  Response.write rsa("seoulorg") %>>
                </td>
                <td class="table04"> 
                  <input type="text" name="txtGroupschoolseoul" size="20" maxlength=20 value=<% IF VarView="ok" THEN  Response.write rss("seoulorg") %>>
                </td>
                <td class="table04"> 
                  <input type="text" name="txtGroupchildseoul" size="20" maxlength=20 value=<% IF VarView="ok" THEN  Response.write rsc("seoulorg") %>>
                </td>
              </tr>
              <tr bgcolor="#B0DFFD"> 
                <td height="7" colspan="4"></td>
              </tr>
            </table>
			<!--����� ���Է� ���̺� ��-->
          </td>
        </tr>
        <tr> 
          <td height="10" colspan="2"></td>
        </tr>
        <tr> 
          <td height="34" colspan="2" class="table02">
		  <!--�ϴ� ��ư�� ���̺� ����--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td align="right"><input type=image src="../../enter/images/save.gif" width="53" height="26" border="0"></td>
                <td width="5"></td>
              </tr>
            </table>
			<!--�ϴ� ��ư�� ���̺� ��-->
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
<!-- include file="../../enter/script/FnErrorCatch.inc"-->
