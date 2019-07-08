<!-- #include file="../../enter/script/FnLoginAuth_admin.inc" -->
<%
' ========================================================================================================
' 프로그램ID : TXT True Plan
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 입장객 실입장 계획입력
' 최초작성일 : 2002/11/07
' 최종작성일 : 2002/11/22
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim intI '증감변수
Dim intInput_Year,intinput_Month,intInput_Day,hidInsert '입력변수
Dim varModel,lngspecial,lngfree,lngeducinst,lngdutyfree,lngcompany,lngmycustomer,lngetc '입력변수

hidInsert=Request.Form("hidInsert")  '넘어오는 폼 변수
intInput_Year=Request.Form("sltInput_year") '년 입력
intInput_Month=Request.Form("sltInput_month") '월 입력
intInput_Day=Request.Form("sltInput_day") '일 입력
lngSpecial=Request.Form("txtSpecial") '특판 입력
lngFree=Request.Form("txtFree") '초대권 입력
lngEducinst=Request.Form("txtEducinst") '학원연합회 입력
lngDutyfree=Request.Form("txtDutyfree") '면세점 입력
lngCompany=Request.Form("txtCompany") '기업체특판 입력
lngMycustomer=Request.Form("txtMycustomer") '나의 손님 모시기 입력
lngEtc=Request.Form("txtEtc") '기타 입력
varModel=Request.Form("rdoModel") '모델형 입력

IF hidInsert="ok" then '저장 버튼을 눌렀을 때
	ArrQuery = array("vxte",varModel,intInput_Year,intInput_Month,intInput_Day,lngSpecial,lngFree,lngEducinst,lngDutyfree,lngCompany,lngMycustomer,lngEtc,"a")
	'변수의 설정
	
	Set objServer = Server.CreateObject("XTEnterPlanIMTS.clsXTEnterPlanITX")
	
	'컴포넌트 호출
	arrRValue = objServer.Save(ArrQuery)
	
	'자원의 해제
	Set objServer = Nothing
	
	hidInsert="" '입력 초기화
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
<script language="javascript"  src="../../enter/script/fnTEnterPlan.js"></script>
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload=document.form.txtSpecial.focus()>
<form method=post action=admin_results_true_plan.asp name=form>
<input type=hidden name=hidInsert value=ok>
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
          <td align="left"><img src="../../enter/images/title_results_true_plan.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="40" valign="top"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td align="right">
		  <!--입력우형/입력일자 테이블 시작--> 
            <table width="436" border="0" cellspacing="0" cellpadding="0" class="title_01">
              <tr>
                <td width="187"><img src="../../enter/images/yellowgreen_buret.gif" width="7" height="7"> 
                  입력유형 
                 <input type="radio" name="rdoModel" value="model_day">
                  일 
                  <input type="radio" name="rdoModel" value="model_month">
                  월 
                  <input type="radio" name="rdoModel" value="model_year">
                  년</td>
                <td width="249" class="table05"><img src="../../enter/images/yellowgreen_buret.gif" width="7" height="7"> 
                  입력일자
                    <select name="sltInput_Year">
                    <option>----</option>
                  <%FOR inti=2000 TO 2010					
							Response.Write "<option value=" & intI & ">" & intI & "년</option>"                    						
					NEXT %>
                  </select>                  
                  <select name="sltInput_Month">
                  <option>----</option>
				  <%FOR intI=1 TO 12                   		
							Response.Write "<option value=" & intI & ">" & intI & "월</option>"                    						
					NEXT %>
                  </select>              
                  <select name="sltInput_Day">
                  <option>----</option>
				  <%FOR intI=1 TO 31                  
							Response.Write "<option value=" & intI & ">" & intI & "일</option>"                    						
					NEXT %>
                  </select>
                </td>
             
              </tr>
            </table>
			<!--입력우형/입력일자 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td height="7"></td>
        </tr>
        <tr> 
          <td>
		  <!--실입장객 계획정보 테이블 시작--> 
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
                  <input type="text" name="txtSpecial" size="65" maxlength=10>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">무료초대권</td>
                <td class="table01"> 
                  <input type="text" name="txtFree" size="65" maxlength=10>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">학원연합회</td>
                <td class="table01"> 
                  <input type="text" name="txtEducinst" size="65" maxlength=10>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">면세점</td>
                <td class="table01"> 
                  <input type="text" name="txtDutyfree" size="65" maxlength=10>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">기업체특판</td>
                <td class="table01"> 
                  <input type="text" name="txtCompany" size="65" maxlength=10>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">나의손님모시기</td>
                <td class="table01"> 
                  <input type="text" name="txtMycustomer" size="65" maxlength=10>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">기타</td>
                <td class="table01"> 
                  <input type="text" name="txtEtc" size="65" maxlength=10>
                </td>
              </tr>
              <tr bgcolor="#B0DFFD"> 
                <td height="7" colspan="2"></td>
              </tr>
            </table>
			<!--실입장객 계획정보 테이블 끝-->
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
</html>
<!-- #include file="../../enter/script/FnErrorCatch.inc"-->