<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' ���α׷�ID : LEFT_MENU - ���
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���尴 ���� ���� �޴� - ���
' �����ۼ��� : 2002/10/16
' �����ۼ��� : 2002/10/18
' ��  ��  �� : �ڼ���(kweather)
' ���    DB : ����
' ========================================================================================================
%>
<!-- #include file="../../enter/script/FnLeftMenu.inc" -->
<html>
<head>
<title>left menu_event</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<script language="JavaScript" src=../../enter/script/FnRolloverReload.js></script>
<link rel="stylesheet" href="../../enter/css/cs_tx.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" text="#000000" background="../../enter/images/left_bg.gif" onLoad="MM_preloadImages('../../enter/images/day_on.gif','../../enter/images/month_on.gif','../../enter/images/year_on.gif')">
<table width="129" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td><a href="../../enter/event/event_lotte_list.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','../../enter/images/event_lotte_onbu.gif',1)" target="mainFrame"><img name="Image2" border="0" src="../../enter/images/event_lotte_bu.gif" width="129" height="27"></a></td>
  </tr>
  <tr> 
    <td><a href="../../enter/event/event_ever_list.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','../../enter/images/event_ever_onbu.gif',1)" target="mainFrame"><img name="Image3" border="0" src="../../enter/images/event_ever_bu.gif" width="129" height="27"></a></td>
  </tr>
  <tr> 
    <td><a href="../../enter/event/event_seoul_list.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','../../enter/images/event_seoul_onbu.gif',1)" target="mainFrame"><img name="Image4" border="0" src="../../enter/images/event_seoul_bu.gif" width="129" height="27"></a></td>
  </tr>
  <tr>
    <td height="70"></td>
  </tr>
  <tr> 
    <td><img src="../../enter/images/logo_lotte.gif" width="129" height="41"></td>
  </tr>
  <tr> 
    <td><img src="../../enter/images/logo_kweather.gif" width="129" height="43"></td>
  </tr>
  <tr> 
    <td><img src="../../enter/images/logo_ldcc.gif" width="129" height="39"></td>
  </tr>
  <tr> 
    <td> 
      <!--���ó�¥/�����湮�� ���̺� ����-->
      <table width="129" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="129" height="48" background="../../enter/images/now1_bg.gif" class="table03"> 
            <!--���ó�¥ ���̺� ����-->
            <table width="102" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="7" class="table03"><img src="../../enter/images/orange_buret.gif" width="7" height="7"></td>
                <td width="5"></td>
                <td class="title_02">������</td>
              </tr>
              <tr> 
                <td width="7"></td>
                <td width="5"></td>
                <td class="list09"> 
                  <% =FnDateFormat(date()) %>
                </td>
              </tr>
            </table>
            <!--���ó�¥ ���̺� ��-->
          </td>
        </tr>
        <tr> 
          <td width="129" height="48" background="../../enter/images/now2_bg.gif" class="table03"> 
            <!--�����湮�� ���̺� ����-->
            <table width="102" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="7" class="table03"><img src="../../enter/images/orange_buret.gif" width="7" height="7"></td>
                <td width="5"></td>
                <td class="title_02">�����湮��</td>
              </tr>
              <tr> 
                <td width="7"></td>
                <td width="5"></td>
                <td class="list09"> 
                  <% =FnDateFormat(varlastconnecttime) %>
                </td>
              </tr>
            </table>
            <!--�����湮�� ���̺� ��-->
          </td>
        </tr>
      </table>
      <!--���ó�¥/�����湮�� ���̺� ��-->
    </td>
  </tr>
  <tr> 
    <td height="10"></td>
  </tr>
  <tr> 
    <td height="20"><a href=../../electric/index.asp target=_blank><img name="Image62" border="0" src="../../enter/images/energy_button.gif" width="129" height="26"></a></td>
  </tr>
</table>
</body>
</html>
<!-- #include file="../../enter/script/FnErrorCatch.inc" -->