<!-- #include file="../../electric/script/FnLoginAuth.inc" -->
<%
' ========================================================================================================
' 프로그램ID : TXERESULTSINPUT
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 전기 실적 - 입력
' 최초작성일 : 2002/11/27
' 최종작성일 : 2002/11/27
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
dim intI '증가변수
Dim intInput_Year,intInput_Month,intInput_Day  '입력 년,월,일
Dim lngMagicisland,lngAdventure,lngMart,lngSports,lngHotel,lngDepartmentstore '매직아일랜드,어드벤쳐,마트,스포츠,호텔,백화점입력
Dim lngShoppingmall,lngTotal '쇼핑몰,합계
Dim varMode,varInsert, varview '일,월입력,날짜,폼변수
Dim rs '레코드셋 조회 관련

Varview=Request.QueryString("varview")
varInsert=Request.Form("varInsert")

IF varInsert="ok" THEN '저장 버튼을 누를경우
intInput_Year=Request.Form("sltInput_Year")
intInput_Month=Request.Form("sltInput_Month")
intInput_Day=Request.Form("sltInput_Day")
lngMagicisland=Request.Form("txtmagicisland")
lngAdventure=Request.Form("txtadventure")
lngMart=Request.Form("txtmart")
lngSports=Request.Form("txtsports")
lngHotel=Request.Form("txthotel")
lngDepartmentstore=Request.Form("txtdepartmentstore")
lngShoppingmall=Request.Form("txtshoppingmall")
lngTotal=Request.Form("txttotal")
varMode=Request.Form("sltMode")

IF lngMagicisland="" THEN lngMagicisland=0
IF lngAdventure="" THEN lngAdventure=0
IF lngMart="" THEN lngMart=0
IF lngSports="" THEN lngSports=0
IF lngHotel="" THEN lngHotel=0
IF lngDepartmentstore="" THEN lngDepartmentstore=0
IF lngShoppingmall="" THEN lngShoppingmall=0
IF lngTotal="" THEN lngTotal=0


ArrQuery = array("Insert",varMode,intInput_Year,intInput_Month,intInput_Day,lngMagicisland,lngAdventure,lngSports,lngHotel,lngDepartmentstore,lngShoppingmall,lngMart,lngTotal) '페이지에 맞는 코드 가져오고

'변수의 설정
Set objServer = Server.CreateObject("XEElectInputIMTS.clsXEElectInputITX")

'컴포넌트 호출
arrRValue = objServer.save(ArrQuery)

'자원의 해제
Set objServer = Nothing
END IF

IF varview="ok" THEN '조회시
intInput_Year=Request.QueryString("sltYear")
intInput_Month=Request.QueryString("sltMonth")
intInput_Day=Request.QueryString("sltDay")
varmode=Request.QueryString("sltMode")

ArrQuery = array("View",varMode,intInput_Year,intInput_Month,intInput_Day) '페이지에 맞는 코드 가져오고

'변수의 설정
Set objServer = Server.CreateObject("XEElectInputIMTS.clsXEElectInputINTX")

