<!-- #include file="../../enter/script/FnLoginAuth_admin.inc" -->
<%
' ========================================================================================================
' 프로그램ID : Vari_Modify
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 변수 수정
' 최초작성일 : 2002/12/18
' 최종작성일 : 2002/12/18
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim rs,rsvar, rsvarlist '레코드셋 모델종류, 모델변수 출력, 모델 변수 마스터 리스트 출력
Dim varMode, SltMode, VarInsert, VarChoose, vcInsert '환경 변수들 일월년 모드, 일월년 모드2, 최종입력, 모델유형선택, 일월년 모드 셀렉트 쿼리 값
Dim intMonth, varWeekDayName, varModelCode '변수 조회시 사용되는 변수
Dim inty6weight,vary6,intvartransweight,varvartrans,intprocessID '변수 리스트 속성들
Dim varmodefinal, varmodelcodefinal, intmonthfinal, varweekdaynamefinal  '최종 수정시 들어갈 값
Dim intI,intIform, intVarOrder '증가변수, VarOrder 순서번호
Dim varchkbox(35), var1(35), varweight1(35), varorder(35), varname2(35), var2(35), varweight2(35), inttime(35), lngweight(35) '변수 리스트 배열 저장

VarMode=Request.QueryString("vcmode") '보기, 입력 모드 결정 쿼리스트링 변수
SltMode=Request.Form("varmode") '값이 겹치치 않게 하기 위해 위의 varmode와 다른 변수로 설정
varInsert=Request.Form("varInsert")

IF Varmode="" THEN varmode=sltmode  'varmode 에 값이 없으면 폼 값으로 대체

IntMonth=Request.Form("sltmonth") '월 입력
varWeekDayName=Request.Form("sltWeekDayName") '요일 이름
varchoose=Request.QueryString("varchoose")  '모델 선택 변수  쿼리스트링 변수
vcinsert=Request.Form("txtinsert") '조회 단추를 눌렸을 경우 작동
varmodelcode=Request.Form("sltmodelcode") '모델 코드를 가져온다

IF varInsert="ok" THEN  '최종입력시 받아오는 변수값들
	intIform=Request.Form("intI")
	intI=0

	For intI=0 to intIform
	varchkbox(intI)=Request.Form("chkbox_"& intI)
	var1(intI)=Request.Form("sltvar1_"& intI)
	VarWeight1(intI)=Request.Form("txtVarWeight1_"& intI)
	Varorder(intI)=Request.Form("txtVarorder_"& intI)
	Varname2(intI)=Request.Form("sltVarname2_"& intI)
	var2(intI)=Request.Form("sltvar2_"& intI)
	VarWeight2(intI)=Request.Form("txtVarWeight2_"& intI)
	intTime(intI)=Request.Form("txtTime_"& intI)
	lngWeight(intI)=Request.Form("txtWeight_"& intI)

	IF var1(intI)="-pow" THEN 'var1 의 값을 pow 가 들어갔을 때를 고려한다.
	var1(intI)=varweight1(intI) & replace(var1(inti),"-","")
	ELSEIF var1(intI)="pow-" THEN '값이 오른쪽에 들어갔을때는 이렇게
	var1(intI)=replace(var1(inti),"-","") & varweight1(intI)
	ELSEIF var2(intI)="-pow" THEN 'var2 의 값을 pow 가 들어갔을 때를 고려한다.
	var2(intI)=varweight2(intI) & replace(var2(inti),"-","")
	ELSEIF var2(intI)="pow-" THEN '값이 오른쪽에 들어갔을때는 이렇게
	var2(intI)=replace(var2(inti),"-","") & varweight2(intI)
	END IF
	NEXT
	
	intmonthfinal=Request.Form("intmonthfinal")
	varweekdaynamefinal=Request.Form("txtweekdaynamefinal")
	varModefinal=Request.Form("varmodefinal")
	varmodelcodefinal=Request.Form("txtmodelcodefinal")
	intProcessID=Request.Form("intprocessID")
