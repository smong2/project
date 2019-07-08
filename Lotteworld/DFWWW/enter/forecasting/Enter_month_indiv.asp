<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' 프로그램ID : Enter_Month_Indiv
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 입장객 예측 - 월-개인
' 최초작성일 : 2002/10/16
' 최종작성일 : 2002/11/21
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim rs,rslast, rssum, rslastsum '레코드셋 : 예측값, 전년실적, 예측값 합계, 전년실적 합계
dim varEnterType '입장객 모형
Dim intI '증감변수

varEnterType=Request.QueryString("varEnterType")

ArrQuery = array(varEnterType,"indiv")

'변수의 설정
Set objServer = Server.CreateObject("XTEnterMonthMTS.clsXTEnterMonthNTX")

'컴포넌트 호출
arrRValue = objServer.Query(ArrQuery)
'레코드셋 어레이를 단일 레코드셋으로 분리

'첫번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rs,1
'두번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rslast,2
'첫번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rssum,3
'두번째 레코드셋을 어레이로 변환
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
<!-- #include file="../../enter/script/FnEnterTypeImage.vbs" -->
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
          <td align="left"><img src="../../enter/images/<% =FnChangeImage(varEnterType,"Month2") %>" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td> 
		  <!--표 테이블 시작-->
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr class="list07_bg3"> 
                <td colspan="2">구분</td>
				<% For intI=0 TO 2 %>
                <td><% =FnDateFormatMonth(Date(),intI) %></td>
                <% rs.MOVENEXT : NEXT  : rs.MOVEFIRST %>
                <td>누계</td>
              </tr>
              <tr> 
                <td rowspan="3" class="list02_bg2">전체</td>
                <td class="list03_bg">예측값</td>
                <% For intI=0 TO 2 %>
                <td class="list01_bg"><% =FnNumberFormat(rs("indivtotal")) %></td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
                <td class="list04_bg"><% =FnNumberFormat(rssum("indivtotal")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg2">전년실적</td>
                <% For intI=0 TO 2 %>
                <td class="list01_bg2"><% =FnNumberFormat(rslast("indivtotal")) %></td>
                <% rslast.MOVENEXT : NEXT : rslast.MOVEFIRST %>
                <td class="list04_bg2"><% =FnNumberFormat(rslastsum("indivtotal")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% For intI=0 TO 2 %>
                <td class="list01_bg"><% =FnPercentFormat(rs("indivtotal"),rslast("indivtotal")) %></td>
                <% rs.MOVENEXT : rslast.MOVENEXT : NEXT : rs.MOVEFIRST : rslast.MOVEFIRST %>
                <td class="list04_bg"><% =FnPercentFormat(rssum("indivtotal"),rslastsum("indivtotal")) %></td>
              </tr>
              <tr align="center"> 
                <td colspan="6"><img src="../../enter/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td rowspan="3" class="list02_bg2">어른</td>
                <td class="list03_bg">예측값</td>
                <% For intI=0 TO 2 %>
                <td class="list01_bg"><% =FnNumberFormat(rs("indivadult")) %></td>
                <% rs.MOVENEXT : NEXT  : rs.MOVEFIRST %>
                <td class="list04_bg"><% =FnNumberFormat(rssum("indivadult")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg2">전년실적</td>
                <% For intI=0 TO 2 %>
                <td class="list01_bg2"><% =FnNumberFormat(rslast("indivadult")) %></td>                
                <% rslast.MOVENEXT : NEXT  : rslast.MOVEFIRST %>
                <td class="list04_bg2"><% =FnNumberFormat(rslastsum("indivadult")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% For intI=0 TO 2 %>
                <td class="list01_bg"><% =FnPercentFormat(rs("indivadult"),rslast("indivadult")) %></td>
                <% rs.MOVENEXT : rslast.MOVENEXT : NEXT : rs.MOVEFIRST : rslast.MOVEFIRST %>
                <td class="list04_bg"><% =FnPercentFormat(rssum("indivadult"),rslastsum("indivadult")) %></td>
              </tr>
              <tr align="center"> 
                <td colspan="6"><img src="../../enter/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td rowspan="3" class="list02_bg2">중고생</td>
                <td class="list03_bg">예측값</td>
                <% For intI=0 TO 2 %>
                <td class="list01_bg"><% =FnNumberFormat(rs("indivschool")) %></td>
                <% rs.MOVENEXT : NEXT  : rs.MOVEFIRST %>
                <td class="list04_bg"><% =FnNumberFormat(rssum("indivschool")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg2">전년실적</td>
                <% For intI=0 TO 2 %>
                <td class="list01_bg2"><% =FnNumberFormat(rslast("indivschool")) %></td>                
                <% rslast.MOVENEXT : NEXT  : rslast.MOVEFIRST %>
                <td class="list04_bg2"><% =FnNumberFormat(rslastsum("indivschool")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% For intI=0 TO 2 %>
                <td class="list01_bg"><% =FnPercentFormat(rs("indivschool"),rslast("indivschool")) %></td>
                <% rs.MOVENEXT : rslast.MOVENEXT : NEXT : rs.MOVEFIRST : rslast.MOVEFIRST %>
                <td class="list04_bg"><% =FnPercentFormat(rssum("indivschool"),rslastsum("indivschool")) %></td>
              </tr>
              <tr align="center"> 
                <td colspan="6"><img src="../../enter/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td rowspan="3" class="list02_bg2">어린이</td>
                <td class="list03_bg">예측값</td>
                 <% For intI=0 TO 2 %>
                <td class="list01_bg"><% =FnNumberFormat(rs("indivchild")) %></td>
                <% rs.MOVENEXT : NEXT  : rs.MOVEFIRST %>
                <td class="list04_bg"><% =FnNumberFormat(rssum("indivchild")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg2">전년실적</td>
                <% For intI=0 TO 2 %>
                <td class="list01_bg2"><% =FnNumberFormat(rslast("indivschool")) %></td>                
                <% rslast.MOVENEXT : NEXT  : rslast.MOVEFIRST %>
                <td class="list04_bg2"><% =FnNumberFormat(rslastsum("indivschool")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% For intI=0 TO 2 %>
                <td class="list01_bg"><% =FnPercentFormat(rs("indivchild"),rslast("indivchild")) %></td>
                <% rs.MOVENEXT : rslast.MOVENEXT : NEXT : rs.MOVEFIRST : rslast.MOVEFIRST %>
                <td class="list04_bg"><% =FnPercentFormat(rssum("indivchild"),rslastsum("indivchild")) %></td>
              </tr>
              <tr bgcolor="#B0DFFD"> 
                <td height="10" colspan="6"></td>
              </tr>
            </table>
			<!--표 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td height="10"></td>
        </tr>
        <tr>
		  <td height="34" class="table02">
		  <!--하단 버튼 바 테이블 시작--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="637" align="right"><a href=../../enter/excel/Enter_month_indiv_excel.asp?varEnterType=<% =varEnterType %>><img border=0 src="../../enter/images/download_button.gif" width="88" height="26"></a></td>
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