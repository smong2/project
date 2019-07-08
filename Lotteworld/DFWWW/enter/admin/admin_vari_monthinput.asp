<!-- #include file="../../enter/script/FnLoginAuth_admin.inc" -->
<%
' ========================================================================================================
' 프로그램ID : Admin_vari_Monthinput
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 모델 변수 입력 - 월입력
' 최초작성일 : 2002/11/26
' 최종작성일 : 2002/11/26
' 개  발  자 : 박순몽(kweather)
' ======================================================================================================== 

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
dim varInsert, varview '폼 변수
Dim intI '증감변수
Dim intYear,intMonth '년,월
Dim	intDummyGiantRoof,intDummyGyroDrop,intDummyGyroSwing,intDummyIMF,intDummyCard,intSnowFall '더미변수들 / 자이언트루프,자이로드롭,자이로스윙,IMF,카드사제휴,폭설
Dim	lngHOSTS,lngDepartmentDutyMonth,intConstruction '호스트수,백화점휴무일수,공사월지수
Dim	lngKOSPI,lngManufacturingKOSPI,lngFinancialKOSPI,lngDistributionKOSPI, lngRepairIndex 'KOSPI,제조업,금융업,유통업
Dim rs '레코드셋 조회관련

varView=Request.QueryString("varview")
varInsert=Request.Form("varInsert")

IF varInsert="ok" THEN '폼으로 넘어왔다면..
intYear = Request.Form("sltYear")
intMonth = Request.Form("sltMonth")
intDummyGiantRoof = Request.Form("sltGiantRoof")
intDummyGyroDrop = Request.Form("sltGyroDrop")
intDummyGyroSwing = Request.Form("sltGyroSwing")
intDummyIMF = Request.Form("sltIMF")
intDummyCard = Request.Form("sltCard")
intSnowFall = Request.Form("txtSnowFall")
lngHOSTS = Request.Form("txtHOSTS")
lngDepartmentDutyMonth = Request.Form("txtDepartment")
lngRepairIndex=Request.Form("txtRepairIndex")
intConstruction = Request.Form("txtConstruction")
lngKOSPI = Request.Form("txtKOSPI")
lngManufacturingKOSPI = Request.Form("txtManufacturing")
lngFinancialKOSPI = Request.Form("txtFinancial")
lngDistributionKOSPI = Request.Form("txtDistribution")

IF intDummyGiantRoof="" THEN intDummyGiantRoof=11
IF intDummyGyroDrop="" THEN intDummyGyroDrop=11
IF intDummyGyroSwing="" THEN intDummyGyroSwing=11
IF intDummyIMF="" THEN intDummyIMF=11
IF intDummyCard="" THEN intDummyCard=11
IF intSnowFall="" THEN intSnowFall=11
IF lngHOSTS="" THEN lngHOSTS=9999999999.99999
IF lngDepartmentDutyMonth="" THEN lngDepartmentDutyMonth=9999999999.99999
IF lngRepairIndex="" THEN lngRepairIndex=9999999999.99999
IF intConstruction="" THEN intConstruction=9999999999.99999
IF lngKOSPI="" THEN lngKOSPI=9999999999.99999
IF lngManufacturingKOSPI="" THEN lngManufacturingKOSPI=9999999999.99999
IF lngFinancialKOSPI="" THEN lngFinancialKOSPI=9999999999.99999
IF lngDistributionKOSPI="" THEN lngDistributionKOSPI=9999999999.99999

ArrQuery=array("Insert",intYear,intMonth,intDummyGiantRoof,intDummyGyroDrop,intDummyGyroSwing,intDummyIMF,intDummyCard,intSnowFall,lngHOSTS,lngDepartmentDutyMonth,intConstruction,lngKOSPI,lngManufacturingKOSPI,lngFinancialKOSPI,lngDistributionKOSPI,lngRepairIndex)

'변수의 설정
Set objServer = Server.CreateObject("XBEnvMonthIMTS.clsXBEnvMonthITX")

'컴포넌트 호출
arrRValue = objServer.save(ArrQuery)

'자원의 해제
Set objServer = Nothing

varInsert="" '폼 변수 지우고..
END IF

