<!-- #include file="../electric/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' ���α׷�ID : MAIN FRAME
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���� ���� FRAME
' �����ۼ��� : 2002/10/16
' �����ۼ��� : 2002/10/18
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================
%>
<html>
<head>
<title>�Ե����� ���俹�� �ý���(���⿹��)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
</head>

<frameset rows="94,*" cols="*" frameborder="NO" border="0" framespacing="0"> 
  <frame name="topFrame" scrolling="NO" noresize src="top.asp" >
  <frameset cols="129,*" frameborder="NO" border="0" framespacing="0" rows="*"> 
    <frame name="leftFrame" noresize scrolling="NO" src="../electric/leftmenu/left_menu_default.asp">
    <frame name="mainFrame" src="main_today.asp">
  </frameset>
</frameset>
<noframes><body bgcolor="#FFFFFF" text="#000000">

</body></noframes>
</html>
<!-- #include file="../electric/script/FnErrorCatch.inc" -->