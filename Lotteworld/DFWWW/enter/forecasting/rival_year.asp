<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' 프로그램ID : TXTRIVAL YEAR
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 경쟁사 예측 - 년
' 최초작성일 : 2002/10/24
' 최종작성일 : 2002/11/21
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim intI 
Dim rs,rslast, rssum '경쟁사 예측, 전년실적, 과거 1년 예측 2년 합계

ArrQuery = array()

'변수의 설정
Set objServer = Server.CreateObject("XTEnterRivalYearMTS.clsXTEnterRivalYNTX")

'컴포넌트 호출 로직의 전개
' ...

'컴포넌트 호출
arrRValue = objServer.Query(ArrQuery)
'레코드셋 어레이를 단일 레코드셋으로 분리

'첫번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rs,1
'두번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rslast,2
'세번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rssum,3

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
          <td align="left" height="21"><img src="../../enter/images/title_rival_year.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--에버랜드 타이틀 시작--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="15" height="11" class="table03"><img src="../../enter/images/orange_buret.gif" width="7" height="7"></td>
                <td class="title_01">에버랜드</td>
              </tr>
            </table>
			<!--에버랜드 타이틀 끝-->
          </td>
        </tr>
        <tr> 
          <td height="5"><img src="../../enter/images/null.gif" width="1" height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--에버랜드 년예측 테이블 시작--> 
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr class="list07_bg4"> 
                <td width="102">구분</td>
                <td width="108">
                  <% =rslast("year") %>
                  년</td>
                <% FOR intI=0 to 1 %>
                <td width="108">
                  <% =Year(date())+intI %>
                  년</td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
                <td width="108">누계</td>
              </tr>
              <tr> 
                <td class="list02_bg2">전체</td>
                <td class="list01_bg2">
                  <% =FnNumberFormat(rslast("evertotal")) %>
                </td>
                <% FOR intI=0 TO 1 %>
                <td class="list01_bg2">
                  <% =FnNumberFormat(rs("evertotal")) %>
                </td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
                <td class="list04_bg2">
                  <% =FnNumberFormat(clng(rslast("evertotal"))+clng(rssum("evertotal"))) %>
                </td>
              </tr>
            </table>
			<!--에버랜드 년예측 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td height="30"><img src="../../enter/images/null.gif" width="1" height="30"></td>
        </tr>
        <tr> 
          <td>
		  <!--서울랜드 타이틀 시작--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="15" height="11" class="table03"><img src="../../enter/images/orange_buret.gif" width="7" height="7"></td>
                <td class="title_01">서울랜드</td>
              </tr>
            </table>
			<!--서울랜드 타이틀 끝-->
          </td>
        </tr>
        <tr> 
          <td height="5"><img src="../../enter/images/null.gif" width="1" height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--서울랜드 년예측 테이블 시작--> 
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr class="list07_bg4"> 
                <td width="102">구분</td>
                <td width="108">
                  <% =rslast("year") %>
                  년</td>
                <% FOR intI=0 to 1 %>
                <td width="108">
                  <% =Year(date())+intI %>
                  년</td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
                <td width="108">누계</td>
              </tr>
              <tr> 
                <td class="list02_bg2">전체</td>
                <% rs.MOVEFIRST %>
                <td class="list01_bg2">
                  <% =FnNumberFormat(rslast("seoultotal")) %>
                </td>
                <% FOR intI=0 TO 1 %>
                <td class="list01_bg2">
                  <% =FnNumberFormat(rs("seoultotal")) %>
                </td>
                <% rs.MOVENEXT : NEXT %>
                <td class="list04_bg2">
                  <% =FnNumberFormat(clng(rslast("seoultotal"))+clng(rssum("seoultotal"))) %>
                </td>
              </tr>
            </table>
			<!--서울랜드 년예측 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td height="30"></td>
        </tr>
		<tr>
		<!--하단 버튼 바 시작-->
		  <td height="34" class="table02"> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="637" align="right"><a href='../../enter/excel/rival_year_excel.asp'><img border=0 src="../../enter/images/download_button.gif" width="88" height="26"></a></td>
                <td width="5"></td>
              </tr>
            </table>
			<!--하단 버튼 바 끝-->
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