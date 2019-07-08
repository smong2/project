<%
Dim dtToday
Dim intDateadd '메인페이지 증감변수

IF intDateadd="" then  '증감변수가 없다면 0으로 초기화
intDateadd=0
END IF

FUNCTION FnDateFormat(df) '행사기간 날짜 표시 형식 (00/00/00)
	df=cstr(df)
	df=replace(df,"-","/")
	df=right(df,8)
	FnDateFormat=df
END FUNCTION

FUNCTION FnContentType(ct) '내용 CR/LF 형식 구분자를 <br> 태그로 변환
	FnContentType=replace(ct,chr(13),"<br>")
END FUNCTION

dtToday=date()+intDateadd
FUNCTION FnDateInter(di,di2)  'today, month 결정함수
IF	dtToday >= di and dtToday <= di2 THEN '행사 기간에 오늘이 포함될 경우
		FnDateInter =1
	ELSEIF not(dtToday>=di and dtToday<=di2) THEN '포함되지는 않지만 이번 월에 포함될 경우
		IF year(dtToday)=year(di) and month(dtToday)=month(di) or year(dtToday)=year(di2) and month(dtToday)=month(di2) THEN
			FnDateInter= 2
		END IF
	ELSE
		FnDateInter=3
END IF
END FUNCTION
%>