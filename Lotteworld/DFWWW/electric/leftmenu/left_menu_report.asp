<!-- #include file="../../electric/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' ���α׷�ID : LEFT_MENU - ���⺸��
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���� ���� ���� �޴� - ����
' �����ۼ��� : 2002/11/27
' �����ۼ��� : 2002/11/27
' ��  ��  �� : �ڼ���(kweather)
' ���    DB : ����
' ========================================================================================================
%>
<!-- #include file="../../electric/script/FnLeftMenu.inc" -->
<html>
<head>
<title>���⺸�� ���ʸ޴�</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<script language="JavaScript" src=../../electric/script/FnRolloverReload.js></script>
<link rel="stylesheet" href="../../electric/css/cs_te.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" text="#000000" background="../../electric/images/left_bg.gif">
<table width="129" border="0" cellspacing="0" cellpadding="0">
  <!--<tr> 
    <td><a href="../../electric/report/report_week.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','../../electric/images/report_left_weekreport_on.gif',1)" target="mainFrame"><img name="Image7" border="0" src="../../electric/images/report_left_weekreport_off.gif" width="129" height="27"></a></td>
  </tr>
  <tr> 
    <td><a href="../../electric/report/report_varyweek.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../../electric/images/report_left_week_on.gif',1)" target="mainFrame"><img name="Image1" border="0" src="../../electric/images/report_left_week_off.gif" width="129" height="27"></a></td>
  </tr>
  <tr> 
    <td><a href="../../electric/report/report_varymonth.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','../../electric/images/report_left_month_on.gif',1)" target="mainFrame"><img name="Image2" border="0" src="../../electric/images/report_left_month_off.gif" width="129" height="27"></a></td>
  </tr>-->
  <tr>
    <td height="70"></td>
  </tr>
  <tr> 
    <td><img src="../../electric/images/logo_lotte.gif" width="129" height="41"></td>
  </tr>
  <tr> 
    <td><img src="../../electric/images/logo_kweather.gif" width="129" height="43"></td>
  </tr>
  <tr> 
    <td><img src="../../electric/images/logo_ldcc.gif" width="129" height="39"></td>
  </tr>
  <tr> 
    <td> 
      <!--���ó�¥/�����湮�� ���̺� ����-->
      <table width="129" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="129" height="48" background="../../electric/images/now1_bg.gif" class="table03"> 
            <!--���ó�¥ ���̺� ����-->
            <table width="102" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="7" class="table03"><img src="../../electric/images/orange_buret.gif" width="7" height="7"></td>
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
          <td width="129" height="48" background="../../electric/images/now2_bg.gif" class="table03"> 
            <!--�����湮�� ���̺� ����-->
            <table width="102" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="7" class="table03"><img src="../../electric/images/orange_buret.gif" width="7" height="7"></td>
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
    <td><a href=../../enter/index.asp target=_blank><img name="Image62" border="0" src="../../electric/images/visitor_button.gif" width="129" height="26"></a></td>
  </tr>
</table>
</body>
</html>
<!-- #include file="../../electric/script/FnErrorCatch.inc" -->