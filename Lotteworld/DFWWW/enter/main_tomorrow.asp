<!-- #include file="../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' ���α׷�ID : MAIN tomorrow
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���尴 ���� ���� ������ - ����
' �����ۼ��� : 2002/10/16
' �����ۼ��� : 2002/10/18
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

'������ ����
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
Dim rslotte,rsever, rsseoul,rsland '���ڵ�� (�Ե� ���, ���﷣�� ���, �������� ���)
Dim rs,rse, rslast, rslaste '���ڵ��(��ǥ����, �����忹��, ��ǥ ���� ����, ������ ���Ž���)

intDateadd=1 '��¥ ��������
ArrQuery = array("Tomorrow") '���� ����

'������ ����
Set objServer = Server.CreateObject("XTEnterMainDayMTS.clsXTEnterMainDayNTX")

'������Ʈ ȣ��
arrRValue = objServer.Query(ArrQuery)
'���ڵ�� ��̸� ���� ���ڵ������ �и�

'ù��° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rslotte,1
'�ι�° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rsever,2
'ù��° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rsseoul,3
'�׹�° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rsland,4
'�ټ���° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rs,5
'������° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rse,6
'�ϰ���° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rslast,7
'������° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rslaste,8

'�ڿ��� ����
Set objServer = Nothing

'������ ó��
IF Err.Number <> 0 THEN 
	Response.Write Err.Number, Err.Source, Err.Description
	Set objServer = Nothing
	objserver.close
END IF
%>
<!-- #include file="../enter/script/fnevent_view.inc" -->
<!-- #include file="../enter/script/FnProgramProcess.vbs" -->
<!-- #include file="../enter/script/fnnumber_format.inc"-->
<!-- #include file="../enter/script/FnWeather_Icon.inc"-->
<html>
<head>
<title>�����ǳ���_main</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<script language="JavaScript" src=../enter/script/FnEnterMain.js></script>
<link rel="stylesheet" href="../enter/css/cs_tx.css" type="text/css">
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../enter/images/map_after_tomorrow_on.gif','../enter/images/map_today_on.gif')">
<input type=hidden name=hiddenid value=<% =Request.Form("hiddenid") %>>
<!--���� ���̾� ����-->
<div id="����" style="position:absolute; left:123px; top:218px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../enter/weather/weather_land.asp"><img src="../enter/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' width="34" height="34" border="0" onClick="top.leftFrame.location.href('../enter/leftmenu/left_menu_weather.asp')"></a></td>
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
            <td class="table09" height="34"><a href="../enter/weather/weather_land.asp"><img src="../enter/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' .gif" width="34" height="34" border="0" onClick="top.leftFrame.location.href('../enter/leftmenu/left_menu_weather.asp')"></a></td>
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
            <td class="table09" height="34"><a href="../enter/weather/weather_land.asp"><img src="../enter/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' .gif" width="34" height="34" border="0" onClick="top.leftFrame.location.href('../enter/leftmenu/left_menu_weather.asp')"></a></td>
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
            <td class="table09" height="34"><a href="../enter/weather/weather_land.asp"><img src="../enter/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' .gif" width="34" height="34" border="0" onClick="top.leftFrame.location.href('../enter/leftmenu/left_menu_weather.asp')"></a></td>
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
            <td class="table09" height="34"><a href="../enter/weather/weather_land.asp"><img src="../enter/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' .gif" width="34" height="34" border="0" onClick="top.leftFrame.location.href('../enter/leftmenu/left_menu_weather.asp')"></a></td>
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
            <td class="table09" height="34"><a href="../enter/weather/weather_land.asp"><img src="../enter/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' .gif" width="34" height="34" border="0" onClick="top.leftFrame.location.href('../enter/leftmenu/left_menu_weather.asp')"></a></td>
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
            <td class="table09" height="34"><a href="../enter/weather/weather_land.asp"><img src="../enter/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' .gif" width="34" height="34" border="0" onClick="top.leftFrame.location.href('../enter/leftmenu/left_menu_weather.asp')"></a></td>
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
            <td class="table09" height="34"><a href="../enter/weather/weather_land.asp?varAreaCode=15&varAreaName=����"><img src="../enter/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' .gif" width="34" height="34" border="0" onClick="top.leftFrame.location.href('../enter/leftmenu/left_menu_weather.asp')"></a></td>
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
            <td class="table09" height="34"><a href="../enter/weather/weather_land.asp?varAreaCode=15&varAreaName=����"><img src="../enter/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' .gif" width="34" height="34" border="0" onClick="top.leftFrame.location.href('../enter/leftmenu/left_menu_weather.asp')"></a></td>
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
            <td class="table09" height="34"><a href="../enter/weather/weather_land.asp?varAreaCode=15&varAreaName=����"><img src="../enter/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' .gif" width="34" height="34" border="0" onClick="top.leftFrame.location.href('../enter/leftmenu/left_menu_weather.asp')"></a></td>
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
            <td class="table09" height="34"><a href="../enter/weather/weather_land.asp?varAreaCode=15&varAreaName=����"><img src="../enter/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' .gif" width="34" height="34" border="0" onClick="top.leftFrame.location.href('../enter/leftmenu/left_menu_weather.asp')"></a></td>
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
            <td class="table09" height="34"><a href="../enter/weather/weather_land.asp?varAreaCode=15&varAreaName=����"><img src="../enter/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' 1.gif" width="34" height="34" border="0" onClick="top.leftFrame.location.href('../enter/leftmenu/left_menu_weather.asp')"></a></td>
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
            <td class="table09" height="34"><a href="../enter/weather/weather_land.asp?varAreaCode=18&varAreaName=���"><img src="../enter/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' .gif" width="34" height="34" border="0" onClick="top.leftFrame.location.href('../enter/leftmenu/left_menu_weather.asp')"></a></td>
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
            <td class="table09" height="34"><a href="../enter/weather/weather_land.asp?varAreaCode=18&varAreaName=���"><img src="../enter/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' .gif" width="34" height="34" border="0" onClick="top.leftFrame.location.href('../enter/leftmenu/left_menu_weather.asp')"></a></td>
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

