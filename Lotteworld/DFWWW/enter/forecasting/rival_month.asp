<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' ���α׷�ID : TXTRIVAL MONTH
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ����� ���� - ��
' �����ۼ��� : 2002/10/24
' �����ۼ��� : 2002/10/24
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

'������ ����
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
Dim rs,rssum, rslotte, rslast,rslastsum '���ڵ�� : ����� ����, �����հ�, �Ե� ����, ���� ����, ���� ���� �հ�
Dim intI '��������

ArrQuery = array()

'������ ����
Set objServer = Server.CreateObject("XTEnterRivalMonMTS.clsXTEnterRivalMNTX")

'������Ʈ ȣ�� ������ ����
' ...

'������Ʈ ȣ��
arrRValue = objServer.Query(ArrQuery)
'���ڵ�� ��̸� ���� ���ڵ������ �и�

'ù��° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rs,1
'�ι�° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rslast,2
'����° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rssum,3
'�׹�° ���ڵ���� ��̷� ��ȯ
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
          <td align="left" height="21"><img src="../../enter/images/title_rival_month.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td> 
		  <!--�������� Ÿ��Ʋ �� ����-->
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="15" height="11" class="table03"><img src="../../enter/images/orange_buret.gif" width="7" height="7"></td>
                <td class="title_01">��������</td>
              </tr>
            </table>
			<!--�������� Ÿ��Ʋ �� ��-->
          </td>
        </tr>
        <tr> 
          <td height="5"><img src="../../enter/images/null.gif" width="1" height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--�������� ������ ���̺� ����--> 
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr class="list07_bg4"> 
                <td width="102">����</td>
                <td width="108">���</td>
				<% FOR intI=0 TO 2 %>
                <td width="108"><% =FnDateFormatMonth(Date(),intI) %></td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
                <td width="108">����</td>
              </tr>
              <tr> 
                <td rowspan="3" class="list02_bg2">��ü</td>
                <td class="list03_bg">������</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg"><% =FnNumberFormat(rs("evertotal")) %></td>
                <% rs.MOVENEXT : NEXT %>
                <td class="list04_bg"><% =FnNumberFormat(rssum("evertotal")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg2">�������</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg2"><%=FnNumberFormat(rslast("evertotal")) %></td>
                <% rslast.MOVENEXT : NEXT %>
                <td class="list04_bg2"><% =FnNumberFormat(rslastsum("evertotal")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg">�����</td>
                <% rs.MOVEFIRST : rslast.MOVEFIRST : FOR intI=0 TO 2 %> 
                <td class="list01_bg"><% =FnPercentFormat(rs("evertotal"),rslast("evertotal")) %></td>
                <% rs.MOVENEXT :  rslast.MOVENEXT :   NEXT %>
                <td class="list04_bg"><% =FnPercentFormat(rssum("evertotal"),rslastsum("evertotal"))%></td>
              </tr>
              <tr bgcolor="#B0DFFD"> 
                <td height="10" colspan="6"></td>
              </tr>
            </table>
			<!--�������� ������ ���̺� ��-->
          </td>
        </tr>
        <tr> 
          <td height="30"><img src="../../enter/images/null.gif" width="1" height="30"></td>
        </tr>
        <tr> 
          <td>
		  <!--���﷣�� Ÿ��Ʋ �� ����--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="15" height="11" class="table03"><img src="../../enter/images/orange_buret.gif" width="7" height="7"></td>
                <td class="title_01">���﷣��</td>
              </tr>
            </table>
			<!--���﷣�� Ÿ��Ʋ �� ��-->
          </td>
        </tr>
        <tr> 
          <td height="5"><img src="../../enter/images/null.gif" width="1" height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--���﷣�� ������ ���̺� ����--> 
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr class="list07_bg4"> 
                <td width="102">����</td>
                <td width="108">���</td>
                <% FOR intI=0 TO 2 %>
                <td width="108"><% =FnDateFormatMonth(Date(),intI) %></td>
                <% NEXT %>
                <td width="108">����</td>
              </tr>
              <tr> 
                <td rowspan="3" class="list02_bg2">��ü</td>
                <td class="list03_bg">������</td>
                <% rs.MOVEFIRST : FOR intI=0 TO 2 %>
                <td class="list01_bg"><% =FnNumberFormat(rs("seoultotal")) %></td>
                <% rs.MOVENEXT :  NEXT %>
                <td class="list04_bg"><% =FnNumberFormat(rssum("seoultotal")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg2">�������</td>
                <% rslast.MOVEFIRST : FOR intI=0 TO 2 %>
                <td class="list01_bg2"><% =FnNumberFormat(rslast("seoultotal")) %></td>
                <% rslast.MOVENEXT : NEXT %>
                <td class="list04_bg2"><% =FnNumberFormat(rslastsum("seoultotal")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg">�����</td>
                <% rs.MOVEFIRST : rslast.MOVEFIRST : FOR intI=0 TO 2 %>
                <td class="list01_bg"><%=FnPercentFormat(rs("seoultotal"),rslast("seoultotal")) %></td>
                <% rs.MOVENEXT :  rslast.MOVENEXT :  NEXT %>
                <td class="list04_bg"><% =FnPercentFormat(rssum("seoultotal"),rslastsum("seoultotal"))%></td>
              </tr>
              <tr bgcolor="#B0DFFD"> 
                <td height="10" colspan="6"></td>
              </tr>
            </table>
			<!--���﷣�� ������ ���̺� ��-->
          </td>
        </tr>
        <tr> 
          <td height="30"></td>
        </tr>
        <tr>
		<!--�ϴ� ��ư �� ���̺� ����-->
		  <td height="34" class="table02"> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="637" align="right"><a href='../../enter/excel/rival_month_excel.asp'><img border=0 src="../../enter/images/download_button.gif" width="88" height="26"></a></td>
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