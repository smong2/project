<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' 프로그램ID : TXTENTERMAIN
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 입장객 예측 - 메인
' 최초작성일 : 2002/11/28
' 최종작성일 : 2002/11/28
' 개  발  자 : 박순몽(kweather)
' 사용    DB : TXTENTERMAIN
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim rs,rse,rssum, rsesum,rslast, rslaste,rslastsum, rslastesum,rslastweek,rslastweeke, rslastweeksum,rslastweekesum 
'레코드셋 (매표 예측,실입장 예측, 매표 예측 합계,실입장 예측 합계, 매표 전년동일,실입장 전년동일, 매표 전년동일 합계, 실입장 전년동일 합계, 매표 전년 동요일, 실입장 전년 동요일, 매표 전년동요일 합계, 실입장 전년동요일 합계)
dim intI '증가변수

%>
<!-- #include file="../../enter/script/FnSearch_Date.inc"-->
<%
ArrQuery = array(dtLastDay,dtLastWeekDay) '페이지에 맞는 코드 가져오고

'변수의 설정
Set objServer = Server.CreateObject("XTEnterMainQMTS.clsXTEnterMainQNTX")

'컴포넌트 호출
arrRValue = objServer.Query(ArrQuery)
'레코드셋 어레이를 단일 레코드셋으로 분리

'첫번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rs,1
'두번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rse,2
'세번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rslast,3
'네번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rslaste,4
'다섯번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rslastweek,5
'여섯번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rslastweeke,6
'일곱번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rssum,7
'여덟번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rsesum,8
'아홉번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rslastsum,9
'열번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rslastesum,10
'열한번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rslastweeksum,11
'열두번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rslastweekesum,12

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
<!-- #include file="../../enter/script/fnnumber_format.inc"-->		
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
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="24"><img src="../../enter/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
          <td align="left" height="21"><img src="../../enter/images/title_visitor.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td> 
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr class="list07_bg4"> 
                <td colspan="3">구분</td>
                <% FOR intI=0 to 2 %>
                <td><% =FnDateFormat(date()+intI) %></td>
                <% NEXT %>
                <td>누계</td>
              </tr>
              <tr> 
                <td rowspan="5" width="92" class="list02_bg2">매표입장객</td>
                <td colspan="2" class="list03_bg">예측값</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg" title=<% =rs("xdate") %>><% =FnNumberFormat(rs("total")) %></td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>                
                <td class="list04_bg"><% =FnNumberFormat(rssum("total")) %></td>
              </tr>
              <tr> 
                <td rowspan="2" width="50" class="list03_bg2">동일</td>
                <td width="68" class="list03_bg2">전년실적</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg2" title=<% =rslast("xdate") %>><% =FnNumberFormat(rslast("total")) %></td>
                <% rslast.MOVENEXT : NEXT : rslast.MOVEFIRST %>                
                <td class="list04_bg2"><% =FnNumberFormat(rslastsum("total")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg"><% =FnPercentFormat(rs("total"),rslast("total")) %></td>
                <% rs.MOVENEXT : rslast.MOVENEXT : NEXT : rs.MOVEFIRST : rslast.MOVEFIRST %>                
                <td class="list04_bg"><% =FnPercentFormat(rssum("total"),rslastsum("total")) %></td>
              </tr>
              <tr> 
                <td rowspan="2" class="list03_bg2">동요일</td>
                <td class="list03_bg2">전년실적</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg2" title=<% =rslastweek("xdate") %>><% =FnNumberFormat(rslastweek("total")) %></td>
                <% rslastweek.MOVENEXT : NEXT : rslastweek.MOVEFIRST %>                
                <td class="list04_bg2"><% =FnNumberFormat(rslastweeksum("total")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg"><% =FnPercentFormat(rs("total"),rslastweek("total")) %></td>
                <% rs.MOVENEXT : rslastweek.MOVENEXT : NEXT : rs.MOVEFIRST : rslastweek.MOVEFIRST %>                
                <td class="list04_bg"><% =FnPercentFormat(rssum("total"),rslastweeksum("total")) %></td>
              </tr>
              <tr align="center"> 
                <td colspan="7"><img src="../../enter/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td rowspan="5" width="92" class="list02_bg2">실입장객</td>
                <td colspan="2" class="list03_bg">예측값</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg" title=<% =rse("xdate") %>><% =FnNumberFormat(rse("total")) %></td>
                <% rse.MOVENEXT : NEXT : rse.MOVEFIRST %>                
                <td class="list04_bg"><% =FnNumberFormat(rsesum("total")) %></td>
              </tr>
              <tr> 
                <td rowspan="2" width="50" class="list03_bg2">동일</td>
                <td width="68" class="list03_bg2">전년실적</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg2" title=<% =rslaste("xdate") %>><% =FnNumberFormat(rslaste("total")) %></td>
                <% rslaste.MOVENEXT : NEXT : rslaste.MOVEFIRST %>                
                <td class="list04_bg2"><% =FnNumberFormat(rslastesum("total")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg"><% =FnPercentFormat(rse("total"),rslaste("total")) %></td>
                <% rse.MOVENEXT : rslaste.MOVENEXT : NEXT : rse.MOVEFIRST : rslaste.MOVEFIRST %>                
                <td class="list04_bg"><% =FnPercentFormat(rsesum("total"),rslastesum("total")) %></td>
              </tr>
              <tr> 
                <td rowspan="2" class="list03_bg2">동요일</td>
                <td class="list03_bg2" align="center">전년실적</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg2" title=<% =rslastweeke("xdate") %>><% =FnNumberFormat(rslastweeke("total")) %></td>
                <% rslastweeke.MOVENEXT : NEXT : rslastweeke.MOVEFIRST %>                
                <td class="list04_bg2"><% =FnNumberFormat(rslastweekesum("total")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg">전년비</td>
                <% FOR intI=0 to 2 %>
                <td class="list01_bg"><% =FnPercentFormat(rse("total"),rslastweeke("total")) %></td>
                <% rse.MOVENEXT : rslastweeke.MOVENEXT : NEXT : rs.MOVEFIRST : rslastweeke.MOVEFIRST %>                
                <td class="list04_bg"><% =FnPercentFormat(rsesum("total"),rslastweekesum("total")) %></td>
              </tr>
              <tr bgcolor="#B0DFFD"> 
                <td height="10" colspan="7"></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td height="30"><img src="../../enter/images/null.gif" width="1" height="30"></td>
        </tr>
      </table>
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
  <!-- #include file="../../enter/script/FnErrorCatch.inc" -->