<%
function FnDateFormat(df) '���Ⱓ ��¥ ǥ�� ���� (00/00/00)
FnDateFormat=month(df) & "��" & day(df) & "��" & weekdayname(weekday(df))
end function
%>