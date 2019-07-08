<%
function FnDateFormat(df) '행사기간 날짜 표시 형식 (00/00/00)
FnDateFormat=month(df) & "월" & day(df) & "일" & weekdayname(weekday(df))
end function
%>