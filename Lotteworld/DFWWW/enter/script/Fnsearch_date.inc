<%
Dim dtToday
Dim dtLastday '�۳⳯¥
Dim dtLastWeekday '���� ������ ��¥
Dim intWeekday '���Ϲ�ȣ
Dim intLastWeekday '�۳� ���Ϲ�ȣ
Dim varWeekdayName '���ϸ�
Dim varLastWeekdayName '���ϸ�


dtToday=date()  '���� ��¥	
dtLastday=dateadd("yyyy",-1,date()) '�۳� ��¥

intWeekday=weekday(dtToday) '���Ϲ�ȣ
intLastweekday=weekday(dtLastday) '�۳���Ϲ�ȣ

varWeekdayName=weekdayname(intWeekday) '���ϸ�
varLastWeekdayName=weekdayname(intLastWeekday) '���ϸ�

IF intWeekday<intLastWeekday THEN '�۳� ���� ��ȣ�� �� Ŭ��

	DO UNTIL intWeekday=intLastweekday '�������� ���� ���� ���Ѵ�
		intLastWeekday=intLastWeekday-1
		intI=intI+1
	LOOP

ELSEIF intWeekday>intLastWeekday THEN '�۳� ���� ��ȣ�� ������

	DO UNTIL intWeekday=intLastweekday '�������� ���� ���� ���Ѵ�
		intLastWeekday=intLastWeekday+1
		intI=intI+1
	LOOP
END IF

dtLastWeekday=dtLastday+intI '���� ��� ��-���⵿����
%>