<!-- #include file="../electric/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' ���α׷�ID : MAIN tomorrow
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���� ���� ���� ������ - ����
' �����ۼ��� : 2002/11/27
' �����ۼ��� : 2002/11/27
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
Dim rs, rslast, rslastsum, rslastweek, rslastweeksum, rsland,rsoverview, rspoint'���ڵ�� (���⵿��,���⵿���հ�,���⵿����,���⵿�����հ�,���󿹺�,���Ȳ)
dim intI '��������

%>
<!-- #include file="../electric/script/FnSearch_Date.inc"-->
<%
ArrQuery = array("tomorrow",dtLastDay,dtLastWeekDay) '���� ����

'������ ����
Set objServer = Server.CreateObject("XEElectMainQMTS.clsXEElectMainQNTX")

'������Ʈ ȣ��
arrRValue = objServer.Query(ArrQuery)
'���ڵ�� ��̸� ���� ���ڵ������ �и�

'ù��° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rs,1
'�ι�° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rslast,2
'����° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rslastweek,3
'�׹�° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rsland,4
'�ټ���° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rsoverview,5
'������° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rspoint,6

'�ڿ��� ����
Set objServer = Nothing

'������ ó��
IF Err.Number <> 0 THEN 
	Response.Write Err.Number, Err.Source, Err.Description
	Set objServer = Nothing
	objserver.close
END IF
%>
<!-- #include file="../electric/script/FnProgramProcess.vbs" -->
<!-- #include file="../electric/script/fnnumber_format.inc"-->
<!-- #include file="../electric/script/FnWeather_Icon.inc"-->
<!-- #include file="../electric/script/fnWeather_Main_Code.inc"-->
<html>
<head>
<title>�����ǳ���_main</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<script language="JavaScript" src=../electric/script/FnRolloverReload.js></script>
<link rel="stylesheet" href="../electric/css/cs_te.css" type="text/css">
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../electric/images/map_today_on.gif','../electric/images/map_after_tomorrow_on.gif')">

<!--���� ���̾� ����-->
<div id="����" style="position:absolute; left:123px; top:218px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../electric/weather/weather_land.asp"><img src="../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../electric/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--���� ���̾� ��-->
<!--��ȭ ���̾� ����-->
<div id="��ȭ" style="position:absolute; left:95px; top:284px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../electric/weather/weather_land.asp"><img src="../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../electric/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--��ȭ ���̾� ��-->
<!--����õ ���̾� ����-->
<div id="����õ" style="position:absolute; left:95px; top:154px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../electric/weather/weather_land.asp"><img src="../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../electric/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--����õ ���̾� ��-->
<!--���� ���̾� ����-->
<div id="����" style="position:absolute; left:168px; top:199px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../electric/weather/weather_land.asp"><img src="../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../electric/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--���� ���̾� ��-->
<!--��õ ���̾� ����-->
<div id="��õ" style="position:absolute; left:60px; top:220px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../electric/weather/weather_land.asp"><img src="../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../electric/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--��õ ���̾� ��-->
<!--���� ���̾� ����-->
<div id="����" style="position:absolute; left:140px; top:289px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../electric/weather/weather_land.asp"><img src="../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../electric/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--���� ���̾� ��-->
<!--��õ ���̾� ����-->
<div id="��õ" style="position:absolute; left:185px; top:264px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../electric/weather/weather_land.asp"><img src="../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../electric/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--��õ ���̾� ��-->
<!--ö�� ���̾� ����-->
<div id="ö��" style="position:absolute; left:160px; top:126px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../electric/weather/weather_land.asp?varAreaCode=15&varAreaName=����"><img src="../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../electric/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--ö�� ���̾� ��-->
<!--��õ ���̾� ����-->
<div id="��õ" style="position:absolute; left:211px; top:158px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../electric/weather/weather_land.asp?varAreaCode=15&varAreaName=����"><img src="../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../electric/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--��õ ���̾� ��-->
<!--ȫõ ���̾� ����-->
<div id="ȫõ" style="position:absolute; left:254px; top:172px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../electric/weather/weather_land.asp?varAreaCode=15&varAreaName=����"><img src="../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../electric/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--ȫõ ���̾� ��-->
<!--���� ���̾� ����-->
<div id="����" style="position:absolute; left:230px; top:237px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../electric/weather/weather_land.asp?varAreaCode=15&varAreaName=����"><img src="../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../electric/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--���� ���̾� ��-->

