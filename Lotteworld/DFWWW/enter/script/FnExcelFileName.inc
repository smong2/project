<%
Dim varFileDateYear

IF varEnterType="vxt" THEN  '���ϸ� ���� ������ �����մϴ�.
varFile="mae"
ELSE
varFile="sil"
END IF

varFileDate=year(date()) & "-" & month(date()) & "-" & day(date()) '��¥ ��������
Response.Buffer=true
Response.ContentType ="application/vnd.ms-excel"
%>