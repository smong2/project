<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' 프로그램ID : User List
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 사용자 계정 리스트 보기
' 최초작성일 : 2002/12/09
' 최종작성일 : 2002/12/09
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim rs '레코드셋  : 계정 리스트
dim intI '증가변수

ArrQuery = array("Tlist","View") '쿼리 변수

'변수의 설정
Set objServer = Server.CreateObject("XBUserUIQMTS.clsXBUSERUIQNTX")

'컴포넌트 호출
arrRValue = objServer.Query(ArrQuery)
'레코드셋 어레이를 단일 레코드셋으로 분리

'첫번째 레코드셋을 어레이로 변환
FnSplitRSArray arrRValue,rs,1

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
<!-- #include file="../../enter/script/FnAcntClassDescript.inc" -->
<html>
<head>
<title>롯데월드 수요예측시스템</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../../enter/css/cs_tx.css" type="text/css">
</head>

<body bgcolor="#f5f5f5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#ffffff">
  <tr> 
    <td width="49"><IMG height=1 src="../../enter/images/null.gif" width=49></td>
    <td width="642" valign="top"><!--큰 테이블 시작-->
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><IMG height=24 src="../../enter/images/null.gif" width=1></td>
        </tr>
        <tr> 
          <td><IMG height=21 src="../../enter/images/title_admin_acnt.gif" width=200></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><IMG height=5 src="../../enter/images/title_bar.gif" width=642></td>
        </tr>
        <tr> 
          <td height="15"><!--계정사용자목록 타이틀 시작--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="15" height="11" class="table03"><IMG height=7 src="../../enter/images/orange_buret.gif" width=7></td>
                <td class="title_01">계정 사용자 목록</td>
              </tr>
            </table><!--계정사용자목록 타이틀 끝-->
          </td>
        </tr>
        <tr> 
          <td><IMG height=5 src="../../enter/images/null.gif" width=1></td>
        </tr>
        <tr> 
          <td><!--목록 테이블 시작-->
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr bgcolor="#b0dffd"> 
                <td height="7" colspan="6"></td>
              </tr>
              <tr class="list13_bg"> 
                <td width="95">이름</td>
                <td width="105">아이디</td>
                <td width="108">부서</td>
                <td width="108">전화</td>
                <td width="126">최종접속시각</td>
                <td width="100">권한등급</td>
              </tr>
              <% DO UNTIL rs.EOF %>
              <tr> 
                <td class="list13_bg2"><a href=admin_acnt_modify.asp?varID=<% =rs("ID") %>><% =rs("NAME") %></td>
                <td class="list11_bg"><% =rs("ID") %></td>
                <td class="list14_bg2"><% =rs("DEPT") %></td>
                <td class="list14_bg2"><% =rs("TEL") %></td>
                <td class="list14_bg2"><% =FnConnecttime(rs("lastconnecttime")) %></td>
                <td class="list13_bg2"><% =FnAcntClassDescript(rs("AUTHLEVEL")) %></td>
              </tr>
              <% rs.MOVENEXT : LOOP %>
              <tr bgcolor="#b0dffd"> 
                <td height="7" colspan="6"></td>
              </tr>
            </table><!--목록 테이블 끝-->
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