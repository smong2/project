<%
FUNCTION FnDateFormat(df) '날짜 표시 형식 (00/00/00)
	FnDateFormat=month(df) & "월" & day(df) & "일(" & left(WeekdayName(Weekday(df)),1) & ")"
END FUNCTION

FUNCTION FnDateFormatMonth(df,Num) '날짜 표시 형식 ( 년 월)
	FnDateFormatMonth=Year(dateadd("m",Num,date())) & "년 " & Month(dateadd("m",Num,date())) & "월"
END FUNCTION

FUNCTION FnNumberFormat(format_number)  '숫자 출력 형식
	IF isnull(format_number) THEN
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


FUNCTION FnReportPercentFormat(format_percent1, format_percent2) '전기 보고서용 전년비 구하기
	IF isnull(format_percent1) or isnull(format_percent2) THEN
		FnReportPercentFormat="자료없음"
	ELSE
		FnReportPercentFormat=(FnNumberFormat(format_percent1)-FnNumberFormat(format_percent2))/FnNumberFormat(format_percent2)	
		FnReportPercentFormat=formatpercent(ABS(FnReportPercentFormat),1)		
	END IF
END FUNCTION

FUNCTION FnReportPercentIncreaseFormat(format_percent1, format_percent2) '전기 보고서용 증감 포함 전년비 구하기
	IF isnull(format_percent1) or isnull(format_percent2) THEN
		FnReportPercentIncreaseFormat="자료없음"
	ELSE
		FnReportPercentIncreaseFormat=(FnNumberFormat(format_percent1)-FnNumberFormat(format_percent2))/FnNumberFormat(format_percent2)	
	END IF
	
	IF FnNumberFormat(format_percent1)-FnNumberFormat(format_percent2) > 0 THEN
	 FnReportPercentIncreaseFormat="▲ " & FormatPercent(abs(FnReportPercentIncreaseFormat),1)
	ELSEIF FnNumberFormat(format_percent1)-FnNumberFormat(format_percent2) < 0 THEN
	 FnReportPercentIncreaseFormat="▽ " & FormatPercent(abs(FnReportPercentIncreaseFormat),1)
	ELSE
	 FnReportPercentIncreaseFormat=FnReportPercentIncreaseFormat  
	END IF		 
END FUNCTION


FUNCTION FnReportIncreaseFormat(format_percent1, format_percent2) '전기 보고서용 증감구하기
	IF isnull(format_percent1) or isnull(format_percent2) THEN
		FnPercentFormat="자료없음"
	ELSE
		FnReportIncreaseFormat=FnNumberFormat(FnNumberFormat(format_percent1)-FnNumberFormat(format_percent2))
		
		IF FnReportIncreaseFormat>0 THEN  '증감별 화살표 넣기
			FnReportIncreaseFormat="▲" & FnReportIncreaseFormat
		ELSEIF FnReportIncreaseFormat=0 THEN
			FnReportIncreaseFormat="  " & FnReportIncreaseFormat
		ELSE
			FnReportIncreaseFormat="▽" & FnNumberFormat(ABS(FnReportIncreaseFormat))
		END IF				
	END IF
END FUNCTION
%>