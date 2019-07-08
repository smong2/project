<!-- #include file="../../enter/script/FnLoginAuth_admin.inc" -->
<%
' ========================================================================================================
' 프로그램ID : TXBReforecast 
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 입장객 재예측 
' 최초작성일 : 2002/11/07
' 최종작성일 : 2002/11/21
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================

'변수의 선언
Dim objServer, arrRValue, ArrQuery, Arr '컴관련 변수들
Dim intI '증감변수
Dim intInput_Year_Start,intInput_Month_Start,intInput_Day_Start,intInput_Year_End,intInput_Month_End,intInput_Day_End
Dim sltGubun,hidMode,varStartDate,varEndDate,hidInsert  '사용자 입력값

hidInsert=Request.Form("hidInsert") '폼 변수
hidMode=Request.Form("hidmode") '일,월,년 선택
intInput_Year_Start=Request.Form("sltinput_Year_Start") '시작 년
intInput_Year_End=Request.Form("sltinput_Year_End") '종료 년
intInput_Month_Start=Request.Form("sltinput_Month_Start") '시작 월
intInput_Month_End=Request.Form("sltinput_Month_End") '종료 월
intInput_Day_Start=Request.Form("sltinput_Day_Start") '시작 일
intInput_Day_End=Request.Form("sltinput_Day_End") '종료 일

if intInput_Month_Start="" then intInput_Month_Start=01  '아무 것도 없을땐 일단 01을 넣어둔다.
if intInput_Month_End="" then intInput_Month_End=01
if intInput_Day_Start="" then intInput_Day_Start=01
if intInput_Day_End="" then intInput_Day_End=01

sltGubun=Request.Form("sltgubun") '모델 모형 선택

varStartDate=intInput_Year_Start & "-" & intInput_Month_Start & "-" & intInput_Day_Start '날짜포맷을 생성
varEndDate=intInput_Year_End & "-" & intInput_Month_End & "-" & intInput_Day_End  

if hidInsert="ok" then '입력될때 쿼리 변수 저장
	ArrQuery = array(hidMode,sltGubun,varStartDate,varEndDate)

	'변수의 설정
	Set objServer = Server.CreateObject("XTEnterRefcIMTS.clsXTEnterRefcITX")

	'컴포넌트 호출
	arrRValue = objServer.Save(ArrQuery)
	
	'자원의 해제
	Set objServer = Nothing
	
	hidInsert=""
