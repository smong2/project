<!-- #include file="../../enter/script/FnLoginAuth_admin.inc" -->
<%
' ========================================================================================================
' ���α׷�ID : User List
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ����� ���� ����Ʈ ����
' �����ۼ��� : 2002/12/09
' �����ۼ��� : 2002/12/09
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

Dim objServer, arrRValue, ArrQuery, Arr, ArrQueryU  '�İ��� ������
Dim rs '���� ���� ��������
Dim Intstartyear, intstartmonth,intstartday,intendyear,intendmonth,intendday, dtstartdate, dtenddate '����� �Է°�
Dim varmodel, varmodelname,vardatenum, varinsert,varterm,varoverlap,varfinal
dim intI '��������
DIM dtsumdate  '���� ������ �Է��� ���� �ؽ�Ʈ �ڽ��� �ѷ����� ��
Dim intinsertyear, intinsertmonth, intinsertday, intinsertdata '����� �Է°�

varoverlap=Request.Form("varoverlap")
varinsert=Request.Form("varinsert")
intStartYear=Request.Form("sltstartYear")
intStartMonth=Request.Form("sltstartmonth")
intStartDay=Request.Form("sltstartday")
intEndYear=Request.Form("sltEndYear")
intEndMonth=Request.Form("sltEndmonth")
intEndDay=Request.Form("sltEndday")
dtstartdate=dateserial(intstartyear,intstartmonth,intstartday)
dtenddate=dateserial(intendyear,intendmonth,intendday)
varModel=Request.Form("sltModel")
varModelName=Request.Form("txtmodelname")
varterm = Request.form("varterm")


'������ ������ �����Ѵ�.
IF varModel="Y" THEN '�� ���� ��
varDateNum=datediff("yyyy",dtstartdate,dtenddate)
varDateNum=vardateNum+1
END IF
IF varModel="M" THEN '�� ���� ��
varDateNum=datediff("M",dtstartdate,dtenddate)
varDateNum=vardateNum+1
END IF
IF varModel="D" THEN '�� ���� ��
varDateNum=datediff("D",dtstartdate,dtenddate)
varDateNum=vardateNum+1
END IF


IF varoverlap="ok" THEN   '���� �ߺ� Ȯ��
	ArrQuery = array("enter","check",varModel,varModelName) '���� ����

	'������ ����
	Set objServer = Server.CreateObject("XBEnvRegistIMTS.clsXBEnvRegistINTX")

	'������Ʈ ȣ��
	arrRValue = objServer.Query(ArrQuery)
	'���ڵ�� ��̸� ���� ���ڵ������ �и�

	'ù��° ���ڵ���� ��̷� ��ȯ
	FnSplitRSArray arrRValue,rs,1

	'�ڿ��� ����
	Set objServer = Nothing

	IF rs("ADDVAR")<>0	 THEN
		Response.Write "<script language='javascript'>alert('�ߺ������� �ֽ��ϴ�. �ٸ� ������ �Է����ֽʽÿ�')</script>"
	ELSE
		Response.Write "<script language='javascript'>alert('�� ������ ����ص� �����ϴ�')</script>"
	END IF
ENd IF

IF Request.Form("varfinal")="ok" THEN '���� �Է½�

	ArrQuery=array("enter","insertadd",varModel,varmodelname)
	
	Set objServer = Server.CreateObject("XBEnvRegistIMTS.clsXBEnvRegistITX")
	arrRvalue=objserver.save(arrQuery)

	'�ڿ��� ����
	Set objServer = Nothing

	FOR inti=1 TO Request.Form("vardatenum")   '��¥ ���ݸ�ŭ�� �����͸� �ݺ��ؼ� ����
		intinsertyear=Request.Form("txtyear_" & inti)
		intinsertmonth=Request.Form("txtmonth_" & inti)
		intinsertday=Request.Form("txtday_" & inti)
		intinsertdata=Request.Form("txtdata_" & inti)

	ArrQueryU = array("enter","Insert",varModel,"�ʿ����",intinsertyear,intinsertmonth,intinsertday,intinsertdata) '���� ����
	'������ ����
	Set objServer = Server.CreateObject("XBEnvRegistIMTS.clsXBEnvRegistITX")

	'������Ʈ ȣ��
	arrRValue = objserver.Save(ArrQueryU)

	set objserver=Nothing '�ڿ�����
	next
END IF

'������ ó��
IF Err.Number <> 0 THEN 
	Response.Write Err.Number, Err.Source, Err.Description
	Set objServer = Nothing
	objserver.close
END IF
%>
<!-- #include file="../../enter/script/FnProgramProcess.vbs" -->
<html>
<head>
<title>�Ե����� ���俹���ý���</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../../enter/css/cs_tx.css" type="text/css">
<script language="JavaScript" src=FnAdminregist.js></script>
</head>

