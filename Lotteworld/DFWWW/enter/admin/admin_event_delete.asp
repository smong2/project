<!-- #include file="../../enter/script/FnLoginAuth_admin.inc" -->
<% 
' ========================================================================================================
' ���α׷�ID : TXBBULLETIN - delete
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ��� ����
' �����ۼ��� : 2002/10/16
' �����ۼ��� : 2002/10/18
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

'������ ����
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
Dim intIdx '�۹�ȣ
DIM txtcode '� ���������� ����� ����� ���ȴ��� Ȯ��

intIdx=Request.QueryString("intIdx")
txtcode=Request.QueryString("code")


ArrQuery = array("delete","����",intIdx,"����","����") '�۹�ȣ�� �ش�Ǵ� ���ڵ� ����

'������ ����
Set objServer = Server.CreateObject("XBbulletinUIQMTS.clsXBbulletinUIQTX")

'������Ʈ ȣ��
arrRValue = objServer.save(ArrQuery)
'���ڵ�� ��̸� ���� ���ڵ������ �и�

'�ڿ��� ����
Set objServer = Nothing

'������ ó��
IF Err.Number <> 0 THEN 
	Response.Write Err.Number, Err.Source, Err.Description
	Set objServer = Nothing
	objserver.close
END IF
%>
<!-- #include file="../../enter/script/FnProgramProcess.vbs" -->
<%
IF txtcode="seoul" THEN
Response.Redirect "admin_event_seoul.asp"  '������ �̵�
ELSEIF txtcode="ever" THEN
Response.Redirect "admin_event_ever.asp"  '������ �̵�
ELSE
Response.Redirect "admin_event_lotte.asp"  '������ �̵�
END IF
%>
<!-- #include file="../../enter/script/FnErrorCatch.inc"-->