end if

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
          <td align="left"><img src="../../enter/images/title_vari_reforecast.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td height="42" class="table07">
		  <!--년 재예측 타이틀 박스 시작--> 
            <table border="0" cellspacing="0" cellpadding="0" width="142">
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge1.gif" width="6" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge_top.gif" width="130" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge2.gif" width="6" height="6"></td>
              </tr>
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge_left.gif" width="6" height="20"></td>
                <td class="title_01_c"><img src="../../enter/images/vermilion_buret.gif" width="7" height="7"> 
                  년 재예측</td>
                <td><img src="../../enter/images/gray_round_s_edge_right.gif" width="6" height="20"></td>
              </tr>
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge3.gif" width="6" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge_bottom.gif" width="130" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge4.gif" width="6" height="6"></td>
              </tr>
            </table>
			<!--년 재예측 타이틀 박스 끝-->
          </td>
        </tr>
        <tr> 
          <td height="40" class="table06"> 
           <form method=post name=form_year action=admin_vari_reforecast.asp>
		   <!--년 재예측 모델유형 시작-->
            <table width="400" border="0" cellspacing="0" cellpadding="0" class="title_01">
              <tr> 
                <td width="18"></td>
                <td><img src="../../enter/images/vermilion_triangle2.gif" width="5" height="9"> 
                  모델유형 : 년 재예측 
                  <select name="sltGubun">
                    <option value=TAI>롯데월드 실수요 어른 개인</option>
                    <option value=TSI>롯데월드 실수요 학생 개인</option>
                    <option value=TCI>롯데월드 실수요 어린이 개인</option>
                    <option value=ETI>롯데월드 실입장 전체 개인</option>
                    <option value=TAG>롯데월드 실수요 어른 단체</option>
                    <option value=TSG>롯데월드 실수요 학생 단체</option>
                    <option value=TCG>롯데월드 실수요 어린이 단체</option>
                    <option value=ETG>롯데월드 실입장 전체 단체</option>
                    <option value=SAR>경쟁사 : 서울랜드 어른</option>
                    <option value=SSR>경쟁사 : 서울랜드 학생</option>
                    <option value=SCR>경쟁사 : 서울랜드 어린이</option>
                    <option value=EAR>경쟁사 : 에버랜드 어른</option>
                    <option value=ESR>경쟁사 : 에버랜드 학생</option>
                    <option value=ECR>경쟁사 : 에버랜드 어린이</option>
                  </select>                  
                </td>
              </tr>
            </table>
			<!--년 재예측 모델유형 끝-->
          </td>
        </tr>
        <tr> 
          <td height="50" class="table01">
		  <!--년 재예측 입력일자 시작--> 
            <table width="303" border="0" cellspacing="0" cellpadding="0" class="title_01">
              <tr> 
                <td width="18"></td>
                <td><img src="../../enter/images/vermilion_triangle2.gif" width="5" height="9"> 
                  입력일자 : 
                  <select name="sltInput_Year_Start">
                    <% FOR intI=2002 TO 2010 %>
                    <option value=<% =intI %>><% =intI %>년</option>
                    <% NEXT %>
                  </select>
                  ~ 
                  <select name="sltInput_Year_End">
                    <% FOR intI=2002 TO 2010 %>
                    <option value='<% =intI %>'><% =intI %>년</option>
                    <% NEXT %>
                  </select>
                  <input type=hidden name='hidMode' value='Y'>
                  <input type=hidden name='hidInsert' value='ok'>
                </td>                
                <td width="53"><input type=image src="../../enter/images/save.gif" width="53" height="26"></td>
              </tr>
            </table>
			<!--년 재예측 입력일자 끝-->            
            </form>
          </td>
        </tr>
        <tr> 
          <td height="3"></td>
        </tr>
        <tr> 
          <td height="1"><img src="../../enter/images/point_line7.gif" width="642" height="1"></td>
        </tr>
        <tr> 
          <td height="30"></td>
        </tr>
        <tr> 
          <td height="42" class="table07">
		  <!--월 재예측 타이틀 박스 시작--> 
            <table border="0" cellspacing="0" cellpadding="0" width="142">
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge1.gif" width="6" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge_top.gif" width="130" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge2.gif" width="6" height="6"></td>
              </tr>
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge_left.gif" width="6" height="20"></td>
                <td class="title_01_c"><img src="../../enter/images/yellowgreen_buret.gif" width="7" height="7"> 
                  월 재예측</td>
                <td><img src="../../enter/images/gray_round_s_edge_right.gif" width="6" height="20"></td>
              </tr>
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge3.gif" width="6" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge_bottom.gif" width="130" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge4.gif" width="6" height="6"></td>
              </tr>
            </table>
			<!--월 재예측 타이틀 박스 끝-->
          </td>
        </tr>
        <tr> 
          <td height="40" class="table06">
             <form method=post name=form_month action=admin_vari_reforecast.asp>
			 <!--월 재예측 모델유형 시작-->
            <table width="400" border="0" cellspacing="0" cellpadding="0" class="title_01">
              <tr> 
                <td width="18"></td>
                <td><img src="../../enter/images/yellowgreen_triangle2.gif" width="5" height="9"> 
                  모델유형 : 월 재예측 
                  <select name="sltGubun">
                    <option value=TAI>롯데월드 실수요 어른 개인</option>
                    <option value=TSI>롯데월드 실수요 학생 개인</option>
                    <option value=TCI>롯데월드 실수요 어린이 개인</option>
                    <option value=ETI>롯데월드 실입장 전체 개인</option>
                    <option value=TAG>롯데월드 실수요 어른 단체</option>
                    <option value=TSG>롯데월드 실수요 학생 단체</option>
                    <option value=TCG>롯데월드 실수요 어린이 단체</option>
                    <option value=ETG>롯데월드 실입장 전체 단체</option>
                    <option value=SAR>경쟁사 : 서울랜드 어른</option>
                    <option value=SSR>경쟁사 : 서울랜드 학생</option>
                    <option value=SCR>경쟁사 : 서울랜드 어린이</option>
                    <option value=EAR>경쟁사 : 에버랜드 어른</option>
                    <option value=ESR>경쟁사 : 에버랜드 학생</option>
                    <option value=ECR>경쟁사 : 에버랜드 어린이</option>
                  </select>
                </td>
              </tr>
            </table>
			<!--월 재예측 모델유형 끝-->
          </td>
        </tr>
        <tr> 
          <td height="50" class="table01"> 
		  <!--월 예측 입력일자 시작-->
            <table width="420" border="0" cellspacing="0" cellpadding="0" class="title_01">
              <tr> 
                <td width="18"> </td>
                <td><img src="../../enter/images/yellowgreen_triangle2.gif" width="5" height="9"> 
                  입력일자 : 
                  <select name="sltInput_Year_Start">
                  <% FOR intI=2002 TO 2010 %>
                    <option value=<% =intI %>><% =intI %>년</option>
                  <% NEXT %>
                  </select>                  
                  <select name="sltInput_Month_Start">
                  <% FOR intI=1 TO 12 %>
                    <option value=<% =intI %>><% =intI %>월</option>
                  <% NEXT %>
                  </select>
                  ~ 
                  <select name="sltInput_Year_End">
                  <% FOR intI=2002 TO 2010 %>
                    <option value=<% =intI %>><% =intI %>년</option>
                  <% NEXT %>
                  </select>                  
                  <select name="sltInput_Month_End">
                  <% FOR intI=1 TO 12 %>
                    <option value=<% =intI %>><% =intI %>월</option>
                  <% NEXT %>
                  </select>
                  <input type=hidden name=hidMode value=M>
                  <input type=hidden name=hidInsert value='ok'>
                </td>                
                <td width="53"><input type=image src="../../enter/images/save.gif" width="53" height="26"></td>
              </tr>
            </table>
			<!--월 예측 입력일자 끝-->            
            </form>
          </td>
        </tr>
        <tr> 
          <td height="3"></td>
        </tr>
        <tr> 
          <td height="1"><img src="../../enter/images/point_line7.gif" width="642" height="1"></td>
        </tr>
        <tr> 
          <td height="30"></td>
        </tr>
        <tr> 
          <td height="42" class="table07">
		  <!--일 재예측 타이틀 박스 시작--> 
            <table border="0" cellspacing="0" cellpadding="0" width="142">
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge1.gif" width="6" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge_top.gif" width="130" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge2.gif" width="6" height="6"></td>
              </tr>
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge_left.gif" width="6" height="20"></td>
                <td class="title_01_c"><img src="../../enter/images/green_buret.gif" width="7" height="7"> 
                  일 재예측</td>
                <td><img src="../../enter/images/gray_round_s_edge_right.gif" width="6" height="20"></td>
              </tr>
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge3.gif" width="6" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge_bottom.gif" width="130" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge4.gif" width="6" height="6"></td>
              </tr>
            </table>
			<!--일 재예측 타이틀 박스 끝-->
          </td>
        </tr>
        <tr> 
          <td height="40" class="table06"> 
           <form method=post name=form_day action=admin_vari_reforecast.asp>
		   <!--일 재예측 모델유형 시작-->
            <table width="400" border="0" cellspacing="0" cellpadding="0" class="title_01">
              <tr> 
                <td width="18"></td>
                <td><img src="../../enter/images/green_triangle2.gif" width="5" height="9"> 
                  모델유형 : 일 재예측 
                  <select name="sltGubun">
                    <option value=SAR>경쟁사 : 서울랜드 어른</option>
                    <option value=SSR>경쟁사 : 서울랜드 학생</option>
                    <option value=SCR>경쟁사 : 서울랜드 어린이</option>
                    <option value=EAR>경쟁사 : 에버랜드 어른</option>
                    <option value=ESR>경쟁사 : 에버랜드 학생</option>
                    <option value=ECR>경쟁사 : 에버랜드 어린이</option>                    
                  </select>
                </td>
              </tr>
            </table>
			<!--일 재예측 모델유형 끝-->
          </td>
        </tr>
        <tr> 
          <td height="50" class="table01">
		  <!--일 재예측 입력일자 시작--> 
            <table width="535" border="0" cellspacing="0" cellpadding="0" class="title_01">
              <tr> 
                <td width="18"></td>
                <td><img src="../../enter/images/green_triangle2.gif" width="5" height="9"> 
                  입력일자 : 
                  <select name="sltInput_Year_Start">
                  <% FOR intI=2002 TO 2010 %>
                    <option value=<% =intI %>><% =intI %>년</option>
                  <% NEXT %>
                  </select>                  
                  <select name="sltInput_Month_Start">
                  <% FOR intI=1 TO 12 %>
                    <option value=<% =intI %>><% =intI %>월</option>
                  <% NEXT %>
                  </select>
                  <select name="sltInput_Day_Start">
                  <% FOR intI=1 TO 31 %>
                    <option value=<% =intI %>><% =intI %>일</option>
                  <% NEXT %>
                  </select>
                  ~ 
                  <select name="sltInput_Year_End">
                  <% FOR intI=2002 TO 2010 %>
                    <option value=<% =intI %>><% =intI %>년</option>
                  <% NEXT %>
                  </select>                  
                  <select name="sltInput_Month_End">
                  <% FOR intI=1 TO 12 %>
                    <option value=<% =intI %>><% =intI %>월</option>
                  <% NEXT %>
                  </select>                  
                  <select name="sltInput_Day_End">
                  <% FOR intI=1 TO 31 %>
                    <option value=<% =intI %>><% =intI %>일</option>
                  <% NEXT %>
                  </select>
                  <input type=hidden name=hidMode value=D>        
                  <input type=hidden name='hidInsert' value='ok'>          
                </td>
                <td width="53"><input type=image src="../../enter/images/save.gif" width="53" height="26"></td>
              </tr>
            </table>
			<!--일 재예측 입력일자 끝-->            
            </form>
          </td>
        </tr>
        <tr> 
          <td height="3"></td>
        </tr>
        <tr> 
          <td height="1"><img src="../../enter/images/point_line7.gif" width="642" height="1"></td>
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

