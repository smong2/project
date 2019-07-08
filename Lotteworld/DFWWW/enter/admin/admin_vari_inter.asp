<!-- #include file="../../enter/script/FnLoginAuth_admin.inc" -->
<%
' ========================================================================================================
' 프로그램ID : Admin_vari_inter
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 모델 변수 입력 - 개입변수 입력
' 최초작성일 : 2002/12/23
' 최종작성일 : 2002/12/23
' 개  발  자 : 박순몽(kweather)
' ======================================================================================================== 

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
dim varInsert,varview'폼 변수
Dim rs '레코드셋 - 모델 목록 가져오기
Dim intI,varType '증감변수
Dim intYear,intMonth,intDay,dtdate '년,월,일
Dim	intDummyIMF,intDummyCard '더미변수들 / IMF,카드사제휴
Dim intduty, intcool, intsaleexist, intvacation '백화점 휴무, 냉방기 가동유무, 세일유무, 방학변수
DIM intInter1, intInter2, varModelCode, varModelType '개입변수1,2, 모델코드, 모델 유형

varType=Request.QueryString("sltType")
varInsert=Request.Form("hidInsert")
dtdate=dateserial(intyear,intmonth,intday)
dtdate=left(weekdayname(weekday(dtdate)),1)

IF varInsert="" AND varType<>"" THEN '모형별 모델 종류 가져오기
ArrQuery=array("Enter","View","월","2002","12","12",varType,"11", "1", "1")

Set objServer = Server.CreateObject("XBInterIMTS.clsXBInterventionINTX")

'컴포넌트 호출
arrRValue = objServer.query(ArrQuery)

'첫번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rs,1

'자원의 해제
Set objServer = Nothing
END IF

IF varInsert="ok"  THEN '폼으로 넘어왔다면..
intYear = Request.Form("sltYear")
intMonth = Request.Form("sltMonth")
intDay=Request.Form("sltDay")
IntInter1 = Request.Form("sltInter1")
IntInter2 = Request.Form("sltInter2")
varModelCode = Request.Form("sltModelCode")
varModelType = Request.Form("hidmodelType")

ArrQuery=array("Enter","Insert",dtdate,intYear,intMonth,intDay, varModelType, varModelCode, IntInter1, IntInter2)

Set objServer = Server.CreateObject("XBInterIMTS.clsXBInterventionITX")

'컴포넌트 호출
arrRValue = objServer.save(ArrQuery)

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
<script language="JavaScript" src="../../enter/script/FnAdminInter.js"></script>
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form method=post name=form action=admin_vari_inter.asp onsubmit='return FnCheck()'>
<input type=hidden name=hidinsert value=ok>
<input type=hidden name=hidmodelType value=<% =varType %>>                  
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
  <tr> 
    <td width="49"><img src="../../enter/images/null.gif" width="49" height="1"></td>
    <td width="642" valign="top"> 
	<!--큰 테이블 시작-->
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="../../enter/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
          <td><img src="../../enter/images/title_vari_inter.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td align="right"> 
            <!--개입변수 조회 시작-->
            <table width="642" border="0" cellspacing="0" cellpadding="0">            
              <tr> 
                <td class="title_01_r"><img src="../../enter/images/vermilion_buret.gif" width="7" height="7"> 
                  개입변수조회: 
                  <select name="sltType" onChange="namosw_goto_byselect(this, 'self')">
					<% IF varType="D" THEN %>
					<option>--</option>
                    <option value=admin_vari_inter.asp?sltType=D selected>일</option>
                    <option value=admin_vari_inter.asp?sltType=M>월</option>
                    <option value=admin_vari_inter.asp?sltType=Y>년</option>
                    <% ELSEIF varType="M" THEN %>
                    <option>--</option>
                    <option value=admin_vari_inter.asp?sltType=D>일</option>
                    <option value=admin_vari_inter.asp?sltType=M selected>월</option>
                    <option value=admin_vari_inter.asp?sltType=Y>년</option>
                    <% ELSEIF varType="Y" THEN %>
                    <option>--</option>
                    <option value=admin_vari_inter.asp?sltType=D>일</option>
                    <option value=admin_vari_inter.asp?sltType=M>월</option>
                    <option value=admin_vari_inter.asp?sltType=Y selected>년</option>
                    <% ELSE %>
                    <option selected>--</option>
                    <option value=admin_vari_inter.asp?sltType=D>일</option>
                    <option value=admin_vari_inter.asp?sltType=M>월</option>
                    <option value=admin_vari_inter.asp?sltType=Y>년</option>
                    <% END IF %>
                  </select>                  
                  <select name="sltModelcode">					
                  <% IF varType<>"" THEN %>                  
					<% DO UNTIL rs.EOF %>					
                    <option value='<% =rs("modelcode") %>'><% =rs("ModelName") %></option>
                    <% rs.MOVENEXT : LOOP %>
                    <% ELSE %>
                    <option> -- </option>  
                  <% END IF %>
                  </select>
                </td>
                <td width="10"></td>
                <td width="53"></td>
              </tr>            
            </table>
            <!--개입변수 조회 끝-->
          </td>
        </tr>
        <tr> 
          <td height="20"></td>
        </tr>
        <tr> 
          <td>
		  <!--개입변수 박스 테두리 시작--> 
            <table border="0" cellspacing="0" cellpadding="0" width="642">
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge1.gif" width="6" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge_top.gif" width="630" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge2.gif" width="6" height="6"></td>
              </tr>
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge_left.gif" width="6" height="80"></td>
                <td class="table03"> 
                  <!--개입변수 입력 시작-->                  
                  <table width="480" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td>
                        <select name="sltYear">
						  <option>--</option>
						<% FOR intI=2002 To 2010 %>
                          <option value=<% =intI %>><% =intI %>년</option>
                        <% NEXT %>
                        </select>
                        <select name="sltMonth">
                          <option>--</option>
						<% FOR intI=1 To 12 %>
                          <option value=<% =intI %>><% =intI %>월</option>
                        <% NEXT %>
                        </select>
                        <select name="sltDay">
                          <option>--</option>
						<% FOR intI=1 To 31 %>
                          <option value=<% =intI %>><% =intI %>일</option>
                        <% NEXT %>
                        </select>
                      </td>
                      <td width="4"></td>
                      <td class="title_01" width="110"><img src="../../enter/images/vermilion_triangle2.gif" width="5" height="9"> 
                        개입변수1 
                        <select name="sltinter1">
                          <option value=0>0</option>
                          <option value=1>1</option>
                        </select>
                      </td>
                      <td class="title_01" width="110"><img src="../../enter/images/vermilion_triangle2.gif" width="5" height="9"> 
                        개입변수2 
                        <select name="sltinter2">
                          <option value=0>0</option>
                          <option value=1>1</option>
                        </select>
                      </td>
                      <td width="53"><input type=image src="../../enter/images/save.gif" width="53" height="26" border="0"></td>
                    </tr>
                  </table>
                  <!--개입변수 입력 끝-->
                </td>
                <td><img src="../../enter/images/gray_round_s_edge_right.gif" width="6" height="80"></td>
              </tr>
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge3.gif" width="6" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge_bottom.gif" width="630" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge4.gif" width="6" height="6"></td>
              </tr>
            </table>
			<!--개입변수 박스 테두리 끝-->
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
</form>
</body>
</html>
<!-- #include file="../../enter/script/FnErrorCatch.inc"-->