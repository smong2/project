<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' ���α׷�ID : TXBWEATHERLANDSEOUL
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���� ǥ�� - ���󿹺� ��������
' �����ۼ��� : 2002/11/28
' �����ۼ��� : 2002/11/28
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

'������ ����
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
Dim rs,rsjisu, varAreaCode, varAreaName '�����ڵ�
'���ڵ�� (�����������,��������)
dim intI '��������

varAreaCode=Request.QueryString("varAreaCode") '�����ڵ�� �̸��� �����´�
varAreaName=Request.QueryString("varAreaName")

ArrQuery = array(varAreaCode,varAreaCode) '�������� �´� �ڵ� ��������

'������ ����
Set objServer = Server.CreateObject("XBWeatherViewQMTS.clsXBWeatherViewQNTX")

'������Ʈ ȣ��
arrRValue = objServer.Query(ArrQuery)
'���ڵ�� ��̸� ���� ���ڵ������ �и�

'ù��° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rs,2

'�ڿ��� ����
Set objServer = Nothing

IF varAreaName="" THEN varAreaName="����/���"  '�ƹ����� ���� �� �⺻���� ����/��⸦ ���

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
          <td align="left" height="21"><img src="../../enter/images/title_weather_land.gif" width="200" height="21"></td>
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
                <td class="title_01">��<a href="weather_land.asp?varAreaCode=14&varAreaName=����/���">����/���</a>��
										<a href="weather_land.asp?varAreaCode=19&varAreaName=�泲">�泲</a>��
										<a href="weather_land.asp?varAreaCode=18&varAreaName=���">���</a>��
										<a href="weather_land.asp?varAreaCode=11&varAreaName=����5��">����5��</a>��
										<a href="weather_land.asp?varAreaCode=15&varAreaName=����">����</a>��
										<a href="weather_land.asp?varAreaCode=16&varAreaName=����">����</a>��
										<a href="weather_land.asp?varAreaCode=17&varAreaName=�︪/����">�︪/����</a>��
										<a href="weather_land.asp?varAreaCode=1B&varAreaName=����">����</a>��
										<a href="weather_land.asp?varAreaCode=1A&varAreaName=����">����</a>��
										<a href="weather_land.asp?varAreaCode=1F&varAreaName=�泲">�泲</a>��
										<a href="weather_land.asp?varAreaCode=1D&varAreaName=���">���</a>��
										<a href="weather_land.asp?varAreaCode=1C&varAreaName=����">����</a>��</td>
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
		  <!--���� ���� ���̺� ����-->
            <table width="642" border="1" bordercolor="#dadada" cellspacing="0" cellpadding="7">
              <tr> 
                <td colspan="11" class="list07_bg4"><% =varAreaName %>(��������)</td>
              </tr>
              <tr class="list07_bg"> 
                <td rowspan="3">��������</td>
                <td colspan="4"><% =right(rs("sdate"),2) %></td><% rs.MOVENEXT %>
                <td colspan="4"><% =right(rs("sdate"),2) %></td><% rs.MOVENEXT %>
                <td colspan="2"><% =right(rs("sdate"),2) %></td><% rs.MOVEFIRST %>
              </tr>
              <tr class="list03_bg"> 
                <td rowspan="2">����</td>
                <td rowspan="2">������(��)</td>
                <td colspan="2">����Ȯ��</td>
                <td rowspan="2">����</td>
                <td rowspan="2">������(��)</td>
                <td colspan="2">����Ȯ��</td>
                <td rowspan="2">����</td>
                <td rowspan="2">������(��)</td>
              </tr>
              <tr class="list03_bg2"> 
                <td>��</td>
                <td>��</td>
                <td>��</td>
                <td>��</td>
              </tr>
              <% DO UNTIL rs.eof %>
              <tr>               
                <td class="list13_bg2"><% =rs("codedescript") %></td>
                <td class="table03"><img src="../../enter/images/new<% =FnWeatherIcon(rs("overview")) %>.gif" width="34" height="34" alt='<% =rs("overview") %>'></td>
                <td class="list14_1"><% =rs("tempmax") %></td>
                <td class="list14_1"><% =rs("probrainam") %>&nbsp;</td>
                <td class="list14_1"><% =rs("probrainpm") %>&nbsp;</td><% rs.MOVENEXT %>
                <td class="table03"><img src="../../enter/images/new<% =FnWeatherIcon(rs("overview")) %>.gif" width="34" height="34" alt='<% =rs("overview") %>'></td>
                <td class="list14_1"><% =rs("tempmin") %> / <% =rs("tempmax") %></td>
                <td class="list14_1"><% =rs("probrainam") %>&nbsp;</td>
                <td class="list14_1"><% =rs("probrainpm") %>&nbsp;</td><% rs.MOVENEXT %>
                <td class="table03"><img src="../../enter/images/new<% =FnWeatherIcon(rs("overview")) %>.gif" width="34" height="34" alt='<% =rs("overview") %>'></td>
                <td class="list14_1"><% =rs("tempmin") %> / <% =rs("tempmax") %></td><% rs.MOVENEXT %>
              </tr>
              <% LOOP %>             
            </table>
			<!--���� ���� ���̺� ��-->
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