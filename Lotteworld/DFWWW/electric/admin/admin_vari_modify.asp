<!-- #include file="../../electric/script/FnLoginAuth_Admin.inc" -->
<%
' ========================================================================================================
' ���α׷�ID : Vari_Modify
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���� ����
' �����ۼ��� : 2002/12/18
' �����ۼ��� : 2002/12/18
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
Dim rs,rsvar, rsvarlist '���ڵ�� ������, �𵨺��� ���, �� ���� ������ ����Ʈ ���
Dim varMode, SltMode, VarInsert, VarChoose, vcInsert 'ȯ�� ������ �Ͽ��� ���, �Ͽ��� ���2, �����Է�, ����������, �Ͽ��� ��� ����Ʈ ���� ��
Dim varModelCode '���� ��ȸ�� ���Ǵ� ����
Dim inty6weight,vary6,intvartransweight,varvartrans,intprocessID '���� ����Ʈ �Ӽ���
Dim varmodefinal, varmodelcodefinal '���� ������ �� ��
Dim intI,intIform, intVarOrder '��������, VarOrder ������ȣ
Dim varchkbox(35), var1(35), varweight1(35), varorder(35), varname2(35), var2(35), varweight2(35), inttime(35), lngweight(35) '���� ����Ʈ �迭 ����

VarMode=Request.QueryString("vcmode") '����, �Է� ��� ���� ������Ʈ�� ����
SltMode=Request.Form("varmode") '���� ��ġġ �ʰ� �ϱ� ���� ���� varmode�� �ٸ� ������ ����
varInsert=Request.Form("varInsert")

IF Varmode="" THEN varmode=sltmode  'varmode �� ���� ������ �� ������ ��ü

varchoose=Request.QueryString("varchoose")  '�� ���� ����  ������Ʈ�� ����
vcinsert=Request.Form("txtinsert") '��ȸ ���߸� ������ ��� �۵�
varmodelcode=Request.Form("sltmodelcode") '�� �ڵ带 �����´�

IF varInsert="ok" THEN  '�����Է½� ����Ǵ� ������
	intIform=Request.Form("intI")
	intI=0

	For intI=0 to intIform
	varchkbox(intI)=Request.Form("chkbox_"& intI)
	var1(intI)=Request.Form("sltvar1_"& intI)
	VarWeight1(intI)=Request.Form("txtVarWeight1_"& intI)
	Varorder(intI)=Request.Form("txtVarorder_"& intI)
	Varname2(intI)=Request.Form("sltVarname2_"& intI)
	var2(intI)=Request.Form("sltvar2_"& intI)
	VarWeight2(intI)=Request.Form("txtVarWeight2_"& intI)
	intTime(intI)=Request.Form("txtTime_"& intI)
	lngWeight(intI)=Request.Form("txtWeight_"& intI)

	IF var1(intI)="-pow" THEN 'var1 �� ���� pow �� ���� ���� ����Ѵ�.
	var1(intI)=varweight1(intI) & replace(var1(inti),"-","")
	ELSEIF var1(intI)="pow-" THEN '���� �����ʿ� �������� �̷���
	var1(intI)=replace(var1(inti),"-","") & varweight1(intI)
	ELSEIF var2(intI)="-pow" THEN 'var2 �� ���� pow �� ���� ���� ����Ѵ�.
	var2(intI)=varweight2(intI) & replace(var2(inti),"-","")
	ELSEIF var2(intI)="pow-" THEN '���� �����ʿ� �������� �̷���
	var2(intI)=replace(var2(inti),"-","") & varweight2(intI)
	END IF
	NEXT
	varModefinal=Request.Form("varmodefinal")
	varmodelcodefinal=Request.Form("txtmodelcodefinal")
	intProcessID=Request.Form("intprocessID")
END IF 

IF varchoose="ok" and vcInsert="" THEN  '��,��,�� ������ �������� ��� �迭 ����
	ArrQuery = array("electric","view",Varmode) '���� ����
END IF

IF vcInsert="ok" THEN '��ȸ ��ư�� ������ ��� 
	ArrQuery = array("electric","view",Varmode,varmodelcode,"0","0") '���� ����
END IF

