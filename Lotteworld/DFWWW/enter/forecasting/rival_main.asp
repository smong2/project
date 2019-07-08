<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' 프로그램ID : RIVAL MAIN
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 경쟁사 예측 메인
' 최초작성일 : 2002/10/24
' 최종작성일 : 2002/11/21
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim rsrival,rsrivalsum, rslotte, rslottesum,rsrivalyear, rsrivalyearsum, rslotteyear, rslotteyearsum '레코드셋
   '라이벌 월 예측, 예측 월 합계, 롯데 월 예측, 롯데 월 함계, 라이벌 년 예측, 년 예측 합계, 롯데 년 예측, 롯데 년 합계

ArrQuery = array()

'변수의 설정
Set objServer = Server.CreateObject("XTEnterRivalMainMTS.clsXTEnterRivalMNTX")

'컴포넌트 호출 로직의 전개
' ...

'컴포넌트 호출
arrRValue = objServer.Query(ArrQuery)
'레코드셋 어레이를 단일 레코드셋으로 분리

'첫번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rsrival,1
'두번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rslotte,2
'세번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rsrivalsum,3
'네번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rslottesum,4
'다섯번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rsrivalyear,5
'여섯번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rslotteyear,6
'일곱번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rsrivalyearsum,7
'여덟번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rslotteyearsum,8

'자원의 해제
Set objServer = Nothing

'에러의 처리
IF Err.Number <> 0 THEN 
	Response.Write Err.Number, Err.Source, Err.Description
	Set objServer = Nothing
	objserver.close
