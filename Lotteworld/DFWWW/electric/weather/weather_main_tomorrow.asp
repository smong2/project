<!-- #include file="../../electric/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' ���α׷�ID : TXBWEATHERMAIN Tomorrow
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���� ǥ�� - ���� ���� - Tomorrow
' �����ۼ��� : 2002/12/06
' �����ۼ��� : 2002/12/06
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

'������ ����
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
Dim varAreaCode, IntDateNum '��¥ �ڵ�
Dim rsoverview, rsland,rssea,rspoint 
'���ڵ�� (������Ȳ, ���󿹺�, �ػ󿹺�, ��������, ����Ʈ����-����ð� �����ϱ�)
dim intI '��������

ArrQuery = array("1") '�������� �´� �ڵ� ��������

'������ ����
Set objServer = Server.CreateObject("XBWeatherMainQMTS.clsXBWeatherMainQNTX")

'������Ʈ ȣ��
arrRValue = objServer.Query(ArrQuery)
'���ڵ�� ��̸� ���� ���ڵ������ �и�

'ù��° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rsoverview,1
'�ι�° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rsland,2
'�׹�° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rspoint,3

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
<!-- #include file="../../electric/script/fnWeather_Main_Code.inc"-->
<!-- #include file="../../electric/script/fnWeather_Icon.inc"-->
<html>
<head>
<title>�������� ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<script language="JavaScript" src="../../electric/script/FnRolloverReload.js"></script>
<link rel="stylesheet" href="../../electric/css/cs_te.css" type="text/css">
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../../electric/images/map_after_tomorrow_on.gif','../../electric/images/map_today_on.gif')">

<!--����/��� ���� ���̾� ����-->
<div id="div����/���" style="position:absolute; left:127px; top:137px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td bgcolor="#b4b4b4">
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="weather_land.asp?varAreaCode=14&varAreaName=����/���"><img src="../../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif" width="34" height="34" border="0" alt='<%=rsland("overview") %>'></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %><% rsland.MOVENEXT %></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--����/��� ���� ���̾� ��-->

<!--���� ���� ���̾� ����-->
<div id="div����" style="position:absolute; left:182px; top:105px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td bgcolor="#b4b4b4">
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="weather_land.asp?varAreaCode=15&varAreaName=����"><img src="../../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif" width="34" height="34" border="0" alt='<%=rsland("overview") %>'></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %><% rsland.MOVENEXT %></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--���� ���� ���̾� ��-->

<!--���� ���� ���̾� ����-->
<div id="div����" style="position:absolute; left:229px; top:127px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td bgcolor="#b4b4b4">
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="weather_land.asp?varAreaCode=16&varAreaName=����"><img src="../../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif" width="34" height="34" border="0" alt='<%=rsland("overview") %>'></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %><% rsland.MOVENEXT %></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--���� ���� ���̾� ��-->

<!--�︪�� ���� ���̾� ����-->
<div id="div�︪��" style="position:absolute; left:280px; top:148px; width:34px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td bgcolor="#b4b4b4">
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="weather_land.asp?varAreaCode=17&varAreaName=�︪/����"><img src="../../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif" width="34" height="34" border="0" alt='<%=rsland("overview") %>'></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %><% rsland.MOVENEXT %></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--�︪�� ���� ���̾� ��-->

<!--��� ���� ���̾� ����-->
<div id="div���" style="position:absolute; left:181px; top:182px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td bgcolor="#b4b4b4">
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="weather_land.asp?varAreaCode=18&varAreaName=���"><img src="../../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif" width="34" height="34" border="0" alt='<%=rsland("overview") %>'></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %><% rsland.MOVENEXT %></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--��� ���� ���̾� ��-->

<!--�泲 ���� ���̾� ����-->
<div id="div�泲" style="position:absolute; left:114px; top:207px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td bgcolor="#b4b4b4">
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="weather_land.asp?varAreaCode=19&varAreaName=�泲"><img src="../../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif" width="34" height="34" border="0" alt='<%=rsland("overview") %>'></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %><% rsland.MOVENEXT %></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--�泲 ���� ���̾� ��-->

<!--���� ���� ���̾� ����-->
<div id="div����" style="position:absolute; left:162px; top:253px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td bgcolor="#b4b4b4">
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="weather_land.asp?varAreaCode=1A&varAreaName=����"><img src="../../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif" width="34" height="34" border="0" alt='<%=rsland("overview") %>'></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %><% rsland.MOVENEXT %></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--���� ���� ���̾� ��-->

<!--���� ���� ���̾� ����-->
<div id="div����" style="position:absolute; left:105px; top:286px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td bgcolor="#b4b4b4">
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="weather_land.asp?varAreaCode=1B&varAreaName=����"><img src="../../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif" width="34" height="34" border="0" alt='<%=rsland("overview") %>'></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %><% rsland.MOVENEXT %></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--���� ���� ���̾� ��-->