<!--û�� ���̾� ����-->
<div id="û��" style="position:absolute; left:184px; top:334px; width:42px; height:44px; z-index:1"> 
  <table width="42" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td bgcolor="#b4b4b4"> 
        <table width="42" border="0" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="table09" height="34"><a href="../enter/weather/weather_land.asp?varAreaCode=18&varAreaName=���"><img src="../enter/images/new<% =FnWeatherIcon(rsland("overview")) %>.gif"  alt='<% =rsland("overview") %>' .gif" width="34" height="34" border="0" onClick="top.leftFrame.location.href('../enter/leftmenu/left_menu_weather.asp')"></a></td>
          </tr>
          <tr> 
            <td height="10" class="map01"><% =rsland("tempmin") %>/<% =rsland("tempmax") %></td><% rsland.MOVENEXT %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</div>
<!--û�� ���̾� ��-->
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%"  bgcolor="#FFFFFF">
  <tr> 
    <td width="49"><img src="../enter/images/null.gif" width="49" height="1"></td>
    <td valign="top">
	<!--ū ���̺� ����--> 
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td colspan="3"><img src="../enter/images/null.gif" width="1" height="25"></td>
        </tr>
        <tr> 
          <td><img src="../enter/images/title_weatherinfo.gif" width="290" height="21"></td>
          <td rowspan="3" width="49"></td>
          <td><img src="../enter/images/title_forecastinfo.gif" width="304" height="21"></td>
        </tr>
        <tr> 
          <td>
		  <!--������ ����/������ ����/���� ���� ��ü���̺� ����--> 
            <table width="290" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="29">
				<!--������ ����/������ ����/���� ���� �� ����--> 
                  <table width="290" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td colspan="3"><img src="../enter/images/null.gif" width="1" height="6"></td>
                    </tr>
                    <tr> 
                      <td><a href="main_today.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image143','','../enter/images/map_today_on.gif',1)"><img name="Image143" border="0" src="../enter/images/map_today.gif" width="96" height="23"></a></td>
                      <td><img src="../enter/images/map_tomorrow_on.gif" width="98" height="23"></td>
                      <td><a href="main_afterto.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image128','','../enter/images/map_after_tomorrow_on.gif',1)"><img name="Image128" border="0" src="../enter/images/map_after_tomorrow.gif" width="96" height="23"></a></td>
                    </tr>
                  </table>
				  <!--������ ����/������ ����/���� ���� �� ��-->
                </td>
              </tr>
              <tr> 
                <td><img src="../enter/images/tomorrow_map.gif" width="290" height="322"></td>
              </tr>
            </table>
			<!--������ ����/������ ����/���� ���� ��ü���̺� ��-->
          </td>
          <td>
		  <!--�����尴/��ǥ���尴 ��ü ���̺� ����-->
            <table width="304" border="0" cellspacing="0" cellpadding="0" height="351">
              <tr>
                <td bgcolor="#E6E6E6"><img src="../enter/images/null.gif" width="1" height="5"></td>
              </tr>
              <tr>
                <td><img src="../enter/images/null.gif" width="1" height="30"></td>
              </tr>
			  <tr>
                <td valign="top">
				<!-- �����尴/��ǥ���尴 ���̺� ����--> 
                  <table width="304" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td>
					  <!--�����尴 Ÿ��Ʋ�� ����-->
                        <table width="304" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td width="22" class="table03"><img src="../enter/images/human_icon1.gif" width="14" height="14"></td>
                            <td width="282" class="title_01_b">�����尴</td>
                          </tr>
                        </table>
						<!--�����尴 Ÿ��Ʋ�� ��-->
                      </td>
                    </tr>
                    <tr>
                      <td><img src="../enter/images/null.gif" width="1" height="5"></td>
                    </tr>
                    <tr>
                      <td>
					  <!--�����尴 ���� ���̺� ����--> 
                        <table width="304" border="0" cellspacing="1" cellpadding="7">
                          <tr class="list02_bg"> 
                            <td width="84">����</td>
                            <td width="50">����</td>
                            <td width="50">��ü</td>
                            <td width="50">��</td>
                            <td width="60">�����</td>
                          </tr>
                          <tr> 
                            <td class="list03_bg">������</td>
                            <td class="list14_bg"><% =FnNumberFormat(rse("indivtotal")) %></td>
                            <td class="list14_bg"><% =FnNumberFormat(rse("grouptotal")) %></td>
                            <td class="list14_bg"><% =FnNumberFormat(rse("total")) %></td>
                            <td rowspan="2" class="list15_bg3"><% =FnPercentFormat(rse("total"),rslaste("total")) %></td>
                          </tr>
                          <tr> 
                            <td class="list03_bg2">�������</td>
                            <td class="list14_bg2"><% =FnNumberFormat(rslaste("indivtotal")) %></td>
                            <td class="list14_bg2"><% =FnNumberFormat(rslaste("grouptotal")) %></td>
                            <td class="list14_bg2"><% =FnNumberFormat(rslaste("total")) %></td>
                          </tr>
                          <tr bgcolor="#B0DFFD"> 
                            <td height="8" colspan="5"></td>
                          </tr>
                        </table>
						<!--�����尴 ���� ���̺� ��-->
                      </td>
                    </tr>
                    <tr>
                      <td><img src="../enter/images/null.gif" width="1" height="30"></td>
                    </tr>
                    <tr>
                      <td>
					  <!--��ǥ���尴 Ÿ��Ʋ�� ����-->
                        <table width="304" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="22" class="table03"><img src="../enter/images/human_icon2.gif" width="14" height="14"></td>
                            <td width="282" class="title_01_b">��ǥ���尴</td>
                          </tr>
                        </table>
						<!--��ǥ���尴 Ÿ��Ʋ�� ��-->	
                      </td>
                    </tr>
                    <tr>
                      <td><img src="../enter/images/null.gif" width="1" height="5"></td>
                    </tr>
                    <tr>
                      <td>
					  <!--��ǥ���尴 ���� ���̺� ����--> 
                        <table width="304" border="0" cellspacing="1" cellpadding="7">
                          <tr class="list02_bg"> 
                            <td width="84">����</td>
                            <td width="50">����</td>
                            <td width="50">��ü</td>
                            <td width="50">��</td>
                            <td width="60">�����</td>
                          </tr>
                          <tr> 
                            <td class="list03_bg">������</td>
                            <td class="list14_bg"><% =FnNumberFormat(rs("indivtotal")) %></td>
                            <td class="list14_bg"><% =FnNumberFormat(rs("grouptotal")) %></td>
                            <td class="list14_bg"><% =FnNumberFormat(rs("total")) %></td>
                            <td rowspan="2" class="list15_bg3"><% =FnPercentFormat(rs("total"),rslast("total")) %></td>
                          </tr>
                          <tr> 
                            <td class="list03_bg2">�������</td>
                            <td class="list14_bg2"><% =FnNumberFormat(rslast("indivtotal")) %></td>
                            <td class="list14_bg2"><% =FnNumberFormat(rslast("grouptotal")) %></td>
                            <td class="list14_bg2"><% =FnNumberFormat(rslast("total")) %></td>
                          </tr>
                          <tr bgcolor="#B0DFFD"> 
                            <td height="8" colspan="5"></td>
                          </tr>
                        </table>
						<!--��ǥ���尴 ���� ���̺� ��-->
                      </td>
                    </tr>
                  </table>
				  <!-- �����尴/��ǥ���尴 ���̺� ��-->
                </td>
              </tr>
              <tr>
                <td height="23" class="table02">
				<!--�ϴ� ��ư�� ���̺� ����-->
                  <table width="304" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td align="right"><a href="../enter/main/enter_main.asp"><img src="../enter/images/more.gif" width="44" height="15" border="0"></a></td>
                      <td width="4"></td>
                    </tr>
                  </table>
				  <!--�ϴ� ��ư�� ���̺� ��-->
                </td>
              </tr>
            </table>
			<!--�����尴/��ǥ���尴 ��ü ���̺� ��-->
          </td>
        </tr>
        <tr> 
          <td height="40"></td>
          <td height="40"></td>
        </tr>
        <tr> 
          <td colspan="3"><img src="../enter/images/title_event.gif" width="290" height="21"></td>
        </tr>
        <tr> 
          <td colspan="3"><img src="../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td colspan="3"><img src="../enter/images/null.gif" width="1" height="16"></td>
        </tr>
        <tr> 
          <td colspan="3">
		  <!--�̺�Ʈ ��ü ���̺� ����--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="4"></td>
                <td>
				<!--�Ե����� �̺�Ʈ ���̺� ����--> 
                  <table width="193" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td colspan="3"><img src="../enter/images/lotteworld1.gif" width="193" height="53"></td>
                    </tr>
                    <tr> 
                      <td height="18" colspan="3"></td>
                    </tr>
                    <% do until rslotte.EOF %>
                    <tr> 
                      <td width="19" height="19" class="table03"><img src="../enter/images/vermilion_buret.gif" width="7" height="7"></td>
                      <td width="128" class="list05"><a href="../enter/event/event_lotte_view.asp?intIdx=<% =rslotte("IDX") %>"><% =left(rslotte("TITLE"),10) %>......</a></td>
                      <td align="right" width="46">
						<% if FnDateInter(rslotte("startdate"),rslotte("enddate"))=1 then %>    
						<img src="../enter/images/today_minibutton.gif" width="42" height="9"> 
						<% elseif FnDateInter(rslotte("startdate"),rslotte("enddate"))=2 then %>
						<img src="../enter/images/month_minibutton.gif" width="42" height="9">    
						<% end if %>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="3"><img src="../enter/images/point_line.gif" width="193" height="1"></td>
                    </tr>
                    <tr> 
                      <td colspan="3" height="10"></td>
                    </tr>
                    <% rslotte.MOVENEXT
                    loop %>
                    <tr class="table05"> 
                      <td colspan="3" height="7"><a href="../enter/event/event_lotte_list.asp"><img src="../enter/images/more.gif" width="44" height="15" border="0"></a></td>
                    </tr>
                  </table>
				  <!--�Ե����� �̺�Ʈ ���̺� ��-->
                </td>
                <td width="27"></td>
                <td>
				<!--�������� �̺�Ʈ ���̺� ����--> 
                  <table width="193" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td colspan="3"><img src="../enter/images/everland1.gif" width="193" height="53"></td>
                    </tr>
                    <tr> 
                      <td height="18" colspan="3"></td>
                    </tr>
                    <% do until rsever.EOF %>
                    <tr> 
                      <td width="19" height="19" class="table03"><img src="../enter/images/yellowgreen_buret.gif" width="7" height="7"></td>
                      <td width="128" class="list05"><a href="../enter/event/event_ever_view.asp?intIdx=<% =rsever("IDX") %>"><% =left(rsever("TITLE"),13) %>......</a></td>
                      <td align="right" width="46">
						<% if FnDateInter(rsever("startdate"),rsever("enddate"))=1 then %>    
						<img src="../enter/images/today_minibutton.gif" width="42" height="9"> 
						<% elseif FnDateInter(rsever("startdate"),rsever("enddate"))=2 then %>
						<img src="../enter/images/month_minibutton.gif" width="42" height="9">    
						<% end if %>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="3"><img src="../enter/images/point_line.gif" width="193" height="1"></td>
                    </tr>
                    <tr> 
                      <td colspan="3" height="10"></td>
                    </tr>
                    <% rsever.MOVENEXT 
                    loop %>
                    <tr class="table05"> 
                      <td colspan="3" height="7"><a href="../enter/event/event_ever_list.asp"><img src="../enter/images/more.gif" width="44" height="15" border="0"></a></td>
                    </tr>
                  </table>
				  <!--�������� �̺�Ʈ ���̺� ��-->
                </td>
                <td width="27"></td>
                <td>
				<!--���﷣�� �̺�Ʈ ���̺� ����--> 
                  <table width="193" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td colspan="3"><img src="../enter/images/seoulland1.gif" width="193" height="53"></td>
                    </tr>
                    <tr> 
                      <td height="18" colspan="3"></td>
                    </tr>
                    <% do until rsseoul.EOF %>
                    <tr> 
                      <td width="19" height="19" class="table03"><img src="../enter/images/green_buret.gif" width="7" height="7"></td>
                      <td width="128" class="list05"><a href="../enter/event/event_seoul_view.asp?intIdx=<% =rsseoul("IDX") %>"><% =left(rsseoul("TITLE"),10) %>......</a></td>
                      <td align="right" width="46">
						<% if FnDateInter(rsseoul("startdate"),rsseoul("enddate"))=1 then %>    
						<img src="../enter/images/today_minibutton.gif" width="42" height="9"> 
						<% elseif FnDateInter(rsseoul("startdate"),rsseoul("enddate"))=2 then %>
						<img src="../enter/images/month_minibutton.gif" width="42" height="9">    
						<% end if %>
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="3"><img src="../enter/images/point_line.gif" width="193" height="1"></td>
                    </tr>
                    <tr> 
                      <td colspan="3" height="10"></td>
                    </tr>
                    <% rsseoul.MOVENEXT 
                    loop  %>                    
                    <tr class="table05"> 
                      <td colspan="3" height="7"><a href="../enter/event/event_seoul_list.asp"><img src="../enter/images/more.gif" width="44" height="15" border="0"></a></td>
                    </tr>
                  </table>
				  <!--���﷣�� �̺�Ʈ ���̺� ��-->
                </td>
                <td width="5"></td>
              </tr>
            </table>
			<!--�̺�Ʈ ��ü ���̺� ��-->
          </td>
        </tr>
        <tr> 
          <td colspan="3" height="30"></td>
        </tr>
      </table>
	  <!--ū ���̺� ��-->
    </td>
    <td width="49"><img src="../enter/images/null.gif" width="49" height="1"></td>
    <td bgcolor="#a4a4a4"><img src="../enter/images/outline.gif" width="1" height="1"></td>
  </tr>
  <tr> 
    <td height="42" colspan="3" background="../enter/images/copyright_bg.gif" align="right"><img src="../enter/images/copyright.gif" width="350" height="42"></td>
    <td bgcolor="#a4a4a4" width="1" height="42"><img src="../enter/images/null.gif"></td>
  </tr>
</table>
</body>
</html>
<!-- #include file="../enter/script/FnErrorCatch.inc"-->