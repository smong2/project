<!-- #include file="../../enter/script/FnLoginAuth_admin.inc" -->
<%
' ========================================================================================================
' 프로그램ID : TXT Ticket Plan
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 입장객 계획입력
' 최초작성일 : 2002/11/07
' 최종작성일 : 2002/11/21
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim intI,hidInsert '증감변수, 폼변수
Dim intInput_year,intInput_month,intInput_day,varClass '사용자 입력값
Dim varModel,lngSpecial,lngFree,lngEducinst,lngDutyfree,lngCompany,lngMycustomer,lngEtc '사용자 입력값
DIM varview '값 보기
DIM rs '값보기 레코드셋

varview = Request.QueryString("varview")
hidInsert=Request.Form("hidInsert") '폼 변수
intinput_Year=Request.Form("sltinput_year") '년 입력
intinput_Month=Request.Form("sltinput_month") '월 입력
intinput_Day=Request.Form("sltinput_day") '일 입력
lngSpecial=Request.Form("txtspecial") '특판 입력
lngFree=Request.Form("txtfree") '초대권 입력
lngEducinst=Request.Form("txteducinst") '학원연합회 입력
lngDutyfree=Request.Form("txtdutyfree") '면세점 입력
lngCompany=Request.Form("txtcompany") '기업체특판 입력
lngMycustomer=Request.Form("txtmycustomer") '나의 손님 모시기 입력
lngEtc=Request.Form("txtetc") '기타 입력
varModel=Request.Form("rdomodel") '모델형  입력
varClass=Request.Form("rdoClass") '어른, 중고생, 어린이 입력


IF intinput_day = "----" THEN intinput_day = 1  '없으면 초기값을 준다
IF lngspecial = "" THEN lngspecial = 0
IF lngFree = "" THEN lngFree = 0
IF lngEducinst = "" THEN lngEducinst = 0
IF lngDutyfree = "" THEN lngDutyfree = 0
IF lngCompany = "" THEN lngCompany = 0
IF lngMycustomer = "" THEN lngMycustomer = 0
IF lngEtc = "" THEN lngEtc = 0


if varview = "ok" then
	intInput_Year = Request.QueryString("sltInput_Year")
	intInput_Month = Request.QueryString("sltInput_Month")
	intInput_Day = Request.QueryString("sltInput_Day")
	varmodel = Request.QueryString("rdomodel")
	varclass = Request.QueryString("rdoclass")
	
	ArrQuery = array("VIEW","vxt",varModel,intInput_Year,intInput_Month,intInput_Day,lngSpecial,lngFree,lngEducinst,lngDutyfree,lngCompany,lngMycustomer,lngEtc,varClass)
	'변수의 설정
	Set objServer = Server.CreateObject("XTEnterPlanIMTS.clsXTEnterPlanINTX")
	'컴포넌트 호출
    arrRValue = objServer.Query(ArrQuery)
  
	'첫번째 레코드셋을 어레이로 변환
	FnSplitRSArray arrRValue,rs,1
  
    '자원의 해제
	Set objServer = Nothing	
	
end if



if hidInsert="ok" then '입력버튼을 눌렀을 때
	ArrQuery = array("INSERT","vxt",varModel,intInput_Year,intInput_Month,intInput_Day,lngSpecial,lngFree,lngEducinst,lngDutyfree,lngCompany,lngMycustomer,lngEtc,varClass)
	'변수의 설정
	Set objServer = Server.CreateObject("XTEnterPlanIMTS.clsXTEnterPlanITX")
	'컴포넌트 호출
    arrRValue = objServer.Save(ArrQuery)
  
    '자원의 해제
	Set objServer = Nothing	
	
	hidInsert=""
