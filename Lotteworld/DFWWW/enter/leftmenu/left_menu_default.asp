<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' ���α׷�ID : LEFT_MENU - �⺻
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���尴 ���� ���� �޴� - �⺻
' �����ۼ��� : 2002/10/16
' �����ۼ��� : 2002/10/18
' ��  ��  �� : �ڼ���(kweather)
' ���    DB : ����
' ========================================================================================================
%>
<!-- #include file="../../enter/script/FnLeftMenu.inc" -->
<html>
<head>
<title>left menu_default</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../../enter/css/Cs_Tx.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" text="#000000" background="../../enter/images/left_bg.gif">
<H3 style="line-height:100%; margin-top:300; margin-bottom:0;"><img name="Image63" border="0" src="../../enter/images/logo_lotte.gif" width="129" height="41"></H3>
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <img name="Image64" border="0" src="../../enter/images/logo_kweather.gif" width="129" height="43"></H3>
<H3 style="line-height:100%; margin-top:0; margin-bottom:0;"> <img name="Image65" border="0" src="../../enter/images/logo_ldcc.gif" width="129" height="39"></H3>
<table width="129" border="0" cellspacing="0" cellpadding="0">
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
          <td class="list09"><% =FnDateFormat(date()) %></td>
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
          <td class="list09"><% =FnDateFormat(varlastconnecttime) %></td>
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
    <td><a href=../../electric/index.asp target=_blank><img name="Image62" border="0" src="../../enter/images/energy_button.gif" width="129" height="26"></a></td>
  </tr>
</table>
</body>
</html>
<!-- #include file="../../enter/script/FnErrorCatch.inc" -->