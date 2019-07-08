<!-- #include file="../../enter/script/FnLoginAuth_admin.inc" -->
<%
' ========================================================================================================
' 프로그램ID : TXT Rival Input
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 입장객 경쟁사 월입력
' 최초작성일 : 2002/11/07
' 최종작성일 : 2002/11/21
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim intI
Dim intInput_Year,intInput_Month '날짜 변수
Dim hidInsert,VarView '저장 여부, 조회여부
Dim lngIndivAdultEver,lngIndivAdultSeoul,lngGroupAdultEver,lngGroupAdultSeoul,lngIndivSchoolEver,lngIndivSchoolSeoul,lngGroupSchoolEver,lngGroupSchoolSeoul,lngIndivChildEver,lngIndivChildSeoul,lngGroupChildEver,lngGroupChildSeoul '저장할 변수들
Dim rsa,rss,rsc '레코드셋: 데이터 조회 , 어른, 중고생, 어린이

VarView=Request.QueryString("VarView") '조회 변수 
hidInsert = Request.Form("hidInsert") '폼 변수
intInput_Year=Request.Form("sltinput_year") '년 입력
intInput_Month=Request.Form("sltinput_month") '월 입력
lngIndivAdultEver=Request.Form("txtIndivAdultEver") '에버랜드 개인-어른 입력
lngIndivAdultSeoul=Request.Form("txtIndivAdultSeoul") '서울랜드 개인-어른 입력
lngIndivSchoolEver=Request.Form("txtIndivSchoolEver") '에버랜드 개인-중고생 입력
lngIndivSchoolSeoul=Request.Form("txtIndivSchoolSeoul") '서울랜드 개인-중고생 입력
lngIndivChildEver=Request.Form("txtIndivChildEver") '에버랜드 개인-어린이 입력
lngIndivChildSeoul=Request.Form("txtIndivChildSeoul") '서울랜드 개인-어린이 입력

lngGroupAdultEver=Request.Form("txtGroupAdultEver") '에버랜드 단체-어른 입력
lngGroupAdultSeoul=Request.Form("txtGroupAdultSeoul") '서울랜드 단체-어른 입력
lngGroupSchoolEver=Request.Form("txtGroupSchoolEver") '에버랜드 단체-중고생 입력
lngGroupSchoolSeoul=Request.Form("txtGroupSchoolSeoul") '서울랜드 단체-중고생 입력
lngGroupChildEver=Request.Form("txtGroupChildEver") '에버랜드 단체-어린이 입력
lngGroupChildSeoul=Request.Form("txtGroupChildSeoul") '서울랜드 단체-어린이 입력

if hidInsert="ok" then '폼으로 넘어오면 입력들어감
	ArrQuery = array("Insert",intInput_Year,intInput_Month,lngIndivAdultEver,lngIndivAdultSeoul,lngGroupAdultEver,lngGroupAdultSeoul,lngIndivSchoolEver,lngIndivSchoolSeoul,lngGroupSchoolEver,lngGroupSchoolSeoul,lngIndivChildEver,lngIndivChildSeoul,lngGroupChildEver,lngGroupChildSeoul)

	'변수의 설정
	Set objServer = Server.CreateObject("XTEnterRivalMIMTS.clsXTEnterRivalMITX")

	'컴포넌트 호출
	arrRValue = objServer.Save(ArrQuery)
	'레코드셋 어레이를 단일 레코드셋으로 분리

	'자원의 해제
	Set objServer = Nothing

	hidInsert=""
end if

