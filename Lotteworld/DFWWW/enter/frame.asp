<!-- #include file="../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' 프로그램ID : MAIN FRAME
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 입장객 예측 FRAME
' 최초작성일 : 2002/10/16
' 최종작성일 : 2002/10/18
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================
%>
<html>
<head>
<title>롯데월드 수요예측(입장객)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
</head>

<frameset rows="94,*" cols="*" frameborder="NO" border="0" framespacing="0"> 
  <frame name="topFrame" scrolling="NO" noresize src="top.asp" >
  <frameset cols="129,*" frameborder="NO" border="0" framespacing="0" rows="*"> 
    <frame name="leftFrame" noresize scrolling="NO" src="../enter/leftmenu/left_menu_default.asp">
    <frame name="mainFrame" src="main_today.asp">
  </frameset>
</frameset>
<noframes><body bgcolor="#FFFFFF" text="#000000">

</body></noframes>
</html>
<!-- #include file="../enter/script/FnErrorCatch.inc"-->