<!--���ֵ� ���� ���̾� ����-->
<div id="div���ֵ�" style="position:absolute; left:150px; top:343px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td bgcolor="#b4b4b4">
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="weather_land.asp?varAreaCode=1C&varAreaName=����"><img src="../../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif" width="34" height="34" border="0" alt='<%=rsland("overview") %>'></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %><% rsland.MOVENEXT %></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--���ֵ� ���� ���̾� ��-->

<!--��� ���� ���̾� ����-->
<div id="div���" style="position:absolute; left:235px; top:210px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td bgcolor="#b4b4b4">
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="weather_land.asp?varAreaCode=1D&varAreaName=���"><img src="../../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif" width="34" height="34" border="0" alt='<%=rsland("overview") %>'></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %><% rsland.MOVENEXT %></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--��� ���� ���̾� ��-->

<!--�泲 ���� ���̾� ����-->
<div id="div�泲" style="position:absolute; left:217px; top:280px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td bgcolor="#b4b4b4">
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="weather_land.asp?varAreaCode=1F&varAreaName=�泲"><img src="../../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif" width="34" height="34" border="0" alt='<%=rsland("overview") %>'></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--�泲 ���� ���̾� ��-->

<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
  <tr> 
    <td width="49"><img src="../../electric/images/null.gif" width="49" height="1"></td>
    <td valign="top">
	<!--ū ���̺� ����--> 
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td colspan="3"><img src="../../electric/images/null.gif" width="1" height="25"></td>
        </tr>
        <tr> 
          <td><img src="../../electric/images/title_weatherinfo.gif" width="290" height="21"></td>
          <td rowspan="8" width="41"></td>
          <td height="21"></td>
        </tr>
        <tr> 
          <td rowspan="7"> 
            <!--������ ����/������ ����/���� ���� ��ü���̺� ����-->
            <table width="290" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="29"> 
                  <!--������ ����/������ ����/���� ���� �� ����-->
                  <table width="290" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td colspan="3" height="6"></td>
                    </tr>
                    <tr> 
                      <td><a href="weather_main_today.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image81','','../../electric/images/map_today_on.gif',1)"><img name="Image81" border="0" src="../../electric/images/map_today.gif" width="96" height="23"></a></td>
                      <td><img src="../../electric/images/map_tomorrow_on.gif" width="98" height="23" alt=<% =rsoverview("sdate") %>></td>
                      <td><a href="weather_main_afterto.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image128','','../../electric/images/map_after_tomorrow_on.gif',1)"><img name="Image128" border="0" src="../../electric/images/map_after_tomorrow.gif" width="96" height="23"></a></td>
                    </tr>
                  </table>
                  <!--������ ����/������ ����/���� ���� �� ��-->
                </td>
              </tr>
              <tr> 
                <td><img src="../../electric/images/tomorrow_national_map.gif" width="290" height="322"></td>
              </tr>
            </table>
            <!--������ ����/������ ����/���� ���� ��ü���̺� ��-->
          </td>
          <td height="6"></td>
        </tr>
        <tr> 
          <td height="20" valign="top"> 
            <!--���Ȳ Ÿ��Ʋ ����-->
            <table width="312" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="15" height="11" class="table03"><img src="../../electric/images/yellowgreen_buret.gif" width="7" height="7"></td>
                <td class="title_01">���Ȳ</td>
              </tr>
            </table>
            <!--���Ȳ Ÿ��Ʋ ��-->
          </td>
        </tr>
        <tr> 
          <td><img src="../../electric/images/point_line8.gif" width="312" height="1"></td>
        </tr>
        <tr> 
          <td class="list14" height="150"><% =rsoverview("landoverview") %></td>
        </tr>
        <tr> 
          <td><img src="../../electric/images/point_line8.gif" width="312" height="1"></td>
        </tr>
        <tr> 
          <td height="173"></td>
        </tr>
        <tr> </tr>
        <tr> 
          <td colspan="3" height="30"></td>
        </tr>
      </table>
	  <!--ū ���̺� ��-->
    </td>
    <td width="49"><img src="../../electric/images/null.gif" width="49" height="1"></td>
    <td bgcolor="#a4a4a4"><img src="../../electric/images/outline.gif" width="1" height="1"></td>
  </tr>
  <tr> 
    <td height="42" colspan="3" background="../../electric/images/copyright_bg.gif" align="right"><img src="../../electric/images/copyright.gif" width="350" height="42"></td>
    <td bgcolor="#a4a4a4" width="1" height="42"><img src="../../electric/images/null.gif"></td>
  </tr>
</table>
</body>
</html>
