<!-- #include file="../../enter/script/FnLoginAuth_admin.inc" -->
<% 
' ========================================================================================================
' 프로그램ID : TXBBULLETIN - seoul admin
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 입장객 예측 행사 - 서울랜드 행사 관리자
' 최초작성일 : 2002/10/16
' 최종작성일 : 2002/10/18
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim ArrRValue, ArrRvalueUI, objserver, Arr '컴관련 변수들
Dim ArrQ, ArrUI '출력, 입력용
Dim rs,rsmodify '레코드셋 : 글 리스트, 수정시 수정 내용
Dim varInsertModify,hidInsert  '수정,등록 모드, 폼변수
Dim varTitle,varContents,intStartYear,intStartMonth,intStartDay,intEndyear,intEndMonth,intEndDay '각변수들
Dim varParkClass,dtStartDate,dtEndDate '각변수들
Dim	intIdx,hidIdx,intI : inti=1 'idx 쿼리값,form값, 증감변수 초기값 1
Dim varMode,hidMode '쿼리로 넘어온 mode 값, form으로 넘어온 mode 값

'변수의 설정
intPage=Request.QueryString("intPage") '레코드 페이지 구분
intIdx=Request.QueryString("intIdx")  '수정모드시 글 번호 가져옴
varMode=Request.QueryString("varMode") '초기화면인지 수정 모드인지 구분
hidInsert=Request.Form("hidInsert") '폼으로 자료가 넘어오는지 확인

IF hidinsert="ok" THEN
	varTitle=Request.Form("txtSubject") '폼으로 넘어온 변수들(입력,수정시 사용) -제목
	varContents=Request.Form("txtaMemo") '내용
	hidIdx=Request.Form("hidIdx") '수정시 사용되는 글번호
	hidMode=Request.Form("hidMode") '수정인지, 등록인지 구분
	
	intStartYear=Request.Form("sltStartyear") '각변수들 -시작년
	intStartMonth=Request.Form("sltStartmonth")  '시작월
	intStartDay=Request.Form("sltStartday") '시작일
	intEndYear=Request.Form("sltEndyear") '종료년
	intEndMonth=Request.Form("sltEndmonth") '종료월
	intEndDay=Request.Form("sltEndday") '종료일
	dtStartDate=dateserial(intStartYear,intStartMonth,intStartDay) '시작날짜 생성
	dtEndDate=dateserial(intEndYear,intEndMonth,intEndDay) '종료날짜 생성
	varParkClass=Request.Form("sltParkClass") '파크 구분
END IF

IF hidMode="MQ" and hidInsert="ok" THEN  '수정인지 입력인지를 결정
	varInsertModify="modify"
ELSEIF hidMode="" and hidInsert="ok" THEN '여기가 입력 위에가 수정.
	varInsertModify="insert"
END IF

'수정 보기 변수 설정
IF varmode="" THEN varmode = null '변수 설정
IF intIdx="" THEN intIdx = null '변수 설정
ArrQ = array(varMode,intIdx,"서울랜드") '수정 보기 쿼리
'여기까지

'입력모드일때 
IF hidInsert="ok" THEN
	IF hididx="" THEN hidIdx=null '변수 설정
	Set objServer = Server.CreateObject("XBbulletinUIQMTS.clsXBbulletinUIQTX")  '입력 쿼리
	ArrUI=array(varInsertModify,varParkClass,hididx,varTitle,varContents,dtStartDate,dtEndDate) '수정,입력 쿼리
	arrRValueUI=objServer.save(ArrUI)  '입력쿼리- 입력 코드가 들어왔을 때 작동
	hidInsert="" '초기값 정하고..
	
	'자원의 해제
	Set objServer = Nothing
END IF

Set objServer =  Server.CreateObject("XBbulletinUIQMTS.clsXBbulletinUIQNTX") '출력 쿼리

'컴포넌트 호출
arrRValue=objServer.Query(ArrQ)

'레코드셋 어레이를 단일 레코드셋으로 분리
'첫번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rs,1 '리스트 레코드

IF varMode="MQ" THEN '수정시 수정 글번호 가져오기
'두번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rsmodIFy,2 '수정 보기 레코드
END IF 

'자원의 해제
Set objServer = Nothing

IF varMode="MQ" and hidinsert="" THEN  '수정 보기 일때 글번호에 해당되는 자료 가져옴
	intStartyear=year(rsmodify("startdate"))
	intStartmonth=month(rsmodify("startdate"))
	intStartday=day(rsmodify("startdate"))
	intEndyear=year(rsmodify("enddate"))
	intEndmonth=month(rsmodify("enddate"))
	intEndday=day(rsmodify("enddate"))
	varTitle=rsmodify("title")
	varContents=rsmodify("contents")
END IF

'에러의 처리
IF Err.Number <> 0 THEN 
	Response.Write Err.Number, Err.Source, Err.Description
	Set objServer = Nothing
	objserver.close
