<%
IF instr(rsvar("y6"),"pow")=1 THEN 
	inty6weight=right(rsvar("y6"),len(rsvar("y6"))-3)					
	vary6="pow-"
ELSEIF instr(rsvar("y6"),"pow")>1 THEN
	inty6weight=left(rsvar("y6"),len(rsvar("y6"))-3)									   					
	vary6="-pow"
END IF

IF instr(rsvar("vartrans"),"pow")=1 THEN 
	intvartransweight=right(rsvar("vartrans"),len(rsvar("vartrans"))-3)					
	varvartrans="pow-"
ELSEIF instr(rsvar("vartrans"),"pow")>1 THEN
	intvartransweight=left(rsvar("vartrans"),len(rsvar("vartrans"))-3)									   					
	varvartrans="-pow"
END IF
%>