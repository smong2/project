<%
if err.number >0 then
 IF err.number=13 THEN
 ELSEIF err.number=3021 THEN
	response.Write "<script>alert('                               *     ��      ��     *\n\n ������ �ʿ��� �����Ͱ� ��� �Էµ��� �ʾҽ��ϴ�. \n�������� ����� ��µ��� ���� �� �ֽ��ϴ� \n������ Ȯ�� ���������� ���� �����͸� �����Ͻʽÿ�\n��ܿ� �����ڸ� Ŭ���Ͻø� �ش� ������ Ȯ���� �� �ֽ��ϴ�\n             - �����ڸ��� ���� �����մϴ� -')</script>"
 ELSE
	Response.Write "<script language=javascript>alert('�����߻�(���� ����� ���� ���� �� �ֽ��ϴ�- �ɰ��ϸ� �����ڿ��� ������ �ֽʽÿ�) \n\n��������("& Err.Number & ") : " & err.Description  & "')</script>"
 END IF
end if
%>