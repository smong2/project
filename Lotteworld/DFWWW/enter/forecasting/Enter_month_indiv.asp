<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' ���α׷�ID : Enter_Month_Indiv
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���尴 ���� - ��-����
' �����ۼ��� : 2002/10/16
' �����ۼ��� : 2002/11/21
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

'������ ����
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
Dim rs,rslast, rssum, rslastsum '���ڵ�� : ������, �������, ������ �հ�, ������� �հ�
dim varEnterType '���尴 ����
Dim intI '��������

varEnterType=Request.QueryString("varEnterType")

ArrQuery = array(varEnterType,"indiv")

'������ ����
Set objServer = Server.CreateObject("XTEnterMonthMTS.clsXTEnterMonthNTX")

'������Ʈ ȣ��
arrRValue = objServer.Query(ArrQuery)
'���ڵ�� ��̸� ���� ���ڵ������ �и�

'ù��° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rs,1
'�ι�° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rslast,2
'ù��° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rssum,3
'�ι�° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rslastsum,4

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
<!-- #include file="../../enter/script/FnEnterTypeImage.vbs" -->
<!-- #include file="../../enter/script/fnnumber_format.inc" -->
<html>
<head>
<title>�Ե����� ���俹���ý���</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../../enter/css/cs_tx.css" type="text/css">
</head>
<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
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
          <td align="left"><img src="../../enter/images/<% =FnChangeImage(varEnterType,"Month2") %>" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td> 
		  <!--ǥ ���̺� ����-->
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr class="list07_bg3"> 
                <td colspan="2">����</td>
				<% For intI=0 TO 2 %>
                <td><% =FnDateFormatMonth(Date(),intI) %></td>
                <% rs.MOVENEXT : NEXT  : rs.MOVEFIRST %>
                <td>����</td>
              </tr>
              <tr> 
                <td rowspan="3" class="list02_bg2">��ü</td>
                <td class="list03_bg">������</td>
                <% For intI=0 TO 2 %>
                <td class="list01_bg"><% =FnNumberFormat(rs("indivtotal")) %></td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
                <td class="list04_bg"><% =FnNumberFormat(rssum("indivtotal")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg2">�������</td>
                <% For intI=0 TO 2 %>
                <td class="list01_bg2"><% =FnNumberFormat(rslast("indivtotal")) %></td>
                <% rslast.MOVENEXT : NEXT : rslast.MOVEFIRST %>
                <td class="list04_bg2"><% =FnNumberFormat(rslastsum("indivtotal")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg">�����</td>
                <% For intI=0 TO 2 %>
                <td class="list01_bg"><% =FnPercentFormat(rs("indivtotal"),rslast("indivtotal")) %></td>
                <% rs.MOVENEXT : rslast.MOVENEXT : NEXT : rs.MOVEFIRST : rslast.MOVEFIRST %>
                <td class="list04_bg"><% =FnPercentFormat(rssum("indivtotal"),rslastsum("indivtotal")) %></td>
              </tr>
              <tr align="center"> 
                <td colspan="6"><img src="../../enter/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td rowspan="3" class="list02_bg2">�</td>
                <td class="list03_bg">������</td>
                <% For intI=0 TO 2 %>
                <td class="list01_bg"><% =FnNumberFormat(rs("indivadult")) %></td>
                <% rs.MOVENEXT : NEXT  : rs.MOVEFIRST %>
                <td class="list04_bg"><% =FnNumberFormat(rssum("indivadult")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg2">�������</td>
                <% For intI=0 TO 2 %>
                <td class="list01_bg2"><% =FnNumberFormat(rslast("indivadult")) %></td>                
                <% rslast.MOVENEXT : NEXT  : rslast.MOVEFIRST %>
                <td class="list04_bg2"><% =FnNumberFormat(rslastsum("indivadult")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg">�����</td>
                <% For intI=0 TO 2 %>
                <td class="list01_bg"><% =FnPercentFormat(rs("indivadult"),rslast("indivadult")) %></td>
                <% rs.MOVENEXT : rslast.MOVENEXT : NEXT : rs.MOVEFIRST : rslast.MOVEFIRST %>
                <td class="list04_bg"><% =FnPercentFormat(rssum("indivadult"),rslastsum("indivadult")) %></td>
              </tr>
              <tr align="center"> 
                <td colspan="6"><img src="../../enter/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td rowspan="3" class="list02_bg2">�߰��</td>
                <td class="list03_bg">������</td>
                <% For intI=0 TO 2 %>
                <td class="list01_bg"><% =FnNumberFormat(rs("indivschool")) %></td>
                <% rs.MOVENEXT : NEXT  : rs.MOVEFIRST %>
                <td class="list04_bg"><% =FnNumberFormat(rssum("indivschool")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg2">�������</td>
                <% For intI=0 TO 2 %>
                <td class="list01_bg2"><% =FnNumberFormat(rslast("indivschool")) %></td>                
                <% rslast.MOVENEXT : NEXT  : rslast.MOVEFIRST %>
                <td class="list04_bg2"><% =FnNumberFormat(rslastsum("indivschool")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg">�����</td>
                <% For intI=0 TO 2 %>
                <td class="list01_bg"><% =FnPercentFormat(rs("indivschool"),rslast("indivschool")) %></td>
                <% rs.MOVENEXT : rslast.MOVENEXT : NEXT : rs.MOVEFIRST : rslast.MOVEFIRST %>
                <td class="list04_bg"><% =FnPercentFormat(rssum("indivschool"),rslastsum("indivschool")) %></td>
              </tr>
              <tr align="center"> 
                <td colspan="6"><img src="../../enter/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td rowspan="3" class="list02_bg2">���</td>
                <td class="list03_bg">������</td>
                 <% For intI=0 TO 2 %>
                <td class="list01_bg"><% =FnNumberFormat(rs("indivchild")) %></td>
                <% rs.MOVENEXT : NEXT  : rs.MOVEFIRST %>
                <td class="list04_bg"><% =FnNumberFormat(rssum("indivchild")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg2">�������</td>
                <% For intI=0 TO 2 %>
                <td class="list01_bg2"><% =FnNumberFormat(rslast("indivschool")) %></td>                
                <% rslast.MOVENEXT : NEXT  : rslast.MOVEFIRST %>
                <td class="list04_bg2"><% =FnNumberFormat(rslastsum("indivschool")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg">�����</td>
                <% For intI=0 TO 2 %>
                <td class="list01_bg"><% =FnPercentFormat(rs("indivchild"),rslast("indivchild")) %></td>
                <% rs.MOVENEXT : rslast.MOVENEXT : NEXT : rs.MOVEFIRST : rslast.MOVEFIRST %>
                <td class="list04_bg"><% =FnPercentFormat(rssum("indivchild"),rslastsum("indivchild")) %></td>
              </tr>
              <tr bgcolor="#B0DFFD"> 
                <td height="10" colspan="6"></td>
              </tr>
            </table>
			<!--ǥ ���̺� ��-->
          </td>
        </tr>
        <tr> 
          <td height="10"></td>
        </tr>
        <tr>
		  <td height="34" class="table02">
		  <!--�ϴ� ��ư �� ���̺� ����--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="637" align="right"><a href=../../enter/excel/Enter_month_indiv_excel.asp?varEnterType=<% =varEnterType %>><img border=0 src="../../enter/images/download_button.gif" width="88" height="26"></a></td>
                <td width="5"></td>
              </tr>
            </table>
			<!--�ϴ� ��ư �� ���̺� ��-->
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