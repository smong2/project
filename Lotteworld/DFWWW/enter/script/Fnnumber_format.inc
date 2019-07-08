<%
FUNCTION FnDateFormat(df) '날짜 표시 형식 (00/00/00)
	FnDateFormat=month(df) & "월" & day(df) & "일(" & left(WeekdayName(Weekday(df)),1) & ")"
END FUNCTION

FUNCTION FnDateFormatMonth(df,Num) '날짜 표시 형식 ( 년 월)
	FnDateFormatMonth=Year(dateadd("m",Num,date())) & "년 " & Month(dateadd("m",Num,date())) & "월"
END FUNCTION

FUNCTION FnNumberFormat(format_number)  '숫자 출력 형식
	IF ISNULL(format_number) THEN
		FnNumberFormat="자료없음"
	ELSE	   
		FnNumberFormat=formatnumber(format_number,0)
	END IF
	
END FUNCTION

FUNCTION FnPercentFormat(format_percent1, format_percent2) '전년비 구하기
	IF isnull(format_percent1) or isnull(format_percent2) THEN
		FnPercentFormat="자료없음"
	ELSE
		FnPercentFormat=FnNumberFormat(format_percent1)/FnNumberFormat(format_percent2)
		FnPercentFormat=formatpercent(FnPercentFormat,2)
	END IF
END FUNCTION
%>