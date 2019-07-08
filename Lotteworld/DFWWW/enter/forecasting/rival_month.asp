<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' 프로그램ID : TXTRIVAL MONTH
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 경쟁사 예측 - 월
' 최초작성일 : 2002/10/24
' 최종작성일 : 2002/10/24
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim rs,rssum, rslotte, rslast,rslastsum '레코드셋 : 경쟁사 예측, 예측합계, 롯데 예측, 과거 실적, 과거 실적 합계
Dim intI '증감변수

ArrQuery = array()

'변수의 설정
Set objServer = Server.CreateObject("XTEnterRivalMonMTS.clsXTEnterRivalMNTX")

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
'네번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rslastsum,4

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
          <td align="left" height="21"><img src="../../enter/images/title_rival_month.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td> 
		  <!--에버랜드 타이틀 바 시작-->
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="15" height="11" class="table03"><img src="../../enter/images/orange_buret.gif" width="7" height="7"></td>
                <td class="title_01">에버랜드</td>
              </tr>
            </table>
			<!--에버랜드 타이틀 바 끝-->
          </td>
        </tr>
        <tr> 
          <td height="5"><img src="../../enter/images/null.gif" width="1" height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--에버랜드 월예측 테이블 시작--> 
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr class="list07_bg4"> 
                <td width="102">구분</td>
                <td width="108">목록</td>
				<% FOR intI=0 TO 2 %>
                <td width="108"><% =FnDateFormatMonth(Date(),intI) %></td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
                <td width="108">누계</td>
              </tr>
              <tr> 
                <td rowspan="3" class="list02_bg2">전체</td>
                <td class="list03_bg">예측값</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg"><% =FnNumberFormat(rs("evertotal")) %></td>
                <% rs.MOVENEXT : NEXT %>
                <td class="list04_bg"><% =FnNumberFormat(rssum("evertotal")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg2">전년실적</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg2"><%=FnNumberFormat(rslast("evertotal")) %></td>
                <% rslast.MOVENEXT : NEXT %>
                <td class="list04_bg2"><% =FnNumberFormat(rslastsum("evertotal")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% rs.MOVEFIRST : rslast.MOVEFIRST : FOR intI=0 TO 2 %> 
                <td class="list01_bg"><% =FnPercentFormat(rs("evertotal"),rslast("evertotal")) %></td>
                <% rs.MOVENEXT :  rslast.MOVENEXT :   NEXT %>
                <td class="list04_bg"><% =FnPercentFormat(rssum("evertotal"),rslastsum("evertotal"))%></td>
              </tr>
              <tr bgcolor="#B0DFFD"> 
                <td height="10" colspan="6"></td>
              </tr>
            </table>
			<!--에버랜드 월예측 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td height="30"><img src="../../enter/images/null.gif" width="1" height="30"></td>
        </tr>
        <tr> 
          <td>
		  <!--서울랜드 타이틀 바 시작--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="15" height="11" class="table03"><img src="../../enter/images/orange_buret.gif" width="7" height="7"></td>
                <td class="title_01">서울랜드</td>
              </tr>
            </table>
			<!--서울랜드 타이틀 바 끝-->
          </td>
        </tr>
        <tr> 
          <td height="5"><img src="../../enter/images/null.gif" width="1" height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--서울랜드 월예측 테이블 시작--> 
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr class="list07_bg4"> 
                <td width="102">구분</td>
                <td width="108">목록</td>
                <% FOR intI=0 TO 2 %>
                <td width="108"><% =FnDateFormatMonth(Date(),intI) %></td>
                <% NEXT %>
                <td width="108">누계</td>
              </tr>
              <tr> 
                <td rowspan="3" class="list02_bg2">전체</td>
                <td class="list03_bg">예측값</td>
                <% rs.MOVEFIRST : FOR intI=0 TO 2 %>
                <td class="list01_bg"><% =FnNumberFormat(rs("seoultotal")) %></td>
                <% rs.MOVENEXT :  NEXT %>
                <td class="list04_bg"><% =FnNumberFormat(rssum("seoultotal")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg2">전년실적</td>
                <% rslast.MOVEFIRST : FOR intI=0 TO 2 %>
                <td class="list01_bg2"><% =FnNumberFormat(rslast("seoultotal")) %></td>
                <% rslast.MOVENEXT : NEXT %>
                <td class="list04_bg2"><% =FnNumberFormat(rslastsum("seoultotal")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% rs.MOVEFIRST : rslast.MOVEFIRST : FOR intI=0 TO 2 %>
                <td class="list01_bg"><%=FnPercentFormat(rs("seoultotal"),rslast("seoultotal")) %></td>
                <% rs.MOVENEXT :  rslast.MOVENEXT :  NEXT %>
                <td class="list04_bg"><% =FnPercentFormat(rssum("seoultotal"),rslastsum("seoultotal"))%></td>
              </tr>
              <tr bgcolor="#B0DFFD"> 
                <td height="10" colspan="6"></td>
              </tr>
            </table>
			<!--서울랜드 월예측 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td height="30"></td>
        </tr>
        <tr>
		<!--하단 버튼 바 테이블 시작-->
		  <td height="34" class="table02"> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="637" align="right"><a href='../../enter/excel/rival_month_excel.asp'><img border=0 src="../../enter/images/download_button.gif" width="88" height="26"></a></td>
                <td width="5"></td>
              </tr>
            </table>
			<!--하단 버튼 바 테이블 끝-->
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