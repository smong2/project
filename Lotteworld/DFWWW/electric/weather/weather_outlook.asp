<!-- #include file="../../electric/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' ���α׷�ID : TXBWEATHEROVERVIEW
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���� ǥ�� - ���Ȳ
' �����ۼ��� : 2002/11/28
' �����ۼ��� : 2002/11/28
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

'������ ����
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
Dim rs '���ڵ�� (���� ��Ȳ)
dim intI '��������

ArrQuery = array() '�������� �´� �ڵ� ��������

'������ ����
Set objServer = Server.CreateObject("XBWeatherViewQMTS.clsXBWeatherViewQNTX")

'������Ʈ ȣ��
arrRValue = objServer.Query(ArrQuery)
'���ڵ�� ��̸� ���� ���ڵ������ �и�

'ù��° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rs,1

'�ڿ��� ����
Set objServer = Nothing

'������ ó��
IF Err.Number <> 0 THEN 
	Response.Write Err.Number, Err.Source, Err.Description
	Set objServer = Nothing
	objserver.close
END IF
%>	
<!-- #include file="../../electric/script/FnProgramProcess.vbs" -->
<!-- #include file="../../electric/script/fnnumber_format.inc"-->	
<html>
<head>
<title>�Ե����� ���俹���ý���</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../../electric/css/cs_te.css" type="text/css">
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
  <tr> 
    <td width="49"><img src="../../electric/images/null.gif" width="49" height="1"></td>
    <td width="642" valign="top">
	<!-- ū ���̺� ����-->
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="24"><img src="../../electric/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
          <td align="left"><img src="../../electric/images/title_weather_outlook.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../electric/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td class="table08">
		  <!--���� ���Ȳ ����--> 
            <table width="628" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="20" valign="top">
				<!--���� Ÿ��Ʋ ����--> 
                  <table width="312" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="15" height="11" class="table03"><img src="../../electric/images/vermilion_buret.gif" width="7" height="7"></td>
                      <td class="title_01_0">����(<% =right(rs("sdate"),2) %>��)</td>
                    </tr>
                  </table>
				  <!--���� Ÿ��Ʋ ��-->
                </td>
              </tr>
              <tr> 
                <td><img src="../../electric/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td height="10"></td>
              </tr>
              <tr> 
                <td class="list14"><u>��а赿��</u> : <% =rs("airtendency") %> <br>
                <u>��������</u> :<% =rs("landoverview") %> <Br>
                <u>�ػ�����</u> :<% =rs("seaoverview") %> <br>
                <u>������</u> :<%=rs("rainsnowamt") %><% rs.MOVENEXT %> </td>
              </tr>
              <tr> 
                <td height="10"></td>
              </tr>
              <tr> 
                <td><img src="../../electric/images/point_line3.gif" width="628" height="1"></td>
              </tr>
            </table>
			<!--���� ���Ȳ ��-->
          </td>
        </tr>
        <tr>
          <td height="40"></td>
        </tr>
        <tr> 
          <td class="table08">
		  <!--���� ���Ȳ ����-->
            <table width="628" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="20" valign="top">
				<!--���� Ÿ��Ʋ ����--> 
                  <table width="312" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="15" height="11" class="table03"><img src="../../electric/images/yellowgreen_buret.gif" width="7" height="7"></td>
                      <td class="title_01_0">����(<% =right(rs("sdate"),2)%>��)</td>
                    </tr>
                  </table>
				  <!--���� Ÿ��Ʋ ��-->
                </td>
              </tr>
              <tr> 
                <td><img src="../../electric/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td height="10"></td>
              </tr>
              <tr> 
                <td class="list14"><u>��а赿��</u> : <% =rs("airtendency") %> <br>
                <u>��������</u> :<% =rs("landoverview") %> <Br>
                <u>�ػ�����</u> :<% =rs("seaoverview") %> <br>
                <u>������</u> :<%=rs("rainsnowamt") %></td>
              </tr>
              <tr> 
                <td height="10"></td>
              </tr>
              <tr> 
                <td><img src="../../electric/images/point_line3.gif" width="628" height="1"></td>
              </tr>
            </table>
			<!--���� ���Ȳ ��-->
          </td>
        </tr>
        <tr> 
          <td height="30"></td>
        </tr>
      </table>
	  <!--ū ���̺� ��-->
    </td>
    <td width="49"><img src="../../electric/images/null.gif" width="49" height="1"></td>
    <td bgcolor="#a4a4a4"><img src="../../electric/images/outline.gif" width="1" height="1"></td>
  </tr>
  <tr> 
    <td height="42" colspan="3" align="right" background="../../electric/images/copyright_bg.gif"><img src="../../electric/images/copyright.gif" width="350" height="42"></td>
    <td bgcolor="#a4a4a4" width="1" height="42"><img src="../../electric/images/null.gif"></td>
  </tr>
</table>
</body>
</html>
  <!-- #include file="../../electric/script/FnErrorCatch.inc" -->