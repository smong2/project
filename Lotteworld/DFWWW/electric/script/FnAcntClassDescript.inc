<%
FUNCTION FnAcntClassDescript(Authlevel) 
IF Authlevel=1 THEN
FnAcntClassDescript="���尴 �Ϲ�"
ELSEIF Authlevel=2 THEN
FnAcntClassDescript="���尴 ����"
ELSEIF Authlevel=3 THEN
FnAcntClassDescript="���� �Ϲ�"
ELSEIF Authlevel=4 THEN
FnAcntClassDescript="���� ����"
ELSEIF Authlevel=5 THEN
FnAcntClassDescript="���尴 ��� ����"
ELSEIF Authlevel=6 THEN
FnAcntClassDescript="���� ��� ����"
ELSEIF Authlevel=7 THEN
FnAcntClassDescript="��ü ����"
END IF
END FUNCTION

Function FnConnectTime(ConnectTime)
'FnConnectTime=Replace(Connecttime,"����","am")
'FnConnectTime=Replace(Connecttime,"����","pm")
FnConnectTime=Month(connecttime) & "��" & Day(connectTime) & "��/" & Hour(connectTime) & "��" & Minute(ConnectTime) & "��"
END FUNCTION
%>