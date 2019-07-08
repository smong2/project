<!-- #include file="../../electric/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' 프로그램ID : User List
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 사용자 계정 보기
' 최초작성일 : 2002/12/09
' 최종작성일 : 2002/12/09
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

Dim objServer, arrRValue,arrRValueUI, ArrQuery, ArrQueryU, Arr '컴관련 변수들
Dim rs '수정 정보 가져오기
dim varInsert,intI '아이디,증가변수
Dim txtID, txtPASSWD, txtREPASSWD, txtMOBILE, txtTEL, txtDEPT, sltAUTHLEVEL '사용자 수정 값
DIM TxtDelete '옵션값

varID=Request("varID")
varInsert=Request.Form("varInsert")
Txtdelete=Request.Form("delete1")

IF varAuthlevel<>4 AND varAuthlevel<>7 AND varID<>Request.Cookies("ckID") THEN '계정 수정 권한 설정
Response.Write "<script>alert('자기 계정만 수정 가능합니다');history.go(-1)</script>"
END IF

IF varInsert="ok" THEN  '폼으로 값이 넘어오면 수정합니다.
txtREPASSWD=Request.Form("txtREPASSWD") '패스워드 수정
txtTEL=Request.Form("txtTEL") '전화번호
txtMOBILE=Request.Form("txtMOBILE") '핸드폰
txtDEPT=Request.Form("txtDEPT") '부서
sltAUTHLEVEL=Request.Form("sltAUTHLEVEL") '권한
 
 IF varNAME="" THEN varNAME="1"
 IF txtPASSWD="" THEN txtPASSWD=NULL
 IF txtID="" THEN txtID="없음"
 IF txtREPASSWD="" THEN txtREPASSWD=NULL

IF txtdelete="delete1" THEN
ArrQueryU =array("Delete",varID,varNAME,txtPASSWD,txtREPASSWD,txtTEL,txtMOBILE,txtDEPT,sltAUTHLEVEL) '삭제 쿼리변수
ELSE
ArrQueryU =array("Update",varID,varNAME,txtPASSWD,txtREPASSWD,txtTEL,txtMOBILE,txtDEPT,sltAUTHLEVEL) '수정 쿼리변수
END IF

Set objServer = Server.CreateObject("XBUserUIQMTS.clsXBUSERUIQTX") '수정 쿼리
arrRvalueUI=objServer.save(ArrQueryU)
Set objServer = Nothing
varInsert="" 
Response.Redirect "admin_acnt_list.asp"
END IF

ArrQuery = array("PerView",varID) '쿼리 변수

