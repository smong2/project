<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' ���α׷�ID : TXBBULLETIN - seoul view
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���尴 ���� ��� - ���﷣�� ��� ����
' �����ۼ��� : 2002/10/16
' �����ۼ��� : 2002/11/13
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

'������ ����
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
Dim rs '���ڵ�� : �� ����
Dim intIdx '�۹�ȣ

intIdx=Request.QueryString("intIdx")

ArrQuery = array("MQ",intIdx,"���﷣��") ' ���� ����

'������ ����
Set objServer = Server.CreateObject("XBbulletinUIQMTS.clsXBbulletinUIQNTX")


'������Ʈ ȣ�� ������ ����
' ...

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
<!-- #include file="../../enter/script/FnProgramProcess.vbs" -->
<!-- #include file="../../enter/script/fnevent_view.inc" -->
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
	<!--ū ���̺� ����--> 
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="24"><img src="../../enter/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
          <td align="left" height="21"><img src="../../enter/images/title_event_seoulland.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td height="40" class="table04">
		  <!--�Խ��� Ÿ��Ʋ ����--> 
            <table width="600" border="0" cellspacing="0" cellpadding="0" height="19">
              <tr> 
                <td width="50" class="list12_1"><% =rs("IDX") %></td>
                <td class="list13" width="417"  title='<%=rs("TiTle") %>'><% =left(rs("title"),35) %>...</td>
                <td width="50" class="list03_1">���Ⱓ</td>
                <td width="125" class="list07">[<% =FnDateFormat(rs("startdate")) %>~<% =FnDateFormat(rs("enddate")) %>] 
              </tr>
            </table>
			<!--�Խ��� Ÿ��Ʋ ��-->
          </td>
        </tr>
        <tr>
          <td height="30"></td>
        </tr>
        <tr> 
          <td height="300" class="table08">
		  <!--�Խ��� ���� ����--> 
            <table width="600" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="list08"><% =FnContentType(rs("contents")) %>
                </td>
              </tr>
            </table>
			<!--�Խ��� ���� ��-->
          </td>
        </tr>
		 <tr> 
          <td height="30"></td>
        </tr>
        <tr> 
          <td height="34" class="table04">
		  <!--������ ��ȣ ����--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
			    <td width="551" align="right"><a href="event_main.asp"><img src="../../enter/images/eventmain_button.gif" width="76" height="26" border="0"></a></td>
			    <td width="10"></td>
                <td width="76"><a href="event_seoul_list.asp"><img src="../../enter/images/listview_button.gif" width="76" height="26" border="0"></a></td>
                <td width="5"></td>
              </tr>
            </table>
			<!--������ ��ȣ ��-->
          </td>
        </tr>
        <tr> 
          <td height="30"></td>
        </tr>
      </table>
	  <!--ū ���̺� ����-->
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
<!-- #include file="../../enter/script/FnErrorCatch.inc"-->