<!-- #include file="../../enter/script/FnLoginAuth_admin.inc" -->
<% 
' ========================================================================================================
' 프로그램ID : Foreigner Input
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 외국인 입력
' 최초작성일 : 2002/12/09
' 최종작성일 : 2002/12/09
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim rs '수정 정보 가져오기
Dim varInsert, varview, intI '아이디,증가변수
Dim txttotal, txtetc, txtJapan, txtTaiwan, txtSouthEast, txtyear, txtmonth '사용자 입력변수

varView=Request.QueryString("varview")
varInsert=Request.Form("varInsert")

IF varInsert="ok" THEN  '폼으로 값이 넘어오면
	txtYear=Request.Form("slt_Year")
	txtMonth=Request.Form("slt_Month")
	txtTotal=Request.Form("txtTotal")
	txtJapan=Request.Form("txtJapan")
	txtTaiwan=Request.Form("txtTaiwan")
	txtsoutheast=Request.Form("txtsoutheast")
	txtEtc=Request.Form("txtEtc")

	ArrQuery =array("Insert",txtyear,txtmonth,txttotal,txtjapan,txttaiwan,txtsoutheast,txtetc) '입력 쿼리변수

	Set objServer = Server.CreateObject("XBForeignerIMTS.clsXBForeignerITX") '입력 쿼리	
	arrRvalue=objServer.save(ArrQuery)	
	
	'자원의 해제
	Set objServer = Nothing
	
	varInsert="" 
END IF

IF VarView="ok" THEN
	txtYear=Request.QueryString("sltYear")
	txtMonth=Request.QueryString("sltMonth")

	ArrQuery =array("View",txtyear,txtmonth) '조회 쿼리변수

	Set objServer = Server.CreateObject("XBForeignerIMTS.clsXBForeignerINTX") '입력 쿼리
	arrRvalue=objServer.Query(ArrQuery)

	'레코드셋 어레이를 단일 레코드셋으로 분리
	
	'첫번째 레코드셋을 어레이로 변환
	FnSplitRSArray arrRValue,rs,1
	
	'자원의 해제
	Set objServer = Nothing
END IF
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
<script language='javascript' src='../../enter/script/Fnadmin_foreigner.js'></script>
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload=document.form.txtTotal.focus()>
<form method=post name=form action=admin_results_foreigner.asp  onsubmit='return Fncheck()'>
<input type=hidden name=varInsert value=ok>
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
  <tr> 
    <td width="49"><img src="../../enter/images/null.gif" width="49" height="1"></td>
    <td width="642" valign="top">
	<!--큰 테이블 시작--> 
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td colspan="2"><img src="../../enter/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
          <td colspan="2"><img src="../../enter/images/title_results_foreigner.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top" colspan="2"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td align="left"> 
		  <!--입력유형 타이틀 박스 시작-->
            <table border="0" cellspacing="0" cellpadding="0" width="142">
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge1.gif" width="6" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge_top.gif" width="130" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge2.gif" width="6" height="6"></td>
              </tr>
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge_left.gif" width="6" height="20"></td>
                <td class="title_01_c"><img src="../../enter/images/yellowgreen_buret.gif" width="7" height="7"> 
                  입력유형: 월</td>
                <td><img src="../../enter/images/gray_round_s_edge_right.gif" width="6" height="20"></td>
              </tr>
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge3.gif" width="6" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge_bottom.gif" width="130" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge4.gif" width="6" height="6"></td>
              </tr>
            </table>
			<!--입력유형 타이틀 박스 끝-->
          </td>
          <td class="table05">
		  <!--입력일자 시작--> 
            <table width="320" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td class="title_01_r"><img src="../../enter/images/yellowgreen_buret.gif" width="7" height="7"> 
                  입력일자 
                  <select name=slt_Year>
                  <option>----</option>
                  <% FOR intI=2000 to 2030 
					IF txtYear-intI=0 THEN %>
                    <option selected value=<% =intI %>><% =intI %>년</option>
                    <% ELSE %>
                    <option value=<% =intI %>><% =intI %>년</option>
                    <% END IF : NEXT %>
                  </select>
                  <select name=slt_Month onchange=FnDate()>
                  <option>----</option>
                  <% FOR intI=1 TO 12 
					IF txtMonth-intI=0 THEN %>
                    <option selected value=<% =intI %>><% =intI %>월</option>
                    <% ELSE %>
                    <option value=<% =inti %>><% =intI %>월</option>
                    <% END IF : NEXT %>
                  </select>
                </td>
              </tr>
            </table>
			<!--입력일자 끝-->
          </td>
        </tr>
        <tr> 
          <td height="7" colspan="2"></td>
        </tr>
        <tr> 
          <td colspan="2"> 
		  <!--입력 테이블 시작-->
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr bgcolor="#B0DFFD"> 
                <td height="7" colspan="2"></td>
              </tr>
              <tr class="list02_bg2"> 
                <td width="200">항목</td>
                <td>입력</td>
              </tr>
              <tr> 
                <td class="list13_bg">외국인 총 입장객</td>
                <td class="table01"> 
                  <input type="text" name="txtTotal" size="65" maxlength=70 value=<% IF varview="ok" THEN Response.Write rs("TOTAL") %>>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">일본</td>
                <td class="table01"> 
                  <input type="text" name="txtJapan" size="65" maxlength=70 value=<% IF varview="ok" THEN Response.Write rs("JAPAN") %>>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">대만</td>
                <td class="table01"> 
                  <input type="text" name="txtTaiwan" size="65" maxlength=70 value=<% IF varview="ok" THEN Response.Write rs("TAIWAN") %>>
                </td>
              </tr>
              <tr>
                <td class="list13_bg">동남아</td>
                <td class="table01">
                  <input type="text" name="txtSouthEast" size="65" maxlength=70 value=<% IF varview="ok" THEN Response.Write rs("SOUTHEAST") %>>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">기타</td>
                <td class="table01"> 
                  <input type="text" name="txtEtc" size="65" maxlength=70 value=<% IF varview="ok" THEN Response.Write rs("ETC") %>>
                </td>
              </tr>
              <tr bgcolor="#B0DFFD"> 
                <td height="7" colspan="2"></td>
              </tr>
            </table>
			<!--입력 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td height="10" colspan="2"></td>
        </tr>
        <tr> 
          <td height="34" colspan="2" class="table02"> 
		  <!--하단 버튼바 시작-->
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td align="right"><input type=image src="../../enter/images/save.gif" width="53" height="26" border="0"></td>
                <td width="5"></td>
              </tr>
            </table>
			<!--하단 버튼바 끝-->
          </td>
        </tr>
        <tr> 
          <td height="30" colspan="2"></td>
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
