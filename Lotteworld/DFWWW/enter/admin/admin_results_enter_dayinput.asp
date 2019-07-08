<!-- #include file="../../enter/script/FnLoginAuth_admin.inc" -->
<%
' ========================================================================================================
' 프로그램ID : TXT Ticket dayinput
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 입장객 일 실적입력
' 최초작성일 : 2002/11/07
' 최종작성일 : 2002/11/21
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim intI,hidInsert,varview '증감변수, 폼 변수
Dim lngtotal_a,lngtotal_s,lngtotal_c, lngtotal_d '전체 -어른,중고생,어린이(이 아래는 생략),실입장 전체  입력 
Dim lngindiv_a,lngindiv_s,lngindiv_c '개인 입력
Dim lnggroup_a,lnggroup_s,lnggroup_c '단체 입력
Dim lngspecial_a,lngspecial_s,lngspecial_c '특판 입력
Dim lngfree_a,lngfree_s,lngfree_c '초대권 입력
dim lngeducinst_a,lngeducinst_s,lngeducinst_c '학원연합회 입력
Dim lngdutyfree_a,lngdutyfree_s,lngdutyfree_c '면세점 입력
dim lngcompany_a,lngcompany_s,lngcompany_c '기업체 특판 입력
Dim lngmycustomer_a,lngmycustomer_s,lngmycustomer_c '나의 손님 모시기 입력
Dim lngetc_a,lngetc_s,lngetc_c '기타 입력
Dim intinput_year,intinput_month,intinput_day,dtxdate '년,월,일,날짜생성
Dim queryinput_year,queryinput_month,queryinput_day '년,월,일,날짜생성 쿼리스트링 값
DIM rsa,rss,rsc,rse '레코드셋 : 어른, 중고생, 어린이, 실입장 자료

varview=Request.QueryString("varview")
hidInsert=Request.Form("hidInsert")
lngtotal_a=Request.Form("txttotal_a")
lngtotal_s=Request.Form("txttotal_s")
lngtotal_c=Request.Form("txttotal_c")
lngtotal_d=Request.Form("txttotal_d")
lngindiv_a=Request.Form("txtindiv_a")
lngindiv_s=Request.Form("txtindiv_s")
lngindiv_c=Request.Form("txtindiv_c")
lnggroup_a=Request.Form("txtgroup_a")
lnggroup_s=Request.Form("txtgroup_s")
lnggroup_c=Request.Form("txtgroup_c")
lngspecial_a=Request.Form("txtspecial_a")
lngspecial_s=Request.Form("txtspecial_s")
lngspecial_c=Request.Form("txtspecial_c")
lngfree_a=Request.Form("txtfree_a")
lngfree_s=Request.Form("txtfree_s")
lngfree_c=Request.Form("txtfree_c")
lngeducinst_a=Request.Form("txteducinst_a")
lngeducinst_s=Request.Form("txteducinst_s")
lngeducinst_c=Request.Form("txteducinst_c")
lngdutyfree_a=Request.Form("txtdutyfree_a")
lngdutyfree_s=Request.Form("txtdutyfree_s")
lngdutyfree_c=Request.Form("txtdutyfree_c")
lngcompany_a=Request.Form("txtcompany_a")
lngcompany_s=Request.Form("txtcompany_s")
lngcompany_c=Request.Form("txtcompany_c")
lngmycustomer_a=Request.Form("txtmycustomer_a")
lngmycustomer_s=Request.Form("txtmycustomer_s")
lngmycustomer_c=Request.Form("txtmycustomer_c")
lngetc_a=Request.Form("txtetc_a")
lngetc_s=Request.Form("txtetc_s")
lngetc_c=Request.Form("txtetc_c")
intinput_year=Request.Form("sltinput_year")
intinput_month=Request.Form("sltinput_month")
intinput_day=Request.Form("sltinput_day")
queryinput_year=Request.QueryString("sltyear")
queryinput_month=Request.QueryString("sltmonth")
queryinput_day=Request.QueryString("sltday")
dtxdate=dateserial(intinput_year,intinput_month,intinput_day)