IF varchoose="ok" or vcinsert="ok" THEN '����Ʈ �׸����� �����ϰų� ��ȸ�� ������ ��� ����

	'������ ����
	Set objServer = Server.CreateObject("XBRegistModIMTS.clsXBRegistModINTX")
	
	'������Ʈ ȣ��
	arrRValue = objServer.Query(ArrQuery)
	
	'���ڵ�� ��̸� ���� ���ڵ������ �и�
	'ù��° ���ڵ���� ��̷� ��ȯ
	FnSplitRSArray arrRValue,rs,1
	'�ι�° ���ڵ���� ��̷� ��ȯ
	FnSplitRSArray arrRValue,rsvar,2
	'����° ���ڵ���� ��̷� ��ȯ
	FnSplitRSArray arrRValue,rsvarlist,3
	
	'�ڿ��� ����
	Set objServer = Nothing
END IF 

IF varInsert="ok" THEN  '���� �Է½�
 intVarOrder=0 '�ʱⰪ�� �����ְ�
 IntI=0
 FOR intI=0 to intIForm '���� varorder���� 0 ���� �𵨺��� ���������� ���� �ݺ��Ѵ�.
 IF varchkbox(intI)="ok" THEN   'üũ�� �׸� �ݺ�
	ArrQuery = array("electric","insert",Varmodefinal,varmodelcodefinal,"0","0",var1(intI),intprocessID,intVarOrder,varname2(intI),inttime(intI),var2(intI),lngweight(intI)) '���� ����
	'������ ����
	Set objServer = Server.CreateObject("XBRegistModIMTS.clsXBRegistModITX")
	'������Ʈ ȣ��
	arrRValue = objServer.Save(ArrQuery)
	
	'�ڿ��� ����
	Set objServer = Nothing		
	
	intVarOrder=intVarOrder+1  '�������� ������Ű��..
  END IF      
 NEXT 
 
END IF

'������ ó��
IF Err.Number <> 0 THEN 
	Response.Write Err.Number, Err.Source, Err.Description
	Set objServer = Nothing
	objserver.close
END IF
%>

