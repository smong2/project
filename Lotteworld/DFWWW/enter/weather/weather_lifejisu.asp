<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' ���α׷�ID : TXBWEATHERJISU
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���� ǥ�� - ����
' �����ۼ��� : 2002/11/28
' �����ۼ��� : 2002/11/28
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

'������ ����
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
Dim rs,rsjisu, varAreaCode '�����ڵ�
'���ڵ�� (�����������,��������)
dim intI '��������

varAreaCode=Request.QueryString("varAreaCode")

ArrQuery = array(varAreaCode) '�������� �´� �ڵ� ��������

'������ ����
Set objServer = Server.CreateObject("XBWeatherViewQMTS.clsXBWeatherViewQNTX")

'������Ʈ ȣ��
arrRValue = objServer.Query(ArrQuery)
'���ڵ�� ��̸� ���� ���ڵ������ �и�

'ù��° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rs,4
'�ι�° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rsjisu,5

'�ڿ��� ����
Set objServer = Nothing

IF varAreaCode="" THEN varAreaCode="������"

'������ ó��
IF Err.Number <> 0 THEN 
	Response.Write Err.Number, Err.Source, Err.Description
	Set objServer = Nothing
	objserver.close
END IF
%>	
<!-- #include file="../../enter/script/FnProgramProcess.vbs" -->	
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
          <td><img src="../../enter/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
          <td align="left"><img src="../../enter/images/title_weather_life.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td> 
            <!--��Ȱ������� ���� ���̺� ����-->
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="15" height="11" class="table03"><img src="../../enter/images/orange_buret.gif" width="7" height="7"></td>
                <td class="title_01">��
                <% DO UNTIL rs.EOF %>
                <a href="weather_lifejisu.asp?varAreaCode=<% =rs("areaname") %>"><% =rs("areaname") %></a>��
                <% rs.MOVENEXT : LOOP %>
                </td>
              </tr>
            </table>
            <!--��Ȱ������� ���� ���̺� ��-->
          </td>
        </tr>
        <tr> 
          <td height="20"></td>
        </tr>
        <tr> 
          <td height="30" class="list13_bg"><% =varAreaCode %> ���� ��Ȱ�������</td>
        </tr>
        <tr> 
          <td height="20"></td>
        </tr>
        <tr> 
          <td>
		  <!--��Ȱ������� ���̺� ����--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td>
				<!--���������� ���̺� ����--> 
                  <table width="300" border="1" bordercolor="#dadada" cellspacing="0" cellpadding="5">
                    <tr> 
                      <td rowspan="2" class="table04" width="80"><img src="../../enter/images/newjisu01.gif" width="80" height="80"></td>
                      <td class="table03" height="50">
					  <!--���������� ����--> 
                        <table width="90" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td class="list15_1">����������</td>
                            <td class="list16"><% =rsjisu("picnicjisu") %></td>
                          </tr>
                        </table>
						<!--���������� ��-->
                      </td>
                    </tr>
                    <tr> 
                      <td class="list14_bg2"><% =rsjisu("picnicindex") %></td>
                    </tr>
                  </table>
				  <!--���������� ���̺� ��-->
                </td>
                <td width="42"></td>
                <td>
				<!--���������� ���̺� ����--> 
                  <table width="300" border="1" bordercolor="#dadada" cellspacing="0" cellpadding="5">
                    <tr> 
                      <td rowspan="2" class="table04" width="80"><img src="../../enter/images/newjisu05.gif" width="80" height="80"></td>
                      <td class="table03" height="50">
					  <!--���������� ����--> 
                        <table width="90" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td class="list15_1">����������</td>
                            <td class="list16"><% =rsjisu("firejisu") %></td>
                          </tr>
                        </table>
						<!--���������� ��-->
                      </td>
                    </tr>
                    <tr> 
                      <td class="list14_bg2"><% =rsjisu("fireindex") %></td>
                    </tr>
                  </table>
				  <!--���������� ���̺� ��-->
                </td>
              </tr>
              <tr> 
                <td height="10"></td>
                <td></td>
                <td></td>
              </tr>
              <tr> 
                <td>
				<!--�������� ���̺� ����--> 
                  <table width="300" border="1" bordercolor="#dadada" cellspacing="0" cellpadding="5">
                    <tr> 
                      <td rowspan="2" class="table04" width="80"><img src="../../enter/images/newjisu02.gif" width="80" height="80"></td>
                      <td class="table03" height="50">
					  <!--�������� ����--> 
                        <table width="90" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td class="list15_1">��������</td>
                            <td class="list16"><% =rsjisu("clothwashjisu")%></td>
                          </tr>
                        </table>
						<!--�������� ��-->
                      </td>
                    </tr>
                    <tr> 
                      <td class="list14_bg2"><% =rsjisu("clothwashindex") %></td>
                    </tr>
                  </table>
				  <!--�������� ���̺� ��-->
                </td>
                <td></td>
                <td>
				<!--�������� ���̺� ����--> 
                  <table width="300" border="1" bordercolor="#dadada" cellspacing="0" cellpadding="5">
                    <tr> 
                      <td rowspan="2" class="table04" width="80"><img src="../../enter/images/newjisu10.gif" width="80" height="80"></td>
                      <td class="table03" height="50">
					  <!--�������� ����--> 
                        <table width="90" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td class="list15_1">��������</td>
                            <td class="list16"><% =rsjisu("hotcooljisu") %></td>
                          </tr>
                        </table>
						<!--�������� ��-->
                      </td>
                    </tr>
                    <tr> 
                      <td class="list14_bg2"><% =rsjisu("hotcoolindex") %></td>
                    </tr>
                  </table>
				  <!--�������� ���̺� ��-->
                </td>
              </tr>
              <tr> 
                <td height="10"></td>
                <td></td>
                <td></td>
              </tr>
              <tr> 
                <td>
				<!--�������� ���̺� ����--> 
                  <table width="300" border="1" bordercolor="#dadada" cellspacing="0" cellpadding="5">
                    <tr> 
                      <td rowspan="2" class="table04" width="80"><img src="../../enter/images/newjisu03.gif" width="80" height="80"></td>
                      <td class="table03" height="50">
					  <!--�������� ����--> 
                        <table width="90" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td class="list15_1">��������</td>
                            <td class="list16"><% =rsjisu("carwashjisu") %></td>
                          </tr>
                        </table>
						<!--�������� ��-->
                      </td>
                    </tr>
                    <tr> 
                      <td class="list14_bg2"><% =rsjisu("carwashindex") %></td>
                    </tr>
                  </table>
				  <!--�������� ���̺� ��-->
                </td>
                <td></td>
                <td>
				<!--����� ���̺� ����--> 
                  <table width="300" border="1" bordercolor="#dadada" cellspacing="0" cellpadding="5">
                    <tr> 
                      <td rowspan="2" class="table04" width="80"><img src="../../enter/images/newjisu06.gif" width="80" height="80"></td>
                      <td class="table03" height="50">
					  <!--����� ����--> 
                        <table width="90" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td class="list15_1">�����</td>
                            <td class="list16"><% =rsjisu("playjisu") %></td>
                          </tr>
                        </table>
						<!--����� ��-->
                      </td>
                    </tr>
                    <tr> 
                      <td class="list14_bg2"><% =rsjisu("playindex") %></td>
                    </tr>
                  </table>
				  <!--����� ���̺� ��-->
                </td>
              </tr>
            </table>
			<!--��Ȱ������� ���̺� ��-->
          </td>
        </tr>
        <tr>
          <td height="20"></td>
        </tr>
        <tr> 
          <td height="10" bgcolor="#E2F3FE"></td>
        </tr>
        <tr> 
          <td><img src="../../enter/images/point_line7.gif" width="642" height="1"></td>
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
  <!-- #include file="../../enter/script/FnErrorCatch.inc" -->