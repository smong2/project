<!-- #include file="../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' ���α׷�ID : top
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���尴 ���� - frame top �κ�
' �����ۼ��� : 2002/10/16
' �����ۼ��� : 2002/10/18
' ��  ��  �� : �ڼ���(kweather)
' ���    DB : ����
' ========================================================================================================

'������ ����
varlastconnecttime=replace(varlastconnecttime,"����","pm")
varlastconnecttime=replace(varlastconnecttime,"����","am")

%>
<HTML>
<HEAD>
<TITLE>top</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=euc-kr">
<script language="JavaScript" src="../enter/script/FnRolloverReload.js"></script>
<link rel="stylesheet" href="../enter/css/cs_tx.css" type="text/css">
</HEAD>
<BODY BGCOLOR=#F5F5F5 leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('../enter/images/visitor.gif','../enter/images/energy.gif','../enter/images/today_on.gif','../enter/images/visitorforecast_on.gif','../enter/images/event_on.gif','../enter/images/weatherinfo_on.gif','../enter/images/administrator_on.gif')">
<!--��ü ���̺� ����-->
<table width="872" border="0" cellspacing="0" cellpadding="0" height="94">
  <tr>
    <td>
	<!--ž�޴� ����--> 
      <table width="871" border="0" cellspacing="0" cellpadding="0" height="94">
        <tr>
          <td>
		  <!--ž�޴� ��� ����-->
            <table width="871" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td><a href="../enter/main_today.asp" target="mainFrame"><img src="../enter/images/logo.gif" width="450" height="62" border="0" onClick="top.leftFrame.location.href('../enter/leftmenu/left_menu_default.asp')"></a></td>
                <td width="204" height="62" background="../enter/images/top_bg.gif"></td>
                <td width="217" background="../enter/images/top_bg2.gif" height="62" class="table03">
				<!--ȯ���޼��� ����--> 
				  <table width="158" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                     <td width="10" valign="top" rowspan="2"><img src="../enter/images/visitor_connect2.png" width="13" height="13"></td>
                     <td width="5" rowspan="2"></td>
                      <td width="143" class="list05"><b><% =varNAME %>(<% =varAUTHLEVEL %>)</b> �� ȯ���մϴ�.</td>
                    </tr>
                   <tr>
                     <td width="143" class="list14">(<% =vartime  %>)</td>
                   </tr>
                </table>
				<!--ȯ���޼��� ��-->
               </td>
              </tr>
            </table>
			<!--ž�޴� ��� ��-->
          </td>
        </tr>
        <tr>
          <td>
		  <!--ž�޴� �ϴ� ����-->
            <table width="871" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><img src="../enter/images/img1.gif" width="129" height="32"></td>
                <td>
				<!--�޴��� ���� ����-->
                  <table width="742" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td><img src="../enter/images/innerline.gif" width="742" height="1"></td>
                    </tr>
                    <tr>
                      <td>
					  <!--�޴��� ����-->
                        <table width="742" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td><a href="../enter/leftmenu/left_menu_today.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','../enter/images/today_on.gif',1)" target='leftFrame'><img name="Image8" border="0" src="../enter/images/today_off.gif" width="105" height="30" onclick="top.mainFrame.location.replace('../../enter/forecasting/today_main.asp')"></a></td>
                            <td><a href="../enter/leftmenu/left_menu.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image9','','../enter/images/enterforecast_on.gif',1)" target="leftFrame"><img name="Image9" border="0" src="../enter/images/enterforecast_off.gif" width="105" height="30" onClick="top.mainFrame.location.replace('../../enter/forecasting/enter_main.asp')"></a></td>
                            <td><a href="../enter/leftmenu/left_menu_event.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','../enter/images/event_on.gif',1)" target="leftFrame"><img name="Image10" border="0" src="../enter/images/event_off.gif" width="105" height="30" onclick="top.mainFrame.location.replace('../../enter/event/event_main.asp')"></a></td>
                            <td><a href="../enter/leftmenu/left_menu_weather.asp" target='leftFrame' onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image11','','../enter/images/weatherinfo_on.gif',1)"><img name="Image11" border="0" src="../enter/images/weatherinfo_off.gif" width="105" height="30" onclick="top.mainFrame.location.replace('../../enter/weather/weather_main_today.asp')"></a></td>
                            <% IF varAUTHLEVEL=2 or varAUTHLEVEL=7 THEN %>
                            <td><a href="../enter/leftmenu/left_menu_admin.asp" target='leftFrame' onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image12','','../enter/images/administrator_on.gif',1)"><img name="Image12" border="0" src="../enter/images/administrator_off.gif" width="105" height="30" onclick="top.mainFrame.location.replace('../../enter/admin/admin_input_confirm.asp')"></a></td>
                            <% ELSE %>
                            <td><a href="../enter/leftmenu/left_menu_admin.asp" target='leftFrame' onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image12','','../enter/images/administrator_on.gif',1)"><img name="Image12" border="0" src="../enter/images/administrator_off.gif" width="105" height="30" onclick="top.mainFrame.location.replace('../../enter/admin/admin_acnt_list.asp')"></a></td>
                            <% END IF %>
                            <td><img src="../enter/images/small_menu.gif" width="217" height="30" usemap="#Map" border="0"></td>
                          </tr>
                        </table>
						<!--�޴��� ��-->
                      </td>
                    </tr>
                    <tr>
                      <td><img src="../enter/images/innerline.gif" width="742" height="1"></td>
                    </tr>
                  </table>
				  <!--�޴��� ���� ��-->
                </td>
              </tr>
            </table>
			<!--ž�޴� �ϴ� ��-->
          </td>
        </tr>
      </table>
	  <!--ž�޴� ��-->
    </td>
    <td><img src="../enter/images/outline.gif" width="1" height="94"></td>
  </tr>
</table>
<!--��ü ���̺� ��-->
<map name="Map"> 
  <area shape="rect" coords="141,11,199,19" title="����Ʈ������ �̵��մϴ�"  href="../enter/sitemap.htm" target="mainFrame" onclick="top.leftFrame.location.href('../enter/leftmenu/left_menu_default.asp')">
  <area shape="rect" coords="75,11,129,20" title="�α׾ƿ��մϴ�" href="logout.asp">
  <area shape="rect" coords="28,10,64,21" title="Ȩ���� �̵��մϴ�" href="../enter/main_today.asp" target="mainFrame" onclick="top.leftFrame.location.href('../enter/leftmenu/left_menu_default.asp')">
</map>
</BODY>
</HTML>
  <!-- #include file="../enter/script/FnErrorCatch.inc" -->