'변수의 설정
Set objServer = Server.CreateObject("XBUserUIQMTS.clsXBUSERUIQNTX") '읽기 쿼리

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
<!-- #include file="../../electric/script/FnProgramProcess.vbs" -->
<html>
<head>
<title>롯데월드 수요예측시스템</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../../electric/css/cs_te.css" type="text/css">
<script language='javascript'>
function Fncheck() {
if (document.form.txtDEPT.value=="") {
 alert("부서를 입력해주십시오");
 document.form.txtDEPT.focus();
 return false;
 }
 if (document.form.txtTEL.value=="") {
 alert("전화를 입력해주십시오");
 document.form.txtTEL.focus();
 return false;
 }
 if(confirm("전송하시겠습니까?")) 
   return true;
  else	
   return false;
} 
function Fndelete() {
document.form.delete1.checked = true ;
}
</script>
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload=document.form.txtREPASSWD.focus()>
<form method=post action=admin_acnt_modify.asp name=form onsubmit='return Fncheck()'>
<input type=hidden name=varInsert value=ok>
<input type=hidden name=varID value=<% =varID %>>
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
          <td><img src="../../electric/images/title_admin_acnt.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../electric/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td height="15"> 
		  <!--계정사용자 수정/삭제 타이틀 시작-->
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="15" height="11" class="table03"><img src="../../electric/images/orange_buret.gif" width="7" height="7"></td>
                <td class="title_01">계정 사용자 수정,삭제</td>
              </tr>
            </table>
			<!--계정사용자 수정/삭제 타이틀 끝-->
          </td>
        </tr>
        <tr> 
          <td height="5"><img src="../../electric/images/null.gif" width="1" height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--수정 테이블 시작--> 
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr bgcolor="#CECFF5"> 
                <td height="7" colspan="2"></td>
              </tr>
              <tr> 
                <td width="100" class="list13_bg">이름</td>
                <td class="list01_bg3"><% =rs("NAME") %></td>
              </tr>
              <tr> 
                <td class="list13_bg">아이디</td>
                <td class="list01_bg3"><% =rs("ID") %></td>
              </tr>
              <tr> 
                <td class="list13_bg">변경할비밀번호</td>
                <td class="list01_bg3"><input type=password name=txtREPASSWD maxlength=8> (기존비밀번호를 쓰실경우엔 공란으로 두세요)</td> 
              </tr>
              <tr> 
                <td class="list13_bg">부서</td>
                <td class="table01"> 
                  <input type="text" name="txtDEPT" size="20" value='<%=rs("DEPT") %>'>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">등급</td>
                <td class="list01_bg3"> 
                <% IF varAuthLevel=4 THEN %>                 
                <% IF rs("Authlevel")=3 THEN %>
                <select name=sltAuthlevel>
                <option value=1 selected>전기 일반</option>
                <option value=2>전기 관리</option>                
                <option value=6>잠긴 계정</option>                
                </select>                 
                <% ELSEIF rs("Authlevel")=4 THEN %>
                <select name=sltAuthlevel>
                <option value=1>전기 일반</option>
                <option value=2 selected>전기 관리</option>                                
                <option value=6>잠긴 계정</option>
                </select>                 
                <% ELSEIF rs("Authlevel")=6 THEN %>
                <select name=sltAuthlevel>
                <option value=1>전기 일반</option>
                <option value=2>전기 관리</option>                                
                <option value=6 selected>잠긴 계정</option>
                </select>                                         
                <% END IF %>
                
                <% ELSEIF varAuthLevel=7 THEN %>                 
                <% IF rs("Authlevel")=3 THEN %>
                <select name=sltAuthlevel>
                <option value=1>입장객 일반</option>
                <option value=2>입장객 관리</option>
                <option value=3 selected>전기 일반</option>
                <option value=4>전기 관리</option>
                <option value=6>잠긴 계정</option>                
                </select>                 
                <% ELSEIF rs("Authlevel")=4 THEN %>
                <select name=sltAuthlevel>
                <option value=1>입장객 일반</option>
                <option value=2>입장객 관리</option>
                <option value=3>전기 일반</option>
                <option value=4 selected>전기 관리</option>
                <option value=6>잠긴 계정</option>
                </select>                 
                <% ELSEIF rs("Authlevel")=6 THEN %>
                <select name=sltAuthlevel>
                <option value=1>입장객 일반</option>
                <option value=2>입장객 관리</option>
                <option value=3>전기 일반</option>
                <option value=4>전기 관리</option>
                <option value=6 selected>잠긴 계정</option>
                </select>                                                         
                <% ELSEIF rs("Authlevel")=7 THEN %>
                <select name=sltAuthlevel>
                <option value=1>입장객 일반</option>
                <option value=2>입장객 관리</option>
                <option value=3>전기 일반</option>
                <option value=4>전기 관리</option>
                <option value=6>잠긴 계정</option>
                <option value=7 selected>전체 관리</option>
                </select>                                         
                <% END IF %>                                
                <% ELSE %>
                 전기 일반
                <input type=hidden name=sltAuthlevel value=<% =rs("Authlevel") %>>
                <% END IF %>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">전화</td>
                <td class="table01"> 
                  <input type="text" name="txtTEL" size="20" value='<% =rs("TEL") %>'>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">핸드폰</td>
                <td class="table01"> 
                  <input type="text" name="txtMOBILE" size="20" value='<% =rs("MOBILE") %>'>
                </td>
              </tr>
              <tr bgcolor="#CECFF5"> 
                <td height="7" colspan="2"></td>
              </tr>
            </table>
			<!--수정 테이블 끝-->
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
			    <td width="362"></td>
			    <% IF varAuthLevel=4 or VarAuthLevel=7 THEN %>    
			    <td width="73"><input type=checkbox name=delete1 value=delete1><img src="../../electric/images/delete_bu.gif" width="53" height="26" border="0" align=absmiddle onclick=Fndelete()></td>
			    <% END IF %>
			    <td width="53"><input type=image src="../../electric/images/modity_bu.gif" width="53" height="26" border="0"></td>
			    <td width="76"><img src="../../electric/images/return_bu.gif" width="76" height="26" border="0" onclick=history.go(-1)></td>
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
</form>
</body>
</html>
<!-- #include file="../../electric/script/FnErrorCatch.inc" -->