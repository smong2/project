<%
' ========================================================================================================
' ���α׷�ID : TXBADMINCon
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���⺸�� ��� - ���� ���ε�
' �����ۼ��� : 2003/01/15
' �����ۼ��� : 2003/01/15
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================


	pid = request("pid")
%>
<HTML>
<HEAD>
<TITLE>Uploading Files...</TITLE>
<STYLE type="text/css">
td {font-size: 9pt}
</STYLE>
</HEAD>
<BODY bgcolor=#d4d0c8 topmargin=0 scroll=no>
<br>
<center>
<IFRAME src="admin_report_upload.asp?pid=<%= pid %>" title="Progress Step1" frameborder=0 marginheight=0 marginwidth=0 noresize scrolling=no width=360 height=65>
</IFRAME>
</center>
</body>
</html>
