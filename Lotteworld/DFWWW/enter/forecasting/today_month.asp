<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' ���α׷�ID : today month
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���尴 ���� - today month
' �����ۼ��� : 2002/10/16
' �����ۼ��� : 2002/10/18
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

'������ ����
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
Dim rsvxt, rsvxte '���ڵ�� : ��ǥ���� ����, ������ ����

ArrQuery = array()

'������ ����
Set objServer = Server.CreateObject("XTTodayMonthMTS.clsXTTodayMonthNTX")

'������Ʈ ȣ�� ������ ����
' ...

'������Ʈ ȣ��
arrRValue = objServer.Query(ArrQuery)
'���ڵ�� ��̸� ���� ���ڵ������ �и�

'ù��° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rsvxt,1
'�ι�° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rsvxte,2

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
          <td align="left"><img src="../../enter/images/title_today_month.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--������(��) ���̺� ����--> 
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr class="list02_bg"> 
                <td colspan="2">����</td>
                <td>��ǥ���尴</td>
                <td>�����尴</td>
              </tr>
              <tr> 
                <td width="100" rowspan="4" class="list02_bg2">����</td>
                <td width="142" class="list03_bg">�</td>
                <td width="200" class="list01_bg"><% =FnNumberFormat(rsvxt("indivadult")) %></td>
                <td width="200" class="list01_bg"><% =FnNumberFormat(rsvxte("indivadult")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg2">�߰��</td>
                <td class="list01_bg2"><% =FnNumberFormat(rsvxt("indivschool")) %></td>
                <td class="list01_bg2"><% =FnNumberFormat(rsvxte("indivschool")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg">���</td>
                <td class="list01_bg"><% =FnNumberFormat(rsvxt("indivchild")) %></td>
                <td class="list01_bg"><% =FnNumberFormat(rsvxte("indivchild")) %></td>
              </tr>
              <tr> 
                <td class="list02_bg3">�Ұ�</td>
                <td class="list04_bg2"><% =FnNumberFormat(rsvxt("indivtotal")) %></td>
                <td class="list04_bg2"><% =FnNumberFormat(rsvxte("indivtotal")) %></td>
              </tr>
              <tr align="center"> 
                <td colspan="4"><img src="../../enter/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td rowspan="4" class="list02_bg2">��ü</td>
                <td class="list03_bg">�</td>
                <td class="list01_bg"><% =FnNumberFormat(rsvxt("groupadult")) %></td>
                <td class="list01_bg"><% =FnNumberFormat(rsvxte("groupadult")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg2">�߰��</td>
                <td class="list01_bg2"><% =FnNumberFormat(rsvxt("groupschool")) %></td>
                <td class="list01_bg2"><% =FnNumberFormat(rsvxte("groupschool")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg">���</td>
                <td class="list01_bg"><% =FnNumberFormat(rsvxt("groupchild")) %></td>
                <td class="list01_bg"><% =FnNumberFormat(rsvxte("groupchild")) %></td>
              </tr>
              <tr> 
                <td class="list02_bg3">�Ұ�</td>
                <td class="list04_bg2"><% =FnNumberFormat(rsvxt("grouptotal")) %></td>
                <td class="list04_bg2"><% =FnNumberFormat(rsvxte("grouptotal")) %></td>
              </tr>
              <tr align="center"> 
                <td colspan="4"><img src="../../enter/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td rowspan="4" class="list02_bg2">��ü</td>
                <td class="list03_bg">�</td>
                <td class="list01_bg"><% =FnNumberFormat(rsvxt("adult")) %></td>
                <td class="list01_bg"><% =FnNumberFormat(rsvxte("adult")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg2">�߰��</td>
                <td class="list01_bg2"><% =FnNumberFormat(rsvxt("school")) %></td>
                <td class="list01_bg2"><% =FnNumberFormat(rsvxte("school")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg">���</td>
                <td class="list01_bg"><% =FnNumberFormat(rsvxt("child"))%></td>
                <td class="list01_bg"><% =FnNumberFormat(rsvxte("child")) %></td>
              </tr>
              <tr> 
                <td class="list02_bg3">�Ұ�</td>
                <td class="list04_bg2"><% =FnNumberFormat(rsvxt("total")) %></td>
                <td class="list04_bg2"><% =FnNumberFormat(rsvxte("total")) %></td>
              </tr>
              <tr bgcolor="#B0DFFD"> 
                <td height="10" colspan="4"></td>
              </tr>
            </table>
			<!--������(��) ���̺� ��-->
          </td>
        </tr>
        <tr> 
          <td height="30"><img src="../../enter/images/null.gif" width="1" height="30"></td>
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