<!--���� ���̾� ����-->
<div id="����" style="position:absolute; left:288px; top:232px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../electric/weather/weather_land.asp?varAreaCode=15&varAreaName=����"><img src="../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../electric/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--���� ���̾� ��-->
<!--���� ���̾� ����-->
<div id="����" style="position:absolute; left:228px; top:303px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../electric/weather/weather_land.asp?varAreaCode=18&varAreaName=���"><img src="../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../electric/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--���� ���̾� ��-->
<!--��õ ���̾� ����-->
<div id="��õ" style="position:absolute; left:272px; top:304px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../electric/weather/weather_land.asp?varAreaCode=18&varAreaName=���"><img src="../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../electric/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--��õ ���̾� ��-->
<!--û�� ���̾� ����-->
<div id="û��" style="position:absolute; left:184px; top:334px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../electric/weather/weather_land.asp?varAreaCode=18&varAreaName=���"><img src="../electric/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../electric/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--û�� ���̾� ��-->
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
  <tr> 
    <td width="49"><img src="../electric/images/null.gif" width="49" height="1"></td>
    <td valign="top"> 
	<!--ū ���̺� ����-->
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td colspan="3"><img src="../electric/images/null.gif" width="1" height="25"></td>
        </tr>
        <tr> 
          <td><img src="../electric/images/title_weatherinfo.gif" width="290" height="21"></td>
          <td rowspan="12" width="41"></td>
          <td height="21"></td>
        </tr>
        <tr> 
          <td rowspan="11"> 
            <!--������ ����/������ ����/���� ���� ��ü���̺� ����-->
            <table width="290" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="29"> 
                  <!--������ ����/������ ����/���� ���� �� ����-->
                  <table width="290" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td colspan="3"><img src="../electric/images/null.gif" width="1" height="6"></td>
                    </tr>
                    <tr> 
                      <td><a href="main_today.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image143','','../electric/images/map_today_on.gif',1)"><img name="Image143" border="0" src="../electric/images/map_today.gif" width="96" height="23"></a></td>
                      <td><img src="../electric/images/map_tomorrow_on.gif" width="98" height="23"></td>
                      <td><a href="main_afterto.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1281','','../electric/images/map_after_tomorrow_on.gif',1)"><img name="Image1281" border="0" src="../electric/images/map_after_tomorrow.gif" width="96" height="23"></a></td>
                    </tr>
                  </table>
                  <!--������ ����/������ ����/���� ���� �� ��-->
                </td>
              </tr>
              <tr> 
                <td><img src="../electric/images/tomorrow_map.gif" width="290" height="322"></td>
              </tr>
            </table>
            <!--������ ����/������ ����/���� ���� ��ü���̺� ��-->
          </td>
          <td width="312" height="6"></td>
        </tr>
        <tr> 
          <td> 
            <!--����µ� Ÿ��Ʋ ����-->
            <table width="312" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="15" height="11" class="table03"><img src="../electric/images/yellowgreen_buret.gif" width="7" height="7"></td>
                <td class="title_01">����µ�</td>
              </tr>
            </table>
            <!--����µ� Ÿ��Ʋ ��-->
          </td>
        </tr>
        <tr> 
          <td height="10" width="312"></td>
        </tr>
        <tr> 
          <td height="26" background="../electric/images/temperature_bg.gif" class="list17_1" width="312">���� 
            <% =hour(time()) %>�� &nbsp; <% =rspoint(hour(time())+25) %>�� &nbsp; <% =FnWeatherCode(rspoint(hour(time()))) %>
          </td>
        </tr>
        <tr> 
          <td height="26"></td>
        </tr>
        <tr> 
          <td height="20" valign="top"> 
            <!--���Ȳ Ÿ��Ʋ ����-->
            <table width="312" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="15" height="11" class="table03"><img src="../electric/images/yellowgreen_buret.gif" width="7" height="7"></td>
                <td class="title_01">���Ȳ</td>
              </tr>
            </table>
            <!--���Ȳ Ÿ��Ʋ ��-->
          </td>
        </tr>
        <tr> 
          <td><img src="../electric/images/point_line8.gif" width="312" height="1"></td>
        </tr>
        <tr> 
          <td width="312" height="10" bgcolor="#f5f5f5"></td>
        </tr>
        <tr> 
          <td class="list14" height="207" width="312">&nbsp; 
            <% =rsoverview("airtendency") %><br>&nbsp; 
            <% =rsoverview("landoverview") %><br>&nbsp; 
            <% =rsoverview("seaoverview") %>
          </td>
        </tr>
        <tr> 
          <td width="312" height="10" bgcolor="#f5f5f5"></td>
        </tr>
        <tr> 
          <td><img src="../electric/images/point_line8.gif" width="312" height="1"></td>
        </tr>
        <tr> 
          <td colspan="3" height="30"></td>
        </tr>
        <tr> 
          <td colspan="3"> 
            <!--���� ���� ���̺� ����-->
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr class="list02_bg"> 
                <td colspan="2">���</td>
                <td>M/I</td>
                <td>ADV</td>
                <td>������</td>
                <td>ȣ��</td>
                <td>��ȭ��</td>
                <td>����</td>
                <td>��Ʈ</td>
                <td>�Ѱ�</td>
              </tr>
              <tr> 
                <td class="list07_bg" colspan="2">������</td>
                <td class="list14_bg"><% =FnNumberFormat(rs("magicisland")) %></td>
                <td class="list14_bg"><% =FnNumberFormat(rs("adventure")) %></td>
                <td class="list14_bg"><% =FnNumberFormat(rs("sports")) %></td>
                <td class="list14_bg"><% =FnNumberFormat(rs("hotel")) %></td>
                <td class="list14_bg"><% =FnNumberFormat(rs("departmentstore")) %></td>
                <td class="list14_bg"><% =FnNumberFormat(rs("shoppingmall")) %></td>
                <td class="list14_bg"><% =FnNumberFormat(rs("mart")) %></td>
                <td class="list15_bg3"><% =FnNumberFormat(rs("total")) %></td>
              </tr>
              <tr> 
                <td rowspan="2" class="list07_bg2" title='<% =rslast("sdate") %>'>����</td>
                <td class="list03_bg2">�������</td>
                <td class="list14_bg2"><% =FnNumberFormat(rslast("magicisland")) %></td>
                <td class="list14_bg2"><% =FnNumberFormat(rslast("adventure")) %></td>
                <td class="list14_bg2"><% =FnNumberFormat(rslast("sports")) %></td>
                <td class="list14_bg2"><% =FnNumberFormat(rslast("hotel")) %></td>
                <td class="list14_bg2"><% =FnNumberFormat(rslast("departmentstore")) %></td>
                <td class="list14_bg2"><% =FnNumberFormat(rslast("shoppingmall")) %></td>
                <td class="list14_bg2"><% =FnNumberFormat(rslast("mart")) %></td>
                <td class="list15_bg"><% =FnNumberFormat(rslast("total")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">�����</td>
                <td class="list14_bg"><% =FnPercentFormat(rs("magicisland"), rslast("magicisland")) %></td>
                <td class="list14_bg"><% =FnPercentFormat(rs("adventure"), rslast("adventure")) %></td>
                <td class="list14_bg"><% =FnPercentFormat(rs("sports"), rslast("sports")) %></td>
                <td class="list14_bg"><% =FnPercentFormat(rs("hotel"), rslast("hotel")) %></td>
                <td class="list14_bg"><% =FnPercentFormat(rs("departmentstore"), rslast("departmentstore")) %>-</td>
                <td class="list14_bg"><% =FnPercentFormat(rs("shoppingmall"), rslast("shoppingmall")) %></td>
                <td class="list14_bg"><% =FnPercentFormat(rs("mart"), rslast("mart")) %></td>
                <td class="list15_bg3"><% =FnPercentFormat(rs("total"), rslast("total")) %></td>
              </tr>
              <tr> 
                <td rowspan="2" class="list07_bg2" title='<% =rslastweek("sdate") %>'>������</td>
                <td class="list03_bg2">�������</td>
                <td class="list14_bg2"><% =FnNumberFormat(rslastweek("magicisland")) %></td>
                <td class="list14_bg2"><% =FnNumberFormat(rslastweek("adventure")) %></td>
                <td class="list14_bg2"><% =FnNumberFormat(rslastweek("sports")) %></td>
                <td class="list14_bg2"><% =FnNumberFormat(rslastweek("hotel")) %></td>
                <td class="list14_bg2"><% =FnNumberFormat(rslastweek("departmentstore")) %></td>
                <td class="list14_bg2"><% =FnNumberFormat(rslastweek("shoppingmall")) %></td>
                <td class="list14_bg2"><% =FnNumberFormat(rslastweek("mart")) %></td>
                <td class="list15_bg"><% =FnNumberFormat(rslastweek("total")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg">�����</td>
                <td class="list14_bg"><% =FnPercentFormat(rs("magicisland"), rslastweek("magicisland")) %></td>
                <td class="list14_bg"><% =FnPercentFormat(rs("adventure"), rslastweek("adventure")) %></td>
                <td class="list14_bg"><% =FnPercentFormat(rs("sports"), rslastweek("sports")) %></td>
                <td class="list14_bg"><% =FnPercentFormat(rs("hotel"), rslastweek("hotel")) %></td>
                <td class="list14_bg"><% =FnPercentFormat(rs("departmentstore"), rslastweek("departmentstore")) %>-</td>
                <td class="list14_bg"><% =FnPercentFormat(rs("shoppingmall"), rslastweek("shoppingmall")) %></td>
                <td class="list14_bg"><% =FnPercentFormat(rs("mart"), rslastweek("mart")) %></td>
                <td class="list15_bg3"><% =FnPercentFormat(rs("total"), rslastweek("total")) %></td>
              </tr>
              <tr bgcolor="#CECFF5"> 
                <td colspan="10" height="6"></td>
              </tr>
            </table>
            <!--���� ���� ���̺� ��-->
          </td>
        </tr>
        <tr> 
          <td colspan="3" height="30"></td>
        </tr>
      </table>
	  <!--ū ���̺� ��-->
    </td>
    <td width="49"><img src="../electric/images/null.gif" width="49" height="1"></td>
    <td bgcolor="#a4a4a4"><img src="../electric/images/outline.gif" width="1" height="1"></td>
  </tr>
  <tr> 
    <td height="42" colspan="3" background="../electric/images/copyright_bg.gif" align="right"><img src="../electric/images/copyright.gif" width="350" height="42"></td>
    <td bgcolor="#a4a4a4" width="1" height="42"><img src="../electric/images/null.gif"></td>
  </tr>
</table>
</body>
</html>
<!-- #include file="../electric/script/FnErrorCatch.inc"-->