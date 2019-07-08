<%
FUNCTION FnDateFormat(df) '��¥ ǥ�� ���� (00/00/00)
	FnDateFormat=month(df) & "��" & day(df) & "��(" & left(WeekdayName(Weekday(df)),1) & ")"
END FUNCTION

FUNCTION FnDateFormatMonth(df,Num) '��¥ ǥ�� ���� ( �� ��)
	FnDateFormatMonth=Year(dateadd("m",Num,date())) & "�� " & Month(dateadd("m",Num,date())) & "��"
END FUNCTION

FUNCTION FnNumberFormat(format_number)  '���� ��� ����
	IF ISNULL(format_number) THEN
		FnNumberFormat="�ڷ����"
	ELSE	   
		FnNumberFormat=formatnumber(format_number,0)
	END IF
	
END FUNCTION

FUNCTION FnPercentFormat(format_percent1, format_percent2) '����� ���ϱ�
	IF isnull(format_percent1) or isnull(format_percent2) THEN
		FnPercentFormat="�ڷ����"
	ELSE
		FnPercentFormat=FnNumberFormat(format_percent1)/FnNumberFormat(format_percent2)
		FnPercentFormat=formatpercent(FnPercentFormat,2)
	END IF
END FUNCTION
%>