<!-- #include file="../../electric/script/FnLoginAuth.inc" -->
<%
' ========================================================================================================
' ���α׷�ID : TXERESULTSCONSTRUCTION
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���� ���� �̷� - �Է�
' �����ۼ��� : 2002/11/27
' �����ۼ��� : 2002/11/27
' ��  ��  �� : �ڼ���(kweather)
'========================================================================================================

'������ ����
Dim objServer, objServerI,arrRValue, ArrQuery, Arr '�İ��� ������
Dim rs '���ڵ�� (�������� ���)
dim intI '��������
Dim intStart_Year,intStart_Month,intStart_Day '���� ��,��,��
Dim intEnd_Year,intEnd_Month,intEnd_Day,dtStart_Day,dtEnd_Day '���� ��,��,��, ������, ������
Dim varConstructionType,varConstructionName,varInsert '��������, �̸�, ������

varInsert=Request.Form("varInsert")
varConstructionName=Request.Form("txtConstructionName")
intStart_Year=Request.Form("sltStart_Year")
intStart_Month=Request.Form("sltStart_Month")
intStart_Day=Request.Form("sltStart_Day")
intEnd_Year=Request.Form("sltEnd_Year")
intEnd_Month=Request.Form("sltEnd_Month")
intEnd_Day=Request.Form("sltEnd_Day")
varConstructionType=Request.Form("sltConstructionType")
dtStart_Day=dateserial(intStart_Year,intStart_Month,intStart_Day)
dtEnd_Day=dateserial(intEnd_Year,intEnd_Month,intEnd_Day)

ArrQuery = array(varInsert,dtStart_Day,dtEnd_Day,varConstructionName,varConstructionType) '�������� �´� �ڵ� ��������

'������ ����
Set objServer  = Server.CreateObject("XEEConstructIMTS.clsXEEConstructionINTX")

IF varInsert="ok" THEN '�Է¸���� ����
Set objServerI = Server.CreateObject("XEEConstructIMTS.clsXEEConstructionITX")
arrRValue = objServerI.save(ArrQuery)

'�ڿ��� ����
Set objServerI = Nothing
END IF

'������Ʈ ȣ��
arrRValue = objServer.Query(ArrQuery)
'���ڵ�� ��̸� ���� ���ڵ������ �и�

'ù��° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rs,1

