<!-- #include file="../../electric/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' ���α׷�ID : TXBWEATHERWEEK
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���� ǥ�� - �ְ�����
' �����ۼ��� : 2002/12/06
' �����ۼ��� : 2002/12/06
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

'������ ����
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
Dim rs,varAreaCode '�����ڵ�
'���ڵ�� (�ְ����� ����Ʈ)
dim intI '��������

varAreaCode=Request.QueryString()

ArrQuery = array() '�������� �´� �ڵ� ��������

'������ ����
Set objServer = Server.CreateObject("XBWeatherViewQMTS.clsXBWeatherViewQNTX")

'������Ʈ ȣ��
arrRValue = objServer.Query(ArrQuery)
'���ڵ�� ��̸� ���� ���ڵ������ �и�

'ù��° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rs,3

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
<!-- #include file="../../electric/script/FnWeather_Icon.inc"-->
<!-- #include file="../../electric/script/FnWeather_week.vbs"-->
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
          <td align="left"><img src="../../electric/images/title_weather_week.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../electric/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--�ְ����� ��ü ���̺� ����-->
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td>
				<!--�ְ����� ���� ���̺� ����-->
                  <table width="400" border="1" bordercolor="#dadada" cellspacing="0" cellpadding="7">
                    <tr> 
                      <td class="list07_bg4" colspan="6">�ְ����� <% =FnWeather_Date_Title(rs(0)) %> ��ǥ </td>
                    </tr>
                    <tr> 
                      <td class="list03_bg">����/��¥</td>
                      <% DO UNTIL rs.eof %>
                      <td class="list18_bg"><% =FnWeather_Week_Date(rs("sdate")) %></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>
                    </tr>
                    <tr> 
                      <td class="list13_bg2">����/���/��������</td>
                      <% DO UNTIL rs.EOF %>
                      <td class="table03"><img src="../../electric/images/new<% =FnWeatherIcon(rs("region1")) %>.gif" width="34" height="34" alt='<% =rs("region1") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>
                    </tr>
                    <tr> 
                      <td class="list13_bg2">��������</td>
                      <% DO UNTIL rs.EOF %>
                      <td class="table03"><img src="../../electric/images/new<% =FnWeatherIcon(rs("region2")) %>.gif" width="34" height="34" alt='<% =rs("region2") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>
                    </tr>
                    <tr> 
                      <td class="list13_bg2">��û����</td>
                      <% DO UNTIL rs.EOF %>
                      <td class="table03"><img src="../../electric/images/new<% =FnWeatherIcon(rs("region3")) %>.gif" width="34" height="34" alt='<% =rs("region3") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>
                    </tr>
                    <tr> 
                      <td class="list13_bg2">���󳲺�</td>
                      <% DO UNTIL rs.EOF %>
                      <td class="table03"><img src="../../electric/images/new<% =FnWeatherIcon(rs("region4")) %>.gif" width="34" height="34" alt='<% =rs("region4") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>
                    </tr>
                    <tr> 
                      <td class="list13_bg2">��󳲺�</td>
                      <% DO UNTIL rs.EOF %>
                      <td class="table03"><img src="../../electric/images/new<% =FnWeatherIcon(rs("region5")) %>.gif" width="34" height="34" alt='<% =rs("region5") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>
                    </tr>
                    <tr> 
                      <td class="list13_bg2">���ֵ�</td>
                      <% DO UNTIL rs.EOF %>
                      <td class="table03"><img src="../../electric/images/new<% =FnWeatherIcon(rs("region6")) %>.gif" width="34" height="34" alt='<% =rs("region6") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>
                    </tr>
                    <tr> 
                      <td class="list13_bg2">����</td>
                      <% DO UNTIL rs.EOF %>
                      <td class="table03"><img src="../../electric/images/new<% =FnWeatherIcon(rs("eastsea")) %>.gif" width="34" height="34" alt='<% =rs("eastsea") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>
                    </tr>
                    <tr> 
                      <td class="list13_bg2">����</td>
                      <% DO UNTIL rs.EOF %>
                      <td class="table03"><img src="../../electric/images/new<% =FnWeatherIcon(rs("westsea")) %>.gif" width="34" height="34" alt='<% =rs("westsea") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>
                    </tr>
                    <tr> 
                      <td class="list13_bg2">����</td>
                      <% DO UNTIL rs.EOF %>
                      <td class="table03"><img src="../../electric/images/new<% =FnWeatherIcon(rs("southsea")) %>.gif" width="34" height="34" alt='<% =rs("southsea") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>
                    </tr>
                  </table>
				  <!--�ְ����� ���� ���̺� ��-->
                </td>
                <td width="10"></td>
                <td class="table08">
				<!--���Ȳ ���̺�-->
                  <table width="193" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td height="20" valign="top">
					  <!--���� Ÿ��Ʋ ����--> 
                        <table width="200" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="15" height="11" class="table03"><img src="../../electric/images/orange_buret.gif" width="7" height="7"></td>
                            <td class="title_01">���Ȳ</td>
                          </tr>
                        </table>
						<!--���� Ÿ��Ʋ ��-->
                      </td>
                    </tr>
                    <tr> 
                      <td><img src="../../electric/images/point_line.gif" width="193" height="1"></td>
                    </tr>
                    <tr>
                      <td height="10"></td>
                    </tr>
                    <tr> 
                      <td class="list14"><% =rs("weatherforecast") %></td>
                    </tr>
                    <tr>
                      <td height="10"></td>
                    </tr>
                    <tr> 
                      <td><img src="../../electric/images/point_line.gif" width="193" height="1"></td>
                    </tr>
                  </table>
				  <!--���Ȳ ���̺�-->
                </td>
              </tr>
            </table>
			<!--�ְ����� ��ü ���̺� ��-->
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
<!-- #include file="../../electric/script/FnErrorCatch.inc"-->