IF varview="ok" THEN '조회시 작동
intYear=Request.QueryString("sltYear")
intMonth=Request.QueryString("sltMonth")

ArrQuery=array("View",intYear,intMonth)

'변수의 설정
Set objServer = Server.CreateObject("XBEnvMonthIMTS.clsXBEnvMonthINTX")
'컴포넌트 호출
	arrRValue = objServer.Query(ArrQuery)

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
<script language=javascript src="../../enter/script/FnAdminvariMonth.js"></script>
</head>
<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload=document.form.txtHosts.focus()>
<form method=post name=form action=admin_vari_monthinput.asp onsubmit='return Fncheck(form)'>
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
          <td colspan="2"><img src="../../enter/images/title_vari_monthinput.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top" colspan="2"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td align="left">
		  <!--입력형태 박스 시작--> 
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
			<!--입력형태 박스 끝-->
          </td>
          <td class="table05">
		  <!--입력일자 시작--> 
            <table width="320" border="0" cellspacing="0" cellpadding="0" class="title_01_r">
              <tr> 
                <td><img src="../../enter/images/yellowgreen_buret.gif" width="7" height="7"> 
                  날짜선택 
                  <select name="sltYear">
						<option>--</option>						
					<% FOR intI=2000 TO 2030 %>						
						<% IF intYear-intI=0 THEN %>
						<option selected value=<% =intI %>><% =intI %>년</option>
						<% ELSE %>
						<option value=<% =intI %>><% =intI %>년</option>
						<% END IF %>
					<% NEXT %>
                  </select>
                  <select name="sltMonth" onchange=FnDate()>
						<option>--</option>
					<% FOR intI=1 TO 12 %>
						<% IF intMonth-intI=0 THEN %>						
						<option selected value=<% =intI %>><% =intI %>월</option>
						<% ELSE %>
						<option value=<% =intI %>><% =intI %>월</option>
						<% END IF %>
                    <% NEXT %>
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
		  <!--변수입력 테이블 시작--> 
              <table width="642" border="0" cellspacing="1" cellpadding="7">
                <tr bgcolor="#B0DFFD"> 
                  <td height="7" colspan="2"></td>
                </tr>
                <tr class="list02_bg2"> 
                  <td width="300">항목</td>
                  <td>입력</td>
                </tr>
                <tr> 
                  <td class="list13_bg">자이언트루프 영업유무</td>
                  <td class="list01_bg3"> 
                    <select name="sltGiantRoof">
                    <% IF varView="ok" THEN 
						IF rs("DummyGiantRoof")=1 THEN %>
					  <option value="1" selected>1(영향있음)</option>
					  <option value="0">0(영향없음)</option>
					  <% ELSE %>
					  <option value="1">1(영향있음)</option>
                      <option value="0" Selected>0(영향없음)</option>
                      <% END IF %><% ELSE %>
                      <option value="1" selected>1(영향있음)</option>
                      <option value="0">0(영향없음)</option>                        
                    <% END IF %>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td class="list13_bg">자이로드롭 영업유무</td>
                  <td class="list01_bg3"> 
                    <select name="sltGyroDrop">
                      <% IF varView="ok" THEN 
						IF rs("DummyGyroDrop")=1 THEN %>
					  <option value="1" selected>1(영향있음)</option>
					  <option value="0">0(영향없음)</option>
					  <% ELSE %>
					  <option value="1">1(영향있음)</option>
                      <option value="0" Selected>0(영향없음)</option>
                      <% END IF %><% ELSE %>
                      <option value="1" selected>1(영향있음)</option>
                      <option value="0">0(영향없음)</option>                        
                    <% END IF %>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td class="list13_bg">자이로스윙 영업유무</td>
                  <td class="list01_bg3"> 
                    <select name="sltGyroSwing">
                      <% IF varView="ok" THEN 
						IF rs("DummyGyroSwing")=1 THEN %>
					  <option value="1" selected>1(영향있음)</option>
					  <option value="0">0(영향없음)</option>
					  <% ELSE %>
					  <option value="1">1(영향있음)</option>
                      <option value="0" Selected>0(영향없음)</option>
                      <% END IF %><% ELSE %>
                      <option value="1" selected>1(영향있음)</option>
                      <option value="0">0(영향없음)</option>                        
                    <% END IF %>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td class="list15_bg3">경기침체여부</td>
                  <td class="list01_bg3"> 
                    <select name="sltIMF">
                      <% IF varView="ok" THEN 
                         IF rs("DummyIMF")=0 THEN %>
					  <option value="1">1(영향있음)</option>
                      <option value="0" Selected>0(영향없음)</option>
					  <% ELSE %>
					  <option value="1" selected>1(영향있음)</option>
					  <option value="0">0(영향없음)</option>					  
                      <% END IF %><% ELSE %>
                      <option value="1">1(영향있음)</option>
                      <option value="0" selected>0(영향없음)</option>                        
                    <% END IF %>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td class="list13_bg">카드사 제휴여부</td>
                  <td class="list01_bg3"> 
                    <select name="sltCard">
                      <% IF varView="ok" THEN 
						 IF rs("DummyCard")=1 THEN %>
					  <option value="1" selected>1(영향있음)</option>
					  <option value="0">0(영향없음)</option>
					  <% ELSEIF rs("DummyCard")=0 THEN %>
					  <option value="1">1(영향있음)</option>
                      <option value="0" Selected>0(영향없음)</option>
                      <% END IF %><% ELSE %>
                      <option value="1" selected>1(영향있음)</option>
                      <option value="0">0(영향없음)</option>                        
                    <% END IF %>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td class="list15_bg3">인터넷 호스트지수(당해년수/93년수)</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtHosts" size="20" maxlength="20" value=<% IF varview="ok" THEN Response.Write rs("hosts") %>>
                  </td>
                </tr>
                <tr> 
                  <td class="list15_bg3">폭설일수(신적설10cm이상)</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtSnowfall" size="20" maxlength="20" value=<% IF varview="ok" THEN Response.Write rs("snowfall") %>>
                    회/월</td>
                </tr>
                <tr> 
                  <td class="list13_bg">백화점 휴무일수</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtDepartment" size="20" maxlength="20" value=<% IF varview="ok" THEN Response.Write rs("departmentdutymonth") %>>
                    회/월</td>
                </tr>
                <tr> 
                  <td class="list13_bg">월별 공사지수</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtRepairIndex" size="20" maxlength="20" value=<% IF varview="ok" THEN Response.Write rs("repairMonthlyIndex") %>>
                    포인트</td>
                </tr>
                <tr> 
                  <td class="list13_bg">주가지수 월평균</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtKOSPI" size="20" maxlength="20" value=<% IF varview="ok" THEN Response.Write rs("KOSPI") %>>
                    포인트</td>
                </tr>
                <tr> 
                  <td class="list13_bg">제조업 주가지수 월평균</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtManufacturing" size="20" maxlength="20" value=<% IF varview="ok" THEN Response.Write rs("manufacturingKOSPI") %>>
                    포인트</td>
                </tr>
                <tr> 
                  <td class="list13_bg">금융업 주가지수 월평균</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtFinancial" size="20" maxlength="20" value=<% IF varview="ok" THEN Response.Write rs("FinancialKOSPI") %>>
                    포인트</td>
                </tr>
                <tr> 
                  <td class="list13_bg">유통업 주가지수 월평균</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtDistribution" size="20" maxlength="20" value=<% IF varview="ok" THEN Response.Write rs("DistributionKOSPI") %>>
                    포인트 </td>
                </tr>
                <tr> 
                  <td class="list13_bg">건설업 주가지수 월평균</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtConstruction" size="20" maxlength="20" value=<% IF varview="ok" THEN Response.Write rs("ConstructionKOSPI") %>>
                    포인트 </td>
                </tr>
                <tr bgcolor="#B0DFFD"> 
                  <td height="7" colspan="2"></td>
                </tr>
              </table>
			<!--변수입력 테이블 끝-->
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
                <td align="right"><input type=image src="../../enter/images/save.gif" width="53" height="26" border="0"></td>
                <td width="5"></td>
              </tr>
            </table>
			<!--하단 버튼 바 테이블 끝-->
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
<!-- #include file="../../electric/script/FnErrorCatch.inc" -->