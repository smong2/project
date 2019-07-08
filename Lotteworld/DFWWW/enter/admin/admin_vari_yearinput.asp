<!-- #include file="../../enter/script/FnLoginAuth_admin.inc" -->
<%
' ========================================================================================================
' 프로그램ID : Admin_vari_Yearinput
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 모델 변수 입력 - 년입력
' 최초작성일 : 2002/11/26
' 최종작성일 : 2002/11/26
' 개  발  자 : 박순몽(kweather)
' ======================================================================================================== 

'변수의 선언
Dim objServer, arrRValue, ArrQuery,Arr '컴관련 변수들
dim varInsert, varView '폼 변수
Dim intI '증감변수
Dim intYear '년
Dim lngPopNationalAdult,lngPopSeoulSchool,lngPopSeoulChild,PopMetropolisAdult '사용자 입력값
Dim	lngKOSPI,intDummyCard,intDummyIMF,intDummyGyroDrop,intDummyHOSTS
Dim lngManufacturingKOSPI,lngFinancialKOSPI,lngConstructionKOSPI,lngDistributionKOSPI,lngGNI
Dim rs '레코드셋 조회관련

varview=Request.QueryString("varview")
varInsert=Request.Form("varInsert") '폼변수

IF varInsert="ok" THEN '폼으로 넘어왔다면..
intYear = Request.Form("sltYear")  '년도
lngPopNationalAdult= Request.Form("txtPopNationalAdult") '전국 성인인구
lngPopSeoulSchool= Request.Form("txtPopSeoulSchool") '서울 중고생 인구
lngPopSeoulChild= Request.Form("txtPopSeoulChild") '서울 어린이 인구
PopMetropolisAdult= Request.Form("txtPopMetropolis") '수도권 성인 인구
lngKOSPI= Request.Form("txtKOSPI") 'KOSPI지수
intDummyCard= Request.Form("sltDummyCard") '카드사 제휴여부
intDummyIMF= Request.Form("sltDummyIMF") 'IMF 여부
intDummyGyroDrop= Request.Form("sltDummyGyroDrop") '자이로 드롭
intDummyHOSTS= Request.Form("txtHOSTS") '호스트수
lngManufacturingKOSPI= Request.Form("txtManufacturing") '제조업
lngFinancialKOSPI= Request.Form("txtFinancial") '금융업
lngConstructionKOSPI= Request.Form("txtConstruction") '건설업
lngDistributionKOSPI= Request.Form("txtDistribution") '유통업
lngGNI= Request.Form("txtGNI") '명목 GNI

IF lngPopNationalAdult ="" THEN lngPopNationalAdult=9999999999.99999
IF lngPopSeoulSchool ="" THEN lngPopSeoulSchool=9999999999.99999
IF lngPopSeoulChild ="" THEN lngPopSeoulChild=9999999999.99999
IF PopMetropolisAdult ="" THEN PopMetropolisAdult=9999999999.99999
IF lngKOSPI ="" THEN lngKOSPI=9999999999.99999
IF intDummyCard ="" THEN intDummyCard=11
IF intDummyIMF ="" THEN intDummyIMF=11
IF intDummyGyroDrop ="" THEN intDummyGyroDrop=11
IF intDummyHOSTS ="" THEN intDummyHOSTS=11
IF lngManufacturingKOSPI ="" THEN lngManufacturingKOSPI=9999999999.99999
IF lngFinancialKOSPI ="" THEN lngFinancialKOSPI=9999999999.99999
IF lngConstructionKOSPI ="" THEN lngConstructionKOSPI=9999999999.99999
IF lngDistributionKOSPI ="" THEN lngDistributionKOSPI=9999999999.99999
IF lngGNI ="" THEN lngGNI=9999999999.99999

ArrQuery=array("Insert",intYear,lngPopNationalAdult,lngPopSeoulSchool,lngPopSeoulChild,PopMetropolisAdult,lngKOSPI,intDummyCard,intDummyIMF,intDummyGyroDrop,intDummyHOSTS,lngManufacturingKOSPI,lngFinancialKOSPI,lngConstructionKOSPI,lngDistributionKOSPI,lngGNI)

'변수의 설정
Set objServer = Server.CreateObject("XBEnvYearIMTS.clsXBEnvYearITX")  '입력 쿼리

'컴포넌트 호출
arrRValue = objServer.save(ArrQuery)

'자원의 해제
Set objServer = Nothing

varInsert="" '폼 변수 지우고..
END IF

