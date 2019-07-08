<%
' ========================================================================================================
' 프로그램ID : TXBADMINCon
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 전기보고서 등록 - 파일 업로드
' 최초작성일 : 2003/01/15
' 최종작성일 : 2003/01/15
' 개  발  자 : 박순몽(kweather)
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
