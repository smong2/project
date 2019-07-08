<%
FUNCTION FnDateFormat(df) '��¥ ǥ�� ���� (00/00/00)
	FnDateFormat=month(df) & "��" & day(df) & "��(" & left(WeekdayName(Weekday(df)),1) & ")"
END FUNCTION

FUNCTION FnDateFormatMonth(df,Num) '��¥ ǥ�� ���� ( �� ��)
	FnDateFormatMonth=Year(dateadd("m",Num,date())) & "�� " & Month(dateadd("m",Num,date())) & "��"
END FUNCTION

FUNCTION FnNumberFormat(format_number)  '���� ��� ����
	IF isnull(format_number) THEN
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


FUNCTION FnReportPercentFormat(format_percent1, format_percent2) '���� �������� ����� ���ϱ�
	IF isnull(format_percent1) or isnull(format_percent2) THEN
		FnReportPercentFormat="�ڷ����"
	ELSE
		FnReportPercentFormat=(FnNumberFormat(format_percent1)-FnNumberFormat(format_percent2))/FnNumberFormat(format_percent2)	
		FnReportPercentFormat=formatpercent(ABS(FnReportPercentFormat),1)		
	END IF
END FUNCTION

FUNCTION FnReportPercentIncreaseFormat(format_percent1, format_percent2) '���� �������� ���� ���� ����� ���ϱ�
	IF isnull(format_percent1) or isnull(format_percent2) THEN
		FnReportPercentIncreaseFormat="�ڷ����"
	ELSE
		FnReportPercentIncreaseFormat=(FnNumberFormat(format_percent1)-FnNumberFormat(format_percent2))/FnNumberFormat(format_percent2)	
	END IF
	
	IF FnNumberFormat(format_percent1)-FnNumberFormat(format_percent2) > 0 THEN
	 FnReportPercentIncreaseFormat="�� " & FormatPercent(abs(FnReportPercentIncreaseFormat),1)
	ELSEIF FnNumberFormat(format_percent1)-FnNumberFormat(format_percent2) < 0 THEN
	 FnReportPercentIncreaseFormat="�� " & FormatPercent(abs(FnReportPercentIncreaseFormat),1)
	ELSE
	 FnReportPercentIncreaseFormat=FnReportPercentIncreaseFormat  
	END IF		 
END FUNCTION


FUNCTION FnReportIncreaseFormat(format_percent1, format_percent2) '���� �������� �������ϱ�
	IF isnull(format_percent1) or isnull(format_percent2) THEN
		FnPercentFormat="�ڷ����"
	ELSE
		FnReportIncreaseFormat=FnNumberFormat(FnNumberFormat(format_percent1)-FnNumberFormat(format_percent2))
		
		IF FnReportIncreaseFormat>0 THEN  '������ ȭ��ǥ �ֱ�
			FnReportIncreaseFormat="��" & FnReportIncreaseFormat
		ELSEIF FnReportIncreaseFormat=0 THEN
			FnReportIncreaseFormat="  " & FnReportIncreaseFormat
		ELSE
			FnReportIncreaseFormat="��" & FnNumberFormat(ABS(FnReportIncreaseFormat))
		END IF				
	END IF
END FUNCTION
%>