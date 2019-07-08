<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' 프로그램ID : TXBBULLETIN - seoul view
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 입장객 예측 행사 - 서울랜드 기사 보기
' 최초작성일 : 2002/10/16
' 최종작성일 : 2002/11/13
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim rs '레코드셋 : 글 내용
Dim intIdx '글번호

intIdx=Request.QueryString("intIdx")

ArrQuery = array("MQ",intIdx,"서울랜드") ' 보기 쿼리

'변수의 설정
Set objServer = Server.CreateObject("XBbulletinUIQMTS.clsXBbulletinUIQNTX")


'컴포넌트 호출 로직의 전개
' ...

'컴포넌트 호출
arrRValue = objServer.Query(ArrQuery)
'레코드셋 어레이를 단일 레코드셋으로 분리

'첫번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rs,1

'자원의 해제
Set objServer = Nothing

'에러의 처리
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
<title>롯데월드 수요예측시스템</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../../enter/css/cs_tx.css" type="text/css">
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
  <tr> 
    <td width="49"><img src="../../enter/images/null.gif" width="49" height="1"></td>
    <td width="642" valign="top">
	<!--큰 테이블 시작--> 
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
		  <!--게시판 타이틀 시작--> 
            <table width="600" border="0" cellspacing="0" cellpadding="0" height="19">
              <tr> 
                <td width="50" class="list12_1"><% =rs("IDX") %></td>
                <td class="list13" width="417"  title='<%=rs("TiTle") %>'><% =left(rs("title"),35) %>...</td>
                <td width="50" class="list03_1">행사기간</td>
                <td width="125" class="list07">[<% =FnDateFormat(rs("startdate")) %>~<% =FnDateFormat(rs("enddate")) %>] 
              </tr>
            </table>
			<!--게시판 타이틀 끝-->
          </td>
        </tr>
        <tr>
          <td height="30"></td>
        </tr>
        <tr> 
          <td height="300" class="table08">
		  <!--게시판 본문 시작--> 
            <table width="600" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="list08"><% =FnContentType(rs("contents")) %>
                </td>
              </tr>
            </table>
			<!--게시판 본문 끝-->
          </td>
        </tr>
		 <tr> 
          <td height="30"></td>
        </tr>
        <tr> 
          <td height="34" class="table04">
		  <!--페이지 번호 시작--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
			    <td width="551" align="right"><a href="event_main.asp"><img src="../../enter/images/eventmain_button.gif" width="76" height="26" border="0"></a></td>
			    <td width="10"></td>
                <td width="76"><a href="event_seoul_list.asp"><img src="../../enter/images/listview_button.gif" width="76" height="26" border="0"></a></td>
                <td width="5"></td>
              </tr>
            </table>
			<!--페이지 번호 끝-->
          </td>
        </tr>
        <tr> 
          <td height="30"></td>
        </tr>
      </table>
	  <!--큰 테이블 시작-->
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