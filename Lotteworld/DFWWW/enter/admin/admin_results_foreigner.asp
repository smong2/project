<!-- #include file="../../enter/script/FnLoginAuth_admin.inc" -->
<% 
' ========================================================================================================
' ���α׷�ID : Foreigner Input
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� �ܱ��� �Է�
' �����ۼ��� : 2002/12/09
' �����ۼ��� : 2002/12/09
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
Dim rs '���� ���� ��������
Dim varInsert, varview, intI '���̵�,��������
Dim txttotal, txtetc, txtJapan, txtTaiwan, txtSouthEast, txtyear, txtmonth '����� �Էº���

varView=Request.QueryString("varview")
varInsert=Request.Form("varInsert")

IF varInsert="ok" THEN  '������ ���� �Ѿ����
	txtYear=Request.Form("slt_Year")
	txtMonth=Request.Form("slt_Month")
	txtTotal=Request.Form("txtTotal")
	txtJapan=Request.Form("txtJapan")
	txtTaiwan=Request.Form("txtTaiwan")
	txtsoutheast=Request.Form("txtsoutheast")
	txtEtc=Request.Form("txtEtc")

	ArrQuery =array("Insert",txtyear,txtmonth,txttotal,txtjapan,txttaiwan,txtsoutheast,txtetc) '�Է� ��������

	Set objServer = Server.CreateObject("XBForeignerIMTS.clsXBForeignerITX") '�Է� ����	
	arrRvalue=objServer.save(ArrQuery)	
	
	'�ڿ��� ����
	Set objServer = Nothing
	
	varInsert="" 
END IF

IF VarView="ok" THEN
	txtYear=Request.QueryString("sltYear")
	txtMonth=Request.QueryString("sltMonth")

	ArrQuery =array("View",txtyear,txtmonth) '��ȸ ��������

	Set objServer = Server.CreateObject("XBForeignerIMTS.clsXBForeignerINTX") '�Է� ����
	arrRvalue=objServer.Query(ArrQuery)

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
<script language='javascript' src='../../enter/script/Fnadmin_foreigner.js'></script>
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload=document.form.txtTotal.focus()>
<form method=post name=form action=admin_results_foreigner.asp  onsubmit='return Fncheck()'>
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
          <td colspan="2"><img src="../../enter/images/title_results_foreigner.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top" colspan="2"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td align="left"> 
		  <!--�Է����� Ÿ��Ʋ �ڽ� ����-->
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
			<!--�Է����� Ÿ��Ʋ �ڽ� ��-->
          </td>
          <td class="table05">
		  <!--�Է����� ����--> 
            <table width="320" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td class="title_01_r"><img src="../../enter/images/yellowgreen_buret.gif" width="7" height="7"> 
                  �Է����� 
                  <select name=slt_Year>
                  <option>----</option>
                  <% FOR intI=2000 to 2030 
					IF txtYear-intI=0 THEN %>
                    <option selected value=<% =intI %>><% =intI %>��</option>
                    <% ELSE %>
                    <option value=<% =intI %>><% =intI %>��</option>
                    <% END IF : NEXT %>
                  </select>
                  <select name=slt_Month onchange=FnDate()>
                  <option>----</option>
                  <% FOR intI=1 TO 12 
					IF txtMonth-intI=0 THEN %>
                    <option selected value=<% =intI %>><% =intI %>��</option>
                    <% ELSE %>
                    <option value=<% =inti %>><% =intI %>��</option>
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
		  <!--�Է� ���̺� ����-->
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr bgcolor="#B0DFFD"> 
                <td height="7" colspan="2"></td>
              </tr>
              <tr class="list02_bg2"> 
                <td width="200">�׸�</td>
                <td>�Է�</td>
              </tr>
              <tr> 
                <td class="list13_bg">�ܱ��� �� ���尴</td>
                <td class="table01"> 
                  <input type="text" name="txtTotal" size="65" maxlength=70 value=<% IF varview="ok" THEN Response.Write rs("TOTAL") %>>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">�Ϻ�</td>
                <td class="table01"> 
                  <input type="text" name="txtJapan" size="65" maxlength=70 value=<% IF varview="ok" THEN Response.Write rs("JAPAN") %>>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">�븸</td>
                <td class="table01"> 
                  <input type="text" name="txtTaiwan" size="65" maxlength=70 value=<% IF varview="ok" THEN Response.Write rs("TAIWAN") %>>
                </td>
              </tr>
              <tr>
                <td class="list13_bg">������</td>
                <td class="table01">
                  <input type="text" name="txtSouthEast" size="65" maxlength=70 value=<% IF varview="ok" THEN Response.Write rs("SOUTHEAST") %>>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">��Ÿ</td>
                <td class="table01"> 
                  <input type="text" name="txtEtc" size="65" maxlength=70 value=<% IF varview="ok" THEN Response.Write rs("ETC") %>>
                </td>
              </tr>
              <tr bgcolor="#B0DFFD"> 
                <td height="7" colspan="2"></td>
              </tr>
            </table>
			<!--�Է� ���̺� ��-->
          </td>
        </tr>
        <tr> 
          <td height="10" colspan="2"></td>
        </tr>
        <tr> 
          <td height="34" colspan="2" class="table02"> 
		  <!--�ϴ� ��ư�� ����-->
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td align="right"><input type=image src="../../enter/images/save.gif" width="53" height="26" border="0"></td>
                <td width="5"></td>
              </tr>
            </table>
			<!--�ϴ� ��ư�� ��-->
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
<!-- #include file="../../enter/script/FnErrorCatch.inc"-->
