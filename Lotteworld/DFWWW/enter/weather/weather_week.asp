<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' ���α׷�ID : TXBWEATHERJISU
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���� ǥ�� - �ְ�����
' �����ۼ��� : 2002/12/04
' �����ۼ��� : 2002/12/04
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

'������ ����
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
Dim rs,varAreaCode '���ڵ�� : �ְ�����, �����ڵ�
Dim intI '��������

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
<!-- #include file="../../enter/script/FnProgramProcess.vbs" -->
<!-- #include file="../../enter/script/FnWeather_Icon.inc"-->
<!-- #include file="../../enter/script/FnWeather_week.vbs"-->
<html>
<head>
<title>�Ե����� ���俹���ý���</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../../enter/css/cs_tx.css" type="text/css">
</head>

<body bgcolor="#f5f5f5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#ffffff">
  <tr> 
    <td width="49"><IMG height=1 src="../../enter/images/null.gif" width=49></td>
    <td width="642" valign="top"><!-- ū ���̺� ����-->
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="24"><IMG height=24 src="../../enter/images/null.gif" width=1></td>
        </tr>
        <tr> 
          <td align="left"><IMG height=21 src="../../enter/images/title_weather_week.gif" width=200></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><IMG height=5 src="../../enter/images/title_bar.gif" width=642></td>
        </tr>
        <tr> 
          <td><!--�ְ����� ��ü ���̺� ����-->
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td><!--�ְ����� ���� ���̺� ����-->
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
                      <td class="table03"><img src="../../enter/images/new<% =FnWeatherIcon(rs("region1")) %>.gif" width="34" height="34" alt='<% =rs("region1") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %></td>
                    </tr>
                    <tr> 
                      <td class="list13_bg2">��������</td>
                      <% DO UNTIL rs.EOF %>
                      <td class="table03"><img src="../../enter/images/new<% =FnWeatherIcon(rs("region2")) %>.gif" width="34" height="34" alt='<% =rs("region2") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>                      
                    </tr>
                    <tr> 
                      <td class="list13_bg2">��û����</td>
                      <% DO UNTIL rs.EOF %>
                      <td class="table03"><img src="../../enter/images/new<% =FnWeatherIcon(rs("region3")) %>.gif" width="34" height="34" alt='<% =rs("region3") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>
                    </tr>
                    <tr> 
                      <td class="list13_bg2">���󳲺�</td>
                      <% DO UNTIL rs.EOF %>
                      <td class="table03"><img src="../../enter/images/new<% =FnWeatherIcon(rs("region4")) %>.gif" width="34" height="34" alt='<% =rs("region4") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>
                    </tr>
                    <tr> 
                      <td class="list13_bg2">��󳲺�</td>
                      <% DO UNTIL rs.EOF %>
                      <td class="table03"><img src="../../enter/images/new<% =FnWeatherIcon(rs("region5")) %>.gif" width="34" height="34" alt='<% =rs("region5") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>                      
                    </tr>
                    <tr> 
                      <td class="list13_bg2">���ֵ�</td>
                      <% DO UNTIL rs.EOF %>
                      <td class="table03"><img src="../../enter/images/new<% =FnWeatherIcon(rs("region6")) %>.gif" width="34" height="34" alt='<% =rs("region6") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>                      
                    </tr>
                    <tr> 
                      <td class="list13_bg2">����</td>
                      <% DO UNTIL rs.EOF %>
                      <td class="table03"><img src="../../enter/images/new<% =FnWeatherIcon(rs("eastsea")) %>.gif" width="34" height="34" alt='<% =rs("eastsea") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>
                    </tr>
                    <tr> 
                      <td class="list13_bg2">����</td>
                      <% DO UNTIL rs.EOF %>
                      <td class="table03"><img src="../../enter/images/new<% =FnWeatherIcon(rs("westsea")) %>.gif" width="34" height="34" alt='<% =rs("westsea") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>
                    </tr>
                    <tr> 
                      <td class="list13_bg2">����</td>
                      <% DO UNTIL rs.EOF %>
                      <td class="table03"><img src="../../enter/images/new<% =FnWeatherIcon(rs("southsea")) %>.gif" width="34" height="34" alt='<% =rs("southsea") %>'></td>
                      <% rs.MOVENEXT : LOOP : rs.MOVEFIRST %>
                    </tr>
                  </table><!--�ְ����� ���� ���̺� ��-->
                </td>
                <td width="10"></td>
                <td class="table08"><!--���Ȳ ���̺�-->
                  <table width="193" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td height="20" valign="top"><!--���� Ÿ��Ʋ ����--> 
                        <table width="200" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="15" height="11" class="table03"><IMG height=7 src="../../enter/images/orange_buret.gif" width=7></td>
                            <td class="title_01">���Ȳ</td>
                          </tr>
                        </table><!--���� Ÿ��Ʋ ��-->
                      </td>
                    </tr>
                    <tr> 
                      <td><IMG height=1 src="../../enter/images/point_line.gif" width=193></td>
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
                      <td><IMG height=1 src="../../enter/images/point_line.gif" width=193></td>
                    </tr>
                  </table><!--���Ȳ ���̺�-->
                </td>
              </tr>
            </table><!--�ְ����� ��ü ���̺� ��-->
          </td>
        </tr>
        <tr> 
          <td height="30"></td>
        </tr>
      </table><!--ū ���̺� ��-->
    </td>
    <td width="49"><IMG height=1 src="../../enter/images/null.gif" width=49></td>
    <td bgcolor="#a4a4a4"><IMG height=1 src="../../enter/images/outline.gif" width=1></td>
  </tr>
  <tr> 
    <td height="42" colspan="3" align="right" background="../../enter/images/copyright_bg.gif"><IMG height=42 src="../../enter/images/copyright.gif" width=350></td>
    <td bgcolor="#a4a4a4" width="1" height="42"><img src="../../enter/images/null.gif"></td>
  </tr>
</table>
</body>
</html>
<!-- #include file="../../enter/script/FnErrorCatch.inc"-->