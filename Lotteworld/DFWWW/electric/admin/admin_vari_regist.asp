<!-- #include file="../../electric/script/FnLoginAuth_Admin.inc" -->
<%
' ========================================================================================================
' 프로그램ID : User List
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 사용자 계정 리스트 보기
' 최초작성일 : 2002/12/09
' 최종작성일 : 2002/12/09
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

Dim objServer, arrRValue, ArrQuery, Arr, ArrQueryU  '컴관련 변수들
Dim rs '레코드셋 :모형 종류 가져오기
Dim Intstartyear, intstartmonth,intstartday,intendyear,intendmonth,intendday, dtstartdate, dtenddate
Dim varmodel, varmodelname,vardatenum, varinsert,varterm,varoverlap,varfinal
dim intI '증가변수
DIM dtsumdate  '최종 데이터 입력을 위해 텍스트 박스에 뿌려지는 값
Dim intinsertyear, intinsertmonth, intinsertday, intinsertdata

varoverlap=Request.Form("varoverlap")
varinsert=Request.Form("varinsert")
intStartYear=Request.Form("sltstartYear")
intStartMonth=Request.Form("sltstartmonth")
intStartDay=Request.Form("sltstartday")
intEndYear=Request.Form("sltEndYear")
intEndMonth=Request.Form("sltEndmonth")
intEndDay=Request.Form("sltEndday")
dtstartdate=dateserial(intstartyear,intstartmonth,intstartday)
dtenddate=dateserial(intendyear,intendmonth,intendday)
varModel=Request.Form("sltModel")
varModelName=Request.Form("txtmodelname")
varterm = Request.Form("varterm")

IF varModel="M" THEN '월모델일때
varDateNum=datediff("M",dtstartdate,dtenddate)
varDateNum=vardateNum+1
END IF
IF varModel="D" THEN '일모델일때
varDateNum=datediff("D",dtstartdate,dtenddate)
varDateNum=vardateNum+1
END IF


IF varoverlap="ok" THEN   '변수 중복 확인
	ArrQuery = array("Electric","check",varModel,varModelName) '쿼리 변수

	'변수의 설정
	Set objServer = Server.CreateObject("XBEnvRegistIMTS.clsXBEnvRegistINTX")

	'컴포넌트 호출
	arrRValue = objServer.Query(ArrQuery)
	'레코드셋 어레이를 단일 레코드셋으로 분리

	'첫번째 레코드셋을 어레이로 변환
	FnSplitRSArray arrRValue,rs,1

	'자원의 해제
	Set objServer = Nothing

	IF rs("ADDVAR")<>0	 THEN
		Response.Write "<script language='javascript'>alert('중복변수가 있습니다. 다른 변수로 입력해주십시오')</script>"
	ELSE
		Response.Write "<script language='javascript'>alert('이 변수를 사용해도 좋습니다')</script>"
	END IF
ENd IF

IF Request.Form("varfinal")="ok" THEN '최종 입력시

	ArrQuery=array("Electric","insertadd",varModel,varmodelname)
	Set objServer = Server.CreateObject("XBEnvRegistIMTS.clsXBEnvRegistITX")
	arrRvalue=objserver.save(arrQuery)

	'자원의 해제
	Set objServer = Nothing

FOR inti=1 TO Request.Form("vardatenum")
	intinsertyear=Request.Form("txtyear_" & inti)
	intinsertmonth=Request.Form("txtmonth_" & inti)
	intinsertday=Request.Form("txtday_" & inti)
	intinsertdata=Request.Form("txtdata_" & inti)

	ArrQueryU = array("electric","Insert",varModel,"필요없음",intinsertyear,intinsertmonth,intinsertday,intinsertdata) '쿼리 변수
	'변수의 설정
	Set objServer = Server.CreateObject("XBEnvRegistIMTS.clsXBEnvRegistITX")

	'컴포넌트 호출
	arrRValue = objserverU.Save(ArrQueryU)
	SET objserver=Nothing '자원의 해제