IF varview="ok" THEN '조회시
	intYear=Request.QueryString("sltYear")

	ArrQuery=array("View",intYear)

	'변수의 설정
	Set objServer = Server.CreateObject("XBEnvYearIMTS.clsXBEnvYearINTX")  '입력 쿼리

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
<script language='javascript' src=../../enter/script/Fnadmin_vari_yearinput.js></script>
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload=document.form.txtPopNationalAdult.focus()>
<form method=post name=form action=admin_vari_yearinput.asp onsubmit='return Fncheck(this.form)'>
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
          <td colspan="2"><img src="../../enter/images/title_vari_yearinput.gif" width="200" height="21"></td>
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
                <td class="title_01_c"><img src="../images/yellowgreen_buret.gif" width="7" height="7"> 
                  입력유형: 년</td>
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
                  년도선택 
                  <select name="sltyear" onchange=FnDate()>
						<option>--</option>
                  <% For intI=1995 To 2030 
					IF intYear-intI=0 THEN %>
						<option selected value=<% =intI %>><% =intI %>년</option>
					<% ELSE %>
					    <option value=<% =intI %>><% =intI %>년</option>					
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
                  <td class="list15_bg3">전국 성인추계인구 (20~39세)</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtPopNationalAdult" size="20" maxlength="20" value=<% IF varView="ok" THEN Response.Write rs("PopNationalAdult") %>> 명</td>
                </tr>
                <tr> 
                  <td class="list15_bg3">수도권(서울,인천,경기) 성인추계인구 (20~39세)</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtPopMetropolis" size="20" maxlength="20" value=<% IF varView="ok" THEN Response.Write rs("PopMetroPolisAdult") %>> 명</td>
                </tr>
                <tr> 
                  <td class="list15_bg3">서울 중고생추계인구 (15~19세)</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtPopSeoulSchool" size="20" maxlength="20" value=<% IF varView="ok" THEN Response.Write rs("PopSeoulSchool") %>> 명</td>
                    
                </tr>
                <tr> 
                  <td class="list15_bg3">서울 어린이추계인구 (10~14세)</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtPopSeoulChild" size="20" maxlength="20" value=<% IF varView="ok" THEN Response.Write rs("PopSeoulChild") %>> 명</td>                    
                </tr>
                <tr> 
                  <td class="list13_bg">카드사 제휴여부</td>
                  <td class="list01_bg3"> 
                    <select name="sltDummyCard">
                    <% IF varView="ok" THEN 
						IF rs("DummyCard")=1 THEN %>
					  <option value="1" selected>1(영향있음)</option>
					  <option value="0">0(영향없음)</option>
					  <% ELSE %>
					  <option value="1">1(영향있음)</option>
                      <option value="0" Selected>0(영향없음)</option>
                      <% END IF %>                      
                    <% ELSE %>
                      <option value="1" selected>1(영향있음)</option>
                      <option value="0">0(영향없음)</option>                        
                    <% END IF %>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td class="list15_bg3">경기침체여부</td>
                  <td class="list01_bg3"> 
                    <select name="sltDummyIMF">
                    <% IF varView="ok" THEN 
						IF rs("DummyIMF")=0 THEN %>
					  <option value="1">1(영향있음)</option>
                      <option value="0" Selected>0(영향없음)</option>						  
					  <% ELSE %>
					  <option value="1" selected>1(영향있음)</option>
					  <option value="0">0(영향없음)</option>
                      <% END IF %>                      
                    <% ELSE %>
                      <option value="1">1(영향있음)</option>
                      <option value="0" selected>0(영향없음)</option>                        
                    <% END IF %>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td class="list13_bg">자이로드롭 영업여부</td>
                  <td class="list01_bg3"> 
                    <select name="sltDummyGyroDrop">
                    <% IF varView="ok" THEN 
						IF rs("DummyGyroDrop")=1 THEN %>
					  <option value="1" selected>1(영향있음)</option>
					  <option value="0">0(영향없음)</option>
					  <% ELSE %>
					  <option value="1">1(영향있음)</option>
                      <option value="0" Selected>0(영향없음)</option>
                      <% END IF %>                      
                    <% ELSE %>
                      <option value="1" selected>1(영향있음)</option>
                      <option value="0">0(영향없음)</option>                        
                    <% END IF %>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td class="list15_bg3">인터넷 호스트지수(당해년수/93년수)</td>
                  <td class="list01_bg3"> 
                    <input type="txt" name="txtHOSTS" size="20" maxlength="20" value=<% IF varView="ok" THEN Response.Write rs("Hosts") %>>
                  </td>
                </tr>
                <tr> 
                  <td class="list13_bg">주가지수 년평균</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtKOSPI" size="20" maxlength="20" value=<% IF varView="ok" THEN Response.Write rs("Kospi") %>> 포인트</td>                   
                </tr>
                <tr> 
                  <td class="list13_bg">제조업 주가지수 년평균</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtManufacturing" size="20" maxlength="20" value=<% IF varView="ok" THEN Response.Write rs("ManufacturingKOSPI") %>> 포인트</td>                    
                </tr>
                <tr> 
                  <td class="list13_bg">금융업 주가지수 년평균</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtFinancial" size="20" maxlength="20" value=<% IF varView="ok" THEN Response.Write rs("FinancialKOSPI") %>> 포인트</td>                    
                </tr>
                <tr> 
                  <td class="list13_bg">유통업 주가지수 년평균</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtDistribution" size="20" maxlength="20" value=<% IF varView="ok" THEN Response.Write rs("DistributionKOSPI") %>> 포인트</td>                    
                </tr>
                <tr> 
                  <td class="list13_bg">건설업 주가지수 년평균</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtConstruction" size="20" maxlength="20" value=<% IF varView="ok" THEN Response.Write rs("ConstructionKOSPI") %>> 포인트</td>                    
                </tr>
                <tr> 
                  <td class="list15_bg3">명목 국민총생산(GNI,단위10억원)</td>
                  <td class="list01_bg3"> 
                    <input type="text" name="txtGNI" size="20" maxlength="20" value=<% IF varView="ok" THEN Response.Write rs("GNI") %>> 10억원</td>                    
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
<!-- #include file="../../enter/script/FnErrorCatch.inc" -->