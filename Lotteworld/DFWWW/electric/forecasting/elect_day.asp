<!-- #include file="../../electric/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' 프로그램ID : TXEEACHBUILDDAY
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 전기 예측 - 일
' 최초작성일 : 2002/10/24
' 최종작성일 : 2002/10/24
' 개  발  자 : 박순몽(kweather)
' 사용    DB : TXEEACHBUILDDAY
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim rs,rssum,rslast, rslastsum, rslastweek, rslastweeksum '레코드셋 (예측,예측합계,전년동일,전년동일합계,전년동요일,전년동요일합계)
dim intI '증가변수

%>
<!-- #include file="../../electric/script/FnSearch_Date.inc"-->
<%
ArrQuery = array(dtLastDay,dtLastWeekDay) '페이지에 맞는 코드 가져오고

'변수의 설정
Set objServer = Server.CreateObject("XEElectDayQMTS.clsXEElectDayQNTX")

'컴포넌트 호출
arrRValue = objServer.Query(ArrQuery)
'레코드셋 어레이를 단일 레코드셋으로 분리

'첫번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rs,1
'두번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rslast,2
'세번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rslastweek,3
'네번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rssum,4
'다섯번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rslastsum,5
'여섯번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rslastweeksum,6

'자원의 해제
Set objServer = Nothing

'에러의 처리
IF Err.Number <> 0 THEN 
	Response.Write Err.Number, Err.Source, Err.Description
	Set objServer = Nothing
	objserver.close