END IF
%>
<!-- #include file="../../enter/script/FnProgramProcess.vbs" -->
<!-- #include file="../../enter/script/fnadmin_event_input.inc" -->
<html>
<head>
<title>롯데월드 수요예측시스템</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<script language="JavaScript" src=../../enter/script/Fnadmin_event_input.js></script>
<link rel="stylesheet" href="../../enter/css/cs_tx.css" type="text/css">
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="MM_preloadImages('../../enter/images/tap_ever2.gif','../../enter/images/tap_seoul2.gif');Fn_clearModify();document.form.txtSubject.focus()" >
<form method=post action='admin_event_lotte.asp' name=form>
<input type=hidden name=hidmode value=<% =varmode %>>
<input type=hidden name=hidIdx value=<% =intIdx %>>
<input type=hidden name=hidInsert value=ok>
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
  <tr> 
    <td width="49"><img src="../../enter/images/null.gif" width="49" height="1"></td>
    <td width="642" valign="top">
	<!--큰 테이블 시작--> 
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="24" colspan="2"><img src="../../enter/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
          <td align="left" colspan="2"><img src="../../enter/images/title_admin_event.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="40" valign="top" colspan="2"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--업체 입력창 시작--> 
            <table width="150" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="title_01_c"><img src="../../enter/images/yellowgreen_buret.gif" width="7" height="7"> 
                  업체 
                  <select name="sltParkClass">                                     
                    <option value=롯데월드>롯데월드</option>
                    <option value=에버랜드>에버랜드</option>
                    <option value=서울랜드 selected>서울랜드</option>                    
                  </select>
                </td>
              </tr>
            </table>
			<!--업체 입력창 끝-->
          </td>
          <td>
		  <!--행사기간 입력 시작--> 
            <table width="492" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="title_01_r"><img src="../../enter/images/yellowgreen_buret.gif" width="7" height="7"> 
                  행사기간 
                  <select name="sltStartyear">                  
                <% FOR intI=2002 to 2010 
                   IF intStartyear=intI THEN
                   Response.Write "<option selected value='" & intI & "'>"& intI & "년</option>"
                   ELSE
                   Response.Write "<option value='" & intI & "'>"& intI & "년</option>"
                   END IF : NEXT %>
                  </select>
                  <select name="sltStartmonth">
                   <% FOR IntI=01 to 12
                    IF intStartmonth=intI THEN
                   Response.Write "<option selected value='" & intI & "'>"& intI & "월</option>"
                   ELSE
                   Response.Write "<option value='" & intI & "'>"& intI & "월</option>"
                   END IF : NEXT %>
                  </select>
                  <select name="sltStartday">
                   <% FOR IntI=01 to 31
                    IF intStartday=intI THEN
                   Response.Write "<option selected value='" & intI & "'>"& intI & "일</option>"
                   ELSE
                   Response.Write "<option value='" & intI & "'>"& intI & "일</option>"
                   END IF : NEXT %>
                  </select>
                  ~ 
                   <select name="sltEndyear">
                  <% FOR IntI=2002 to 2010 
                   IF intEndyear=intI THEN
                   Response.Write "<option selected value='" & intI & "'>"& intI & "년</option>"
                   ELSE
                   Response.Write "<option value='" & intI & "'>"& intI & "년</option>"
                   END IF : NEXT %>
                  </select>
                  <select name="sltEndmonth">
                   <% FOR IntI=01 to 12
                    IF intEndmonth=intI THEN
                   Response.Write "<option selected value='" & intI & "'>"& intI & "월</option>"
                   ELSE
                   Response.Write "<option value='" & intI & "'>"& intI & "월</option>"
                   END IF : NEXT %>
                  </select>
                  <select name="sltEndday">
                   <% FOR IntI=01 to 31
                    IF intEndday=intI THEN
                   Response.Write "<option selected value='" & intI & "'>"& intI & "일</option>"
                   ELSE
                   Response.Write "<option value='" & intI & "'>"& intI & "일</option>"
                   END IF : NEXT %>
                  </select>
                </td>
              </tr>
            </table>
			<!--행사기간 입력 끝-->
          </td>
        </tr>
        <tr> 
          <td height="7" colspan="2"></td>
        </tr>
        <tr> 
          <td colspan="2">
		  <!--행사 입력 테이블 시작--> 
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr bgcolor="#B0DFFD"> 
                <td height="7" colspan="2"></td>
              </tr>
              <tr> 
                <td width="100" class="list13_bg">제목</td>
                <td class="table01"> 
                  <input type="text" name="txtSubject" size="65" maxlength=70 value='<% =varTitle %>'>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">내용</td>
                <td class="table01"> 
                  <textarea cols="65" rows="12" name=txtaMemo><% =varContents %></textarea>
                </td>
              </tr>
              <tr bgcolor="#B0DFFD"> 
                <td height="7" colspan="2"></td>
              </tr>
            </table>
			<!--행사 입력 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td height="10" colspan="2"></td>
        </tr>
        <tr> 
          <td height="34" colspan="2" class="table02">
		  <!--하단 버튼 바 테이블 시작--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td align="right"><input type=image src="../../enter/images/save.gif" width="53" height="26" border="0" onclick='return Fn_check()' id=image1 name=image1></td>
                <td width="5"></td>
              </tr>
            </table>
			<!--하단 버튼 바 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td height="30" colspan="2"></td>
        </tr>
        <tr>
          <td colspan="2">
		  <!--롯데월드/에버랜드/서울랜드 행사정보게시판 롤오버 탭 시작-->
            <table width="217" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><a href="admin_event_lotte.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image40','','../../enter/images/tab_lotte.gif',1)"><img name="Image40" border="0" src="../../enter/images/tab_lotte2.gif" width="73" height="24"></a></td>
                <td><a href="admin_event_ever.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image41','','../../enter/images/tab_ever.gif',1)"><img name="Image41" border="0" src="../../enter/images/tab_ever2.gif" width="72" height="24"></a></td>
                <td><img src="../../enter/images/tab_seoul.gif" width="72" height="24"></td>
              </tr>
            </table>
			<!--롯데월드/에버랜드/서울랜드 행사정보게시판 롤오버 탭 끝-->
          </td>
        </tr>
        <tr valign="top"> 
          <td height="350" colspan="2">
		  <!--서울랜드 행사정보 게시판 시작--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td><img src="../../enter/images/gray_edge2.gif" width="15" height="15"></td>
                <td width="612" align="right" bgcolor="#F4F4F4"><img src="../../enter/images/gray_round_edge_top.gif" width="555" height="15"></td>
                <td><img src="../../enter/images/gray_round_edge2.gif" width="15" height="15"></td>
              </tr>
              <tr> 
                <td width="15" background="../../enter/images/gray_round_edge_left.gif"></td>
                <td class="table03">
				<!--게시판 목록 시작--> 
                  <table width="523" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td colspan="4" height="20"></td>
                    </tr>
                       <% do while not rs.EOF and intTotalPage>0 %>
                    <tr> 
                      <td width="50" height="19" class="list10_1"><% =rs("IDX") %></td>
                      <td width="316" class="list05"><a href="../../enter/event/event_seoul_view.asp?intIdx=<% =rs("IDX") %>" title='<% =rs("TITLE") %>'><% =left(rs("title"),30) %>...</a></td>
                      <td width="107" align="right"><img src="../../enter/images/modIFy_small_bu.gif" width="52" height="13" onclick="location.href('admin_event_seoul.asp?intIdx=<%=rs("IDX") %>&varMode=MQ')"></td>
                      <td width="60" align="right"><img src="../../enter/images/delete_small_bu.gif" width="52" height="13"  onclick="location.href('admin_event_delete.asp?code=seoul&intIdx=<%=rs("Idx") %>')"></td>
                    </tr>
                    <tr> 
                      <td colspan="4"><img src="../../enter/images/point_line5.gif" width="523" height="1"></td>
                    </tr>
                    <tr> 
                      <td colspan="4" height="10"></td>
                    </tr>
                      <% intTotalPage=intTotalPage-1 : rs.MOVENEXT : LOOP %>
                    <tr class="table04"> 
                      <td colspan="4" height="20">
					  <!--페이지 번호 테이블 시작--> 
                        <table width="268" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="64" class="list13_1">
								 <%	IF intCurPage >1 THEN
										Response.Write "<a href='admin_event_seoul.asp?intPage=" & intCurPage-1 & "'>◀ 이전</a>"
									ELSE
										Response.Write "<font color=#f5f5f5>◀ 이전</font>"
									END IF %></td>
										<td width="140" class="list14_1">
									<div align="center">
								<%	FOR intI=intStartPage to intStartPage-1+intLimit
										Response.Write "<a href='admin_event_seoul.asp?intPage=" & intI & "'>" & intI & "</a> "
											IF intI>=intLastPage THEN
											exit for
											END IF
									NEXT %>
									</div>
									</td>
										<td width="64" class="list13_2">
								<%	IF intCurPage - intLastPage <0 THEN
										Response.Write "<a href='admin_event_seoul.asp?intPage=" & intCurpage+1 & "'>다음 ▶</a>"
									ELSE
										Response.Write "<font color=#f5f5f5>끝끝 ▶</font></a>"
									END IF %></td>
                          </tr>
                        </table>
						<!--페이지 번호 테이블 끝-->
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="4" height="10"></td>
                    </tr>
                  </table>
				  <!--게시판 목록 끝-->
                </td>
                <td width="15" background="../../enter/images/gray_round_edge_right.gif"></td>
              </tr>
              <tr> 
                <td><img src="../../enter/images/gray_round_edge3.gif" width="15" height="15"></td>
                <td><img src="../../enter/images/gray_round_edge_bottom.gif" width="612" height="15"></td>
                <td><img src="../../enter/images/gray_round_edge4.gif" width="15" height="15"></td>
              </tr>
            </table>
			<!--서울랜드 행사정보 게시판 끝-->
          </td>
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
</form>
</body>
</html>
<!-- #include file="../../enter/script/FnErrorCatch.inc"-->
