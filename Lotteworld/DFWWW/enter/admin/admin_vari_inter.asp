<!-- #include file="../../enter/script/FnLoginAuth_admin.inc" -->
<%
' ========================================================================================================
' ���α׷�ID : Admin_vari_inter
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� �� ���� �Է� - ���Ժ��� �Է�
' �����ۼ��� : 2002/12/23
' �����ۼ��� : 2002/12/23
' ��  ��  �� : �ڼ���(kweather)
' ======================================================================================================== 

'������ ����
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
dim varInsert,varview'�� ����
Dim rs '���ڵ�� - �� ��� ��������
Dim intI,varType '��������
Dim intYear,intMonth,intDay,dtdate '��,��,��
Dim	intDummyIMF,intDummyCard '���̺����� / IMF,ī�������
Dim intduty, intcool, intsaleexist, intvacation '��ȭ�� �޹�, �ù�� ��������, ��������, ���к���
DIM intInter1, intInter2, varModelCode, varModelType '���Ժ���1,2, ���ڵ�, �� ����

varType=Request.QueryString("sltType")
varInsert=Request.Form("hidInsert")
dtdate=dateserial(intyear,intmonth,intday)
dtdate=left(weekdayname(weekday(dtdate)),1)

IF varInsert="" AND varType<>"" THEN '������ �� ���� ��������
ArrQuery=array("Enter","View","��","2002","12","12",varType,"11", "1", "1")

Set objServer = Server.CreateObject("XBInterIMTS.clsXBInterventionINTX")

'������Ʈ ȣ��
arrRValue = objServer.query(ArrQuery)

'ù��° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rs,1

'�ڿ��� ����
Set objServer = Nothing
END IF

IF varInsert="ok"  THEN '������ �Ѿ�Դٸ�..
intYear = Request.Form("sltYear")
intMonth = Request.Form("sltMonth")
intDay=Request.Form("sltDay")
IntInter1 = Request.Form("sltInter1")
IntInter2 = Request.Form("sltInter2")
varModelCode = Request.Form("sltModelCode")
varModelType = Request.Form("hidmodelType")

ArrQuery=array("Enter","Insert",dtdate,intYear,intMonth,intDay, varModelType, varModelCode, IntInter1, IntInter2)

Set objServer = Server.CreateObject("XBInterIMTS.clsXBInterventionITX")

'������Ʈ ȣ��
arrRValue = objServer.save(ArrQuery)

