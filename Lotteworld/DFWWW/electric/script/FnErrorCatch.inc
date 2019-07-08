<%
if err.number >0 then
 IF err.number=13 THEN
 ELSEIF err.number=3021 THEN
	response.Write "<script>alert('                               *     오      류     *\n\n 예측에 필요한 데이터가 모두 입력되지 않았습니다. \n예측값이 제대로 출력되지 않을 수 있습니다 \n관리자 확인 페이지에서 빠진 데이터를 점검하십시오\n상단에 관리자를 클릭하시면 해당 내역을 확인할 수 있습니다\n             - 관리자만이 열람 가능합니다 -')</script>"
 ELSE
	Response.Write "<script language=javascript>alert('오류발생(값이 제대로 뜨지 않을 수 있습니다- 심각하면 관리자에게 연락을 주십시오) \n\n오류내용("& Err.Number & ") : " & err.Description  & "')</script>"
 END IF
end if
%>