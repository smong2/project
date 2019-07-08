<%
Dim dtToday
Dim dtLastday '작년날짜
Dim dtLastWeekday '전년 동요일 날짜
Dim intWeekday '요일번호
Dim intLastWeekday '작년 요일번호
Dim varWeekdayName '요일명
Dim varLastWeekdayName '요일명


dtToday=date()  '오늘 날짜	
dtLastday=dateadd("yyyy",-1,date()) '작년 날짜

intWeekday=weekday(dtToday) '요일번호
intLastweekday=weekday(dtLastday) '작년요일번호

varWeekdayName=weekdayname(intWeekday) '요일명
varLastWeekdayName=weekdayname(intLastWeekday) '요일명

IF intWeekday<intLastWeekday THEN '작년 요일 번호가 더 클때

	DO UNTIL intWeekday=intLastweekday '같아지는 날의 수를 구한다
		intLastWeekday=intLastWeekday-1
		intI=intI+1
	LOOP

ELSEIF intWeekday>intLastWeekday THEN '작년 요일 번호가 작을때

	DO UNTIL intWeekday=intLastweekday '같아지는 날의 수를 구한다
		intLastWeekday=intLastWeekday+1
		intI=intI+1
	LOOP
END IF

dtLastWeekday=dtLastday+intI '최종 결과 값-전년동요일
%>