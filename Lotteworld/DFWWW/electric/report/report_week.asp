<!-- #include file="../../electric/script/FnLoginAuth.inc" -->
<%
' ========================================================================================================
' ���α׷�ID : TXEELECREPORTWEEK
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���� ���� - �ְ�����
' �����ۼ��� : 2002/11/29
' �����ۼ��� : 2002/11/29
' ��  ��  �� : �ڼ���(kweather)
' ���    DB : TXEELECREPORTWEEK
' ========================================================================================================
%>
<html>
<head>
<title>�Ե����� ���俹���ý���</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../../electric/css/cs_te.css" type="text/css">
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form method=post name=form action=report_week.asp>
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
  <tr> 
    <td width="49"><img src="../../electric/images/null.gif" width="49" height="1"></td>
    <td width="642" valign="top"> 
	<!--ū ���̺� ����-->
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="../../electric/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
          <td><img src="../../electric/images/title_report_week.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../electric/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td height="7"></td>
        </tr>
        <tr> 
          <td height="7" bgcolor="#CECFF5"></td>
        </tr>
        <tr> 
          <td height="15"></td>
        </tr>
        <tr> 
          <td><iframe src="../../electric/excel/�ְ�������<%=Year(date()) %>��.xls" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" scrolling="yes" style="position:relative;top:0;left:0" width=642 height=460 frameborder=0></iframe></td>
        </tr>
        <tr> 
          <td height="15"></td>
        </tr>
        <tr> 
          <td height="7" bgcolor="#CECFF5"></td>
        </tr>
        <tr> 
          <td height="5"></td>
        </tr>
        <tr> 
          <td height="34" class="table02"> 
		  <!--�ϴ� ��ư�� ����-->
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td align="right"><a href="../../electric/excel/�ְ�������<%=Year(date()) %>��.xls"><img src="../../electric/images/download_button.gif" width="88" height="26" border="0"></a></td>
                <td width="5"></td>
              </tr>
            </table>
			<!--�ϴ� ��ư�� ��-->
          </td>
        </tr>
        <tr> 
          <td height="30"></td>
        </tr>
      </table>
	  <!--ū ���̺� ��-->
    </td>
    <td width="49"><img src="../../electric/images/null.gif" width="1" height="1"></td>
    <td bgcolor="#a4a4a4"><img src="/images/outline.gif" width="1" height="1"></td>
  </tr>
  <tr> 
    <td height="42" colspan="3" align="right" background="../../electric/images/copyright_bg.gif"><img src="../../electric/images/copyright.gif" width="350" height="42"></td>
    <td bgcolor="#a4a4a4" width="1" height="42"><img src="../../electric/images/null.gif" width="1" height="1"></td>
  </tr>
</table>
</body>
</html>
