<%
Dim dtToday
Dim intDateadd '���������� ��������

IF intDateadd="" then  '���������� ���ٸ� 0���� �ʱ�ȭ
intDateadd=0
END IF

FUNCTION FnDateFormat(df) '���Ⱓ ��¥ ǥ�� ���� (00/00/00)
	df=cstr(df)
	df=replace(df,"-","/")
	df=right(df,8)
	FnDateFormat=df
END FUNCTION

FUNCTION FnContentType(ct) '���� CR/LF ���� �����ڸ� <br> �±׷� ��ȯ
	FnContentType=replace(ct,chr(13),"<br>")
END FUNCTION

dtToday=date()+intDateadd
FUNCTION FnDateInter(di,di2)  'today, month �����Լ�
IF	dtToday >= di and dtToday <= di2 THEN '��� �Ⱓ�� ������ ���Ե� ���
		FnDateInter =1
	ELSEIF not(dtToday>=di and dtToday<=di2) THEN '���Ե����� ������ �̹� ���� ���Ե� ���
		IF year(dtToday)=year(di) and month(dtToday)=month(di) or year(dtToday)=year(di2) and month(dtToday)=month(di2) THEN
			FnDateInter= 2
		END IF
	ELSE
		FnDateInter=3
END IF
END FUNCTION
%>