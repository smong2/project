<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' ���α׷�ID : TODAY_DAY
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� TODAY_DAY
' �����ۼ��� : 2002/11/28
' �����ۼ��� : 2002/11/28
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

'������ ����
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
Dim intI
Dim rs,rse,rslast, rslastweek, rslaste, rslastweeke '���ڵ�� : ��ǥ����, �����忹��,��ǥ���� ���⵿�Ͻ���, ��ǥ���� ���⵿���Ͻ���, ������ ���⵿�Ͻ���, ������ ���⵿���Ͻ���
%>
<!-- #include file="../../enter/script/fnsearch_date.inc"-->
<%
ArrQuery = array(dtLastday,dtLastWeekday)

'������ ����
Set objServer = Server.CreateObject("XTTodayMainMTS.clsXTTodayMainNTX")

'������Ʈ ȣ�� ������ ����
' ...

'������Ʈ ȣ��
arrRValue = objServer.Query(ArrQuery)
'���ڵ�� ��̸� ���� ���ڵ������ �и�

'ù��° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rs,1 '����
'�ι�° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rse,2  '������ ����
'����° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rslast,3 '���� ���� ����
'�׹�° ���ڵ���� ��̷� ��ȯ 
FnSplitRSArray arrRValue,rslaste,4 '������ ���� ���� ����
'�ټ���° ���ڵ���� ��̷� ��ȯ 
FnSplitRSArray arrRValue,rslastweek,5 '���� ������ ����
'������° ���ڵ���� ��̷� ��ȯ 
FnSplitRSArray arrRValue,rslastweeke,6 '������ ���� ������ ����

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
<!-- #include file="../../enter/script/fnnumber_format.inc"-->
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
          <td align="left"><img src="../../enter/images/title_today_day.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td> 
            <!--������(��) ���̺� ����-->
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr class="list07_bg4"> 
                <td colspan="2">����</td>
                <td>��ǥ���尴</td>
                <td>�����尴</td>
              </tr>
              <tr> 
                <td width="100" rowspan="4" class="list02_bg2">����</td>
                <td width="142" class="list03_bg">�</td>
                <td width="200" class="list01_bg"> 
                  <% =FnNumberFormat(rs("indivadult")) %>
                </td>
                <td width="200" class="list01_bg"> 
                  <% =FnNumberFormat(rse("indivadult")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg2">�߰��</td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rs("indivschool")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rse("indivschool")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">���</td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rs("indivchild")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rse("indivchild")) %>
                </td>
              </tr>
              <tr> 
                <td class="list02_bg3">�Ұ�</td>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rs("indivtotal")) %>
                </td>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rse("indivtotal")) %>
                </td>
              </tr>
              <tr align="center"> 
                <td height="15" colspan="4"><img src="../../enter/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td rowspan="4" class="list02_bg2">��ü</td>
                <td class="list03_bg">�</td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rs("groupadult")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rse("groupadult")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg2">�߰��</td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rs("groupschool")) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rse("groupschool")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">���</td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rs("groupchild")) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(rse("groupchild")) %>
                </td>
              </tr>
              <tr> 
                <td class="list02_bg3">�Ұ�</td>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rs("grouptotal")) %>
                </td>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rse("grouptotal")) %>
                </td>
              </tr>
              <tr align="center"> 
                <td height="15" colspan="4"><img src="../../enter/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td rowspan="4" class="list02_bg2">��ü</td>
                <td class="list03_bg">�</td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(int(FnNumberFormat(rs("indivadult")))+int(FnNumberFormat(rs("groupadult")))) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(int(FnNumberFormat(rse("indivadult")))+int(FnNumberFormat(rse("groupadult")))) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg2">�߰��</td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(int(FnNumberFormat(rs("indivschool")))+int(FnNumberFormat(rs("groupschool")))) %>
                </td>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(int(FnNumberFormat(rse("indivschool")))+int(FnNumberFormat(rse("groupschool")))) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">���</td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(int(FnNumberFormat(rs("indivchild")))+int(FnNumberFormat(rs("groupchild")))) %>
                </td>
                <td class="list01_bg"> 
                  <% =FnNumberFormat(int(FnNumberFormat(rse("indivchild")))+int(FnNumberFormat(rse("groupchild")))) %>
                </td>
              </tr>
              <tr> 
                <td class="list02_bg3">�Ұ�</td>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(int(FnNumberFormat(rs("indivtotal")))+int(FnNumberFormat(rs("grouptotal")))) %>
                </td>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(int(FnNumberFormat(rse("indivtotal")))+int(FnNumberFormat(rse("grouptotal")))) %>
                </td>
              </tr>
              <tr bgcolor="#B0DFFD"> 
                <td height="10" colspan="4"></td>
              </tr>
            </table>
            <!--������(��) ���̺� ��-->
          </td>
        </tr>
        <tr> 
          <td height="30"></td>
        </tr>
      </table>
	  <!--ū ���̺� ��-->
    </td>
    <td width="49"><img src="../../enter/images/null.gif" width="49" height="1"></td>
    <td bgcolor="#a4a4a4" height="851"><img src="../../enter/images/outline.gif" width="1" height="1"></td>
  </tr>
  <tr> 
    <td colspan="3" align="right" background="../../enter/images/copyright_bg.gif"><img src="../../enter/images/copyright.gif" width="350" height="42"></td>
    <td bgcolor="#a4a4a4" width="1" height="42"><img src="../../enter/images/null.gif"></td>
  </tr>
</table>
</body>
</html>
<!-- #include file="../../enter/script/FnErrorCatch.inc"-->