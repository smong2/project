<%
Dim varFileDateYear

IF varEnterType="D" THEN  '���ϸ� ���� ������ �����մϴ�.
varFile="Day"
ELSE
varFile="Month"
END IF

varFileDate=year(date()) & "-" & month(date()) & "-" & day(date()) '��¥ ��������
Response.Buffer=true
Response.ContentType ="application/vnd.ms-excel"
%>