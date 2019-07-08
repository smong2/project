<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<%
' ========================================================================================================
' 프로그램ID : TXBADMINCon
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 입력 확인 내역
' 최초작성일 : 2003/01/03
' 최종작성일 : 2003/01/03
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim intI '증가변수
Dim rs,rse,rsres,rsrival,rsforeigner,rsvarday,rsvarmonth,rsvaryear '각 레코드셋들
'매표입장, 실입장, 경쟁사, 외국인, 일변수, 월변수, 년변수 레코드셋

ArrQuery = array("enter") '입장

'변수의 설정
Set objServer  = Server.CreateObject("XBAdminConQMTS.clsXBAdminConQNTX")
'컴포넌트 호출
arrRValue = objServer.Query(ArrQuery)

'첫번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rs,1   
'두번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rse,2
'세번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rsres,3
'네번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rsrival,4
'다섯번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rsforeigner,5
'여섯번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rsvarday,6
'일곱번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rsvarmonth,7
'여덟번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rsvaryear,8

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
<html>
<head>
<title>롯데월드 수요예측시스템</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../../enter/css/cs_tx.css" type="text/css">
</head>

<body bgcolor="#f5f5f5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#ffffff">
  <tr> 
    <td width="49"><IMG height=1 src="../../enter/images/null.gif" width=49></td>
    <td width="642" valign="top"><!--큰 테이블 시작--> 
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><IMG height=24 src="../../enter/images/null.gif" width=1></td>
        </tr>
        <tr> 
          <td><IMG height=21 src="../../enter/images/title_input_confirm.gif" width=200></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><IMG height=5 src="../../enter/images/title_bar.gif" width=642></td>
        </tr>
        <tr> 
          <td><!--입력내역 테이블 시작--> 
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr bgcolor="#b0dffd"> 
                <td height="7" colspan="4"></td>
              </tr>
              <tr class="list13_bg"> 
                <td>제목 -  () 안은 입력간격임</td>
                <td width="100">입력여부</td>
                <td width='100'>최종입력일</td>
                <td width="100">입력</td>
              </tr>
              <tr> 
                <td class="list03_bg2">매표 일 실적 입력(일)</td>                
                <td class="list14_bg2"><% IF rs("xdate")>=date()-1 THEN Response.Write "입력O" ELSE Response.Write "<font color=red>입력X</font>" %></td>
                <td class="list14_bg2"><% =YEAR(rs("xdate")) %>년 <% =Month(rs("xdate")) %>월 <% =Day(rs("xdate")) %>일</td>
                <TD class=table04>
                <IMG height=26 src="../../enter/images/input_bu.gif" width=53 onclick=location.href('admin_results_enter_dayinput.asp')></TD>
              </tr>
              <tr> 
                <td class="list03_bg2">실입장 일 실적 입력(일)</td>
                <td class="list14_bg2"><% IF rse("xdate")>=date()-1 THEN Response.Write "입력O" ELSE Response.Write "<font color=red>입력X</font>" %></td>
                <td class=list14_bg2><% =YEAR(rse("xdate")) %>년 <% =Month(rse("xdate")) %>월 <% =Day(rse("xdate")) %>일</td>
                <TD class=table04>
                <IMG height=26 src="../../enter/images/input_bu.gif" width=53 onclick=location.href('admin_results_enter_dayinput.asp')></TD>
              </tr>
              <tr> 
                <td class="list03_bg2">단체예약정보(일)</td>
                <td class="list14_bg2"><% IF rsres("xdate")>=date()+1 THEN Response.Write "입력O" ELSE Response.Write "<font color=red>입력X</font>" %></td>
                <td class=list14_bg2><% =YEAR(rsres("xdate")) %>년 <% =Month(rsres("xdate")) %>월 <% =Day(rsres("xdate")) %>일</td>
                <td class="table04"><IMG height=26 src="../../enter/images/input_bu.gif" width=53 onclick=location.href('admin_results_reservation.asp')></td>
              </tr>                            
              <tr> 
                <td class="list03_bg2">경쟁사 입력(월)</td>
                <td class="list14_bg2"><% IF DateDiff("m",rsrival("xdate"),date())<=1  THEN Response.Write "입력O" ELSE Response.Write "<font color=red>입력X</font>" %></td>
                <td class=list14_bg2><% =YEAR(rsrival("xdate")) %>년 <% =Month(rsrival("xdate")) %>월</td>
                <TD class=table04>
                <IMG height=26 src="../../enter/images/input_bu.gif" width=53 onclick=location.href('admin_results_rival.asp')></TD>
              </tr>
              <tr> 
                <td class="list03_bg2">외국인 입력(월)</td>
                <td class="list14_bg2"><% IF DateDiff("m",rsforeigner("xdate"),date())<=1 THEN Response.Write "입력O" ELSE Response.Write "<font color=red>입력X</font>" %></td>
                <td class=list14_bg2><% =YEAR(rsforeigner("xdate")) %>년 <% =Month(rsforeigner("xdate")) %>월</td>
                <TD class=table04>
                <IMG height=26 src="../../enter/images/input_bu.gif" width=53 onclick=location.href('admin_results_foreigner.asp')></TD>
              </tr>
              <tr> 
                <td class="list03_bg2">일 변수 입력(일)</td>
                <td class="list14_bg2"><% IF rsvarday("xdate")>=date()+2 THEN Response.Write "입력O" ELSE Response.Write "<font color=red>입력X</font>" %></td>
                <td class=list14_bg2><% =YEAR(rsvarday("xdate")) %>년 <% =Month(rsvarday("xdate")) %>월 <% =Day(rsvarday("xdate")) %>일</td>
                <TD class=table04>
                <IMG height=26 src="../../enter/images/input_bu.gif" width=53 onclick=location.href('admin_vari_dayinput.asp')></TD>
              </tr>
              <tr> 
                <td class="list03_bg2">월 변수 입력(월)</td>
                <td class="list14_bg2"><% IF DateDiff("m",rsvarmonth("xdate"),date())<=-2 THEN Response.Write "입력O" ELSE Response.Write "<font color=red>입력X</font>" %></td>
                <td class=list14_bg2><% =YEAR(rsvarmonth("xdate")) %>년 <% =Month(rsvarmonth("xdate")) %>월</td>
                <TD class=table04>
                <IMG height=26 src="../../enter/images/input_bu.gif" width=53 onclick=location.href('admin_vari_monthinput.asp')></TD>
              </tr>
              <tr> 
                <td class="list03_bg2">년 변수 입력(년)</td>
                <td class="list14_bg2"><% IF rsvaryear("xdate")>=YEAR(date()) THEN Response.Write "입력O" ELSE Response.Write "<font color=red>입력X</font>" %></td>
                <td class=list14_bg2><% =rsvaryear("xdate") %>년 </td>
                <TD class=table04>
                <IMG height=26 src="../../enter/images/input_bu.gif" width=53 onclick=location.href('admin_vari_yearinput.asp')></TD>
              </tr>
              <tr bgcolor="#b0dffd"> 
                <td height="7" colspan="4"></td>
              </tr>
            </table><!--입력내역 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td height="30"></td>
        </tr>
      </table><!--큰 테이블 끝-->
    </td>
    <td width="49"><IMG height=1 src="../../enter/images/null.gif" width=49></td>
    <td bgcolor="#a4a4a4"><IMG height=1 src="../../enter/images/outline.gif" width=1></td>
  </tr>
  <tr> 
    <td height="42" colspan="3" align="right" background="../../enter/images/copyright_bg.gif"><IMG height=42 src="../../enter/images/copyright.gif" width=350></td>
    <td bgcolor="#a4a4a4" width="1" height="42"><IMG src="../../enter/images/null.gif"></td>
  </tr>
</table>
</body>
</html>
<!-- #include file="../../enter/script/FnErrorCatch.inc"-->