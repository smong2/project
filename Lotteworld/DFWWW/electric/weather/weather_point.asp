<!-- #include file="../../electric/script/FnLoginAuth.inc" -->
<%
' ========================================================================================================
' ���α׷�ID : TXB Weather Point
' ��  ��  �� : ���俹��
' ���α׷��� : ���� ����Ʈ ���� ���
' �����ۼ��� : 2002/12/03
' �����ۼ��� : 2002/12/03
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

'������ ����
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
Dim rs '���ڵ�� : ����Ʈ ����
Dim varLocal, intI '����, ��������'

varLocal=Request.QueryString("varLocal")
IF varLocal="" THEN varLocal="����/���" '�ʱⰪ�� ����/���

ArrQuery = array(varLocal) '������ ��������

'������ ����
Set objServer = Server.CreateObject("XBWeatherPointQMTS.clsXBWeatherPntQNTX")

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
<!-- #include file="../../electric/script/FnWeather_Point.inc" -->
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
          <td align="left" height="21"><img src="../../electric/images/title_weather_point.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../electric/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--����/��� ����Ʈ���� Ÿ��Ʋ ����--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="15" height="11" class="table03"><img src="../../electric/images/orange_buret.gif" width="7" height="7"></td>
                <td class="title_01"><% =varLocal %> ����Ʈ����</td>
              </tr>
            </table>
			<!--����/��� ����Ʈ���� Ÿ��Ʋ ��-->
          </td>
        </tr>
        <tr> 
          <td height="10" class="list13_3"><img src="../../electric/images/graph.gif" width="12" height="6"> �µ� 
            <img src="../../electric/images/graph2.gif" width="12" height="6"> ������</td>
        </tr>
        <tr> 
          <td>
		  <!--����Ʈ���� ���̺� ����-->
            <table width="642" border="1" bordercolor="#dadada" cellspacing="0" cellpadding="4">
              <tr> 
                <td colspan="19" class="list07_bg5"><% =left(rs("sdate"),4) %>�� <% =mid(rs("sdate"),5,2) %>�� <% =right(rs("sdate"),2) %>��
                (<% =left(weekdayname(weekday(dateserial(left(rs("sdate"),4),mid(rs("sdate"),5,2),right(rs("sdate"),2)))),1) %>) ��ǥ</td>
              </tr>
              <tr class="list07_bg"> 
                <td>����</td>
                <td colspan="6">����:<% =mid(rs("sdate"),5,2) %>��<% =right(rs("sdate"),2) %>��(<% =left(weekdayname(weekday(dateserial(left(rs("sdate"),4),mid(rs("sdate"),5,2),right(rs("sdate"),2)))),1) %>)<% rs.MOVENEXT %></td>
                <td colspan="6">����:<% =mid(rs("sdate"),5,2) %>��<% =right(rs("sdate"),2) %>��(<% =left(weekdayname(weekday(dateserial(left(rs("sdate"),4),mid(rs("sdate"),5,2),right(rs("sdate"),2)))),1) %>)<% rs.MOVENEXT %></td>
                <td colspan="6">��:<% =mid(rs("sdate"),5,2) %>��<% =right(rs("sdate"),2) %>��(<% =left(weekdayname(weekday(dateserial(left(rs("sdate"),4),mid(rs("sdate"),5,2),right(rs("sdate"),2)))),1) %>)<% rs.MOVEFIRST%></td>
              </tr>
              <tr class="list18_bg"> 
                <td>ǳ��/ǳ��</td>
                <td colspan="6"><% =rs("winddir") %> &nbsp;<% =rs("windspeedmin") %>-<% =rs("windspeedmax") %><% rs.MOVENEXT %> m/s</td>
                <td colspan="6"><% =rs("winddir") %> &nbsp;<% =rs("windspeedmin") %>-<% =rs("windspeedmax") %><% rs.MOVENEXT %> m/s</td>
                <td colspan="6"><% =rs("winddir") %> &nbsp;<% =rs("windspeedmin") %>-<% =rs("windspeedmax") %><% rs.MOVEFIRST%> m/s</td>
              </tr>
              <tr class="list03_bg"> 
                <td>��������</td>
                <td colspan="6"><% =rs("weatheroverview") %><% rs.MOVENEXT %></td>
                <td colspan="6"><% =rs("weatheroverview") %><% rs.MOVENEXT %></td>
                <td colspan="6"><% =rs("weatheroverview") %><% rs.MOVEFIRST%></td>
              </tr>
              <tr class="list18_bg2"> 
                <td rowspan="5">����</td>
                <td>06</td>
                <td>09</td>
                <td>12</td>
                <td>15</td>
                <td>18</td>
                <td>21</td>
                <td>06</td>
                <td>09</td>
                <td>12</td>
                <td>15</td>
                <td>18</td>
                <td>21</td>
                <td>06</td>
                <td>09</td>
                <td>12</td>
                <td>15</td>
                <td>18</td>
                <td>21</td>
              </tr>
              <tr> 
                <% FOR intI=1 to 3 %>
                <td class="table03"><img src="../../enter/images/s_icon<% =FnWeatherCode(rs("weathercodeh6")) %>.gif" width="17" height="17"></td>
                <td class="list14_1"><img src="../../enter/images/s_icon<% =FnWeatherCode(rs("weathercodeh9")) %>.gif" width="17" height="17"></td>
                <td class="list14_1"><img src="../../enter/images/s_icon<% =FnWeatherCode(rs("weathercodeh12")) %>.gif" width="17" height="17"></td>
                <td class="list14_1"><img src="../../enter/images/s_icon<% =FnWeatherCode(rs("weathercodeh15")) %>.gif" width="17" height="17"></td>
                <td class="list14_1"><img src="../../enter/images/s_icon<% =FnWeatherCode(rs("weathercodeh18")) %>.gif" width="17" height="17"></td>
                <td class="list14_1"><img src="../../enter/images/s_icon<% =FnWeatherCode(rs("weathercodeh21")) %>.gif" width="17" height="17"></td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
              </tr>
              <tr> 
                <% FOR intI=1 to 3 %>
                <td class="table10"><img src="../../enter/images/graph.gif" width="6" height=<% =FnWeatherBarHeightTemp(rs("temph6")) %>><img src="../../enter/images/graph2.gif" width="6" height=<% =FnWeatherBarHeightRain(rs("rainprobh6")) %>></td>
                <td class="table10"><img src="../../enter/images/graph.gif" width="6" height=<% =FnWeatherBarHeightTemp(rs("temph9")) %>><img src="../../enter/images/graph2.gif" width="6" height=<% =FnWeatherBarHeightRain(rs("rainprobh9")) %>></td>
                <td class="table10"><img src="../../enter/images/graph.gif" width="6" height=<% =FnWeatherBarHeightTemp(rs("temph12")) %>><img src="../../enter/images/graph2.gif" width="6" height=<% =FnWeatherBarHeightRain(rs("rainprobh12")) %>></td>
                <td class="table10"><img src="../../enter/images/graph.gif" width="6" height=<% =FnWeatherBarHeightTemp(rs("temph15")) %>><img src="../../enter/images/graph2.gif" width="6" height=<% =FnWeatherBarHeightRain(rs("rainprobh15")) %>></td>
                <td class="table10"><img src="../../enter/images/graph.gif" width="6" height=<% =FnWeatherBarHeightTemp(rs("temph18")) %>><img src="../../enter/images/graph2.gif" width="6" height=<% =FnWeatherBarHeightRain(rs("rainprobh18")) %>></td>
                <td class="table10"><img src="../../enter/images/graph.gif" width="6" height=<% =FnWeatherBarHeightTemp(rs("temph21")) %>><img src="../../enter/images/graph2.gif" width="6" height=<% =FnWeatherBarHeightRain(rs("rainprobh21")) %>></td>
              <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
              </tr>
              <tr>
                <% FOR intI=1 to 3 %>
                <td class="point01"><img src="../../enter/images/graph.gif" width="12" height="6"><br><% =rs("temph6") %></td>
                <td class="point01"><img src="../../enter/images/graph.gif" width="12" height="6"><br><% =rs("temph9") %></td>
                <td class="point01"><img src="../../enter/images/graph.gif" width="12" height="6"><br><% =rs("temph12") %></td>
                <td class="point01"><img src="../../enter/images/graph.gif" width="12" height="6"><br><% =rs("temph15") %></td>
                <td class="point01"><img src="../../enter/images/graph.gif" width="12" height="6"><br><% =rs("temph18") %></td>
                <td class="point01"><img src="../../enter/images/graph.gif" width="12" height="6"><br><% =rs("temph21") %></td>
              <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
              </tr>
              <tr> 
                <% FOR intI=1 to 3 %>
                <td class="point01"><img src="../../enter/images/graph2.gif" width="12" height="6"><br><% =rs("rainprobh6") %>%</td>
                <td class="point01"><img src="../../enter/images/graph2.gif" width="12" height="6"><br><% =rs("rainprobh9") %>%</td>
                <td class="point01"><img src="../../enter/images/graph2.gif" width="12" height="6"><br><% =rs("rainprobh12") %>%</td>
                <td class="point01"><img src="../../enter/images/graph2.gif" width="12" height="6"><br><% =rs("rainprobh15") %>%</td>
                <td class="point01"><img src="../../enter/images/graph2.gif" width="12" height="6"><br><% =rs("rainprobh18") %>%</td>
                <td class="point01"><img src="../../enter/images/graph2.gif" width="12" height="6"><br><% =rs("rainprobh21") %>%</td>
              <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
              </tr>
              <tr> 
                <td class="list13_bg2">����/�ְ�<br>
                  ���</td>
                <td class="list14_1" colspan="6"><% =rs("tempmax") %> ��</td><% rs.MOVENEXT %>
                <td class="list14_1" colspan="6"><% =rs("tempmin") %> / <% =rs("tempmax") %> ��</td> <% rs.MOVENEXT %>
                <td class="list14_1" colspan="6"><% =rs("tempmin") %> / <% =rs("tempmax") %> ��</td><% rs.MOVEFIRST %>
              </tr>
              <tr> 
                <td class="list13_bg2">�ּ�/�ִ�<br>
                  ����</td>
                <% FOR inti=1 to 3 %>
                <td class="list14_1" colspan="6"><% =rs("humimin") %> / <% =rs("humimax") %> %</td>
              <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
              </tr>
              <tr> 
                <td class="list13_bg2">���󰭼���</td>
                <% FOR inti=1 to 3 %>  
                <td class="list14_1" colspan="6"><% =rs("rainfalldcr") %> mm</td>
              <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>  
              </tr>
              <tr> 
                <td class="list13_bg2">���������</td>
                <% FOR inti=1 to 3 %>  
                <td class="list14_1" colspan="6"><% =rs("snowfalldcr") %> cm</td>
              <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
              </tr>
              <tr> 
                <td class="list13_bg2">���Ǻ�<br>
                  ��ǥ����</td>
                <% For inti=1 to 3 %>    
                <td class="list14_1" colspan="6"><% =rs("specialnotice") %></td>
              <% rs.MOVENEXT : NEXT  %>
              </tr>
              <tr> 
                <td class="list07_bg" rowspan="4">�ְ�����</td>
                <td class="list03_bg2" colspan="2">��¥</td>
                <% FOR inti=1 to 4 %>
                <td class="list15_bg" colspan="4"><% =mid(rs("sdate"),5,2) %>��<% =right(rs("sdate"),2) %>��(<% =left(weekdayname(weekday(dateserial(left(rs("sdate"),4),mid(rs("sdate"),5,2),right(rs("sdate"),2)))),1) %>)</td>
                <% rs.MOVENEXT : NEXT : FnMovingPointer %>
              </tr>
              <tr> 
                <td class="list03_bg2" colspan="2">����</td>
                <% FOR inti=1 to 4 %>
                <td class="list14_1" colspan="4"><% =rs("weatheroverview") %></td>
                <% rs.MOVENEXT : NEXT : FnMovingPointer %>
              </tr>
              <tr> 
                <td class="list03_bg2" colspan="2" rowspan="2">���</td>
                <td class="list14_1" colspan="2">����(��)</td>
                <td class="list14_1" colspan="2">�ְ�(��)</td>
                <td class="list14_1" colspan="2">����(��)</td>
                <td class="list14_1" colspan="2">�ְ�(��)</td>
                <td class="list14_1" colspan="2">����(��)</td>
                <td class="list14_1" colspan="2">�ְ�(��)</td>
                <td class="list14_1" colspan="2">����(��)</td>
                <td class="list14_1" colspan="2">�ְ�(��)</td>
              </tr>
              <tr> 
                <td class="list14_1" colspan="2"><% =rs("tempmin") %></td>
                <td class="list14_1" colspan="2"><% =rs("tempmax") %></td><% rs.MOVENEXT %>
                <td class="list14_1" colspan="2"><% =rs("tempmin") %></td>
                <td class="list14_1" colspan="2"><% =rs("tempmax") %></td><% rs.MOVENEXT %>
                <td class="list14_1" colspan="2"><% =rs("tempmin") %></td>
                <td class="list14_1" colspan="2"><% =rs("tempmax") %></td><% rs.MOVENEXT %>
                <td class="list14_1" colspan="2"><% =rs("tempmin") %></td>
                <td class="list14_1" colspan="2"><% =rs("tempmax") %></td><% FnMovingPointer %>
              </tr>
              <tr> 
                <td class="list13_bg2">�������</td>
                <td class="list14_1" colspan="18">&nbsp;</td>
              </tr>
              <tr> 
                <td class="list13_bg2" rowspan="2">�����ܼ���</td>
                <td class="table03"><img src="../../electric/images/s_icon01.gif" width="17" height="17"></td>
                <td class="table03" colspan="2"><img src="../../electric/images/s_icon02.gif" width="17" height="17"></td>
                <td class="table03" colspan="2"><img src="../../electric/images/s_icon03.gif" width="17" height="17"></td>
                <td class="table03"><img src="../../electric/images/s_icon04.gif" width="17" height="17"></td>
                <td class="table03"><img src="../../electric/images/s_icon05.gif" width="17" height="17"></td>
                <td class="table03"><img src="../../electric/images/s_icon06.gif" width="17" height="17"></td>
                <td class="table03"><img src="../../electric/images/s_icon07.gif" width="17" height="17"></td>
                <td class="table03" colspan="2"><img src="../../electric/images/s_icon08.gif" width="17" height="17"></td>
                <td class="table03" colspan="2"><img src="../../electric/images/s_icon09.gif" width="17" height="17"></td>
                <td class="table03" colspan="2"><img src="../../electric/images/s_icon10.gif" width="17" height="17"></td>
                <td class="table03" colspan="2"><img src="../../electric/images/s_icon11.gif" width="17" height="17"></td>
                <td class="table03"><img src="../../electric/images/s_icon12.gif" width="17" height="17"></td>
              </tr>
              <tr> 
                <td class="point01">����</td>
                <td class="point01" colspan="2">��������</td>
                <td class="point01" colspan="2">��������</td>
                <td class="point01">�帲</td>
                <td class="point01">��</td>
                <td class="point01">��</td>
                <td class="point01">��</td>
                <td class="point01" colspan="2">�ҳ���</td>
                <td class="point01" colspan="2">��Ǵ´�</td>
                <td class="point01" colspan="2">���Ǵº�</td>
                <td class="point01" colspan="2">õ�չ���</td>
                <td class="point01">�Ȱ�</td>
              </tr>
            </table>
			<!--����Ʈ���� ���̺� ��-->
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