<!-- #include file="../../enter/script/FnLoginAuth_admin.inc" -->
<%
' ========================================================================================================
' 프로그램ID : Admin_vari_dayinput
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 모델 변수 입력 - 일입력
' 최초작성일 : 2002/11/26
' 최종작성일 : 2002/11/26
' 개  발  자 : 박순몽(kweather)
' ======================================================================================================== 

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
dim varInsert,varview '폼 변수
Dim intI '증감변수
Dim intYear,intMonth,intDay '년,월,일
Dim	intDummyIMF,intDummyCard '더미변수들 / 자이언트루프,자이로드롭,자이로스윙,IMF,카드사제휴,폭설
Dim intduty, intcool, intsaleexist, intvacation '백화점 휴무, 냉방기 가동유무, 세일유무, 방학변수
Dim rs '레코드셋 조회

varview=Request.QueryString("varview")
varInsert=Request.Form("varInsert")

IF varInsert="ok" THEN '폼으로 넘어왔다면..
intYear = Request.Form("sltYear")
intMonth = Request.Form("sltMonth")
intDay = Request.Form("sltDay")
intDummyIMF = Request.Form("sltIMF")
intDummyCard = Request.Form("sltCard")
intduty=Request.Form("sltduty")
intcool=Request.Form("sltcooler")
intvacation=Request.Form("sltvacation")
intsaleexist=Request.Form("sltsaleexist")

ArrQuery=array("Insert",intYear,intMonth,intDay, intDuty, intCool, intSaleexist, intVacation, intDummyCard, intDummyIMF)

'변수의 설정
Set objServer = Server.CreateObject("XBEnvDayIMTS.clsXBEnvDayITX")

'컴포넌트 호출
arrRValue = objServer.save(ArrQuery)

'자원의 해제
Set objServer = Nothing
END IF

IF varview="ok" THEN '쿼리 스트링으로 넘어왔다면
intYear=Request.QueryString("sltYear")
intMonth=Request.QueryString("sltMonth")
intDay=Request.QueryString("sltDay")

ArrQuery=array("View",intYear,intMonth,intDay)

'변수의 설정
Set objServer = Server.CreateObject("XBEnvDayIMTS.clsXBEnvDayINTX")
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
<script language=javascript src="../../enter/script/FnAdminVariDayI.js"></script>
</head>
<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form method=post name=form action=admin_vari_dayinput.asp onsubmit='return Fncheck()'>
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
            <td colspan="2"><img src="../../enter/images/title_vari_dayinput.gif" width="200" height="21"></td>
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
                    입력유형: 일</td>
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
                  <select name="sltMonth">
							<option>--</option>
					<% FOR intI=1 TO 12 %>						
						<% IF intMonth-intI=0 THEN %>
							<option selected value=<% =intI %>><% =intI %>월</option>
						<% ELSE %>	
							<option value=<% =intI %>><% =intI %>월</option>
						<% END IF %>
                    <% NEXT %>
                  </select>
                  <select name="sltDay" onchange=FnDate()>
							<option>--</option>
					<% FOR intI=1 TO 31 %>						
						<% IF intDay-intI=0 THEN %>
							<option selected value=<% =intI %>><% =intI %>일</option>						
						<% ELSE %>
							<option value=<% =intI %>><% =intI %>일</option>						
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
                  <td class="list13_bg">냉방기 가동유무</td>
                  <td class="list01_bg3"> 
                    <select name="sltCooler">
                    <% IF varView="ok" THEN 
						IF rs("COOL")=1 THEN %>
					  <option value="1" selected>1(가동)</option>
					  <option value="0">0(비가동)</option>
					  <% ELSE %>
					  <option value="1">1(가동)</option>
                      <option value="0" Selected>0(비가동)</option>
                      <% END IF %><% ELSE %>
                      <option value="1" selected>1(가동)</option>
                      <option value="0">0(비가동)</option>                        
                    <% END IF %>                      
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td class="list13_bg">백화점 세일유무</td>
                  <td class="list01_bg3"> 
                    <select name="sltSaleexist">
                    <% IF varView="ok" THEN 
						IF rs("SaleExist")=1 THEN %>
					  <option value="1" selected>1(세일)</option>
					  <option value="0">0(비세일)</option>
					  <% ELSE %>
					  <option value="1">1(세일)</option>
                      <option value="0" Selected>0(비세일)</option>
                      <% END IF %><% ELSE %>
                      <option value="1">1(세일)</option>
                      <option value="0" selected>0(비세일)</option>                        
                    <% END IF %>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td class="list13_bg">백화점 휴무여부</td>
                  <td class="list01_bg3"> 
                    <select name="sltDuty">
                    <% IF varView="ok" THEN 
						IF rs("Duty")=1 THEN %>
					  <option value="1" selected>1(휴무)</option>
					  <option value="0">0(비휴무)</option>
					  <% ELSE %>
					  <option value="1">1(휴무)</option>
                      <option value="0" Selected>0(비휴무)</option>
                      <% END IF %><% ELSE %>
                      <option value="1">1(휴무)</option>
                      <option value="0" selected>0(비휴무)</option>                        
                    <% END IF %>                      
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td class="list15_bg3">방학 여부(2월,7월,8월)</td>
                  <td class="list01_bg3"> 
                    <select name="sltVacation">
                    <% IF varView="ok" THEN 
						IF rs("VACATION")=1 THEN %>
					  <option value="1" selected>1(방학)</option>
					  <option value="0">0(비방학)</option>
					  <% ELSE %>
					  <option value="1">1(방학)</option>
                      <option value="0" Selected>0(비방학)</option>
                      <% END IF %><% ELSE %>
                      <option value="1">1(방학)</option>
                      <option value="0" selected>0(비방학)</option>                        
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
					  <option value="1" selected>제휴(1)</option>
					  <option value="0">제휴아님(0)</option>
					  <% ELSE %>
					  <option value="1">제휴(1)</option>
                      <option value="0" Selected>제휴아님(0)</option>
                      <% END IF %><% ELSE %>
                      <option value="1" selected>제휴(1)</option>
                      <option value="0">제휴아님(0)</option>                        
                    <% END IF %>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td class="list15_bg3">경기침체변수</td>
                  <td class="list01_bg3"> 
                    <select name="sltIMF">
                      <% IF varView="ok" THEN 
						IF rs("DummyIMF")=1 THEN %>
					  <option value="1" selected>영향있음(1)</option>
					  <option value="0">영향없음(0)</option>
					  <% ELSE %>
					  <option value="1">영향있음(1)</option>
                      <option value="0" Selected>영향없음(0)</option>
                      <% END IF %><% ELSE %>
                      <option value="1">영향있음(1)</option>
                      <option value="0" selected>영향없음(0)</option>                        
                    <% END IF %>
                    </select>
                  </td>
                </tr>
                <tr bgcolor="#B0DFFD"> 
                  <td height="7" colspan="2"></td>
                </tr>
              </table>
			<!--변수입력 테이블 끝-->
          </td>
        </tr>
        <tr> 
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