<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<%
' ========================================================================================================
' ���α׷�ID : TXB Weather Sea
' ��  ��  �� : ���俹��
' ���α׷��� : ���� �ػ� ���� ���
' �����ۼ��� : 2002/11/29
' �����ۼ��� : 2002/12/03
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

'������ ����
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
Dim rstoday,rstomo,rsafterto '���� �ػ� ����, ���� �ػ� ����, �� �ػ� ���� ���ڵ��
Dim varLocal '����'

varLocal=Request.QueryString("varLocal") '�ʱⰪ�� ����
IF varLocal="" THEN varLocal="����"

ArrQuery = array(varLocal) '������ ��������

'������ ����
Set objServer = Server.CreateObject("XBWeatherSeaQMTS.clsXBWeatherSeaQNTX")

'������Ʈ ȣ��
arrRValue = objServer.Query(ArrQuery)
'���ڵ�� ��̸� ���� ���ڵ������ �и�

'ù��° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rstoday,1
'�ι�° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rstomo,2
'����° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rsafterto,3

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
<!-- #include file="../../enter/script/FnWeather_Icon.inc"-->
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
	<!-- ū ���̺� ����-->
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="24"><img src="../../enter/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
          <td align="left" height="21"><img src="../../enter/images/title_weather_sea.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td> 
            <!--���� ���� ���̺� ����-->
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="15" height="11" class="table03"><img src="../../enter/images/orange_buret.gif" width="7" height="7"></td>
                <td class="title_01">��<a href="weather_sea.asp?varLocal=����">�����ػ�</a>��<a href="weather_sea.asp?varLocal=����">�����ػ�</a>��<a href="weather_sea.asp?varLocal=����">�����ػ�</a> 
                  l</td>
              </tr>
            </table>
            <!--���� ���� ���̺� ��-->
          </td>
        </tr>
        <tr> 
          <td height="10"></td>
        </tr>
        <tr> 
          <td>
		  <!--�����ػ����� Ÿ��Ʋ ����--> 
            <table width="642" border="1" bordercolor="#dadada" cellspacing="0" cellpadding="7">
              <tr> 
                <td class="list07_bg4"><% =varLocal %>�ػ�����</td>
              </tr>
            </table>
			<!--�����ػ����� Ÿ��Ʋ ��-->
          </td>
        </tr>
        <tr> 
          <td height="5"></td>
        </tr>
        <tr> 
          <td> 
            <!-- �����ػ� ���� ���̺� ����-->
            <table width="642" border="1" bordercolor="#dadada" cellspacing="0" cellpadding="7">
              <tr class="list07_bg"> 
                <td colspan="2" rowspan="3">��������</td>
                <td colspan="4">�ߺ�</td>
              </tr>
              <tr class="list03_bg"> 
                <td colspan="2">�չٴ�</td>
                <td colspan="2">�չٴ�</td>
              </tr>
              <tr class="list03_bg2"> 
                <td>����</td>
                <td>����</td>
                <td>����</td>
                <td>����</td>
              </tr>
              <tr> 
                <td class="list15_bg" rowspan="4"><% =right(rstoday("sdate"),2) %></td>
                <td class="list05_bg2">����</td>
                <td class="list14_1" colspan="2"><img src="../../enter/images/new<% =FnWeatherIcon(rstoday("overview")) %>.gif" width="34" height="34" alt='<% =rstoday("overview") %>'><% rstoday.MOVENEXT %></td>
                <td class="list14_1" colspan="2"><img src="../../enter/images/new<% =FnWeatherIcon(rstoday("overview")) %>.gif" width="34" height="34" alt='<% =rstoday("overview") %>'><% rstoday.MOVEFIRST%></td>
              </tr>
              <tr> 
                <td class="list05_bg2">ǳ��</td>
                <td class="list14_1"><% =rstoday("winddiram") %></td>
                <td class="list14_1"><% =rstoday("winddirpm") %><% rstoday.MOVENEXT %></td>
                <td class="list14_1"><% =rstoday("winddiram") %></td>
                <td class="list14_1"><% =rstoday("winddirpm") %><% rstoday.MOVEFIRST %></td>
              </tr>
              <tr> 
                <td class="list05_bg2">ǳ��</td>
                <td class="list14_1"><% =rstoday("windspeedam") %></td>
                <td class="list14_1"><% =rstoday("windspeedpm") %><% rstoday.MOVENEXT %></td>
                <td class="list14_1"><% =rstoday("windspeedam") %></td>
                <td class="list14_1"><% =rstoday("windspeedpm") %><% rstoday.MOVEFIRST %></td>
              </tr>
              <tr> 
                <td class="list05_bg2">�İ�</td>
                <td class="list14_1"><% =rstoday("wavehigham") %></td>
                <td class="list14_1"><% =rstoday("wavehighpm") %><% rstoday.MOVENEXT %></td>
                <td class="list14_1"><% =rstoday("wavehigham") %></td>
                <td class="list14_1"><% =rstoday("wavehighpm") %><% rstoday.MOVENEXT %></td>
              </tr>
              <tr> 
                <td class="list15_bg" rowspan="4"><% =right(rstomo("sdate"),2) %></td>
                <td class="list05_bg2">����</td>
                <td class="list14_1" colspan="2"><img src="../../enter/images/new<% =FnWeatherIcon(rstomo("overview")) %>.gif" width="34" height="34" alt='<% =rstomo("overview") %>'><% rstomo.MOVENEXT %></td>
                <td class="list14_1" colspan="2"><img src="../../enter/images/new<% =FnWeatherIcon(rstomo("overview")) %>.gif" width="34" height="34" alt='<% =rstomo("overview") %>'><% rstomo.MOVEFIRST %></td>
              </tr>
              <tr> 
                <td class="list05_bg2">ǳ��</td>
                <td class="list14_1"><% =rstomo("winddiram") %></td>
                <td class="list14_1"><% =rstomo("winddirpm") %><% rstomo.MOVENEXT %></td>
                <td class="list14_1"><% =rstomo("winddiram") %></td>
                <td class="list14_1"><% =rstomo("winddirpm") %><% rstomo.MOVEFIRST %></td>
              </tr>
              <tr> 
                <td class="list05_bg2">ǳ��</td>
                <td class="list14_1"><% =rstomo("windspeedam") %></td>
                <td class="list14_1"><% =rstomo("windspeedpm") %><% rstomo.MOVENEXT %></td>
                <td class="list14_1"><% =rstomo("windspeedam") %></td>
                <td class="list14_1"><% =rstomo("windspeedpm") %><% rstomo.MOVEFIRST %></td>
              </tr>
              <tr> 
                <td class="list05_bg2">�İ�</td>
                <td class="list14_1"><% =rstomo("wavehigham") %></td>
                <td class="list14_1"><% =rstomo("wavehighpm") %><% rstomo.MOVENEXT %></td>
                <td class="list14_1"><% =rstomo("wavehigham") %></td>
                <td class="list14_1"><% =rstomo("wavehighpm") %><% rstomo.MOVENEXT %></td>
              </tr>
              <tr> 
                <td class="list15_bg" rowspan="4"><% =right(rsafterto("sdate"),2) %></td>
                <td class="list05_bg2">����</td>
                <td class="list14_1" colspan="2"><img src="../../enter/images/new<% =FnWeatherIcon(rsafterto("overview")) %>.gif" width="34" height="34" alt='<% =rsafterto("overview") %>'><% rsafterto.MOVENEXT %></td>
                <td class="list14_1" colspan="2"><img src="../../enter/images/new<% =FnWeatherIcon(rsafterto("overview")) %>.gif" width="34" height="34" alt='<% =rsafterto("overview") %>'><% rsafterto.MOVEFIRST%></td>
              </tr>
              <tr> 
                <td class="list05_bg2">ǳ��</td>
                <td class="list14_1"><% =rsafterto("winddiram") %></td>
                <td class="list14_1"><% =rsafterto("winddirpm") %><% rsafterto.MOVENEXT %></td>
                <td class="list14_1"><% =rsafterto("winddiram") %></td>
                <td class="list14_1"><% =rsafterto("winddirpm") %><% rsafterto.MOVEFIRST %></td>
              </tr>
              <tr> 
                <td class="list05_bg2">ǳ��</td>
                <td class="list14_1"><% =rsafterto("windspeedam") %></td>
                <td class="list14_1"><% =rsafterto("windspeedpm") %><% rsafterto.MOVENEXT %></td>
                <td class="list14_1"><% =rsafterto("windspeedam") %></td>
                <td class="list14_1"><% =rsafterto("windspeedpm") %><% rsafterto.MOVEFIRST %></td>
              </tr>
              <tr> 
                <td class="list05_bg2">�İ�</td>
                <td class="list14_1"><% =rsafterto("wavehigham") %></td>
                <td class="list14_1"><% =rsafterto("wavehighpm") %><% rsafterto.MOVENEXT %></td>
                <td class="list14_1"><% =rsafterto("wavehigham") %></td>
                <td class="list14_1"><% =rsafterto("wavehighpm") %><% rsafterto.MOVENEXT %></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td height="5"></td>
        </tr>
        <tr> 
          <td>
            <table width="642" border="1" bordercolor="#dadada" cellspacing="0" cellpadding="7">
              <tr class="list07_bg"> 
                <td colspan="2" rowspan="3">��������</td>
                <td colspan="4">����</td>
              </tr>
              <tr class="list03_bg"> 
                <td colspan="2">�չٴ�</td>
                <td colspan="2">�չٴ�</td>
              </tr>
              <tr class="list03_bg2"> 
                <td>����</td>
                <td>����</td>
                <td>����</td>
                <td>����</td>
              </tr>
              <tr> 
                <td class="list15_bg" rowspan="4"><% =right(rstoday("sdate"),2) %></td>
                <td class="list05_bg2">����</td>
                <td class="list14_1" colspan="2"><img src="../../enter/images/new<% =FnWeatherIcon(rstoday("overview")) %>.gif" width="34" height="34" alt='<% =rstoday("overview") %>'><% rstoday.MOVENEXT %></td>
                <td class="list14_1" colspan="2"><img src="../../enter/images/new<% =FnWeatherIcon(rstoday("overview")) %>.gif" width="34" height="34" alt='<% =rstoday("overview") %>'><% rstoday.MOVEFIRST%></td>
              </tr>
              <tr> 
                <td class="list05_bg2">ǳ��</td>
                <td class="list14_1"><% =rstoday("winddiram") %></td>
                <td class="list14_1"><% =rstoday("winddirpm") %><% rstoday.MOVENEXT %></td>
                <td class="list14_1"><% =rstoday("winddiram") %></td>
                <td class="list14_1"><% =rstoday("winddirpm") %><% rstoday.MOVEFIRST %></td>
              </tr>
              <tr> 
                <td class="list05_bg2">ǳ��</td>
                <td class="list14_1"><% =rstoday("windspeedam") %></td>
                <td class="list14_1"><% =rstoday("windspeedpm") %><% rstoday.MOVENEXT %></td>
                <td class="list14_1"><% =rstoday("windspeedam") %></td>
                <td class="list14_1"><% =rstoday("windspeedpm") %><% rstoday.MOVEFIRST %></td>
              </tr>
              <tr> 
                <td class="list05_bg2">�İ�</td>
                <td class="list14_1"><% =rstoday("wavehigham") %></td>
                <td class="list14_1"><% =rstoday("wavehighpm") %><% rstoday.MOVENEXT %></td>
                <td class="list14_1"><% =rstoday("wavehigham") %></td>
                <td class="list14_1"><% =rstoday("wavehighpm") %><% rstoday.MOVENEXT %></td>
              </tr>
              <tr> 
                <td class="list15_bg" rowspan="4"><% =right(rstomo("sdate"),2) %></td>
                <td class="list05_bg2">����</td>
                <td class="list14_1" colspan="2"><img src="../../enter/images/new<% =FnWeatherIcon(rstomo("overview")) %>.gif" width="34" height="34" alt='<% =rstomo("overview") %>'><% rstomo.MOVENEXT %></td>
                <td class="list14_1" colspan="2"><img src="../../enter/images/new<% =FnWeatherIcon(rstomo("overview")) %>.gif" width="34" height="34" alt='<% =rstomo("overview") %>'><% rstomo.MOVEFIRST %></td>
              </tr>
              <tr> 
                <td class="list05_bg2">ǳ��</td>
                <td class="list14_1"><% =rstomo("winddiram") %></td>
                <td class="list14_1"><% =rstomo("winddirpm") %><% rstomo.MOVENEXT %></td>
                <td class="list14_1"><% =rstomo("winddiram") %></td>
                <td class="list14_1"><% =rstomo("winddirpm") %><% rstomo.MOVEFIRST %></td>
              </tr>
              <tr> 
                <td class="list05_bg2">ǳ��</td>
                <td class="list14_1"><% =rstomo("windspeedam") %></td>
                <td class="list14_1"><% =rstomo("windspeedpm") %><% rstomo.MOVENEXT %></td>
                <td class="list14_1"><% =rstomo("windspeedam") %></td>
                <td class="list14_1"><% =rstomo("windspeedpm") %><% rstomo.MOVEFIRST %></td>
              </tr>
              <tr> 
                <td class="list05_bg2">�İ�</td>
                <td class="list14_1"><% =rstomo("wavehigham") %></td>
                <td class="list14_1"><% =rstomo("wavehighpm") %><% rstomo.MOVENEXT %></td>
                <td class="list14_1"><% =rstomo("wavehigham") %></td>
                <td class="list14_1"><% =rstomo("wavehighpm") %><% rstomo.MOVENEXT %></td>
              </tr>
              <tr> 
                <td class="list15_bg" rowspan="4"><% =right(rsafterto("sdate"),2) %></td>
                <td class="list05_bg2">����</td>
                <td class="list14_1" colspan="2"><img src="../../enter/images/new<% =FnWeatherIcon(rsafterto("overview")) %>.gif" width="34" height="34" alt='<% =rsafterto("overview") %>'><% rsafterto.MOVENEXT %></td>
                <td class="list14_1" colspan="2"><img src="../../enter/images/new<% =FnWeatherIcon(rsafterto("overview")) %>.gif" width="34" height="34" alt='<% =rsafterto("overview") %>'><% rsafterto.MOVEFIRST%></td>
              </tr>
              <tr> 
                <td class="list05_bg2">ǳ��</td>
                <td class="list14_1"><% =rsafterto("winddiram") %></td>
                <td class="list14_1"><% =rsafterto("winddirpm") %><% rsafterto.MOVENEXT %></td>
                <td class="list14_1"><% =rsafterto("winddiram") %></td>
                <td class="list14_1"><% =rsafterto("winddirpm") %><% rsafterto.MOVEFIRST %></td>
              </tr>
              <tr> 
                <td class="list05_bg2">ǳ��</td>
                <td class="list14_1"><% =rsafterto("windspeedam") %></td>
                <td class="list14_1"><% =rsafterto("windspeedpm") %><% rsafterto.MOVENEXT %></td>
                <td class="list14_1"><% =rsafterto("windspeedam") %></td>
                <td class="list14_1"><% =rsafterto("windspeedpm") %><% rsafterto.MOVEFIRST %></td>
              </tr>
              <tr> 
                <td class="list05_bg2">�İ�</td>
                <td class="list14_1"><% =rsafterto("wavehigham") %></td>
                <td class="list14_1"><% =rsafterto("wavehighpm") %><% rsafterto.MOVENEXT %></td>
                <td class="list14_1"><% =rsafterto("wavehigham") %></td>
                <td class="list14_1"><% =rsafterto("wavehighpm") %><% rsafterto.MOVENEXT %></td>
              </tr>
            </table>
			<!--�����ػ� ���� ���̺� ��-->
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