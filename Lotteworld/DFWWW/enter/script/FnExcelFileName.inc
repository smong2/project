<%
Dim varFileDateYear

IF varEnterType="vxt" THEN  '파일명 결정 경쟁사는 제외합니다.
varFile="mae"
ELSE
varFile="sil"
END IF

varFileDate=year(date()) & "-" & month(date()) & "-" & day(date()) '날짜 가져오기
Response.Buffer=true
Response.ContentType ="application/vnd.ms-excel"
%>