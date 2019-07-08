<%
FUNCTION FnAcntClassDescript(Authlevel) 
IF Authlevel=1 THEN
FnAcntClassDescript="입장객 일반"
ELSEIF Authlevel=2 THEN
FnAcntClassDescript="입장객 관리"
ELSEIF Authlevel=3 THEN
FnAcntClassDescript="전기 일반"
ELSEIF Authlevel=4 THEN
FnAcntClassDescript="전기 관리"
ELSEIF Authlevel=5 THEN
FnAcntClassDescript="잠긴계정(입장)"
ELSEIF Authlevel=6 THEN
FnAcntClassDescript="잠긴계정(전기)"
ELSEIF Authlevel=7 THEN
FnAcntClassDescript="전체 관리"
END IF
END FUNCTION

Function FnConnectTime(ConnectTime)
'FnConnectTime=Replace(Connecttime,"오전","am")
'FnConnectTime=Replace(Connecttime,"오후","pm")
FnConnectTime=Month(connecttime) & "월" & Day(connectTime) & "일/" & Hour(connectTime) & "시" & Minute(ConnectTime) & "분"
END FUNCTION
%>