END IF
%>	
<!-- #include file="../../electric/script/FnProgramProcess.vbs" -->
<!-- #include file="../../electric/script/fnnumber_format.inc"-->		
<html>
<head>
<title>롯데월드 수요예측시스템</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../../electric/css/cs_te.css" type="text/css">
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
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
          <td><img src="../../electric/images/title_elect_day.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../electric/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td> 
            <!--일예측 테이블 시작-->
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr class="list07_bg3"> 
                <td colspan="3">구분</td>
                <% FOR intI=0 TO 2 %>
                <td> 
                  <% =FnDateFormat(date()+intI) %>
                </td>
                <% NEXT %>
                <td>누계</td>
              </tr>
              <tr> 
                <td rowspan="5" width="92" class="list02_bg2">전체</td>
                <td colspan="2" class="list03_bg">예측값</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg"> 
                  <% =FnNumberForMat(rs("total")) %>
                </td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnNumberFormat(rssum("total")) %>
                </td>
              </tr>
              <tr> 
                <td rowspan="2" width="50" class="list03_bg2">동일</td>
                <td width="68" class="list03_bg2">전년실적</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg2"  width=108> 
                  <% =FnNumberFormat(rslast("total")) %>
                </td>
                <% rslast.MOVENEXT : NEXT : rslast.MOVEFIRST %>
                <td class="list04_bg2" width=108 title='<%=FnDateFormat(dateserial(year(dtLastDay),month(dtLastDay),01)) %>~<%=FnDateFormat(dtLastDay) %>'> 
                  <% =FnNumberFormat(rslastsum("total")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rs("total"),rslast("total")) %>
                </td>
                <% rs.MOVENEXT : rslast.MOVENEXT : NEXT : rs.MOVEFIRST : rslast.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnPercentFormat(rssum("total"),rslastsum("total")) %>
                </td>
              </tr>
              <tr> 
                <td rowspan="2" class="list03_bg2">동요일</td>
                <td class="list03_bg2">전년실적</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rslastweek("total")) %>
                </td>
                <% rslastweek.MOVENEXT : NEXT : rslastweek.MOVEFIRST %>
                <td class="list04_bg2" title='<%=FnDateFormat(dateserial(year(dtLastWeekDay),month(dtLastWeekDay),01)) %>~<%=FnDateFormat(dtLastWeekDay) %>'> 
                  <% =FnNumberFormat(rslastweeksum("total")) %>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rs("total"),rslastweek("total")) %>
                </td>
                <% rs.MOVENEXT : rslastweek.MOVENEXT : NEXT : rs.MOVEFIRST : rslastweek.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnPercentFormat(rssum("total"),rslastweeksum("total")) %>
                </td>
              </tr>
              <tr align="center"> 
                <td colspan="7"><img src="../../electric/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td rowspan="5" class="list02_bg2">매직<br>
                  아일랜드</td>
                <td colspan="2" class="list03_bg">예측값</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg"> 
                  <% =FnNumberForMat(rs("magicisland")) %>
                </td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnNumberFormat(rssum("magicisland")) %>
                </td>
              </tr>
              <tr> 
                <td rowspan="2" class="list03_bg2">동일</td>
                <td class="list03_bg2">전년실적</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rslast("magicisland")) %>
                </td>
                <% rslast.MOVENEXT : NEXT : rslast.MOVEFIRST %>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rslastsum("magicisland")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rs("magicisland"),rslast("magicisland")) %>
                </td>
                <% rs.MOVENEXT : rslast.MOVENEXT : NEXT : rs.MOVEFIRST : rslast.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnPercentFormat(rssum("magicisland"),rslastsum("magicisland")) %>
                </td>
              </tr>
              <tr> 
                <td rowspan="2" class="list03_bg2">동요일</td>
                <td class="list03_bg2">전년실적</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rslastweek("magicisland")) %>
                </td>
                <% rslastweek.MOVENEXT : NEXT : rslastweek.MOVEFIRST %>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rslastweeksum("magicisland")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rs("magicisland"),rslastweek("magicisland")) %>
                </td>
                <% rs.MOVENEXT : rslastweek.MOVENEXT : NEXT : rs.MOVEFIRST : rslastweek.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnPercentFormat(rssum("magicisland"),rslastweeksum("magicisland")) %>
                </td>
              </tr>
              <tr align="center"> 
                <td colspan="7"><img src="../../electric/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td rowspan="5" class="list02_bg2">어드벤처</td>
                <td colspan="2" class="list03_bg">예측값</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg"> 
                  <% =FnNumberForMat(rs("adventure")) %>
                </td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnNumberFormat(rssum("adventure")) %>
                </td>
              </tr>
              <tr> 
                <td rowspan="2" class="list03_bg2">동일</td>
                <td class="list03_bg2">전년실적</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rslast("adventure")) %>
                </td>
                <% rslast.MOVENEXT : NEXT : rslast.MOVEFIRST %>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rslastsum("adventure")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rs("adventure"),rslast("adventure")) %>
                </td>
                <% rs.MOVENEXT : rslast.MOVENEXT : NEXT : rs.MOVEFIRST : rslast.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnPercentFormat(rssum("adventure"),rslastsum("adventure")) %>
                </td>
              </tr>
              <tr> 
                <td rowspan="2" class="list03_bg2">동요일</td>
                <td class="list03_bg2">전년실적</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rslastweek("adventure")) %>
                </td>
                <% rslastweek.MOVENEXT : NEXT : rslastweek.MOVEFIRST %>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rslastweeksum("adventure")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rs("adventure"),rslastweek("adventure")) %>
                </td>
                <% rs.MOVENEXT : rslastweek.MOVENEXT : NEXT : rs.MOVEFIRST : rslastweek.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnPercentFormat(rssum("adventure"),rslastweeksum("adventure")) %>
                </td>
              </tr>
              <tr align="center"> 
                <td colspan="7"><img src="../../electric/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td rowspan="5" class="list02_bg2">호텔</td>
                <td colspan="2" class="list03_bg">예측값</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg"> 
                  <% =FnNumberForMat(rs("hotel")) %>
                </td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnNumberFormat(rssum("hotel")) %>
                </td>
              </tr>
              <tr> 
                <td rowspan="2" class="list03_bg2">동일</td>
                <td class="list03_bg2">전년실적</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rslast("hotel")) %>
                </td>
                <% rslast.MOVENEXT : NEXT : rslast.MOVEFIRST %>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rslastsum("hotel")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rs("hotel"),rslast("hotel")) %>
                </td>
                <% rs.MOVENEXT : rslast.MOVENEXT : NEXT : rs.MOVEFIRST : rslast.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnPercentFormat(rssum("hotel"),rslastsum("hotel")) %>
                </td>
              </tr>
              <tr> 
                <td rowspan="2" class="list03_bg2">동요일</td>
                <td class="list03_bg2">전년실적</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rslastweek("hotel")) %>
                </td>
                <% rslastweek.MOVENEXT : NEXT : rslastweek.MOVEFIRST %>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rslastweeksum("hotel")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rs("hotel"),rslastweek("hotel")) %>
                </td>
                <% rs.MOVENEXT : rslastweek.MOVENEXT : NEXT : rs.MOVEFIRST : rslastweek.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnPercentFormat(rssum("hotel"),rslastweeksum("hotel")) %>
                </td>
              </tr>
              <tr align="center"> 
                <td colspan="7"><img src="../../electric/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td rowspan="5" class="list02_bg2">백화점</td>
                <td colspan="2" class="list03_bg">예측값</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg"> 
                  <% =FnNumberForMat(rs("departmentstore")) %>
                </td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rssum("departmentstore")) %>
                </td>
              </tr>
              <tr> 
                <td rowspan="2" class="list03_bg2">동일</td>
                <td class="list03_bg2">전년실적</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rslast("departmentstore")) %>
                </td>
                <% rslast.MOVENEXT : NEXT : rslast.MOVEFIRST %>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rslastsum("departmentstore")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rs("departmentstore"),rslast("departmentstore")) %>
                </td>
                <% rs.MOVENEXT : rslast.MOVENEXT : NEXT : rs.MOVEFIRST : rslast.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnPercentFormat(rssum("departmentstore"),rslastsum("departmentstore")) %>
                </td>
              </tr>
              <tr> 
                <td rowspan="2" class="list03_bg2">동요일</td>
                <td class="list03_bg2">전년실적</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rslastweek("departmentstore")) %>
                </td>
                <% rslastweek.MOVENEXT : NEXT : rslastweek.MOVEFIRST %>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rslastweeksum("departmentstore")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rs("departmentstore"),rslastweek("departmentstore")) %>
                </td>
                <% rs.MOVENEXT : rslastweek.MOVENEXT : NEXT : rs.MOVEFIRST : rslastweek.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnPercentFormat(rssum("departmentstore"),rslastweeksum("departmentstore")) %>
                </td>
              </tr>
              <tr align="center"> 
                <td colspan="7"><img src="../../electric/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td rowspan="5" class="list02_bg2">스포츠</td>
                <td colspan="2" class="list03_bg">예측값</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg"> 
                  <% =FnNumberForMat(rs("sports")) %>
                </td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnNumberFormat(rssum("sports")) %>
                </td>
              </tr>
              <tr> 
                <td rowspan="2" class="list03_bg2">동일</td>
                <td class="list03_bg2">전년실적</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rslast("sports")) %>
                </td>
                <% rslast.MOVENEXT : NEXT : rslast.MOVEFIRST %>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rslastsum("sports")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rs("sports"),rslast("sports")) %>
                </td>
                <% rs.MOVENEXT : rslast.MOVENEXT : NEXT : rs.MOVEFIRST : rslast.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnPercentFormat(rssum("sports"),rslastsum("sports")) %>
                </td>
              </tr>
              <tr> 
                <td rowspan="2" class="list03_bg2">동요일</td>
                <td class="list03_bg2">전년실적</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rslastweek("sports")) %>
                </td>
                <% rslastweek.MOVENEXT : NEXT : rslastweek.MOVEFIRST %>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rslastweeksum("sports")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rs("sports"),rslastweek("sports")) %>
                </td>
                <% rs.MOVENEXT : rslastweek.MOVENEXT : NEXT : rs.MOVEFIRST : rslastweek.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnPercentFormat(rssum("sports"),rslastweeksum("sports")) %>
                </td>
              </tr>
              <tr align="center"> 
                <td colspan="7"><img src="../../electric/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td rowspan="5" class="list02_bg2">쇼핑몰</td>
                <td colspan="2" class="list03_bg">예측값</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg"> 
                  <% =FnNumberForMat(rs("shoppingmall")) %>
                </td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnNumberFormat(rssum("shoppingmall")) %>
                </td>
              </tr>
              <tr> 
                <td rowspan="2" class="list03_bg2">동일</td>
                <td class="list03_bg2">전년실적</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rslast("shoppingmall")) %>
                </td>
                <% rslast.MOVENEXT : NEXT : rslast.MOVEFIRST %>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rslastsum("shoppingmall")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rs("shoppingmall"),rslast("shoppingmall")) %>
                </td>
                <% rs.MOVENEXT : rslast.MOVENEXT : NEXT : rs.MOVEFIRST : rslast.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnPercentFormat(rssum("shoppingmall"),rslastsum("shoppingmall")) %>
                </td>
              </tr>
              <tr> 
                <td rowspan="2" class="list03_bg2">동요일</td>
                <td class="list03_bg2">전년실적</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rslastweek("shoppingmall")) %>
                </td>
                <% rslastweek.MOVENEXT : NEXT : rslastweek.MOVEFIRST %>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rslastweeksum("shoppingmall")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rs("shoppingmall"),rslastweek("shoppingmall")) %>
                </td>
                <% rs.MOVENEXT : rslastweek.MOVENEXT : NEXT : rs.MOVEFIRST : rslastweek.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnPercentFormat(rssum("shoppingmall"),rslastweeksum("shoppingmall")) %>
                </td>
              </tr>
              <tr align="center"> 
                <td colspan="7"><img src="../../electric/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td rowspan="5" class="list02_bg2">마트</td>
                <td colspan="2" class="list03_bg">예측값</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg"> 
                  <% =FnNumberForMat(rs("mart")) %>
                </td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnNumberFormat(rssum("mart")) %>
                </td>
              </tr>
              <tr> 
                <td rowspan="2" width="50" class="list03_bg2">동일</td>
                <td class="list03_bg2">전년실적</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rslast("mart")) %>
                </td>
                <% rslast.MOVENEXT : NEXT : rslast.MOVEFIRST %>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rslastsum("mart")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rs("mart"),rslast("mart")) %>
                </td>
                <% rs.MOVENEXT : rslast.MOVENEXT : NEXT : rs.MOVEFIRST : rslast.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnPercentFormat(rssum("mart"),rslastsum("mart")) %>
                </td>
              </tr>
              <tr> 
                <td rowspan="2" class="list03_bg2">동요일</td>
                <td class="list03_bg2">전년실적</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg2"> 
                  <% =FnNumberFormat(rslastweek("mart")) %>
                </td>
                <% rslastweek.MOVENEXT : NEXT : rslastweek.MOVEFIRST %>
                <td class="list04_bg2"> 
                  <% =FnNumberFormat(rslastweeksum("mart")) %>
                </td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg"> 
                  <% =FnPercentFormat(rs("mart"),rslastweek("mart")) %>
                </td>
                <% rs.MOVENEXT : rslastweek.MOVENEXT : NEXT : rs.MOVEFIRST : rslastweek.MOVEFIRST %>
                <td class="list04_bg"> 
                  <% =FnPercentFormat(rssum("mart"),rslastweeksum("mart")) %>
                </td>
              </tr>
              <tr bgcolor="#CECFF5"> 
                <td height="10" colspan="7"></td>
              </tr>
            </table>
            <!--일예측 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td height="10"></td>
        </tr>
        <tr> 
          <td height="34" class="table02"> 
            <!--하단 버튼바 시작-->
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="637" align="right"><a href="../../electric/excel/elect_day_excel.asp"><img src="../../electric/images/download_button.gif" width="88" height="26" border=0></a></td>
                <td width="5"></td>
              </tr>
            </table>
            <!--하단 버튼바 끝-->
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
    <td height="42" colspan="3" align="right" background="../../electric/images/copyright_bg.gif"><img src="../../electric/images/copyright.gif" width="350" height="42"></td>
    <td bgcolor="#a4a4a4" width="1" height="42"><img src="../../electric/images/null.gif"></td>
  </tr>
</table>
</body>
</html>
<!-- #include file="../../electric/script/FnErrorCatch.inc" -->