END IF 

IF intMonth=NULL THEN intMonth="" '대체값 설정
IF varweekdayname=NULL THEN varweekdayname=""

IF varchoose="ok" and vcInsert="" THEN  '년,월,일 예측을 선택했을 경우 배열 저장
	ArrQuery = array("Enter","view",Varmode) '쿼리 변수
END IF

IF vcInsert="ok" THEN '조회 버튼을 눌렀을 경우 
	ArrQuery = array("enter","view",Varmode,varmodelcode,intmonth,varweekdayname) '쿼리 변수
END IF

IF varchoose="ok" or vcinsert="ok" THEN '셀렉트 항목으로 선택하거나 조회를 눌렀을 경우 실행

	'변수의 설정
	Set objServer = Server.CreateObject("XBRegistModIMTS.clsXBRegistModINTX")

	'컴포넌트 호출
	arrRValue = objServer.Query(ArrQuery)

	'레코드셋 어레이를 단일 레코드셋으로 분리
	'첫번째 레코드셋을 어레이로 변환
	FnSplitRSArray arrRValue,rs,1
	'두번째 레코드셋을 어레이로 변환
	FnSplitRSArray arrRValue,rsvar,2
	'세번째 레코드셋을 어레이로 변환
	FnSplitRSArray arrRValue,rsvarlist,3
	
	'자원의 해제
Set objServer = Nothing
END IF 