'�ڿ��� ����
Set objServer = Nothing

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
<script>
function fncheck() {
if (document.form.txtConstructionName.value=="") {
 alert('������� �Է��� �ֽʽÿ�');
 document.form.txtConstructionName.focus();
 return false;
}
if(confirm("�����Ͻðڽ��ϱ�?")) 
   return true;
  else	
   return false;
}
</script>
</head>
<body bgcolor="#f5f5f5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload=document.form.txtConstructionName.focus()>
<form method=post name=form action=admin_results_construction.asp onsubmit='return fncheck()'>
<input type=hidden name=varInsert value=ok>
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#ffffff">
  <tr> 
    <td width="49"><IMG height=1 src="../../electric/images/null.gif" width=49></td>
    <td width="642" valign="top">
	<!--ū ���̺� ����--> 
        <table width="642" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td colspan="2"><IMG height=24 src="../../electric/images/null.gif" width=1></td>
          </tr>
          <tr> 
            <td colspan="2"><IMG height=21 src="../../electric/images/title_results_construction.gif" width=200></td>
          </tr>
          <tr> 
            <td height="40" valign="top" colspan="2"><IMG height=5 src="../../electric/images/title_bar.gif" width=642></td>
          </tr>
          <tr> 
            <td colspan="2">
			<!--�Է� ���̺� ����--> 
              <table width="642" border="0" cellspacing="1" cellpadding="7">
                <tr bgcolor="#cecff5"> 
                  <td height="7" colspan="2"></td>
                </tr>
                <tr class="list07_bg"> 
                  <td width="120">���</td>
                  <td>�Է°�</td>
                </tr>
                <tr> 
                  <td class="list13_bg">�����</td>
                  <td class="table01"> 
                    <input type=text name=txtConstructionName size="65" maxlength=70>
                  </td>
                </tr>
                <tr> 
                  <td class="list13_bg">������</td>
                  <td class="table01"> 
                    <select name="sltStart_Year">
                      <% for intI=2002 to 2010 %>
                      <% if intI=year(date()) then %>
                      <option selected value=<% =intI %>><% =intI %>��</option>
                      <% else %>
                      <option value=<% =intI %>><% =intI %>��</option>
                      <% end if : next %>
                    </select>
                    <select name="sltStart_Month">
                      <% for intI=1 to 12 %>
                      <% if intI=month(date()) then %>
                      <option selected value=<% =intI %>><% =intI %>��</option>
                      <% else %>
                      <option value=<% =intI %>><% =intI %>��</option>
                      <% end if :next %>
                    </select>
                    <select name="sltStart_Day">
                      <% for intI=1 to 31 %>
                      <% if intI=day(date()) then %>
                      <option selected value=<% =intI %>><% =intI %>��</option>
                      <% else %>
                      <option value=<% =intI %>><% =intI %>��</option>
                      <% end if :next %>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td class="list13_bg">�ϰ���</td>
                  <td class="table01"> 
                    <select name="sltEnd_Year">
                      <% for intI=2002 to 2010 %>
                      <% if intI=year(date()) then %>
                      <option selected value=<% =intI %>><% =intI %>��</option>
                      <% else %>
                      <option value=<% =intI %>><% =intI %>��</option>
                      <% end if : next %>
                    </select>
                    <select name="sltEnd_Month">
                      <% for intI=1 to 12 %>
                      <% if intI=month(date()) then %>
                      <option selected value=<% =intI %>><% =intI %>��</option>
                      <% else %>
                      <option value=<% =intI %>><% =intI %>��</option>
                      <% end if :next %>
                    </select>
                    <select name="sltEnd_Day">
                      <% for intI=1 to 31 %>
                      <% if intI=day(date()) then %>
                      <option selected value=<% =intI %>><% =intI %>��</option>
                      <% else %>
                      <option value=<% =intI %>><% =intI %>��</option>
                      <% end if :next %>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td class="list13_bg">��������<br>
                  </td>
                  <td class="table01"> 
                    <select name="sltConstructionType">
                      <% do until rs.eof %>
                      <option value=<% =rs("repairtype") %>><% =rs("repairtypename") %></option>
                      <% rs.movenext : loop %>
                    </select>
                  </td>
                </tr>                
                <tr bgcolor="#cecff5"> 
                  <td height="7" colspan="2"></td>
                </tr>
              </table>
			  <!--�Է� ���̺� ��-->
            </td>
          </tr>
          <tr> 
            <td height="10" colspan="2"></td>
          </tr>
          <tr> 
            <td height="34" colspan="2" class="table02"> 
			<!--�ϴ� ��ư�� ����-->
              <table width="642" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td align="right">
                    <input type=image height=26 src="../../electric/images/save.gif" width=53 border=0>
                  </td>
                  <td width="5"></td>
                </tr>
              </table>
			  <!--�ϴ� ��ư�� ��-->
            </td>
          </tr>
          <tr> 
            <td height="30" colspan="2"></td>
          </tr>
        </table>
		<!--ū ���̺� ��-->
    </td>
    <td width="49"><IMG height=1 src="../../electric/images/null.gif" width=1></td>
    <td bgcolor="#a4a4a4"><IMG height=1 src="../../electric/images/outline.gif" width=1></td>
  </tr>
  <tr> 
    <td height="42" colspan="3" align="right" background="../../electric/images/copyright_bg.gif"><IMG height=42 src="../../electric/images/copyright.gif" width=350></td>
    <td bgcolor="#a4a4a4" width="1" height="42"><IMG height=1 src="../../electric/images/null.gif" width=1></td>
  </tr>
</table>
</form>
</body>
</html>
<!-- #include file="../../electric/script/FnErrorCatch.inc" -->