IF VarView="ok" THEN
	intInput_Year=Request.QueryString("sltYear")
	intInput_Month=Request.QueryString("sltMonth") 
	
	ArrQuery = array("View",intInput_Year,intInput_Month)

	'변수의 설정
	Set objServer = Server.CreateObject("XTEnterRivalMIMTS.clsXTEnterRivalMINTX")

	'컴포넌트 호출
	arrRValue = objServer.Query(ArrQuery)
	'레코드셋 어레이를 단일 레코드셋으로 분리
	
	'첫번째 레코드셋을 어레이로 변환
	FnSplitRSArray arrRValue,rsa,1
	'두번째 레코드셋을 어레이로 변환
	FnSplitRSArray arrRValue,rss,2
	'세번째 레코드셋을 어레이로 변환
	FnSplitRSArray arrRValue,rsc,3
	
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
<script language="JavaScript" src="../../enter/script/fnTrivalmonth.js"></script>
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload=document.form.txtIndivadultever.focus()>
<form method=post name=form action=admin_results_rival.asp  onsubmit='return Fncheck()'>
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
          <td align="left" colspan="2"><img src="../../enter/images/title_results_rival_monthinput.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top" colspan="2"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--입력유형:월 타이틀박스 시작-->
            <table border="0" cellspacing="0" cellpadding="0" width="142" height="32">
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
			<!--입력유형:월 타이틀박스 끝-->
          </td>
          <td class="table05">
		  <!--입력일자 테이블 시작--> 
            <table width="260" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td class="title_01_r"><img src="../../enter/images/yellowgreen_buret.gif" width="7" height="7"> 
                  입력일자 
                   <select name="sltInput_year">
                   <option>----</option>
                  <%FOR intI=2000 TO 2030 
						IF intInput_Year-intI=0 THEN
							Response.Write "<option selected value=" & intI & ">" & intI & "년</option>"
						ELSE
							Response.Write "<option value=" & intI & ">" & intI & "년</option>"                    
						END IF 
					NEXT %>
                  </select>                  
                  <select name="sltInput_month" onchange=FnDate()>
                  <option>----</option>
				  <%FOR intI=1 TO 12
						IF intInput_Month-intI=0 THEN
							Response.Write "<option selected value=" & intI & ">" & intI & "월</option>"
						ELSE
							Response.Write "<option value=" & intI & ">" & intI & "월</option>"                    
						END IF
					NEXT %>
                  </select>
                </td>                
              </tr>
            </table>
			<!--입력일자 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td height="7" colspan="2"></td>
        </tr>
        <tr> 
          <td colspan="2"> 
		  <!--경쟁사 월입력 테이블 시작-->
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr> 
                <td colspan="4" class="list02_bg4">에버랜드</td>
              </tr>
              <tr class="list02_bg2"> 
                <td width="100">항목</td>
                <td>어른</td>
                <td>중고생</td>
                <td>어린이</td>
              </tr>
              <tr> 
                <td class="list13_bg">개인</td>
                <td class="table04"> 
                  <input type="text" name="txtIndivadultever" size="20" maxlength=20 value=<% IF VarView="ok" THEN Response.write rsa("everindiv") %>>
                </td>
                <td class="table04"> 
                  <input type="text" name="txtIndivschoolever" size="20" maxlength=20 value=<% IF VarView="ok" THEN  Response.write rss("everindiv") %>>
                </td>
                <td class="table04"> 
                  <input type="text" name="txtIndivchildever" size="20" maxlength=20 value=<% IF VarView="ok" THEN  Response.write rsc("everindiv") %>>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">단체</td>
                <td class="table04"> 
                  <input type="text" name="txtGroupadultever" size="20" maxlength=20 value=<% IF VarView="ok" THEN  Response.write rsa("everorg") %>>
                </td>
                <td class="table04"> 
                  <input type="text" name="txtGroupschoolever" size="20" maxlength=20 value=<% IF VarView="ok" THEN Response.write  rss("everorg") %>>
                </td>
                <td class="table04"> 
                  <input type="text" name="txtGroupchildever" size="20" maxlength=20 value=<% IF VarView="ok" THEN  Response.write rsc("everorg") %>>
                </td>
              </tr>
              <tr class="table03"> 
                <td height="15" colspan="7"><img src="../../enter/images/point_line3.gif" width="628" height="1" disabled></td>
              </tr>
              <tr> 
                <td colspan="4" class="list02_bg4">서울랜드</td>
              <tr class="list02_bg2"> 
                <td width="100">항목</td>
                <td>어른</td>
                <td>중고생</td>
                <td>어린이</td>
              </tr>
              <tr> 
                <td class="list13_bg">개인</td>
                <td class="table04"> 
                  <input type="text" name="txtIndivadultseoul" size="20" maxlength=20 value=<% IF VarView="ok" THEN  Response.write rsa("seoulindiv") %>>
                </td>
                <td class="table04"> 
                  <input type="text" name="txtIndivschoolseoul" size="20" maxlength=20 value=<% IF VarView="ok" THEN  Response.write rss("seoulindiv") %>>
                </td>
                <td class="table04"> 
                  <input type="text" name="txtIndivchildseoul" size="20" maxlength=20 value=<% IF VarView="ok" THEN  Response.write rsc("seoulindiv") %>>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">단체</td>
                <td class="table04"> 
                  <input type="text" name="txtGroupadultseoul" size="20" maxlength=20 value=<% IF VarView="ok" THEN  Response.write rsa("seoulorg") %>>
                </td>
                <td class="table04"> 
                  <input type="text" name="txtGroupschoolseoul" size="20" maxlength=20 value=<% IF VarView="ok" THEN  Response.write rss("seoulorg") %>>
                </td>
                <td class="table04"> 
                  <input type="text" name="txtGroupchildseoul" size="20" maxlength=20 value=<% IF VarView="ok" THEN  Response.write rsc("seoulorg") %>>
                </td>
              </tr>
              <tr bgcolor="#B0DFFD"> 
                <td height="7" colspan="4"></td>
              </tr>
            </table>
			<!--경쟁사 월입력 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td height="10" colspan="2"></td>
        </tr>
        <tr> 
          <td height="34" colspan="2" class="table02">
		  <!--하단 버튼바 테이블 시작--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td align="right"><input type=image src="../../enter/images/save.gif" width="53" height="26" border="0"></td>
                <td width="5"></td>
              </tr>
            </table>
			<!--하단 버튼바 테이블 끝-->
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
<!-- include file="../../enter/script/FnErrorCatch.inc"-->