END IF
%>
<!-- #include file="../../enter/script/FnProgramProcess.vbs" -->
<!-- #include file="../../enter/script/fnnumber_format.inc" -->
<html>
<head>
<title>롯데월드 수요예측시스템</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../../enter/css/cs_tx.css" type="text/css">
</head>
<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
  <tr> 
    <td width="49"><img src="../../enter/images/null.gif" width="49" height="1"></td>
    <td width="642" valign="top">
	<!--큰 테이블 시작--> 
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="24"><img src="../../enter/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr>
          <td align="left" height="21"><img src="../../enter/images/title_rival.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--경쟁사 월 타이틀 바 테이블 시작--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="15" height="11" class="table03"><img src="../../enter/images/vermilion_buret.gif" width="7" height="7"></td>
                <td class="title_01">경쟁사 <% =rsrival("month") %>월 예측</td>
              </tr>
            </table>
			<!--경쟁사 월 타이틀 바 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td height="5"><img src="../../enter/images/null.gif" width="1" height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--경쟁사 월 예측 테이블 시작--> 
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr class="list02_bg"> 
                <td width="102">구분</td>
                <td width="90">어른</td>
                <td width="90">중고생</td>
                <td width="90">어린이</td>
                <td width="90">총계</td>
                <td width="90">누계</td>
                <td width="90">비고</td>
              </tr>
              <tr> 
                <td class="list03_bg">롯데월드</td>
                <td class="list01_bg"><% =FnNumberFormat(rslotte("lotteadult")) %></td>
                <td class="list01_bg"><% =FnNumberFormat(rslotte("lotteschool")) %></td>
                <td class="list01_bg"><% =FnNumberFormat(rslotte("lottechild")) %></td>
                <td class="list01_bg"><% =FnNumberFormat(rslotte("lottetotal")) %></td>
                <td class="list04_bg"><% =FnNumberFormat(rslottesum("lottetotal")) %></td>
                <td class="list05_bg">실입장객</td>
              </tr>
              <tr> 
                <td class="list03_bg2">에버랜드</td>
                <td class="list01_bg2"><% =FnNumberFormat(rsrival("everadult")) %></td>
                <td class="list01_bg2"><% =FnNumberFormat(rsrival("everschool")) %></td>
                <td class="list01_bg2"><% =FnNumberFormat(rsrival("everchild")) %></td>
                <td class="list01_bg2"><% =FnNumberFormat(rsrival("evertotal")) %></td>
                <td class="list04_bg2"><% =FnNumberFormat(rsrivalsum("evertotal")) %></td>
                <td class="list05_bg2">실입장객</td>
              </tr>
              <tr> 
                <td class="list03_bg">서울랜드</td>
                <td class="list01_bg"><% =FnNumberFormat(rsrival("seouladult")) %></td>
                <td class="list01_bg"><% =FnNumberFormat(rsrival("seoulschool")) %></td>
                <td class="list01_bg"><% =FnNumberFormat(rsrival("seoulchild")) %></td>
                <td class="list01_bg"><% =FnNumberFormat(rsrival("seoultotal")) %></td>
                <td class="list04_bg"><% =FnNumberFormat(rsrivalsum("seoultotal")) %></td>
                <td class="list05_bg">실입장객</td>
              </tr>
              <tr bgcolor="#B0DFFD"> 
                <td height="10" colspan="7"></td>
              </tr>
            </table>
			<!--경쟁사 월 예측 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td height="30"><img src="../../enter/images/null.gif" width="1" height="30"></td>
        </tr>
        <tr> 
          <td> 
		  <!--경쟁사 년 타이틀 바 테이블 시작-->
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="15" height="11" class="table03"><img src="../../enter/images/vermilion_buret.gif" width="7" height="7"></td>
                <td class="title_01">경쟁사 <% =rsrival("year") %>년 예측</td>
              </tr>
            </table>
			<!--경쟁사 년 타이틀 바 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td height="5"><img src="../../enter/images/null.gif" width="1" height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--경쟁사 년 예측 테이블 시작--> 
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr class="list02_bg"> 
                <td width="102">구분</td>
                <td width="90">어른</td>
                <td width="90">중고생</td>
                <td width="90">어린이</td>
                <td width="90">총계</td>
                <td width="90">누계(2년간)</td>
                <td width="90">비고</td>
              </tr>
              <tr> 
                <td class="list03_bg">롯데월드</td>
                <td class="list01_bg"><% =FnNumberFormat(rslotteyear("lotteadult")) %></td>
                <td class="list01_bg"><% =FnNumberFormat(rslotteyear("lotteschool")) %></td>
                <td class="list01_bg"><% =FnNumberFormat(rslotteyear("lottechild")) %></td>
                <td class="list01_bg"><% =FnNumberFormat(rslotteyear("lottetotal")) %></td>
                <td class="list04_bg"><% =FnNumberFormat(rslotteyearsum("lottetotal")) %></td>
                <td class="list05_bg">실입장객</td>
              </tr>
              <tr> 
                <td class="list03_bg2">에버랜드</td>
                <td class="list01_bg2"><% =FnNumberFormat(rsrivalyear("everadult")) %></td>
                <td class="list01_bg2"><% =FnNumberFormat(rsrivalyear("everschool")) %></td>
                <td class="list01_bg2"><% =FnNumberFormat(rsrivalyear("everchild")) %></td>
                <td class="list01_bg2"><% =FnNumberFormat(rsrivalyear("evertotal")) %></td>
                <td class="list04_bg2"><% =FnNumberFormat(rsrivalyearsum("evertotal")) %></td>
                <td class="list05_bg2">실입장객</td>
              </tr>
              <tr> 
                <td class="list03_bg">서울랜드</td>
                <td class="list01_bg"><% =FnNumberFormat(rsrivalyear("seouladult")) %></td>
                <td class="list01_bg"><% =FnNumberFormat(rsrivalyear("seoulschool")) %></td>
                <td class="list01_bg"><% =FnNumberFormat(rsrivalyear("seoulchild")) %></td>
                <td class="list01_bg"><% =FnNumberFormat(rsrivalyear("seoultotal")) %></td>
                <td class="list04_bg"><% =FnNumberFormat(rsrivalyearsum("seoultotal")) %></td>
                <td class="list05_bg">실입장객</td>
              </tr>
              <tr bgcolor="#B0DFFD"> 
                <td height="10" colspan="7"></td>
              </tr>
            </table>
			<!--경쟁사 년 예측 테이블 끝-->
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
</body>
</html>
<!-- #include file="../../enter/script/FnErrorCatch.inc"-->