'컴포넌트 호출
arrRValue = objServer.Query(ArrQuery)

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
<!-- #include file="../../electric/script/FnProgramProcess.vbs" -->
<html>
<head>
<title>롯데월드 수요예측시스템</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../../electric/css/cs_te.css" type="text/css">
<script language=javascript src=../../electric/script/fnResultInput.js></script>
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload=document.form.txtMagicisland.focus()>
<form method=post name=form action=admin_results_input.asp onsubmit='return fncheck()'>
<input type=hidden name=varInsert value=ok>
<input type=hidden name=sltMode value=results_day>
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
  <tr> 
    <td width="49"><img src="../../electric/images/null.gif" width="49" height="1"></td>
    <td width="642" valign="top">
	<!--큰 테이블 시작--> 
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td colspan="2"><img src="../../electric/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
          <td colspan="2"><img src="../../electric/images/title_results_input.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="40" valign="top" colspan="2"><img src="../../electric/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td align="right"> 
		  <!--입력선택 시작-->
            <table width="410" border="0" cellspacing="0" cellpadding="0" class="title_01">
              <tr> 
                <!--td width="157" valign="bottom"><img src="../../electric/images/yellowgreen_buret.gif" width="7" height="7"> 
                  일별 실적 입력 입니다
                </td-->
                <td width="410" colspan=2 align=right class="table05"><img src="../../electric/images/yellowgreen_buret.gif" width="7" height="7"> 
                  입력일자 
                  <select name="sltInput_Year">
						<option>----</option>
                        <% FOR intI=2000 to 2030 %>
                        <% IF intInput_Year-intI=0 then %>
                          <option selected value=<% =intI %>><% =intI %>년</option>
                        <% ELSE %>
                          <option value=<% =intI %>><% =intI %>년</option>
                        <% END IF 
                         NEXT %>                        
                        </select>
                        <select name="sltInput_Month">
                        <option>----</option>
                        <% FOR intI=1 to 12 %>
                        <% if intInput_Month-intI=0 then %>
                          <option selected value=<% =intI %>><% =intI %>월</option>
                        <% else %>
                          <option value=<% =intI %>><% =intI %>월</option>                        
                        <% end if :next %>
                        </select>
                        <select name="sltInput_Day" onchange=FnDate()>
                        <option>----</option>
                        <% FOR intI=1 to 31 %>
                        <% if intInput_Day-intI=0 then %>
                          <option selected value=<% =intI %>><% =intI %>일</option>
                        <% else %>
                          <option value=<% =intI %>><% =intI %>일</option>                          
                        <% end if :next %>
                        </select>
                </td>
              </tr>
            </table>
			<!--입력선택 끝-->
          </td>
        </tr>
        <tr> 
          <td height="7" colspan="2"></td>
        </tr>
        <tr> 
          <td colspan="2">
		  <!--입력 테이블 시작--> 
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr bgcolor="#CECFF5"> 
                <td height="7" colspan="2"></td>
              </tr>
              <tr class="list07_bg"> 
                <td width="120">목록</td>
                <td>입력값</td>
              </tr>
              <tr> 
                <td class="list15_bg3">Magicisland</td>
                <td class="table01"> 
                  <input type="text" name="txtMagicisland" size="65" maxlength=70 value=<% IF varview="ok" THEN Response.Write rs("MagicIsland") %>>
                </td>
              </tr>
              <tr> 
                <td class="list15_bg3">Adventure</td>
                <td class="table01"> 
                  <input type="text" name="txtAdventure" size="65" maxlength=70 value=<% IF varview="ok" THEN Response.Write rs("Adventure") %>>
                </td>
              </tr>
              <tr> 
                <td class="list15_bg3">Sports</td>
                <td class="table01"> 
                  <input type="text" name="txtSports" size="65" maxlength=70 value=<% IF varview="ok" THEN Response.Write rs("Sports") %>>
                </td>
              </tr>
              <tr> 
                <td class="list15_bg3">Hotel</td>
                <td class="table01"> 
                  <input type="text" name="txtHotel" size="65" maxlength=70 value=<% IF varview="ok" THEN Response.Write rs("Hotel") %>>
                </td>
              </tr>
              <tr> 
                <td class="list15_bg3">Departmentstore</td>
                <td class="table01"> 
                  <input type="text" name="txtDepartmentstore" size="65" maxlength=70 value=<% IF varview="ok" THEN Response.Write rs("Departmentstore") %>>
                </td>
              </tr>
              <tr> 
                <td class="list15_bg3">Shoppingmall</td>
                <td class="table01"> 
                  <input type="text" name="txtShoppingmall" size="65" maxlength=70 value=<% IF varview="ok" THEN Response.Write rs("Shoppingmall") %>>
                </td>
              </tr>
              <tr> 
                <td class="list15_bg3">Mart</td>
                <td class="table01"> 
                  <input type="text" name="txtMart" size="65" maxlength=70 value=<% IF varview="ok" THEN Response.Write rs("Mart") %>>
                </td>
              </tr>
              <tr> 
                <td class="list15_bg3">Total</td>
                <td class="table01"> 
                  <input type="text" name="txtTotal" size="65" maxlength=70 value=<% IF varview="ok" THEN Response.Write rs("Total") %>>
                </td>
              </tr>
              <tr bgcolor="#CECFF5"> 
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
                <td align="right"><input type=image src="../../electric/images/save.gif" width="53" height="26" border="0"></td>
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
    <td width="49"><img src="../../electric/images/null.gif" width="1" height="1"></td>
    <td bgcolor="#a4a4a4"><img src="../../electric/images/outline.gif" width="1" height="1"></td>
  </tr>
  <tr> 
    <td height="42" colspan="3" align="right" background="../../electric/images/copyright_bg.gif"><img src="../../electric/images/copyright.gif" width="350" height="42"></td>
    <td bgcolor="#a4a4a4" width="1" height="42"><img src="../../electric/images/null.gif" width="1" height="1"></td>
  </tr>
</table>
</form>
</body>
</html>
<!-- #include file="../../electric/script/FnErrorCatch.inc" -->