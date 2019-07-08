<!-- #include file="../../enter/script/FnLoginAuth_admin.inc" -->
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
Dim rs '모형 종류 가져오기
Dim Intstartyear, intstartmonth,intstartday,intendyear,intendmonth,intendday, dtstartdate, dtenddate '사용자 입력값
Dim varmodel, varmodelname,vardatenum, varinsert,varterm,varoverlap,varfinal
dim intI '증가변수
DIM dtsumdate  '최종 데이터 입력을 위해 텍스트 박스에 뿌려지는 값
Dim intinsertyear, intinsertmonth, intinsertday, intinsertdata '사용자 입력값

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
varterm = Request.form("varterm")


'데이터 간격을 조사한다.
IF varModel="Y" THEN '년 모델일 때
varDateNum=datediff("yyyy",dtstartdate,dtenddate)
varDateNum=vardateNum+1
END IF
IF varModel="M" THEN '월 모델일 때
varDateNum=datediff("M",dtstartdate,dtenddate)
varDateNum=vardateNum+1
END IF
IF varModel="D" THEN '일 모델일 때
varDateNum=datediff("D",dtstartdate,dtenddate)
varDateNum=vardateNum+1
END IF


IF varoverlap="ok" THEN   '변수 중복 확인
	ArrQuery = array("enter","check",varModel,varModelName) '쿼리 변수

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

	ArrQuery=array("enter","insertadd",varModel,varmodelname)
	
	Set objServer = Server.CreateObject("XBEnvRegistIMTS.clsXBEnvRegistITX")
	arrRvalue=objserver.save(arrQuery)

	'자원의 해제
	Set objServer = Nothing

	FOR inti=1 TO Request.Form("vardatenum")   '날짜 간격만큼의 데이터를 반복해서 삽입
		intinsertyear=Request.Form("txtyear_" & inti)
		intinsertmonth=Request.Form("txtmonth_" & inti)
		intinsertday=Request.Form("txtday_" & inti)
		intinsertdata=Request.Form("txtdata_" & inti)

	ArrQueryU = array("enter","Insert",varModel,"필요없음",intinsertyear,intinsertmonth,intinsertday,intinsertdata) '쿼리 변수
	'변수의 설정
	Set objServer = Server.CreateObject("XBEnvRegistIMTS.clsXBEnvRegistITX")

	'컴포넌트 호출
	arrRValue = objserver.Save(ArrQueryU)

	set objserver=Nothing '자원해제
	next
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
<script language="JavaScript" src=FnAdminregist.js></script>
</head>