IF hidInsert="ok" then
	ArrQuery = array("Insert",dtxdate,lngtotal_a,lngindiv_a,lnggroup_a,lngspecial_a,lngfree_a,lngeducinst_a,lngdutyfree_a,lngcompany_a,lngmycustomer_a,lngetc_a,lngtotal_s,lngindiv_s,lnggroup_s,lngspecial_s,lngfree_s,lngeducinst_s,lngdutyfree_s,lngcompany_s,lngmycustomer_s,lngetc_s,lngtotal_c,lngindiv_c,lnggroup_c,lngspecial_c,lngfree_c,lngeducinst_c,lngdutyfree_c,lngcompany_c,lngmycustomer_c,lngetc_c,lngtotal_d)

	'변수의 설정
	Set objServer = Server.CreateObject("XTEnterDayIMTS.clsXTEnterDayITX")

	'컴포넌트 호출
	arrRValue = objServer.Save(ArrQuery)
	'자원의 해제
	Set objServer = Nothing

	hidInsert=""
END IF

IF varView="ok" THEN 
	dtxdate=dateserial(queryinput_year,queryinput_month,queryinput_day)
	ArrQuery = array("View",dtxdate,"0","0","0","0","0","0","0","0","0","0")
	'변수의 설정
	Set objServer = Server.CreateObject("XTEnterDayIMTS.clsXTEnterDayINTX")
	'컴포넌트 호출
	arrRValue = objServer.Query(ArrQuery)
	'레코드셋 어레이를 단일 레코드셋으로 분리
	
	'첫번째 레코드셋을 어레이로 변환
	FnSplitRSArray arrRValue,rsa,1
	'두번째 레코드셋을 어레이로 변환
	FnSplitRSArray arrRValue,rss,2
	'세번째 레코드셋을 어레이로 변환	
	FnSplitRSArray arrRValue,rsc,3
	'네번째 레코드셋을 어레이로 변환
	FnSplitRSArray arrRValue,rse,4
	
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
<script language="javascript"  src="../../enter/script/fnTDayInput.js"></script>
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload=document.form.txttotal_a.focus()>
<form method=post name=form action=admin_results_enter_dayinput.asp>
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
            <td align="left" colspan="2"><img src="../../enter/images/title_enter_input.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top" colspan="2"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--입력유형:일 타이틀 박스 시작--> 
            <table border="0" cellspacing="0" cellpadding="0" width="142">
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge1.gif" width="6" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge_top.gif" width="130" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge2.gif" width="6" height="6"></td>
              </tr>
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge_left.gif" width="6" height="20"></td>
                <td class="title_01_c"><img src="../../enter/images/yellowgreen_buret.gif" width="7" height="7"> 
                  입력유형: 일 </td>
                <td><img src="../../enter/images/gray_round_s_edge_right.gif" width="6" height="20"></td>
              </tr>
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge3.gif" width="6" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge_bottom.gif" width="130" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge4.gif" width="6" height="6"></td>
              </tr>
            </table>
			<!--입력유형:일 타이틀 박스 끝-->
          </td>
          <td class="table05">
		  <!--입력일자 테이블 시작--> 
            <table width="320" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td class="title_01_r"><img src="../../enter/images/yellowgreen_buret.gif" width="7" height="7"> 
                  입력일자
				  <select name="sltInput_Year">				  
				  <option>------</option>
                  <% FOR intI=2000 TO 2030
						IF queryinput_year-intI=0 THEN
							Response.Write "<option selected value=" & intI & ">" & intI & "년</option>"
						ELSE
							Response.Write "<option value=" & intI & ">" & intI & "년</option>"                    
						END IF
					NEXT %>					
                  </select>                  
                  <select name="sltInput_Month">
                  <option>----</option>
				  <% FOR intI=1 to 12 
						IF queryinput_month-intI=0 THEN
							Response.Write "<option selected value=" & intI & ">" & intI & "월</option>"
						ELSE
							Response.Write "<option value=" & intI & ">" & intI & "월</option>"                    
						END IF
					NEXT %>				
                  </select>              
                  <select name="sltInput_Day" onchange=FnDate()>
                  <option>----</option>
				  <% FOR intI=1 TO 31 
						IF queryinput_day-intI=0 THEN
							Response.Write "<option selected value=" & intI & ">" & intI & "일</option>"
						ELSE
							Response.Write "<option value=" & intI & ">" & intI & "일</option>"                    
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
		  <!--매표입장객 일입력 테이블 시작--> 
              <table width="642" border="0" cellspacing="1" cellpadding="7">
                <tr> 
                  <td colspan="4" class="list02_bg4">매표입장객</td>
                </tr>
                <tr class="list02_bg2"> 
                  <td>항목</td>
                  <td>어른</td>
                  <td>중고생</td>
                  <td>어린이</td>
                </tr>
                <tr> 
                  <td class="list13_bg">전체</td>
                  <td class="table04"> 
                    <input type="text" name="txttotal_a" size="10" maxlength=20 value=<% IF varview="ok" THEN Response.Write rsa("total") %>>
                  </td>
                  <td class="table04"> 
                    <input type="text" name="txttotal_s" size="10" maxlength=20 value=<% IF varview="ok"  THEN Response.Write rss("total") %>>
                  </td>
                  <td class="table04"> 
                    <input type="text" name="txttotal_c" size="10" maxlength=20 value=<% IF varview="ok" THEN Response.Write rsc("total") %>>
                  </td>
                </tr>
                <tr> 
                  <td class="list13_bg">개인</td>
                  <td class="table04"> 
                    <input type="text" name="txtIndiv_a" size="10" maxlength=20 value=<% IF varview="ok" THEN Response.Write rsa("indiv") %>>
                  </td>
                  <td class="table04"> 
                    <input type="text" name="txtIndiv_s" size="10" maxlength=20 value=<% IF varview="ok" THEN Response.Write rss("indiv") %>>
                  </td>
                  <td class="table04"> 
                    <input type="text" name="txtIndiv_c" size="10" maxlength=20 value=<% IF varview="ok" THEN Response.Write rsc("indiv") %>>
                  </td>
                </tr>
                <tr> 
                  <td class="list13_bg">단체</td>
                  <td class="table04"> 
                    <input type="text" name="txtGroup_a" size="10" maxlength=20 value=<% IF varview="ok" THEN Response.Write rsa("org") %>>
                  </td>
                  <td class="table04"> 
                    <input type="text" name="txtGroup_s" size="10" maxlength=20 value=<% IF varview="ok" THEN Response.Write rss("org") %>>
                  </td>
                  <td class="table04"> 
                    <input type="text" name="txtGroup_c" size="10" maxlength=20 value=<% IF varview="ok" THEN Response.Write rsc("org") %>>
                  </td>
                </tr>
                <tr> 
                  <td class="list13_bg">특판</td>
                  <td class="table04"> 
                    <input type="text" name="txtSpecial_a" size="10" maxlength=20 value=<% IF varview="ok" THEN Response.Write rsa("special") %>>
                  </td>
                  <td class="table04"> 
                    <input type="text" name="txtSpecial_s" size="10" maxlength=20 value=<% IF varview="ok" THEN Response.Write rss("special") %>>
                  </td>
                  <td class="table04"> 
                    <input type="text" name="txtSpecial_c" size="10" maxlength=20 value=<% IF varview="ok" THEN Response.Write rsc("special") %>>
                  </td>
                </tr>
                <tr> 
                  <td class="list13_bg">초대권</td>
                  <td class="table04"> 
                    <input type="text" name="txtFree_a" size="10" maxlength=20  value=<% IF varview="ok" THEN Response.Write rsa("free") %>>
                  </td>
                  <td class="table04"> 
                    <input type="text" name="txtFree_s" size="10" maxlength=20 value=<% IF varview="ok" THEN Response.Write rss("free") %>>
                  </td>
                  <td class="table04"> 
                    <input type="text" name="txtFree_c" size="10" maxlength=20 value=<% IF varview="ok" THEN Response.Write rsc("free") %>>
                  </td>
                </tr>
                <tr> 
                  <td class="list13_bg">학원연합회</td>
                  <td class="table04"> 
                    <input type="text" name="txtEducinst_a" size="10" maxlength=20 value=<% IF varview="ok" THEN Response.Write rsa("educinst") %>>
                  </td>
                  <td class="table04"> 
                    <input type="text" name="txtEducinst_s" size="10" maxlength=20 value=<% IF varview="ok" THEN Response.Write rss("educinst") %>>
                  </td>
                  <td class="table04"> 
                    <input type="text" name="txtEducinst_c" size="10" maxlength=20 value=<% IF varview="ok" THEN Response.Write rsc("educinst") %>>
                  </td>
                </tr>
                <tr> 
                  <td class="list13_bg">해외단체</td>
                  <td class="table04"> 
                    <input type="text" name="txtDutyfree_a" size="10" maxlength=20 value=<% IF varview="ok" THEN Response.Write rsa("dutyfree") %>>
                  </td>
                  <td class="table04"> 
                    <input type="text" name="txtDutyfree_s" size="10" maxlength=20 value=<% IF varview="ok" THEN Response.Write rss("dutyfree") %>>
                  </td>
                  <td class="table04"> 
                    <input type="text" name="txtDutyfree_c" size="10" maxlength=20 value=<% IF varview="ok" THEN Response.Write rsc("dutyfree") %>>
                  </td>
                </tr>
                <tr> 
                  <td class="list13_bg">기업체특판</td>
                  <td class="table04"> 
                    <input type="text" name="txtCompany_a" size="10" maxlength=20 value=<% IF varview="ok" THEN Response.Write rsa("company") %>>
                  </td>
                  <td class="table04"> 
                    <input type="text" name="txtCompany_s" size="10" maxlength=20 value=<% IF varview="ok" THEN Response.Write rss("company") %>>
                  </td>
                  <td class="table04"> 
                    <input type="text" name="txtCompany_c" size="10" maxlength=20 value=<% IF varview="ok" THEN Response.Write rsc("company") %>>
                  </td>
                </tr>
                <tr> 
                  <td class="list13_bg">나의손님모시기</td>
                  <td class="table04"> 
                    <input type="text" name="txtMycustomer_a" size="10" maxlength=20 value=<% IF varview="ok" THEN Response.Write rsa("mycustomer") %>>
                  </td>
                  <td class="table04"> 
                    <input type="text" name="txtMycustomer_s" size="10" maxlength=20 value=<% IF varview="ok" THEN Response.Write rss("mycustomer") %>>
                  </td>
                  <td class="table04"> 
                    <input type="text" name="txtMycustomer_c" size="10" maxlength=20 value=<% IF varview="ok" THEN Response.Write rsc("mycustomer") %>>
                  </td>
                </tr>
                <tr> 
                  <td class="list13_bg">기타</td>
                  <td class="table04"> 
                    <input type="text" name="txtEtc_a" size="10" maxlength=20 value=<% IF varview="ok" THEN Response.Write rsa("etc") %>>
                  </td>
                  <td class="table04"> 
                    <input type="text" name="txtEtc_s" size="10" maxlength=20 value=<% IF varview="ok" THEN Response.Write rss("etc") %>>
                  </td>
                  <td class="table04"> 
                    <div align="center"> 
                      <input type="text" name="txtEtc_c" size="10" maxlength=20 value=<% IF varview="ok" THEN Response.Write rsc("etc") %>>
                    </div>
                  </td>
                </tr>
                <tr align="center"> 
                  <td colspan="4"><img src="../../enter/images/point_line3.gif" width="628" height="1"></td>
                </tr>
                <tr> 
                  <td colspan="4" class="list02_bg4">실입장객</td>
                </tr>
                <tr> 
                  <td class="list13_bg">전체</td>
                  <td class="table04" colspan="3">
                    <input type="text" name=txttotal_d size="61" value=<% IF varview="ok" THEN Response.Write rse("total") %>>
                  </td>
                </tr>
                <tr bgcolor="#B0DFFD"> 
                  <td height="7" colspan="4"></td>
                </tr>
              </table>
			<!--매표입장객 일입력 테이블 끝-->
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
                <td align="right"><input type=image src="../../enter/images/save.gif" width="53" height="26" border="0" onclick='return Fn_check()'></td>
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
<!-- #include file="../../enter/script/FnErrorCatch.inc"-->  