<body bgcolor="#f5f5f5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload=document.variableform.txtModelName.focus()>
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#ffffff">
  <tr> 
    <td width="49"><IMG height=1 src="../../enter/images/null.gif" width=49></td>
    <td width="642" valign="top"><!--ū ���̺� ����-->
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><IMG height=24 src="../../enter/images/null.gif" width=1></td>
        </tr>
        <tr> 
          <td align="left"><IMG height=21 src="../../enter/images/title_vari_regist.gif" width=200></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><IMG height=5 src="../../enter/images/title_bar.gif" width=642></td>
        </tr>
        <tr> 
          <td height="42" class="table07"><!--���尴 �űԸ� �������� Ȯ�� ���̺� ����-->
            <table border="0" cellspacing="0" cellpadding="0" width="642">
              <tr> 
                <td><IMG height=6 src="../../enter/images/gray_round_s_edge1.gif" width=6></td>
                <td><IMG height=6 src="../../enter/images/gray_round_s_edge_top.gif" width=630></td>
                <td><IMG height=6 src="../../enter/images/gray_round_s_edge2.gif" width=6></td>
              </tr>
              <tr> 
                <td><IMG height=40 src="../../enter/images/gray_round_s_edge_left.gif" width=6></td>
                <td class="table03"><!--���尴 �űԸ� �������� Ȯ�� ����--> 
                <form method=post name=variableform action=admin_vari_regist.asp name=form>
				<input type=hidden name=varoverlap value=ok>
                  <table width="430" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td class="title_01" width="160"><IMG height=9 src="../../enter/images/vermilion_triangle2.gif" width=5> 
                        �𵨺������� 
                        <select name="sltModel">
                          <option value=Y>�⿹��</option>
                          <option value=M>������</option>
                          <option value=D selected>�Ͽ���</option>
                        </select>
                      </td>
                      <td width="4"></td>
                      <td class="title_01" width="170"><IMG height=9 src="../../enter/images/vermilion_triangle2.gif" width=5> 
                        �𵨺���(�ѱ�) 
                        <input name="txtModelName" size="8" value=<% =varModelName %>>
                      </td>
                      <td width="76"><input type=IMAGE height=26 src="../../enter/images/re_confirm.gif"></td>
                    </tr>
                  </table><!--���尴 �űԸ� �������� Ȯ�� ��-->
                </td>
                <td><IMG height=40 src="../../enter/images/gray_round_s_edge_right.gif" width=6></td>
              </tr>
              <tr> 
                <td><IMG height=6 src="../../enter/images/gray_round_s_edge3.gif" width=6></td>
                <td><IMG height=6 src="../../enter/images/gray_round_s_edge_bottom.gif" width=630></td>
                <td><IMG height=6 src="../../enter/images/gray_round_s_edge4.gif" width=6></td>
              </tr>              
            </table><!--���尴 �űԸ� �������� Ȯ�� ���̺� ��-->
            </form>
          </td>
        </tr>
        <tr> 
          <td height="40"></td>
        </tr>
        <tr> 
          <td><!--������ ��ϱⰣ ��ȸ ����-->
          <form method=post action=admin_vari_regist.asp name=form1>
          <input type=hidden name=sltmodel value=<% =varmodel %>>
          <input type=hidden name=txtModelName value=<% =varModelName %>>
          <input type=hidden name=varTerm value=ok>
            <table width="560" border="0" cellspacing="0" cellpadding="0">            
              <tr>
                <td width="15"></td>
                <td class="title_01"><IMG height=7 src="../../enter/images/vermilion_buret.gif" width=7> 
                  &nbsp;������ ��ϱⰣ: 
                  <select name="sltStartYear">
                  <% FOR intI=2002 to 2010
                  IF year(date()) = intI THEN                    
                   Response.Write "<option selected value= " & intI & ">" & intI & "��</option>"
                  ELSE 
                   Response.Write "<option value=" & intI & ">" & intI  &"��</option>"
                  END IF : NEXT %>
                  </select>
                  
                  <select name="sltStartMonth">
                  <% FOR intI=1 to 12
                  IF month(date()) = intI THEN                    
                   Response.Write "<option selected value= " & intI & ">" & intI & "��</option>"
                  ELSE 
                   Response.Write "<option value=" & intI & ">" & intI  &"��</option>"
                  END IF : NEXT %>
                  <select>
                  
                  <select name="sltStartDay">
                  <% FOR intI=1 to 31
                  IF day(date()) = intI THEN                    
                   Response.Write "<option selected value= " & intI & ">" & intI & "��</option>"
                  ELSE 
                   Response.Write "<option value=" & intI & ">" & intI  &"��</option>"
                  END IF : NEXT %>
                  </select>
                  ~ 
                  <select name="sltEndYear">
                  <% FOR intI=2002 to 2010
                  IF year(date()) = intI THEN                    
                   Response.Write "<option selected value= " & intI & ">" & intI & "��</option>"
                  ELSE 
                   Response.Write "<option value=" & intI & ">" & intI  &"��</option>"
                  END IF : NEXT %></select>
                  
                  <select name="sltEndMonth">
                  <% FOR intI=1 to 12
                  IF month(date()) = intI THEN                    
                   Response.Write "<option selected value= " & intI & ">" & intI & "��</option>"
                  ELSE 
                   Response.Write "<option value=" & intI & ">" & intI  &"��</option>"
                  END IF : NEXT %>                  
                  </select>
                  <select name="sltEndDay">
                  <% FOR intI=1 to 31
                  IF day(date()) = intI THEN                    
                   Response.Write "<option selected value= " & intI & ">" & intI & "��</option>"
                  ELSE 
                   Response.Write "<option value=" & intI & ">" & intI  &"��</option>"
                  END IF : NEXT %>
                  </select>
                </td>
                <td>
                <% IF varModelName<>"" THEN %>
                <input type=IMaGe height=26 src="../../enter/images/commu_bu.gif" width=53>
                <% END IF %>
                </td>                
              </tr>              
            </table><!--���̴� ��ϱⰣ ��ȸ ��-->
            </form>
          </td>
        </tr>
        <tr> 
          <td height="5"></td>
        </tr>
        <tr> 
          <td><!--��� ���̺� ����--> 
			<form method=post name=form2 action=admin_vari_regist.asp onsubmit='return FnCheck()'>
			<input type=hidden name=varfinal value=ok>         
            <input type=hidden name=varDateNum value=<% =varDateNum %>>
            <input type=hidden name=sltmodel value=<% =varModel %>>            
            <input type=hidden name=txtModelName value=<% =varModelName %>>
            <table width="642" border="0" cellspacing="1" cellpadding="7">               
              <tr bgcolor="#b0dffd"> 
                <td height="7" colspan="4"></td>
              </tr>
              <tr class="list07_bg"> 
                <td>��</td>
                <td>��</td>
                <td>��</td>
                <td>data <% =varModel %></td>
              </tr>
              <% For Inti=1 to varDateNum %>              
				<% IF varmodel="Y" THEN %>            
				<% dtsumdate=dateadd("yyyy",inti-1,dtstartdate) %>
              <tr class="list14_bg2"> 
                <td><input name="txtyear_<% =intI %>" size="4" value=<% =year(dtsumdate) %> onfocus=blur()>��</td>
                <td><input name="txtmonth_<% =intI %>" size="2" disabled>��</td>
                <td><input name="txtday_<% =intI %>" size="2" disabled>��</td>
                <td><input name="txtdata_<% =intI %>" size="60"></td>
              </tr>
                <% ELSEIF varmodel="M" THEN %>                
                <% dtsumdate=dateadd("m",inti-1,dtstartdate) %>
                <tr class="list14_bg2"> 
                <td><input name="txtyear_<% =intI %>" size="4" value=<% =year(dtsumdate) %> onfocus=blur()>��</td>
                <td><input name="txtmonth_<% =intI %>" size="2" value=<% =month(dtsumdate) %>  onfocus=blur()>��</td>
                <td><input name="txtday_<% =intI %>" size="2" disabled>��</td>
                <td><input name="txtdata_<% =intI %>" size="60"></td>
              </tr>
               <% ELSEIF varmodel="D" THEN %>
               <% dtsumdate=dateadd("d",inti-1,dtstartdate) %>
               <tr class="list14_bg2"> 
                <td><input name="txtyear_<% =intI %>" size="4" value=<% =year(dtsumdate) %> onfocus=blur()>��</td>
                <td><input name="txtmonth_<% =intI %>" size="2" value=<% =month(dtsumdate) %>  onfocus=blur()>��</td>
                <td><input name="txtday_<% =intI %>" size="2" value=<% =day(dtsumdate) %> onfocus=blur()>��</td>
                <td><input name="txtdata_<% =intI %>" size="60"></td>
              </tr>
              <% END IF %>
              <% NEXT %>
              <tr bgcolor="#b0dffd"> 
                <td height="7" colspan="4"></td>
              </tr>              
            </table><!--��� ���̺� ��-->
          </td>
        </tr>
        <tr>
          <td height="10"></td>
        </tr>
        <tr> 
          <td height="34" class="table02"><!--�ϴ� ��ư�� ���̺� ����-->
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td align="right">
                <% IF VarTerm<>"" THEN %>
                <input type=image height=26 src="../../enter/images/save.gif" width=53 border=0>
                <% END IF %>
                </td>
                <td width="5"></td></form>
              </tr>              
            </table><!--�ϴ� ��ư�� ���̺� ��-->            
		  </td>
        </tr>
        <tr> 
          <td height="30"></td>
        </tr>
      </table><!--ū ���̺� ��-->
    </td>
    <td width="49"><IMG height=1 src="../../enter/images/null.gif" width=49></td>
    <td bgcolor="#a4a4a4"><IMG height=1 src="../../enter/images/outline.gif" width=1></td>
  </tr>
  <tr> 
    <td height="42" colspan="3" align="right" background="../../enter/images/copyright_bg.gif"><IMG height=42 src="../../enter/images/copyright.gif" width=350></td>
    <td bgcolor="#a4a4a4" width="1" height="42"><IMG src="../../enter/images/null.gif"></td>
  </tr>
</table>
</body>
</html>
<!-- #include file="../../enter/script/FnErrorCatch.inc"-->