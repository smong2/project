<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' ���α׷�ID : VISITOR_TICKET_YEAR_GROUP
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���尴 ���� - ��-��ü
' �����ۼ��� : 2002/10/16
' �����ۼ��� : 2002/10/18
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

'������ ����
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
Dim rs,rslast, rssum, rslastsum  '���ڵ�� : ������, �������, ������ �հ�, ������� �հ�
dim varEnterType '���尴 ����
Dim intI '��������

varEnterType=Request.QueryString("varEnterType")

ArrQuery = array(varEnterType,"group")

'������ ����
Set objServer = Server.CreateObject("XTEnterYearMTS.clsXTEnterYearNTX")

'������Ʈ ȣ��
arrRValue = objServer.Query(ArrQuery)
'���ڵ�� ��̸� ���� ���ڵ������ �и�

'ù��° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rs,1
'�ι�° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rslast,2

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
          <td align="left"><img src="../../enter/images/<% =FnChangeImage(varEnterType,"year3") %>" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td> 
		  <!--ǥ ���̺� ����-->
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr class="list07_bg3"> 
                <td>����</td>
                <td><% =YEAR(Date())-1 %>��</td>
                <% For intI=0 TO 1 %>
                <td><% =YEAR(Date())+intI %>��</td>
                <% NEXT %>                
              </tr>
              <tr> 
                <td width="192" class="list02_bg2">��ü ��ü</td>
				<td width="150" class="list01_bg"><% =FnNumberFormat(rslast("grouptotal")) %></td>
				<% For intI=0 TO 1 %>
                <td width="150" class="list01_bg"><% =FnNumberFormat(rs("grouptotal")) %></td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
              </tr>
              <tr align="center"> 
                <td colspan="4"><img src="../../enter/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td class="list02_bg2">�</td>
                <td class="list01_bg"><% =FnNumberFormat(rslast("groupadult")) %></td>
                <% For intI=0 TO 1 %>
                <td class="list01_bg"><% =FnNumberFormat(rs("groupadult")) %></td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
              </tr>
              <tr> 
                <td class="list02_bg3">�߰��</td>
                <td class="list01_bg2"><% =FnNumberFormat(rslast("groupschool")) %></td>
                <% For intI=0 TO 1 %>
                <td class="list01_bg2"><% =FnNumberFormat(rs("groupschool")) %></td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
              </tr>
              <tr> 
                <td class="list02_bg2">���</td>
                <td class="list01_bg"><% =FnNumberFormat(rslast("groupchild")) %></td>
                <% For intI=0 TO 1 %>
                <td class="list01_bg"><% =FnNumberFormat(rs("groupchild")) %></td>
                <% rs.MOVENEXT : NEXT  %>
              </tr>
              <tr bgcolor="#B0DFFD"> 
                <td height="10" colspan="7"></td>
              </tr>
            </table>
			<!--ǥ ���̺� ����-->
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
                <td width="637" align="right"><a href=../../enter/excel/Enter_year_group_excel.asp?varEnterType=<%=varEnterType%>><img border=0 src="../../enter/images/download_button.gif" width="88" height="26"></a></td>
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