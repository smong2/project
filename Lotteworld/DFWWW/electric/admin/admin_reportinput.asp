<%
' ========================================================================================================
' 프로그램ID : TXBADMINCon
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 전기보고서 등록 페이지
' 최초작성일 : 2003/01/15
' 최종작성일 : 2003/01/15
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================
%>
<!-- #include file="../../electric/script/FnLoginAuth.inc" -->
<%
Dim Upstate, CID
    session.timeout = 60
    Set UpState = Server.CreateObject("UpState.UpStateClass.1")
    CID = UpState.CreateID()  ' 키를 생성한다.
    Set UpState = Nothing
%>

<html>
<head>
<title>롯데월드 수요예측시스템</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../../electric/css/cs_te.css" type="text/css">
<Script Language="JavaScript">
    <!--
       var pid  = "<%= CID %>";
       function ok()
       {
         if (pid != "")
         {
            window.showModelessDialog("admin_report_ProgressWindow.asp?Pid=" + pid, null, "help=no;dialogWidth=390px; dialogHeight:120px; center:yes");
            document.writeform.action="admin_report_up.asp?Pid=<%= CID %>";
            document.writeform.submit();
         }
         return false;
      }
    //-->
    </script>
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload=document.writeform.file1.focus()>
<form enctype="multipart/form-data" method="post" name=writeform id=writeform>
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
  <tr> 
    <td width="49"><img src="../../electric/images/null.gif" width="49" height="1"></td>
    <td width="642" valign="top">
	<!--큰 테이블 시작--> 
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="../../electric/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
          <td>
          <img src="../../electric/images/title_admin_report_dayinput.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top">
          <img src="../../electric/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td align="right" class="title_01">             
			<!--입력 선택 끝-->
          </td>
        </tr>
        <tr> 
          <td height="7"></td>
        </tr>
        <tr> 
          <td height="7" bgcolor="#CECFF5"></td>
        </tr>
        
        
        <tr> 
          <td height="50" class=title_01><img src="../../electric/images/yellowgreen_buret.gif" width="7" height="7"> 업로드 
            파일 선택 :&nbsp;&nbsp; <input type="file" name="file1" size="30" class="text1">
            <input type="hidden" name="pid" value="<%= CID %>"></td>
        </tr>
        <tr> 
          <td height="7" bgcolor="#CECFF5"></td>
        </tr>
        <tr> 
          <td height="5"></td>
        </tr>
        <tr> 
          <td height="34" class="table02">
		  <!--하단 버튼바 시작--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td align="right"><img src="../../electric/images/save.gif" width="53" height="26" border="0" OnClick="JavaScript: ok(); return false;"></td>
                <td width="5"></td>
              </tr>
            </table>
			<!--하단 버튼바 끝-->
          </td>
        </tr>
        <tr> 
          <td height="30"></td>
        </tr>
      </table>
	  <!--큰 테이블 끝-->
    </td>
    <td width="49"><img src="null.gif" width="1" height="1"></td>
    <td bgcolor="#a4a4a4"><img src="../../electric/images/outline.gif" width="1" height="1"></td>
  </tr>
  <tr> 
    <td height="42" colspan="3" align="right" background="../../electric/images/copyright_bg.gif">
    <img src="../../electric/images/copyright.gif" width="350" height="42"></td>
    <td bgcolor="#a4a4a4" width="1" height="42">
    <img src="../../electric/images/null.gif" width="1" height="1"></td>
  </tr>
</table>
</form>
</body>
</html>