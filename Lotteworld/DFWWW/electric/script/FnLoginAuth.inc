<%
' ========================================================================================================
' ���α׷�ID : LogAuthscript
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ����� ���� �� ���� ��Ű - ����
' �����ۼ��� : 2002/12/11
' �����ۼ��� : 2002/12/11
' ��  ��  �� : �ڼ���(kweather)
' ���    DB : ����
' ========================================================================================================

'������ �Ӽ��� ����
'Response.Expire = 0
Option Explicit
'���� ��ġ
On Error Resume NEXT

DIM varTime, varID, varName, varLastConnectTime, varAuthlevel, varConnectTimes '���̵�, �̸�, �������ӽð�, ����, ����Ƚ��

varTime=Request.Cookies("ckTime") '���� �ð� ��Ű
varId=Request.Cookies("ckID")
varName=Request.Cookies("ckNAME")
varLastConnectTime=Request.Cookies("ckLastConnectTime")
varConnectTimes=Request.Cookies("ckConnectTimes")
varAuthLevel=Request.Cookies("ckAuthlevel")

IF varID="" THEN
response.write "<script>alert('�α��� ���� �����̽��ϴ�')</script>"
response.write "<script>top.location.replace('http://lwdfs/electric/index.asp')</script>"
END IF

IF VarAuthLevel<>3 AND VarAuthLevel<>4 AND VarAuthLevel<>7 THEN  '����� ���� �ʴ� ���� ���� �Ұ�
response.write "<script>alert('������ �ִ��� Ȯ���Ͻʽÿ�')</script>"
response.write "<script>top.location.replace('http://lwdfs/electric/index.asp')</script>"
END IF
%>