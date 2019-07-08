<!-- #include file="../../electric/script/FnLoginAuth.inc" -->
<%
' ========================================================================================================
' 프로그램ID : TXBADMINCon
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 입력 확인 내역
' 최초작성일 : 2003/01/06
' 최종작성일 : 2003/01/06
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim intI '증가변수
Dim rs,rsvarday,rsvarmonth,rsvaryear '각 레코드셋들 -실적, 일변수, 월변수, 년변수


ArrQuery = array("Electric") '입장

'변수의 설정
Set objServer  = Server.CreateObject("XBAdminConQMTS.clsXBAdminConQNTX")
'컴포넌트 호출
arrRValue = objServer.Query(ArrQuery)

'첫번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rs,1
'두번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rsvarday,2
'세번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rsvarmonth,3
'네번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rsvaryear,4

'자원의 해제
Set objServer = Nothing

'에러의 처리
IF Err.Number <> 0 THEN 
	Response.Write Err.Number, Err.Source, Err.Description
	Set objServer = Nothing
	objserver.close
END IF
%>
<!-- #include file="../../electric/script/FnProgramProcess.vbs" -->
<html>
<head>
<title>롯데월드 수요예측시스템</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../../electric/css/cs_te.css" type="text/css">
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
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
          <td><img src="../../electric/images/title_input_confirm.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../electric/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--입력내역 테이블 시작--> 
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr bgcolor="#CECFF5"> 
                <td height="7" colspan="4"></td>
              </tr>
              <tr class="list13_bg"> 
                <td>제목</td>
                <td width="100">입력여부</td>
                <td width="100">최종입력일</td>
                <td width="100">입력</td>
              </tr>
              <tr> 
                <td class="list03_bg2">라이드 동별입력(일)</td>
                <td class="list14_bg2"><% IF rs("xdate")>=date()-1 THEN Response.Write "입력O" ELSE Response.Write "<font color=red>입력X</font>" %></td>
                <td class="list14_bg2"><% =Year(rs("xdate")) %>년 <% =Month(rs("xdate")) %>월 <% =Day(rs("xdate")) %>일</td>
                <td class="table04"><img src="../../electric/images/input_bu.gif" width="53" height="26" onclick=location.href('admin_results_input.asp')></td>
              </tr>              
              <tr> 
                <td class="list03_bg2">변수입력(일)</td>
                <td class="list14_bg2"><% IF rsvarday("xdate")>=date()-1 THEN Response.Write "입력O" ELSE Response.Write "<font color=red>입력X</font>" %></td>
                <td class="list14_bg2"><% =YEAR(rsvarday("xdate")) %>년 <% =Month(rsvarday("xdate")) %>월 <% =Day(rsvarday("xdate")) %>일</td>
                <td class="table04"><img src="../../electric/images/input_bu.gif" width="53" height="26" onclick=location.href('admin_vari_dayinput.asp')></td>
              </tr>
              <tr> 
                <td class="list03_bg2">변수입력(월)</td>
                <td class="list14_bg2"><% IF DateDiff("m",rsvarmonth("xdate"),date())<=-2 THEN Response.Write "입력O" ELSE Response.Write "<font color=red>입력X</font>" %></td>
                <td class="list14_bg2"><% =YEAR(rsvarmonth("xdate")) %>년 <% =Month(rsvarmonth("xdate")) %>월</td>
                <td class="table04"><img src="../../electric/images/input_bu.gif" width="53" height="26" onclick=location.href('admin_vari_monthinput.asp')></td>
              </tr>
              <tr> 
                <td class="list03_bg2">변수입력(년)</td>
                <td class="list14_bg2"><% IF rsvaryear("xdate")>=YEAR(date()) THEN Response.Write "입력O" ELSE Response.Write "<font color=red>입력X</font>" %></td>
                <td class="list14_bg2"><% =rsvaryear("xdate") %>년</td>
                <td class="table04"><img src="../../electric/images/input_bu.gif" width="53" height="26" onclick=location.href('admin_vari_yearinput.asp')></td>
              </tr>
              <tr bgcolor="#CECFF5"> 
                <td height="7" colspan="4"></td>
              </tr>
            </table>
			<!--입력내역 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td height="30"></td>
        </tr>
      </table>
	  <!--큰 테이블 끝-->
    </td>
    <td width="49"><img src="../../electric/images/null.gif" width="49" height="1"></td>
    <td bgcolor="#a4a4a4"><img src="../../electric/images/outline.gif" width="1" height="1"></td>
  </tr>
  <tr> 
    <td height="42" colspan="3" align="right" background="../../electric/images/copyright_bg.gif"><img src="../../electric/images/copyright.gif" width="350" height="42"></td>
    <td bgcolor="#a4a4a4" width="1" height="42"><img src="../../electric/images/null.gif"></td>
  </tr>
</table>
</body>
</html>