NEXT
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
<script language="JavaScript" src="../../electric/script/FnAdminregist.js"></script>
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form method=post name=form action=admin_vari_regist.asp>
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
  <tr> 
    <td width="49"><img src="../../electric/images/null.gif" width="49" height="1"></td>
    <td width="642" valign="top"> 
	<!--큰 테이블 시작-->
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="../../electric/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
          <td align="left"><img src="../../electric/images/title_vari_regist.gif" width="220" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../electric/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td height="42" class="table07"> 
            <!--전기사용량 신규모델 변수유형 확인 테이블 시작-->
            <table border="0" cellspacing="0" cellpadding="0" width="642">
              <tr> 
                <td><img src="../../electric/images/gray_round_s_edge1.gif" width="6" height="6"></td>
                <td><img src="../../electric/images/gray_round_s_edge_top.gif" width="630" height="6"></td>
                <td><img src="../../electric/images/gray_round_s_edge2.gif" width="6" height="6"></td>
              </tr>
              <tr> 
                <td><img src="../../electric/images/gray_round_s_edge_left.gif" width="6" height="40"></td>
                <td class="table03">
				<!--전기사용량 신규모델 변수유형 확인 시작--> 
				<form method=post name=variableform action=admin_vari_regist.asp name=form>
				<input type=hidden name=varoverlap value=ok>
                  <table width="410" border="0" cellspacing="0" cellpadding="0">                  
                    <tr> 
                      <td class="title_01" width="160"><img src="../../electric/images/vermilion_triangle2.gif" width="5" height="9"> 
                        모델변수유형 
                        <select name="sltModel">                          
                          <option value=M>월예측</option>
                          <option value=D selected>일예측</option>
                        </select>
                      </td>
                      <td width="4"></td>
                      <td class="title_01" width="170"><img src="../../electric/images/vermilion_triangle2.gif" width="5" height="9"> 
                        모델변수(한글) 
                        <input name="txtModelName" size="8" value=<% =varModelName %>>
                      </td>
                      <td width="76"><input type=image src="../../electric/images/re_confirm.gif" width="76" height="26"></td>
                    </tr>
                  </table>
				  <!--전기사용량 신규모델 변수유형 확인 끝-->
                </td>
                <td><img src="../../electric/images/gray_round_s_edge_right.gif" width="6" height="40"></td>
              </tr>
              <tr> 
                <td><img src="../../electric/images/gray_round_s_edge3.gif" width="6" height="6"></td>
                <td><img src="../../electric/images/gray_round_s_edge_bottom.gif" width="630" height="6"></td>
                <td><img src="../../electric/images/gray_round_s_edge4.gif" width="6" height="6"></td>
              </tr>              
            </table>
            <!--전기사용량 신규모델 변수유형 확인 테이블 끝-->
            </form>
          </td>
        </tr>
        <tr> 
          <td height="40"></td>
        </tr>
        <tr> 
          <td> 
            <!--데이터 등록기간 조회 시작-->
            <form method=post action=admin_vari_regist.asp name=form1>
          <input type=hidden name=sltmodel value=<% =varmodel %>>
          <input type=hidden name=txtModelName value=<% =varModelName %>>
          <input type=hidden name=varTerm value=ok>
            <table width="560" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="15"></td>
                <td class="title_01"><img src="../../electric/images/vermilion_buret.gif" width="7" height="7"> 
                  데이터 등록기간: 
                  <select name="sltStartYear">
                  <% FOR intI=2002 to 2010
                  IF year(date()) = intI THEN                    
                   Response.Write "<option selected value= " & intI & ">" & intI & "년</option>"
                  ELSE 
                   Response.Write "<option value=" & intI & ">" & intI  &"년</option>"
                  END IF : NEXT %>
                  </select>
                  
                  <select name="sltStartMonth">
                  <% FOR intI=1 to 12
                  IF month(date()) = intI THEN                    
                   Response.Write "<option selected value= " & intI & ">" & intI & "월</option>"
                  ELSE 
                   Response.Write "<option value=" & intI & ">" & intI  &"월</option>"
                  END IF : NEXT %>
                  <select id=select1 name=select1>
                  
                  <select name="sltStartDay">
                  <% FOR intI=1 to 31
                  IF day(date()) = intI THEN                    
                   Response.Write "<option selected value= " & intI & ">" & intI & "일</option>"
                  ELSE 
                   Response.Write "<option value=" & intI & ">" & intI  &"일</option>"
                  END IF : NEXT %>
                  </select>
                  ~ 
                  <select name="sltEndYear">
                  <% FOR intI=2002 to 2010
                  IF year(date()) = intI THEN                    
                   Response.Write "<option selected value= " & intI & ">" & intI & "년</option>"
                  ELSE 
                   Response.Write "<option value=" & intI & ">" & intI  &"년</option>"
                  END IF : NEXT %></select>
                  
                  <select name="sltEndMonth">
                  <% FOR intI=1 to 12
                  IF month(date()) = intI THEN                    
                   Response.Write "<option selected value= " & intI & ">" & intI & "월</option>"
                  ELSE 
                   Response.Write "<option value=" & intI & ">" & intI  &"월</option>"
                  END IF : NEXT %>                  
                  </select>
                  <select name="sltEndDay">
                  <% FOR intI=1 to 31
                  IF day(date()) = intI THEN                    
                   Response.Write "<option selected value= " & intI & ">" & intI & "일</option>"
                  ELSE 
                   Response.Write "<option value=" & intI & ">" & intI  &"일</option>"
                  END IF : NEXT %>
                  </select>
                </td>
                <td>
                <% IF varModelName<>"" THEN %>
                <input type=image src="../../electric/images/commu_bu.gif" width="53" height="26">
                <% END IF %>
                </td>
              </tr>
            </table>
            </form>
            <!--라이더 등록기간 조회 끝-->
          </td>
        </tr>
        <tr> 
          <td height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--등록 테이블 시작--> 
		  <form method=post name=form2 action=admin_vari_regist.asp onsubmit='return FnCheck()'>
		  <input type=hidden name=varfinal value=ok>         
            <input type=hidden name=varDateNum value=<% =varDateNum %>>
            <input type=hidden name=sltmodel value=<% =varModel %>>            
            <input type=hidden name=txtModelName value=<% =varModelName %>>
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr bgcolor="#CECFF5"> 
                <td height="7" colspan="4"></td>
              </tr>
              <tr class="list07_bg"> 
                <td>년</td>
                <td>월</td>
                <td>일</td>
                <td>data <% =varModel %></td>
              </tr>              
                <% For Inti=1 to varDateNum %>              				
                <% IF varmodel="M" THEN %>                
                <% dtsumdate=dateadd("m",inti-1,dtstartdate) %>
                <tr class="list14_bg2"> 
                <td><input name="txtyear_<% =intI %>" size="4" value=<% =year(dtsumdate) %> onfocus=blur()>년</td>
                <td><input name="txtmonth_<% =intI %>" size="2" value=<% =month(dtsumdate) %>  onfocus=blur()>월</td>
                <td><input name="txtday_<% =intI %>" size="2" disabled>일</td>
                <td><input name="txtdata_<% =intI %>" size="60"></td>
              </tr>
               <% ELSEIF varmodel="D" THEN %>
               <% dtsumdate=dateadd("d",inti-1,dtstartdate) %>
               <tr class="list14_bg2"> 
                <td><input name="txtyear_<% =intI %>" size="4" value=<% =year(dtsumdate) %> onfocus=blur()>년</td>
                <td><input name="txtmonth_<% =intI %>" size="2" value=<% =month(dtsumdate) %>  onfocus=blur()>월</td>
                <td><input name="txtday_<% =intI %>" size="2" value=<% =day(dtsumdate) %> onfocus=blur()>일</td>
                <td><input name="txtdata_<% =intI %>" size="60"></td>
              </tr>
              <% END IF %>
              <% NEXT %>
              <tr bgcolor="#CECFF5"> 
                <td height="7" colspan="4"></td>
              </tr>
            </table>          
			<!--등록 테이블 끝-->
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
                <td align="right">
                <% IF varterm<>"" THEN %>
                <input type=image src="../../electric/images/save.gif" width="53" height="26" border="0">
                <% END IF %>
                </td>
                <td width="5">  </form></td>
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
    <td width="49"><img src="../../electric/images/null.gif" width="49" height="1"></td>
    <td bgcolor="#a4a4a4"><img src="../../electric/images/outline.gif" width="1" height="1"></td>
  </tr>
  <tr> 
    <td height="42" colspan="3" align="right" background="../../electric/images/copyright_bg.gif"><img src=../../electric/images/copyright.gif width="350" height="42"></td>
    <td bgcolor="#a4a4a4" width="1" height="42"><img src="../../electric/images/null.gif"></td>
  </tr>
</table>
</form>
</body>
</html>
<!-- #include file="../../electric/script/FnErrorCatch.inc" -->