<!-- #include file="../../electric/script/FnProgramProcess.vbs" -->
<html>
<head>
<title>�Ե����� ���俹���ý���</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../../electric/css/cs_te.css" type="text/css">
<script src="../../electric/script/Fnadminregist.js"></script>
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
  <tr> 
    <td width="49"><img src="../../electric/images/null.gif" width="49" height="1"></td>
    <td width="642" valign="top"> 
	<!--ū ���̺� ����-->
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td colspan="2"><img src="../../electric/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
          <td align="left" colspan="2"><img src="../../electric/images/title_vari_modify.gif" width="220" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top" colspan="2"><img src="../../electric/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td width="190"> 
            <!--�������� Ÿ��Ʋ ����-->
            <table border="0" cellspacing="0" cellpadding="0" width="172">
              <tr> 
                <td><img src="../../electric/images/gray_round_s_edge1.gif" width="6" height="6"></td>
                <td><img src="../../electric/images/gray_round_s_edge_top.gif" width="160" height="6"></td>
                <td><img src="../../electric/images/gray_round_s_edge2.gif" width="6" height="6"></td>
              </tr>
              <tr> 
                <td><img src="../../electric/images/gray_round_s_edge_left.gif" width="6" height="20"></td>
                <td class="title_01_c"><img src="../../electric/images/vermilion_buret.gif" width="7" height="7"> 
                  �������� </td>
                <td><img src="../../electric/images/gray_round_s_edge_right.gif" width="6" height="20"></td>
              </tr>
              <tr> 
                <td><img src="../../electric/images/gray_round_s_edge3.gif" width="6" height="6"></td>
                <td><img src="../../electric/images/gray_round_s_edge_bottom.gif" width="160" height="6"></td>
                <td><img src="../../electric/images/gray_round_s_edge4.gif" width="6" height="6"></td>
              </tr>
            </table>
            <!--�������� Ÿ��Ʋ ��-->
          </td>
          <td width="452"> 
          <form name=form method=post action=admin_vari_modify.asp>
              <input type=hidden name=varmode value=<% =varmode %>>
              <input type=hidden name=txtinsert value=ok>
		  <!--�������� ����-->
            <table width="447" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td class="title_01"> ������ 
                  <select name="sltmodel"  onChange="namosw_goto_byselect(this, 'self')">                    
                    <% IF varmode="m" THEN %>
                    <option>--</option>                    
                    <option value=admin_vari_modify.asp?vcmode=m&varchoose=ok selected>������</option>
                    <option value=admin_vari_modify.asp?vcmode=d&varchoose=ok>�Ͽ���</option>
                    <% ELSEIF varmode="d" THEN %>
                    <option>--</option>                    
                    <option value=admin_vari_modify.asp?vcmode=m&varchoose=ok>������</option>
                    <option value=admin_vari_modify.asp?vcmode=d&varchoose=ok selected>�Ͽ���</option>
                    <% ELSE %>
                    <option selected>--</option>                    
                    <option value=admin_vari_modify.asp?vcmode=m&varchoose=ok>������</option>
                    <option value=admin_vari_modify.asp?vcmode=d&varchoose=ok>�Ͽ���</option>
                    <% END IF %>
                  </select>&nbsp;&nbsp;&nbsp;&nbsp;
                  �������� 
                  <select name="sltmodelcode">
                    <% IF varmode<>"" THEN %>                    
                    <% DO UNTIL rs.EOF %>
                    <% IF varmodelcode=rs("modelcode") THEN %>
                    <option selected value=<% =rs("modelcode") %>><% =rs("modelname") %></option>
                    <% ELSE %>
                    <option value=<% =rs("modelcode") %>><% =rs("modelname") %></option>
                    <% END IF %>
                    <% rs.MOVENEXT : LOOP %>
                    <% ELSE %>
                    <option>--</option>
                    <% END IF : intI=0%>
                  </select>                    
                </td>
                <td width="53" align=right><input type=image src="../../electric/images/commu_bu.gif" width="53" height="26"></td>
              </tr>
            </table>            
			<!--�������� ��-->
			</form>
          </td>
        </tr>
        <tr> 
          <td height="10" colspan="2"></td>
        </tr>
        <tr> 
          <td colspan="2"> 
            <!--���� ���̺� ����-->
            <form method=post action=admin_vari_modify.asp name=form>
            <input type=hidden name=varinsert value=ok>
            <input type=hidden name=txtmodelcodefinal value=<% =varmodelcode %>>
            <input type=hidden name=varmodefinal value=<% =varmode %>>                        
            <table width="642" border="0" cellspacing="1" cellpadding="5">
              <tr bgcolor="#CECFF5"> 
                <td height="7" colspan="8"></td>
              </tr>
              <tr class="list07_bg"> 
                <td>����<br>
                  ����</td>
                <td>����������</td>
                <td>����<br>
                  ����</td>
                <!--td>����level1</td -->
                <td>����level2</td>
                <td>��������</td>
                <td>����</td>
                <td>���</td>
              </tr>
              <% IF vcinsert<>"" THEN 
					intI=0
              DO UNTIL rsvar.eof %>
              <!-- #include file="../../electric/script/FnvariModify.inc" -->
              <tr class="list14_bg2"> 
                <td> 
                  <input type="checkbox" name="chkbox_<% =intI %>" value=ok checked>
                </td>
                <td> 
                  <select name="sltVar1_<% =intI %>">                   
                   <% If rsvar("y6")="square" THEN %>
                    <option value=NULL>---</option>
                    <option value='-pow'>-pow</option>
                    <option value='pow-'>pow-</option>
                    <option value=square SELECTED>square</option>
                    <option value=ln>ln</option>
                    <option value=log>log</option>
                    <option value=sqrt>sqrt</option>
                    <option value=exp>exp</option>
                    <option value=abs>abs</option>
                  <% ELSEIF vary6="-pow" THEN %>
                    <option value=NULL>---</option>
                    <option value='-pow' selected>-pow</option>
                    <option value='pow-'>pow-</option>
                    <option value=square>square</option>
                    <option value=ln>ln</option>
                    <option value=log>log</option>
                    <option value=sqrt>sqrt</option>
                    <option value=exp>exp</option>
                    <option value=abs>abs</option>
                  <% ELSEIF vary6="pow-" THEN %>
                    <option value=NULL>---</option>
                    <option value='-pow'>-pow</option>
                    <option value='pow-' selected>pow-</option>
                    <option value=square>square</option>
                    <option value=ln>ln</option>
                    <option value=log>log</option>
                    <option value=sqrt>sqrt</option>
                    <option value=exp>exp</option>
                    <option value=abs>abs</option>
                  <% ELSEIF rsvar("y6")="log" THEN %>
                    <option value=NULL>---</option>
                    <option value='-pow'>-pow</option>
                    <option value='pow-'>pow-</option>
                    <option value=square>square</option>
                    <option value=ln>ln</option>
                    <option value=log SELECTED>log</option>
                    <option value=sqrt>sqrt</option>
                    <option value=exp>exp</option>
                    <option value=abs>abs</option>
                  <% ELSEIF rsvar("y6")="ln" THEN %>
                    <option value=NULL>---</option>
                    <option value='-pow'>-pow</option>
                    <option value='pow-'>pow-</option>
                    <option value=square>square</option>
                    <option value=ln SELECTED>ln</option>
                    <option value=log>log</option>
                    <option value=sqrt>sqrt</option>
                    <option value=exp>exp</option>
                    <option value=abs>abs</option>
                  <% ELSEIF rsvar("y6")="sqrt" THEN %>
					<option value=NULL>---</option>
                    <option value='-pow'>-pow</option>
                    <option value='pow-'>pow-</option>
                    <option value=square>square</option>
                    <option value=ln>ln</option>
                    <option value=log>log</option>
                    <option value=sqrt SELECTED>sqrt</option>
                    <option value=exp>exp</option>
                    <option value=abs>abs</option>
                  <% ELSEIF rsvar("y6")="exp" THEN %>
                    <option value=NULL>---</option>
                    <option value='-pow'>-pow</option>
                    <option value='pow-'>pow-</option>
                    <option value=square>square</option>
                    <option value=ln>ln</option>
                    <option value=log>log</option>
                    <option value=sqrt>sqrt</option>
                    <option value=exp SELECTED>exp</option>
                    <option value=abs>abs</option>
                  <% ELSEIF rsvar("y6")="abs" THEN %>
                    <option value=NULL>---</option>
                    <option value='-pow'>-pow</option>
                    <option value='pow-'>pow-</option>
                    <option value=square>square</option>
                    <option value=ln>ln</option>
                    <option value=log>log</option>
                    <option value=sqrt>sqrt</option>
                    <option value=exp>exp</option>
                    <option value=abs SELECTED>abs</option>
                  <% ELSE  %>
                    <option SELECTED value=NULL>---</option>
                    <option value='-pow'>-pow</option>
                    <option value='pow-'>pow-</option>
                    <option value=square>square</option>
                    <option value=ln>ln</option>
                    <option value=log>log</option>
                    <option value=sqrt>sqrt</option>
                    <option value=exp>exp</option>
                    <option value=abs>abs</option>                  
                  <% END IF %>                   
                  </select>
                  <input type="text" name="txtVarWeight1_<% =intI %>" size="3" value=<% =inty6weight %>>
                </td>
                <td> 
                  <input type="text" name="txtVarorder_<% =intI %>" size="2" value=<% =rsvar("varorder") %>>
                </td>             
                <td> 
                  <select name="sltVarname2_<% =intI %>">
                    <% DO UNTIL rsvarlist.EOF %>
                    <% IF rsvar("varlevel2")=rsvarlist("varlevel2") THEN %>
                    <option value=<% =rsvar("varlevel2")%> selected><% =rsvar("varlevel2_name") %></option>
                    <% ELSE %>
                    <option value=<% =rsvarlist("varlevel2")%>><% =rsvarlist("varlevel2_name") %></option>
                    <%END IF : 
                     rsVarList.MOVENEXT :  LOOP : rsvarlist.MOVEFIRST %>
                  </select>
                </td>
                <td> 
                  <select name="sltvar2_<% =intI %>">
                    <% If rsvar("vartrans")="square" THEN %>
                    <option value=NULL>---</option>
                    <option value='-pow'>-pow</option>
                    <option value='pow-'>pow-</option>
                    <option value=square SELECTED>square</option>
                    <option value=ln>ln</option>
                    <option value=log>log</option>
                    <option value=sqrt>sqrt</option>
                    <option value=exp>exp</option>
                    <option value=abs>abs</option>
                  <% ELSEIF varvartrans="-pow" THEN %>
                    <option value=NULL>---</option>
                    <option value='-pow' selected>-pow</option>
                    <option value='pow-'>pow-</option>
                    <option value=square>square</option>
                    <option value=ln>ln</option>
                    <option value=log>log</option>
                    <option value=sqrt>sqrt</option>
                    <option value=exp>exp</option>
                    <option value=abs>abs</option>
                  <% ELSEIF varvartrans="pow-" THEN %>
                    <option value=NULL>---</option>
                    <option value='-pow'>-pow</option>
                    <option value='pow-' selected>pow-</option>
                    <option value=square>square</option>
                    <option value=ln>ln</option>
                    <option value=log>log</option>
                    <option value=sqrt>sqrt</option>
                    <option value=exp>exp</option>
                    <option value=abs>abs</option>
                  <% ELSEIF rsvar("vartrans")="log" THEN %>
                    <option value=NULL>---</option>
                    <option value='-pow'>-pow</option>
                    <option value='pow-'>pow-</option>
                    <option value=square>square</option>
                    <option value=ln>ln</option>
                    <option value=log SELECTED>log</option>
                    <option value=sqrt>sqrt</option>
                    <option value=exp>exp</option>
                    <option value=abs>abs</option>
                  <% ELSEIF rsvar("vartrans")="ln" THEN %>
                    <option value=NULL>---</option>
                    <option value='-pow'>-pow</option>
                    <option value='pow-'>pow-</option>
                    <option value=square>square</option>
                    <option value=ln SELECTED>ln</option>
                    <option value=log>log</option>
                    <option value=sqrt>sqrt</option>
                    <option value=exp>exp</option>
                    <option value=abs>abs</option>
                  <% ELSEIF rsvar("vartrans")="sqrt" THEN %>
					<option value=NULL>---</option>
                    <option value='-pow'>-pow</option>
                    <option value='pow-'>pow-</option>
                    <option value=square>square</option>
                    <option value=ln>ln</option>
                    <option value=log>log</option>
                    <option value=sqrt SELECTED>sqrt</option>
                    <option value=exp>exp</option>
                    <option value=abs>abs</option>
                  <% ELSEIF rsvar("vartrans")="exp" THEN %>
                    <option value=NULL>---</option>
                    <option value='-pow'>-pow</option>
                    <option value='pow-'>pow-</option>
                    <option value=square>square</option>
                    <option value=ln>ln</option>
                    <option value=log>log</option>
                    <option value=sqrt>sqrt</option>
                    <option value=exp SELECTED>exp</option>
                    <option value=abs>abs</option>
                  <% ELSEIF rsvar("vartrans")="abs" THEN %>
					<option value=NULL>---</option>
                    <option value='-pow'>-pow</option>
                    <option value='pow-'>pow-</option>
                    <option value=square>square</option>
                    <option value=ln>ln</option>
                    <option value=log>log</option>
                    <option value=sqrt>sqrt</option>
                    <option value=exp>exp</option>
                    <option value=abs SELECTED>abs</option>
                  <% ELSE  %>
                    <option SELECTED value=NULL>---</option>
                    <option value='-pow'>-pow</option>
                    <option value='pow-'>pow-</option>
                    <option value=square>square</option>
                    <option value=ln>ln</option>
                    <option value=log>log</option>
                    <option value=sqrt>sqrt</option>
                    <option value=exp>exp</option>
                    <option value=abs>abs</option>                  
                  <% END IF %>
                  </select>
                  <input type="text" name="txtVarWeight2_<% =intI %>" size="3" value=<% =intvartransweight %>>
                </td>
                <td> 
                  <input type="text" name="txtTime_<% =intI %>" size="3" value=<% =rsvar("time") %>>
                </td>
                <td> 
                  <input type="text" name="txtWeight_<% =intI %>" size="10" value=<% =rsvar("weight") %>>
                </td>
              </tr>
              <% rsvar.MOVENEXT : inty6weight="" :vary6="" :intvartransweight="" :varvartrans="" : intI=intI+1 : LOOP : rsvar.MOVELAST%>
              <input type=hidden name=intProcessID value=<% =rsvar("processID") %>>
              <% END IF%>
              <tr bgcolor="#CECFF5"> 
                <td height="7" colspan="8"></td>
              </tr>
            </table>
            <!--���� ���̺� ��-->
          </td>
        </tr>
        <tr> 
          <td height="10" colspan="2"></td>
        </tr>
        <tr> 
          <td height="34" class="table02" colspan="2"> 
            <!--�ϴ� ��ư�� ���̺� ����-->
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td align="right">
                <input type=hidden name=intI value=<% =intI %>>
                <% IF varMOde<>"" THEN %>
                <input type=image src="../../electric/images/save.gif" width="53" height="26" border="0" id=image1 name=image1>
                <% END If %>
                </td>
                <td width="5"></td>
              </tr>
            </table>
            </form>
            <!--�ϴ� ��ư�� ���̺� ��-->
          </td>
        </tr>
        <tr> 
          <td height="30" colspan="2"></td>
        </tr>
      </table>
	  <!--ū ���̺� ��-->
    </td>
    <td width="49"><img src="../../electric/images/null.gif" width="49" height="1"></td>
    <td bgcolor="#a4a4a4"><img src="../../electric/images/outline.gif" width="1" height="1"></td>
  </tr>
  <tr> 
    <td height="42" colspan="3" align="right" background="../../electric/images/copyright_bg.gif"><img src="../../electric/images/copyright.gif" width="350" height="42"></td>
    <td bgcolor="#a4a4a4" width="1" height="42"><img src="../../electric/images/null.gif"></td>
  </tr>
</table>
</body>
</html>
<!-- #include file="../../electric/script/FnErrorCatch.inc" -->