IF varInsert="ok" THEN  '최종 입력시
 intVarOrder=0 '초기값을 정해주고
 IntI=0
 FOR intI=0 to intIForm '변수 varorder값이 0 부터 모델변수 개수까지의 값을 반복한다.
 IF varchkbox(intI)="ok" THEN   '체크된 항목만 반복
	ArrQuery = array("enter","insert",Varmodefinal,varmodelcodefinal,intmonthfinal,varweekdaynamefinal,var1(intI),intprocessID,intVarOrder,varname2(intI),inttime(intI),var2(intI),lngweight(intI)) '쿼리 변수
	'변수의 설정
	Set objServer = Server.CreateObject("XBRegistModIMTS.clsXBRegistModITX")
	'컴포넌트 호출
	arrRValue = objServer.Save(ArrQuery)
		
	'자원의 해제
	Set objServer = Nothing
	
	intVarOrder=intVarOrder+1  '변수값을 증가시키고..
 END IF
 NEXT  
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
<script src="../../enter/script/Fnadminregist.js"></script>
</head>
<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
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
          <td align="left" colspan="2"><img src="../../enter/images/title_vari_modify.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top" colspan="2"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td width="190"> 
            <!--모형선택 타이틀 시작-->
            <table border="0" cellspacing="0" cellpadding="0" width="172">
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge1.gif" width="6" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge_top.gif" width="160" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge2.gif" width="6" height="6"></td>
              </tr>
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge_left.gif" width="6" height="20"></td>
                <td class="title_01_c"><img src="../../enter/images/vermilion_buret.gif" width="7" height="7"> 
                  모형선택 </td>
                <td><img src="../../enter/images/gray_round_s_edge_right.gif" width="6" height="20"></td>
              </tr>
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge3.gif" width="6" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge_bottom.gif" width="160" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge4.gif" width="6" height="6"></td>
              </tr>
            </table>
            <!--모형선택 타이틀 끝-->
          </td>
          <td width="452"> 
          </td>
        </tr>
        <tr>
          <td height="10" colspan="2"></td>
        </tr>
        <tr> 
          <td height="10" colspan="2">
           <form name=form method=post action=admin_vari_modify.asp>
              <input type=hidden name=varmode value=<% =varmode %>>
              <input type=hidden name=txtinsert value=ok>
            <!--모형선택 시작-->                      
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td class="title_01"> 모델종류 
                  <select name="sltmodel"  onChange="namosw_goto_byselect(this, 'self')">
                    <% IF varmode="y" THEN %>
                    <option>--</option>
                    <option value=admin_vari_modify.asp?vcmode=y&varchoose=ok selected>년예측</option>
                    <option value=admin_vari_modify.asp?vcmode=m&varchoose=ok>월예측</option>
                    <option value=admin_vari_modify.asp?vcmode=d&varchoose=ok>일예측</option>
                    <% ELSEIF varmode="m" THEN %>
                    <option>--</option>
                    <option value=admin_vari_modify.asp?vcmode=y&varchoose=ok>년예측</option>
                    <option value=admin_vari_modify.asp?vcmode=m&varchoose=ok selected>월예측</option>
                    <option value=admin_vari_modify.asp?vcmode=d&varchoose=ok>일예측</option>
                    <% ELSEIF varmode="d" THEN %>
                    <option>--</option>
                    <option value=admin_vari_modify.asp?vcmode=y&varchoose=ok>년예측</option>
                    <option value=admin_vari_modify.asp?vcmode=m&varchoose=ok>월예측</option>
                    <option value=admin_vari_modify.asp?vcmode=d&varchoose=ok selected>일예측</option>
                    <% ELSE %>
                    <option selected>--</option>
                    <option value=admin_vari_modify.asp?vcmode=y&varchoose=ok>년예측</option>
                    <option value=admin_vari_modify.asp?vcmode=m&varchoose=ok>월예측</option>
                    <option value=admin_vari_modify.asp?vcmode=d&varchoose=ok>일예측</option>
                    <% END IF %>
                  </select>
                  모형종류 
                  <select name="sltmodelcode">
                    <% IF varmode<>"" THEN %>                    
                    <% DO UNTIL rs.EOF %>    
                    <% IF varmodelcode=rs("modelcode") THEN %>
                    <option selected value=<% =rs("modelcode") %>><% =rs("modelname") %></option>
                    <% ELSE %>
                    <option value=<% =rs("modelcode") %>><% =rs("modelname") %></option>
                    <% END IF %>
                    <% rs.MOVENEXT : LOOP %>
                    <% ELSE %>
                    <option>--</option>
                    <% END IF %>
                  </select>
                  <% IF varmode="m" or varmode="d" THEN %>
                  <select name="sltmonth">
                    <% FOR intI=1 TO 12 : IF intMonth-inti=0 THEN %>
                    <option value=<% =intI %> selected><% =inti %>월</option>
                    <% else %>
                    <option value=<% =intI %>><% =inti %>월</option>
                    <% END IF : NEXT %>
                  </select>
                  <% END IF %>
                  <% IF varmode="d" THEN %>
                  <select name="sltweekdayname">
                    <% FOR intI=1 TO 7 : IF varWeekdayName=left(weekdayname(intI),1) THEN %>
                    <option value=<% =left(weekdayname(intI),1) %> selected><% =weekdayname(intI) %></option>
                    <% ELSE %>
                    <option value=<% =left(weekdayname(intI),1) %>><% =weekdayname(intI) %></option>
                    <% END IF :NEXT 
                  END IF%>
                  </select>
                </td>
                <td width="53"><input type=image src="../../enter/images/commu_bu.gif" width="53" height="26">
                </td>
              </tr>
            </table>
            <!--모형선택 선택 끝-->
            </form>
          </td>
        </tr>
        <tr>
          <td height="10" colspan="2"></td>
        </tr>
        <tr> 
          <td colspan="2"> 
            <!--수정 테이블 시작-->
            <form method=post action=admin_vari_modify.asp name=form>
            <input type=hidden name=varinsert value=ok>
            <input type=hidden name=txtmodelcodefinal value=<% =varmodelcode %>>
            <input type=hidden name=varmodefinal value=<% =varmode %>>
            <input type=hidden name=intmonthfinal value=<% =intmonth %>>
            <input type=hidden name=txtweekdaynamefinal value=<% =varweekdayname %>>
            <table width="642" border="0" cellspacing="1" cellpadding="5">            
              <tr bgcolor="#B0DFFD"> 
                <td height="7" colspan="8"></td>
              </tr>
              <tr class="list07_bg"> 
                <td>변수<br>
                  선택</td>
                <td>예측값변형</td>
                <td>변수<br>
                  순서</td>
                <!--td>변수level1</td -->
                <td>변수</td>
                <td>변수변형</td>
                <td>시점</td>
                <td>계수</td>
              </tr>
              <% IF vcinsert<>"" THEN 
              intI=0
              DO UNTIL rsvar.eof %>
              <!-- #include file="../../enter/script/FnvariModify.inc" -->
              <tr class="list14_bg2"> 
                <td> 
                  <input type="checkbox" name="chkbox_<% =intI %>" value=ok checked>
                </td>
                <td> 
                  <select name="sltVar1_<% =intI %>">                   
                   <% If rsvar("y6")="square" THEN %>
                    <option value=NULL>---</option>
                    <option value='-pow'>-pow</option>
                    <option value='pow-'>pow-</option>
                    <option value=square SELECTED>square</option>
                    <option value=ln>ln</option>
                    <option value=log>log</option>
                    <option value=sqrt>sqrt</option>
                    <option value=exp>exp</option>
                    <option value=abs>abs</option>
                  <% ELSEIF vary6="-pow" THEN %>
                    <option value=NULL>---</option>
                    <option value='-pow' selected>-pow</option>
                    <option value='pow-'>pow-</option>
                    <option value=square>square</option>
                    <option value=ln>ln</option>
                    <option value=log>log</option>
                    <option value=sqrt>sqrt</option>
                    <option value=exp>exp</option>
                    <option value=abs>abs</option>
                  <% ELSEIF vary6="pow-" THEN %>
                    <option value=NULL>---</option>
                    <option value='-pow'>-pow</option>
                    <option value='pow-' selected>pow-</option>
                    <option value=square>square</option>
                    <option value=ln>ln</option>
                    <option value=log>log</option>
                    <option value=sqrt>sqrt</option>
                    <option value=exp>exp</option>
                    <option value=abs>abs</option>
                  <% ELSEIF rsvar("y6")="log" THEN %>
                    <option value=NULL>---</option>
                    <option value='-pow'>-pow</option>
                    <option value='pow-'>pow-</option>
                    <option value=square>square</option>
                    <option value=ln>ln</option>
                    <option value=log SELECTED>log</option>
                    <option value=sqrt>sqrt</option>
                    <option value=exp>exp</option>
                    <option value=abs>abs</option>
                  <% ELSEIF rsvar("y6")="ln" THEN %>
                    <option value=NULL>---</option>
                    <option value='-pow'>-pow</option>
                    <option value='pow-'>pow-</option>
                    <option value=square>square</option>
                    <option value=ln SELECTED>ln</option>
                    <option value=log>log</option>
                    <option value=sqrt>sqrt</option>
                    <option value=exp>exp</option>
                    <option value=abs>abs</option>
                  <% ELSEIF rsvar("y6")="sqrt" THEN %>
					<option value=NULL>---</option>
                    <option value='-pow'>-pow</option>
                    <option value='pow-'>pow-</option>
                    <option value=square>square</option>
                    <option value=ln>ln</option>
                    <option value=log>log</option>
                    <option value=sqrt SELECTED>sqrt</option>
                    <option value=exp>exp</option>
                    <option value=abs>abs</option>
                  <% ELSEIF rsvar("y6")="exp" THEN %>
                    <option value=NULL>---</option>
                    <option value='-pow'>-pow</option>
                    <option value='pow-'>pow-</option>
                    <option value=square>square</option>
                    <option value=ln>ln</option>
                    <option value=log>log</option>
                    <option value=sqrt>sqrt</option>
                    <option value=exp SELECTED>exp</option>
                    <option value=abs>abs</option>
                  <% ELSEIF rsvar("y6")="abs" THEN %>
                  <option value=NULL>---</option>
                    <option value='-pow'>-pow</option>
                    <option value='pow-'>pow-</option>
                    <option value=square>square</option>
                    <option value=ln>ln</option>
                    <option value=log>log</option>
                    <option value=sqrt>sqrt</option>
                    <option value=exp>exp</option>
                    <option value=abs SELECTED>abs</option>
                  <% ELSE  %>
                    <option value=NULL SELECTED>---</option>
                    <option value='-pow'>-pow</option>
                    <option value='pow-'>pow-</option>
                    <option value=square>square</option>
                    <option value=ln>ln</option>
                    <option value=log>log</option>
                    <option value=sqrt>sqrt</option>
                    <option value=exp>exp</option>
                    <option value=abs>abs</option>                  
                  <% END IF %>                   
                  </select>
                  <input type="text" name="txtVarWeight1_<% =intI %>" size="3" value=<% =inty6weight %>>
                </td>
                <td> 
                  <input type="text" name="txtVarorder_<% =intI %>" size="2" value=<% =rsvar("varorder") %>>
                </td>
                <!--td> 
                  <select name="sltVarname1">                    
                    <option value=<%' =rsvar("varlevel1") %>><%' =rsvar("varLevel1_name") %></option>                    
                  </select>
                </td-->
                <td> 
                  <select name="sltVarname2_<% =intI %>">
                    <% DO UNTIL rsvarlist.EOF %>
                    <% IF rsvar("varlevel2")=rsvarlist("varlevel2") THEN %>
                    <option value=<% =rsvar("varlevel2")%> selected><% =rsvar("varlevel2_name") %></option>
                    <% ELSE %>
                    <option value=<% =rsvarlist("varlevel2")%>><% =rsvarlist("varlevel2_name") %></option>
                    <%END IF : 
                     rsVarList.MOVENEXT :  LOOP : rsvarlist.MOVEFIRST %>
                  </select>
                </td>
                <td> 
                  <select name="sltvar2_<% =intI %>">
                    <% If rsvar("vartrans")="square" THEN %>
                    <option value=NULL>---</option>
                    <option value='-pow'>-pow</option>
                    <option value='pow-'>pow-</option>
                    <option value=square SELECTED>square</option>
                    <option value=ln>ln</option>
                    <option value=log>log</option>
                    <option value=sqrt>sqrt</option>
                    <option value=exp>exp</option>
                    <option value=abs>abs</option>
                  <% ELSEIF varvartrans="-pow" THEN %>
                    <option value=NULL>---</option>
                    <option value='-pow' selected>-pow</option>
                    <option value='pow-'>pow-</option>
                    <option value=square>square</option>
                    <option value=ln>ln</option>
                    <option value=log>log</option>
                    <option value=sqrt>sqrt</option>
                    <option value=exp>exp</option>
                    <option value=abs>abs</option>
                  <% ELSEIF varvartrans="pow-" THEN %>
                    <option value=NULL>---</option>
                    <option value='-pow'>-pow</option>
                    <option value='pow-' selected>pow-</option>
                    <option value=square>square</option>
                    <option value=ln>ln</option>
                    <option value=log>log</option>
                    <option value=sqrt>sqrt</option>
                    <option value=exp>exp</option>
                    <option value=abs>abs</option>
                  <% ELSEIF rsvar("vartrans")="log" THEN %>
                    <option value=NULL>---</option>
                    <option value='-pow'>-pow</option>
                    <option value='pow-'>pow-</option>
                    <option value=square>square</option>
                    <option value=ln>ln</option>
                    <option value=log SELECTED>log</option>
                    <option value=sqrt>sqrt</option>
                    <option value=exp>exp</option>
                    <option value=abs>abs</option>
                  <% ELSEIF rsvar("vartrans")="ln" THEN %>
                    <option value=NULL>---</option>
                    <option value='-pow'>-pow</option>
                    <option value='pow-'>pow-</option>
                    <option value=square>square</option>
                    <option value=ln SELECTED>ln</option>
                    <option value=log>log</option>
                    <option value=sqrt>sqrt</option>
                    <option value=exp>exp</option>
                    <option value=abs>abs</option>
                  <% ELSEIF rsvar("vartrans")="sqrt" THEN %>
					<option value=NULL>---</option>
                    <option value='-pow'>-pow</option>
                    <option value='pow-'>pow-</option>
                    <option value=square>square</option>
                    <option value=ln>ln</option>
                    <option value=log>log</option>
                    <option value=sqrt SELECTED>sqrt</option>
                    <option value=exp>exp</option>
                    <option value=abs>abs</option>
                  <% ELSEIF rsvar("vartrans")="exp" THEN %>
                    <option value=NULL>---</option>
                    <option value='-pow'>-pow</option>
                    <option value='pow-'>pow-</option>
                    <option value=square>square</option>
                    <option value=ln>ln</option>
                    <option value=log>log</option>
                    <option value=sqrt>sqrt</option>
                    <option value=exp SELECTED>exp</option>
                    <option value=abs>abs</option>
                  <% ELSEIF rsvar("vartrans")="abs" THEN %>
                    <option value=NULL>---</option>
                    <option value='-pow'>-pow</option>
                    <option value='pow-'>pow-</option>
                    <option value=square>square</option>
                    <option value=ln>ln</option>
                    <option value=log>log</option>
                    <option value=sqrt>sqrt</option>
                    <option value=exp>exp</option>
                    <option value=abs SELECTED>abs</option>
                  <% ELSE  %>
                    <option value=NULL SELECTED>---</option>
                    <option value='-pow'>-pow</option>
                    <option value='pow-'>pow-</option>
                    <option value=square>square</option>
                    <option value=ln>ln</option>
                    <option value=log>log</option>
                    <option value=sqrt>sqrt</option>
                    <option value=exp>exp</option>
                    <option value=abs>abs</option>                  
                  <% END IF %>
                  </select>
                  <input type="text" name="txtVarWeight2_<% =intI %>" size="3" value=<% =intvartransweight %>>
                </td>
                <td> 
                  <input type="text" name="txtTime_<% =intI %>" size="3" value=<% =rsvar("time") %>>
                </td>
                <td> 
                  <input type="text" name="txtWeight_<% =intI %>" size="10" value=<% =rsvar("weight") %>>
                </td>
              </tr>              
              <% rsvar.MOVENEXT : inty6weight="" :vary6="" :intvartransweight="" :varvartrans="" : intI=intI+1 : LOOP : rsvar.MOVELAST%>
              <input type=hidden name=intProcessID value=<% =rsvar("processID") %>>
              <% END IF%>
              <tr bgcolor="#B0DFFD"> 
                <td height="7" colspan="8"></td>
              </tr>
            </table>
            <!--수정 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td height="10" colspan="2"></td>
        </tr>
        <tr> 
          <td height="34" class="table02" colspan="2"> 
            <!--하단 버튼바 테이블 시작-->
            <input type=hidden name=intI value=<% =intI %>>
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <% IF VarMode<>"" THEN %>
              <tr>                 
                <td align="right">                                              
                  <input type=image src="../../enter/images/save.gif" width="53" height="26" border="0" id=image1 name=image1>                  
                </td>                
                <td width="5"></td>
              </tr>
              <% END IF %>
            </table>
            </form>
            <!--하단 버튼바 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td height="30" colspan="2"></td>
        </tr>
      </table>
      </form>
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
