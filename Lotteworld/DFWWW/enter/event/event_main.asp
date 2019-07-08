<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<%
' ========================================================================================================
' 프로그램ID : TXBBULLETIN - main
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 입장객 예측 행사 - 메인
' 최초작성일 : 2002/10/16
' 최종작성일 : 2002/11/13
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim rslotte,rsever, rsseoul '레코드셋 : 롯데월드, 에버랜드. 서울랜드 게시판 목록

ArrQuery = array()

'변수의 설정
Set objServer = Server.CreateObject("XBEventMainMTS.clsXBEventMainNTX")

'컴포넌트 호출 로직의 전개
' ...

'컴포넌트 호출
arrRValue = objServer.Query(ArrQuery)
'레코드셋 어레이를 단일 레코드셋으로 분리

'첫번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rslotte,1
'두번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rsever,2
'세번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rsseoul,3

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
          <td align="left" height="21"><img src="../../enter/images/title_event.gif" width="290" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td height="358" width="642">
		  <!--롯데월드 이벤트 시작-->
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="142"><img src="../../enter/images/event_lotte_img01.gif" width="642" height="142"></td>
              </tr>
              <tr>
                <td height="216">
				<!--롯데월드 이벤트 리스트 시작-->
                  <table width="642" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="33"><img src="../../enter/images/event_lotte_img02.gif" width="33" height="264"></td>
                      <td height=264>
					  <!--리스트 여백 시작-->
                        <table width="576" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td width="11"><img src="../../enter/images/event_round_edge1.gif" width="11" height="11"></td>
                            <td width="565" background="../../enter/images/event_round_top.gif"></td>
                            <td width="11"><img src="../../enter/images/event_round_edge2.gif" width="11" height="11"></td>
                          </tr>
                          <tr>
                            <td width="11" background="../../enter/images/event_round_left.gif"></td>
                            <td width="565" height="242" class="table03">
							<!-- 리스트 시작-->
                              <table width="523" border="0" cellspacing="0" cellpadding="0">
							  <tr>
							  <td colspan="4" height="20"></td>
							  </tr>
							  <% DO UNTIL rslotte.EOF %>
							  <tr>
							  <td width="20" height="19" class="table03"><img src="../../enter/images/vermilion_buret.gif" width="7" height="7"></td>
							  <td width="316" class="list05"><a href="event_lotte_view.asp?intIdx=<% =rslotte("Idx") %>" title='<% =rslotte("title") %>'><% =left(rslotte("title"),30) %>......</a></td>
							  <td width="62" align="center">        
							  <% IF FnDateInter(rslotte("startdate"),rslotte("enddate"))=1 THEN %>    
							  <img src="../../enter/images/today_minibutton.gif" width="42" height="9"> 
							  <% ELSEIF FnDateInter(rslotte("startdate"),rslotte("enddate"))=2 THEN %>
							  <img src="../../enter/images/month_minibutton.gif" width="42" height="9">   
							  <% END IF %>
							  <td width="125" class="list07">[<% =FnDateFormat(rslotte("startdate")) %>~<% =FnDateFormat(rslotte("enddate")) %>] 
							  </tr>    
							  <tr> 
							  <td colspan="4"><img src="../../enter/images/point_line5.gif" width="523" height="1"></td>
							  </tr>  
							  <tr> 
							  <td colspan="4" height="9"></td>
							  </tr>
							  <% rslotte.MOVENEXT : LOOP %>  
							  <tr> 
							  <td colspan="4" height="19" class="table05"><a href="event_lotte_list.asp"><img src="../../enter/images/more.gif" width="44" height="15" border="0"></a></td>
							  </tr>
							  </table>
							  <!--리스트 끝-->
							  </td>
                            <td width="11" background="../../enter/images/event_round_right.gif"></td>
                          </tr>
                          <tr>
                            <td width="11"><img src="../../enter/images/event_round_edge3.gif" width="11" height="11"></td>
                            <td width="565" background="../../enter/images/event_round_bottom.gif"></td>
                            <td width="11"><img src="../../enter/images/event_round_edge4.gif" width="11" height="11"></td>
                          </tr>
                        </table>
						<!--리스트 여백 끝-->
                      </td>
                      <td width="33"><img src="../../enter/images/event_lotte_img02.gif" width="33" height="264"></td>
                    </tr>
                    <tr>
                      <td width="33" height="17"><img src="../../enter/images/event_lotte_img03.gif" width="33" height="17"></td>
                      <td width="576" bgcolor="#AFF290" height="17"></td>
                      <td width="33" height="17"><img src="../../enter/images/event_lotte_img04.gif" width="33" height="17"></td>
                    </tr>
                  </table>
				  <!--롯데월드 이벤트 리스트 끝-->
                </td>
              </tr>
            </table>
			<!--롯데월드 이벤트 끝-->
          </td>
        </tr>
        <tr> 
          <td height="37"></td>
        </tr>
        <tr> 
          <td>
		  <!--에버랜드/서울랜드 이벤트 시작-->
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td>
				<!--에버랜드 이벤트 시작--> 
                  <table width="307" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td colspan="4"><img src="../../enter/images/everland2.gif" width="307" height="53"></td>
                    </tr>
                    <tr> 
                      <td height="18" colspan="4"></td>
                    </tr>
                    <% DO UNTIL rsever.EOF %>
                    <tr> 
                      <td width="19" height="19" class="table03"><img src="../../enter/images/yellowgreen_buret.gif" width="7" height="7"></td>
                      <td class="list05" width="138"><a href="event_ever_view.asp?intIdx=<%=rsever("Idx") %>" title='<% =rsever("title") %>'><% =left(rsever("title"),9) %>......</a></td>
                      <td width="50" align="center">
                    <% IF FnDateInter(rsever("startdate"),rsever("enddate"))=1 THEN %>    
					<img src="../../enter/images/today_minibutton.gif" width="42" height="9"> 
					<% ELSEIF FnDateInter(rsever("startdate"),rsever("enddate"))=2 THEN %>
					<img src="../../enter/images/month_minibutton.gif" width="42" height="9">    
					<% END IF %>                    
                      <td width="100" class="list01">[<% =FnDateFormat(rsever("startdate")) %>~<% =FnDateFormat(rsever("enddate")) %>]</td>
                    </tr>
                    <tr> 
                      <td colspan="4"><img src="../../enter/images/point_line6.gif" width="307" height="1"></td>
                    </tr>
                    <tr> 
                      <td colspan="4" height="10"></td>
                    </tr>
                    <% rsever.MOVENEXT :  LOOP  %>
                    <tr> 
                      <td colspan="4" height="10" class="table05"><a href="event_ever_list.asp"><img src="../../enter/images/more.gif" width="44" height="15" border="0"></a></td>
                    </tr>
                  </table>
				  <!--에버랜드 이벤트 끝-->
                </td>
                <td><img src="../../enter/images/null.gif" width="28" height="1"></td>
                <td>
				<!--서울랜드 이벤트 시작--> 
                  <table width="307" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td colspan="4"><img src="../../enter/images/seoulland2.gif" width="307" height="53"></td>
                    </tr>
                    <tr> 
                      <td height="18" colspan="4"></td>
                    </tr>
                    <% DO UNTIL rsseoul.EOF %>
                    <tr> 
                      <td width="19" height="19" class="table03"><img src="../../enter/images/green_buret.gif" width="7" height="7"></td>
                      <td class="list05" width="138"><a href="event_seoul_view.asp?intIdx=<% =rsseoul("Idx") %>" title='<% =rsseoul("title") %>'><% =left(rsseoul("title"),9) %>......</a></td>
                      <td width="50" align="center">
                      <% IF FnDateInter(rsseoul("startdate"),rsseoul("enddate"))=1 THEN %>    
					<img src="../../enter/images/today_minibutton.gif" width="42" height="9"> 
					<% ELSEIF FnDateInter(rsseoul("startdate"),rsseoul("enddate"))=2 THEN %>
					<img src="../../enter/images/month_minibutton.gif" width="42" height="9">    
					<% END IF %>                    
                      <td width="100" class="list01">[<% =FnDateFormat(rsseoul("startdate")) %>~<% =FnDateFormat(rsseoul("enddate")) %>]</td>
                    </tr>
                    <tr> 
                      <td colspan="4"><img src="../../enter/images/point_line6.gif" width="307" height="1"></td>
                    </tr>
                    <tr> 
                      <td colspan="4" height="10"></td>
                    </tr>
                    <% rsseoul.MOVENEXT : LOOP %>
                    <tr> 
                      <td colspan="4" height="10" class="table05"><a href="event_seoul_list.asp"><img src="../../enter/images/more.gif" width="44" height="15" border="0"></a></td>
                    </tr>
                  </table>
				  <!--서울랜드 이벤트 끝-->
				  </td>
              </tr>
            </table>
			<!--에버랜드/서울랜드 이벤트 끝-->
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