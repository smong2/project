<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' 프로그램ID : TXBBULLETIN - ever list
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 입장객 예측 행사 - 에버랜드 행사 리스트 보기
' 최초작성일 : 2002/10/16
' 최종작성일 : 2002/11/21
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim rs '글 목록
Dim intI :intI=1 '증감변수 기본값 1

ArrQuery = array("에버랜드")

'변수의 설정
Set objServer = Server.CreateObject("XBEventListMTS.clsXBEventListNTX")

intPAGE=Request.QueryString("intPAGE")

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
<!-- #include file="../../enter/script/fnevent_list.inc" -->
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
          <td align="left" height="21"><img src="../../enter/images/title_event_everland.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="20" valign="top"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td valign="top" height="70"><img src="../../enter/images/everland3.gif" width="642" height="53"></td>
        </tr>
        <tr> 
          <td>
		  <!--게시판 목록 시작--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
            	<% DO WHILE NOT rs.EOF AND intTotalPage>0 %>
              <tr> 
              <td width="50" height="19" class="list11_1"><% =rs("IDX") %></td>
              <td class="list05" width="417"><a href="../../enter/event/event_ever_view.asp?intIdx=<% =rs("IDX") %>" title='<% =rs("title") %>'><% =rs("title") %></a></td>
              <td width="50" align="center">
				<% IF FnDateInter(rs("startdate"),rs("enddate"))=1 THEN %>    				
				<img src="../../enter/images/today_minibutton.gif" width="42" height="9">
				<% ELSEIF FnDateInter(rs("startdate"),rs("enddate"))=2 THEN %>
				<img src="../../enter/images/month_minibutton.gif" width="42" height="9">
				<% END IF %>              
              </td>
              <td width="125" class="list07">[<% =FnDateFormat(rs("startdate")) %>~<% =FnDateFormat(rs("enddate")) %>] 
            </tr>
            <tr> 
              <td colspan="4"><img src="../../enter/images/point_line7.gif" width="642" height="1"></td>
            </tr>
            <tr> 
              <td colspan="4" height="10"></td>
            </tr>
            <% intTotalPage=intTotalPage-1 : rs.MOVENEXT : LOOP %>          
       </table>
	   <!--게시판 목록 끝-->
        </td>
        </tr>
        <tr>
          <td height="34" class="table04">
		  <!--페이지 번호 시작--> 
            <table width="268" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="64" class="list13_1"> 
                  <% 
					IF intCurPage >1 THEN '이전 페이지 결정
						Response.Write "<a href='event_ever_list.asp?intPAGE=" & intCurPage-1 & "'>◀ 이전</a>"
					ELSE
						Response.Write "<font color=#f5f5f5>◀ 이전</font>"
					END IF 
				%>
                </td>
                <td width="140" class="list14_1"> 
                  <div align="center">
                <%	FOR intI=intStartPage to intStartPage-1+intLimit '페이지 번호 링크
							Response.Write "<a href='event_ever_list.asp?intPAGE=" & intI & "'>" & intI & "</a>"
						IF intI>=intLastPage THEN
							exit for
						END IF
					NEXT 
				%>
                  </div>
                </td>
                <td width="64" class="list13_2"> 
                  <% 
					IF intCurPage - intLastPage <0 THEN '다음 페이지 결정
						Response.Write "<a href='event_ever_list.asp?intPAGE=" & intCurPage+1 & "'>다음 ▶</a>"
					ELSE
						Response.Write "<font color=#f5f5f5>끝끝 ▶</font></a>"
					END IF 
				%>
                </td>
              </tr>
            </table>
			<!--페이지 번호 끝-->
          </td>
        </tr>
        <tr> 
          <td height="30"></td>
        </tr>
      </table>
	  <!--큰 테이블 끝-->
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