<body bgcolor="#f5f5f5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload=document.variableform.txtModelName.focus()>
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#ffffff">
  <tr> 
    <td width="49"><IMG height=1 src="../../enter/images/null.gif" width=49></td>
    <td width="642" valign="top"><!--큰 테이블 시작-->
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><IMG height=24 src="../../enter/images/null.gif" width=1></td>
        </tr>
        <tr> 
          <td align="left"><IMG height=21 src="../../enter/images/title_vari_regist.gif" width=200></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><IMG height=5 src="../../enter/images/title_bar.gif" width=642></td>
        </tr>
        <tr> 
          <td height="42" class="table07"><!--입장객 신규모델 변수유형 확인 테이블 시작-->
            <table border="0" cellspacing="0" cellpadding="0" width="642">
              <tr> 
                <td><IMG height=6 src="../../enter/images/gray_round_s_edge1.gif" width=6></td>
                <td><IMG height=6 src="../../enter/images/gray_round_s_edge_top.gif" width=630></td>
                <td><IMG height=6 src="../../enter/images/gray_round_s_edge2.gif" width=6></td>
              </tr>
              <tr> 
                <td><IMG height=40 src="../../enter/images/gray_round_s_edge_left.gif" width=6></td>
                <td class="table03"><!--입장객 신규모델 변수유형 확인 시작--> 
                <form method=post name=variableform action=admin_vari_regist.asp name=form>
				<input type=hidden name=varoverlap value=ok>
                  <table width="430" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td class="title_01" width="160"><IMG height=9 src="../../enter/images/vermilion_triangle2.gif" width=5> 
                        모델변수유형 
                        <select name="sltModel">
                          <option value=Y>년예측</option>
                          <option value=M>월예측</option>
                          <option value=D selected>일예측</option>
                        </select>
                      </td>
                      <td width="4"></td>
                      <td class="title_01" width="170"><IMG height=9 src="../../enter/images/vermilion_triangle2.gif" width=5> 
                        모델변수(한글) 
                        <input name="txtModelName" size="8" value=<% =varModelName %>>
                      </td>
                      <td width="76"><input type=IMAGE height=26 src="../../enter/images/re_confirm.gif"></td>
                    </tr>
                  </table><!--입장객 신규모델 변수유형 확인 끝-->
                </td>
                <td><IMG height=40 src="../../enter/images/gray_round_s_edge_right.gif" width=6></td>
              </tr>
              <tr> 
                <td><IMG height=6 src="../../enter/images/gray_round_s_edge3.gif" width=6></td>
                <td><IMG height=6 src="../../enter/images/gray_round_s_edge_bottom.gif" width=630></td>
                <td><IMG height=6 src="../../enter/images/gray_round_s_edge4.gif" width=6></td>
              </tr>              
            </table><!--입장객 신규모델 변수유형 확인 테이블 끝-->
            </form>
          </td>
        </tr>
        <tr> 
          <td height="40"></td>
        </tr>
        <tr> 
          <td><!--데이터 등록기간 조회 시작-->
          <form method=post action=admin_vari_regist.asp name=form1>
          <input type=hidden name=sltmodel value=<% =varmodel %>>
          <input type=hidden name=txtModelName value=<% =varModelName %>>
          <input type=hidden name=varTerm value=ok>
            <table width="560" border="0" cellspacing="0" cellpadding="0">            
              <tr>
                <td width="15"></td>
                <td class="title_01"><IMG height=7 src="../../enter/images/vermilion_buret.gif" width=7> 
                  &nbsp;데이터 등록기간: 
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
                  <select>
                  
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
                <input type=IMaGe height=26 src="../../enter/images/commu_bu.gif" width=53>
                <% END IF %>
                </td>                
              </tr>              
            </table><!--라이더 등록기간 조회 끝-->
            </form>
          </td>
        </tr>
        <tr> 
          <td height="5"></td>
        </tr>
        <tr> 
          <td><!--등록 테이블 시작--> 
			<form method=post name=form2 action=admin_vari_regist.asp onsubmit='return FnCheck()'>
			<input type=hidden name=varfinal value=ok>         
            <input type=hidden name=varDateNum value=<% =varDateNum %>>
            <input type=hidden name=sltmodel value=<% =varModel %>>            
            <input type=hidden name=txtModelName value=<% =varModelName %>>
            <table width="642" border="0" cellspacing="1" cellpadding="7">               
              <tr bgcolor="#b0dffd"> 
                <td height="7" colspan="4"></td>
              </tr>
              <tr class="list07_bg"> 
                <td>년</td>
                <td>월</td>
                <td>일</td>
                <td>data <% =varModel %></td>
              </tr>
              <% For Inti=1 to varDateNum %>              
				<% IF varmodel="Y" THEN %>            
				<% dtsumdate=dateadd("yyyy",inti-1,dtstartdate) %>
              <tr class="list14_bg2"> 
                <td><input name="txtyear_<% =intI %>" size="4" value=<% =year(dtsumdate) %> onfocus=blur()>년</td>
                <td><input name="txtmonth_<% =intI %>" size="2" disabled>월</td>
                <td><input name="txtday_<% =intI %>" size="2" disabled>일</td>
                <td><input name="txtdata_<% =intI %>" size="60"></td>
              </tr>
                <% ELSEIF varmodel="M" THEN %>                
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
              <tr bgcolor="#b0dffd"> 
                <td height="7" colspan="4"></td>
              </tr>              
            </table><!--등록 테이블 끝-->
          </td>
        </tr>
        <tr>
          <td height="10"></td>
        </tr>
        <tr> 
          <td height="34" class="table02"><!--하단 버튼바 테이블 시작-->
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td align="right">
                <% IF VarTerm<>"" THEN %>
                <input type=image height=26 src="../../enter/images/save.gif" width=53 border=0>
                <% END IF %>
                </td>
                <td width="5"></td></form>
              </tr>              
            </table><!--하단 버튼바 테이블 끝-->            
		  </td>
        </tr>
        <tr> 
          <td height="30"></td>
        </tr>
      </table><!--큰 테이블 끝-->
    </td>
    <td width="49"><IMG height=1 src="../../enter/images/null.gif" width=49></td>
    <td bgcolor="#a4a4a4"><IMG height=1 src="../../enter/images/outline.gif" width=1></td>
  </tr>
  <tr> 
    <td height="42" colspan="3" align="right" background="../../enter/images/copyright_bg.gif"><IMG height=42 src="../../enter/images/copyright.gif" width=350></td>
    <td bgcolor="#a4a4a4" width="1" height="42"><IMG src="../../enter/images/null.gif"></td>
  </tr>
</table>
</body>
</html>
<!-- #include file="../../enter/script/FnErrorCatch.inc"-->