end if

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
<script language="javascript"  src="../../enter/script/fnTEnterPlan.js">
</script>
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload=document.form.txtSpecial.focus()>
<form method=post action=admin_results_ticket_plan.asp name=form>
<input type=hidden name=hidInsert value=ok>
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
  <tr> 
    <td width="49"><img src="../../enter/images/null.gif" width="49" height="1"></td>
    <td width="642" valign="top">
	<!--큰 테이블 시작--> 
      <table width="642" border="0" cellspacing="0" cellpadding="0" class="title_01">
        <tr> 
          <td height="24"><img src="../../enter/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
          <td align="left"><img src="../../enter/images/title_results_ticket_plan.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="40" valign="top"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--입력유형 테이블 시작--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="18"></td>
                <td width="70" class="title_01"><img src="../../enter/images/yellowgreen_buret.gif" width="7" height="7"> 
                  입력유형</td>
                <td width="192">
				<!--일/월/년 입력 시작--> 
                  <table border="0" cellspacing="0" cellpadding="0" width="182">
                    <tr> 
                      <td><img src="../../enter/images/gray_round_s_edge1.gif" width="6" height="6"></td>
                      <td><img src="../../enter/images/gray_round_s_edge_top.gif" width="170" height="6"></td>
                      <td><img src="../../enter/images/gray_round_s_edge2.gif" width="6" height="6"></td>
                    </tr>
                    <tr> 
                      <td><img src="../../enter/images/gray_round_s_edge_left.gif" width="6" height="20"></td>
                      <td class="title_01_c"> 
                        <% IF varmodel="model_day" THEN %>                      
                        <input type="radio" name="rdoModel" value="model_day" checked>일 
                        <input type="radio" name="rdoModel" value="model_month">월 
                        <input type="radio" name="rdoModel" value="model_year">년
						<% ELSEIF varmodel="model_month" THEN %>                      
                        <input type="radio" name="rdoModel" value="model_day">일 
                        <input type="radio" name="rdoModel" value="model_month" checked>월 
                        <input type="radio" name="rdoModel" value="model_year">년
						<% ELSEIF varmodel="model_year" THEN %>
                        <input type="radio" name="rdoModel" value="model_day">일 
                        <input type="radio" name="rdoModel" value="model_month">월 
                        <input type="radio" name="rdoModel" value="model_year" checked>년
						<% ELSE %>                      
                        <input type="radio" name="rdoModel" value="model_day">일 
                        <input type="radio" name="rdoModel" value="model_month">월 
                        <input type="radio" name="rdoModel" value="model_year">년
						<% END IF %>
                        </td>
                      <td><img src="../../enter/images/gray_round_s_edge_right.gif" width="6" height="20"></td>
                    </tr>
                    <tr> 
                      <td><img src="../../enter/images/gray_round_s_edge3.gif" width="6" height="6"></td>
                      <td><img src="../../enter/images/gray_round_s_edge_bottom.gif" width="170" height="6"></td>
                      <td><img src="../../enter/images/gray_round_s_edge4.gif" width="6" height="6"></td>
                    </tr>
                  </table>
				  <!--일/월/년 입력 끝-->
                </td>
                <td width="362">
				<!--어른/중고생/어린이 입력 시작--> 
                  <table border="0" cellspacing="0" cellpadding="0" width="212">
                    <tr> 
                      <td><img src="../../enter/images/gray_round_s_edge1.gif" width="6" height="6"></td>
                      <td><img src="../../enter/images/gray_round_s_edge_top.gif" width="200" height="6"></td>
                      <td><img src="../../enter/images/gray_round_s_edge2.gif" width="6" height="6"></td>
                    </tr>
                    <tr> 
                      <td><img src="../../enter/images/gray_round_s_edge_left.gif" width="6" height="20"></td>
                      <td class="title_01_c"> 
                      <% IF varClass="A" THEN %>
                        <input type="radio" name="rdoClass" value="A" checked>어른 
                        <input type="radio" name="rdoClass" value="S">중고생 
                        <input type="radio" name="rdoClass" value="C">어린이
                      <% ELSEIF varClass="S" THEN %>
                        <input type="radio" name="rdoClass" value="A">어른 
                        <input type="radio" name="rdoClass" value="S" checked>중고생 
                        <input type="radio" name="rdoClass" value="C">어린이
                      <% ELSEIF varClass="C" THEN %>
                        <input type="radio" name="rdoClass" value="A">어른 
                        <input type="radio" name="rdoClass" value="S">중고생 
                        <input type="radio" name="rdoClass" value="C" checked>어린이
                      <% ELSE %>  
                        <input type="radio" name="rdoClass" value="A">어른 
                        <input type="radio" name="rdoClass" value="S">중고생 
                        <input type="radio" name="rdoClass" value="C">어린이
                      <% END IF %>
                      </td>
                      <td><img src="../../enter/images/gray_round_s_edge_right.gif" width="6" height="20"></td>
                    </tr>
                    <tr> 
                      <td><img src="../../enter/images/gray_round_s_edge3.gif" width="6" height="6"></td>
                      <td><img src="../../enter/images/gray_round_s_edge_bottom.gif" width="200" height="6"></td>
                      <td><img src="../../enter/images/gray_round_s_edge4.gif" width="6" height="6"></td>
                    </tr>
                  </table>
				  <!--어른/중고생/어린이 입력 끝-->
                </td>
              </tr>
            </table>
			<!--입력유형 테이블 시작-->
          </td>
        </tr>
        <tr>
          <td height="35" valign="bottom">
		  <!--입력일자 시작--> 
            <table width="333" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="18"></td>
                <td width="70" class="title_01"><img src="../../enter/images/yellowgreen_buret.gif" width="7" height="7"> 
                  입력일자</td>
                <td> 
                  <select name=sltInput_Year>
					<option>----</option>
                    <% FOR intI=2000 TO 2030 	
                        IF intinput_Year-inti=0 THEN
							Response.Write "<option value=" & intI & " selected>" & intI & "년</option>"
						ELSE	
							Response.Write "<option value=" & intI & ">" & intI & "년</option>"
						END IF	
					   NEXT %>
                  </select>                  
                  <select name=sltInput_Month>
                   <option>----</option>
				  <% FOR intI=1 to 12
						IF intInput_Month-inti=0 THEN
							Response.Write "<option value=" & intI & " selected>" & intI & "월</option>"
						ELSE							
							Response.Write "<option value=" & intI & ">" & intI & "월</option>"
						END IF
					NEXT %>
                  </select>              
                  <select name=sltInput_Day onchange=FnDate()>
				   <option>----</option>
				  <% FOR intI=1 to 31
						IF intInput_Day-inti=0 THEN
							Response.Write "<option value=" & intI & " selected>" & intI & "일</option>"
						ELSE	
							Response.Write "<option value=" & intI & ">" & intI & "일</option>"
						END IF
					NEXT %>
				  </select>
                </td>                
              </tr>
            </table>
			<!--입력일자 끝-->
          </td>
        </tr>
        <tr> 
          <td height="15"></td>
        </tr>
        <tr> 
          <td> 
		  <!--매표입장객 계획정보 테이블 시작-->
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr bgcolor="#B0DFFD"> 
                <td height="7" colspan="2"></td>
              </tr>
              <tr class="list02_bg2"> 
                <td width="120">항목</td>
                <td>입력</td>
              </tr>
              <tr> 
                <td class="list13_bg">특판</td>
                <td class="table01"> 
                  <input type="text" name="txtSpecial" size="65" maxlength=20 value=<% IF varView="ok" THEN Response.Write rs("special") %>>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">무료초대권</td>
                <td class="table01"> 
                  <input type="text" name="txtFree" size="65" maxlength=20 value=<% IF varView="ok" THEN Response.Write rs("free") %>>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">학원연합회</td>
                <td class="table01"> 
                  <input type="text" name="txtEducinst" size="65" maxlength=20 value=<% IF varView="ok" THEN Response.Write rs("educinst") %>>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">해외단체</td>
                <td class="table01"> 
                  <input type="text" name="txtDutyfree" size="65" maxlength=20 value=<% IF varView="ok" THEN Response.Write rs("dutyfree") %>>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">기업체특판</td>
                <td class="table01"> 
                  <input type="text" name="txtCompany" size="65" maxlength=20 value=<% IF varView="ok" THEN Response.Write rs("Company") %>>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">나의손님모시기</td>
                <td class="table01"> 
                  <input type="text" name="txtMycustomer" size="65" maxlength=20 value=<% IF varView="ok" THEN Response.Write rs("Mycustomer") %>>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">기타</td>
                <td class="table01"> 
                  <input type="text" name="txtEtc" size="65" maxlength=20 value=<% IF varView="ok" THEN Response.Write rs("ETC") %>>
                </td>
              </tr>
              <tr bgcolor="#B0DFFD"> 
                <td height="7" colspan="2"></td>
              </tr>
            </table>
			<!--매표입장객 계획정보 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td height="10"></td>
        </tr>
        <tr> 
          <td height="34" class="table02">
		  <!--하단 버튼바 테이블 시작--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td align="right"><input type=image src="../../enter/images/save.gif" width="53" height="26" border="0" onclick='return fncheck()'></td>
                <td width="5"></td>
              </tr>
            </table>
			<!--하단 버튼바 테이블 끝-->
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
</form>
</html>
<!-- #include file="../../enter/script/FnErrorCatch.inc"-->