'�ڿ��� ����
Set objServer = Nothing
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
<script language="JavaScript" src="../../enter/script/FnAdminInter.js"></script>
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form method=post name=form action=admin_vari_inter.asp onsubmit='return FnCheck()'>
<input type=hidden name=hidinsert value=ok>
<input type=hidden name=hidmodelType value=<% =varType %>>                  
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
  <tr> 
    <td width="49"><img src="../../enter/images/null.gif" width="49" height="1"></td>
    <td width="642" valign="top"> 
	<!--ū ���̺� ����-->
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="../../enter/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
          <td><img src="../../enter/images/title_vari_inter.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td align="right"> 
            <!--���Ժ��� ��ȸ ����-->
            <table width="642" border="0" cellspacing="0" cellpadding="0">            
              <tr> 
                <td class="title_01_r"><img src="../../enter/images/vermilion_buret.gif" width="7" height="7"> 
                  ���Ժ�����ȸ: 
                  <select name="sltType" onChange="namosw_goto_byselect(this, 'self')">
					<% IF varType="D" THEN %>
					<option>--</option>
                    <option value=admin_vari_inter.asp?sltType=D selected>��</option>
                    <option value=admin_vari_inter.asp?sltType=M>��</option>
                    <option value=admin_vari_inter.asp?sltType=Y>��</option>
                    <% ELSEIF varType="M" THEN %>
                    <option>--</option>
                    <option value=admin_vari_inter.asp?sltType=D>��</option>
                    <option value=admin_vari_inter.asp?sltType=M selected>��</option>
                    <option value=admin_vari_inter.asp?sltType=Y>��</option>
                    <% ELSEIF varType="Y" THEN %>
                    <option>--</option>
                    <option value=admin_vari_inter.asp?sltType=D>��</option>
                    <option value=admin_vari_inter.asp?sltType=M>��</option>
                    <option value=admin_vari_inter.asp?sltType=Y selected>��</option>
                    <% ELSE %>
                    <option selected>--</option>
                    <option value=admin_vari_inter.asp?sltType=D>��</option>
                    <option value=admin_vari_inter.asp?sltType=M>��</option>
                    <option value=admin_vari_inter.asp?sltType=Y>��</option>
                    <% END IF %>
                  </select>                  
                  <select name="sltModelcode">					
                  <% IF varType<>"" THEN %>                  
					<% DO UNTIL rs.EOF %>					
                    <option value='<% =rs("modelcode") %>'><% =rs("ModelName") %></option>
                    <% rs.MOVENEXT : LOOP %>
                    <% ELSE %>
                    <option> -- </option>  
                  <% END IF %>
                  </select>
                </td>
                <td width="10"></td>
                <td width="53"></td>
              </tr>            
            </table>
            <!--���Ժ��� ��ȸ ��-->
          </td>
        </tr>
        <tr> 
          <td height="20"></td>
        </tr>
        <tr> 
          <td>
		  <!--���Ժ��� �ڽ� �׵θ� ����--> 
            <table border="0" cellspacing="0" cellpadding="0" width="642">
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge1.gif" width="6" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge_top.gif" width="630" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge2.gif" width="6" height="6"></td>
              </tr>
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge_left.gif" width="6" height="80"></td>
                <td class="table03"> 
                  <!--���Ժ��� �Է� ����-->                  
                  <table width="480" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td>
                        <select name="sltYear">
						  <option>--</option>
						<% FOR intI=2002 To 2010 %>
                          <option value=<% =intI %>><% =intI %>��</option>
                        <% NEXT %>
                        </select>
                        <select name="sltMonth">
                          <option>--</option>
						<% FOR intI=1 To 12 %>
                          <option value=<% =intI %>><% =intI %>��</option>
                        <% NEXT %>
                        </select>
                        <select name="sltDay">
                          <option>--</option>
						<% FOR intI=1 To 31 %>
                          <option value=<% =intI %>><% =intI %>��</option>
                        <% NEXT %>
                        </select>
                      </td>
                      <td width="4"></td>
                      <td class="title_01" width="110"><img src="../../enter/images/vermilion_triangle2.gif" width="5" height="9"> 
                        ���Ժ���1 
                        <select name="sltinter1">
                          <option value=0>0</option>
                          <option value=1>1</option>
                        </select>
                      </td>
                      <td class="title_01" width="110"><img src="../../enter/images/vermilion_triangle2.gif" width="5" height="9"> 
                        ���Ժ���2 
                        <select name="sltinter2">
                          <option value=0>0</option>
                          <option value=1>1</option>
                        </select>
                      </td>
                      <td width="53"><input type=image src="../../enter/images/save.gif" width="53" height="26" border="0"></td>
                    </tr>
                  </table>
                  <!--���Ժ��� �Է� ��-->
                </td>
                <td><img src="../../enter/images/gray_round_s_edge_right.gif" width="6" height="80"></td>
              </tr>
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge3.gif" width="6" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge_bottom.gif" width="630" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge4.gif" width="6" height="6"></td>
              </tr>
            </table>
			<!--���Ժ��� �ڽ� �׵θ� ��-->
          </td>
        </tr>
        <tr> 
          <td height="30"></td>
        </tr>
      </table>
	  <!--ū ���̺� ��-->
    </td>
    <td width="49"><img src="../../enter/images/null.gif" width="49" height="1"></td>
    <td bgcolor="#a4a4a4"><img src="../../enter/images/outline.gif" width="1" height="1"></td>
  </tr>
  <tr> 
    <td height="42" colspan="3" align="right" background="../../enter/images/copyright_bg.gif"><img src="../../enter/images/copyright.gif" width="350" height="42"></td>
    <td bgcolor="#a4a4a4" width="1" height="42"><img src="../../enter/images/null.gif"></td>
  </tr>
</table>
</form>
</body>
</html>
<!-- #include file="../../enter/script/FnErrorCatch.inc"-->