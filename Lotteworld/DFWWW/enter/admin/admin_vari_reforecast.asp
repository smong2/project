<!-- #include file="../../enter/script/FnLoginAuth_admin.inc" -->
<%
' ========================================================================================================
' ���α׷�ID : TXBReforecast 
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���尴 �翹�� 
' �����ۼ��� : 2002/11/07
' �����ۼ��� : 2002/11/21
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

'������ ����
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
Dim intI '��������
Dim intInput_Year_Start,intInput_Month_Start,intInput_Day_Start,intInput_Year_End,intInput_Month_End,intInput_Day_End
Dim sltGubun,hidMode,varStartDate,varEndDate,hidInsert  '����� �Է°�

hidInsert=Request.Form("hidInsert") '�� ����
hidMode=Request.Form("hidmode") '��,��,�� ����
intInput_Year_Start=Request.Form("sltinput_Year_Start") '���� ��
intInput_Year_End=Request.Form("sltinput_Year_End") '���� ��
intInput_Month_Start=Request.Form("sltinput_Month_Start") '���� ��
intInput_Month_End=Request.Form("sltinput_Month_End") '���� ��
intInput_Day_Start=Request.Form("sltinput_Day_Start") '���� ��
intInput_Day_End=Request.Form("sltinput_Day_End") '���� ��

if intInput_Month_Start="" then intInput_Month_Start=01  '�ƹ� �͵� ������ �ϴ� 01�� �־�д�.
if intInput_Month_End="" then intInput_Month_End=01
if intInput_Day_Start="" then intInput_Day_Start=01
if intInput_Day_End="" then intInput_Day_End=01

sltGubun=Request.Form("sltgubun") '�� ���� ����

varStartDate=intInput_Year_Start & "-" & intInput_Month_Start & "-" & intInput_Day_Start '��¥������ ����
varEndDate=intInput_Year_End & "-" & intInput_Month_End & "-" & intInput_Day_End  

if hidInsert="ok" then '�Էµɶ� ���� ���� ����
	ArrQuery = array(hidMode,sltGubun,varStartDate,varEndDate)

	'������ ����
	Set objServer = Server.CreateObject("XTEnterRefcIMTS.clsXTEnterRefcITX")

	'������Ʈ ȣ��
	arrRValue = objServer.Save(ArrQuery)
	
	'�ڿ��� ����
	Set objServer = Nothing
	
	hidInsert=""
end if

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
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
  <tr> 
    <td width="49"><img src="../../enter/images/null.gif" width="49" height="1"></td>
    <td width="642" valign="top">
	<!--ū ���̺� ����--> 
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="24"><img src="../../enter/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
          <td align="left"><img src="../../enter/images/title_vari_reforecast.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td height="42" class="table07">
		  <!--�� �翹�� Ÿ��Ʋ �ڽ� ����--> 
            <table border="0" cellspacing="0" cellpadding="0" width="142">
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge1.gif" width="6" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge_top.gif" width="130" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge2.gif" width="6" height="6"></td>
              </tr>
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge_left.gif" width="6" height="20"></td>
                <td class="title_01_c"><img src="../../enter/images/vermilion_buret.gif" width="7" height="7"> 
                  �� �翹��</td>
                <td><img src="../../enter/images/gray_round_s_edge_right.gif" width="6" height="20"></td>
              </tr>
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge3.gif" width="6" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge_bottom.gif" width="130" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge4.gif" width="6" height="6"></td>
              </tr>
            </table>
			<!--�� �翹�� Ÿ��Ʋ �ڽ� ��-->
          </td>
        </tr>
        <tr> 
          <td height="40" class="table06"> 
           <form method=post name=form_year action=admin_vari_reforecast.asp>
		   <!--�� �翹�� ������ ����-->
            <table width="400" border="0" cellspacing="0" cellpadding="0" class="title_01">
              <tr> 
                <td width="18"></td>
                <td><img src="../../enter/images/vermilion_triangle2.gif" width="5" height="9"> 
                  ������ : �� �翹�� 
                  <select name="sltGubun">
                    <option value=TAI>�Ե����� �Ǽ��� � ����</option>
                    <option value=TSI>�Ե����� �Ǽ��� �л� ����</option>
                    <option value=TCI>�Ե����� �Ǽ��� ��� ����</option>
                    <option value=ETI>�Ե����� ������ ��ü ����</option>
                    <option value=TAG>�Ե����� �Ǽ��� � ��ü</option>
                    <option value=TSG>�Ե����� �Ǽ��� �л� ��ü</option>
                    <option value=TCG>�Ե����� �Ǽ��� ��� ��ü</option>
                    <option value=ETG>�Ե����� ������ ��ü ��ü</option>
                    <option value=SAR>����� : ���﷣�� �</option>
                    <option value=SSR>����� : ���﷣�� �л�</option>
                    <option value=SCR>����� : ���﷣�� ���</option>
                    <option value=EAR>����� : �������� �</option>
                    <option value=ESR>����� : �������� �л�</option>
                    <option value=ECR>����� : �������� ���</option>
                  </select>                  
                </td>
              </tr>
            </table>
			<!--�� �翹�� ������ ��-->
          </td>
        </tr>
        <tr> 
          <td height="50" class="table01">
		  <!--�� �翹�� �Է����� ����--> 
            <table width="303" border="0" cellspacing="0" cellpadding="0" class="title_01">
              <tr> 
                <td width="18"></td>
                <td><img src="../../enter/images/vermilion_triangle2.gif" width="5" height="9"> 
                  �Է����� : 
                  <select name="sltInput_Year_Start">
                    <% FOR intI=2002 TO 2010 %>
                    <option value=<% =intI %>><% =intI %>��</option>
                    <% NEXT %>
                  </select>
                  ~ 
                  <select name="sltInput_Year_End">
                    <% FOR intI=2002 TO 2010 %>
                    <option value='<% =intI %>'><% =intI %>��</option>
                    <% NEXT %>
                  </select>
                  <input type=hidden name='hidMode' value='Y'>
                  <input type=hidden name='hidInsert' value='ok'>
                </td>                
                <td width="53"><input type=image src="../../enter/images/save.gif" width="53" height="26"></td>
              </tr>
            </table>
			<!--�� �翹�� �Է����� ��-->            
            </form>
          </td>
        </tr>
        <tr> 
          <td height="3"></td>
        </tr>
        <tr> 
          <td height="1"><img src="../../enter/images/point_line7.gif" width="642" height="1"></td>
        </tr>
        <tr> 
          <td height="30"></td>
        </tr>
        <tr> 
          <td height="42" class="table07">
		  <!--�� �翹�� Ÿ��Ʋ �ڽ� ����--> 
            <table border="0" cellspacing="0" cellpadding="0" width="142">
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge1.gif" width="6" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge_top.gif" width="130" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge2.gif" width="6" height="6"></td>
              </tr>
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge_left.gif" width="6" height="20"></td>
                <td class="title_01_c"><img src="../../enter/images/yellowgreen_buret.gif" width="7" height="7"> 
                  �� �翹��</td>
                <td><img src="../../enter/images/gray_round_s_edge_right.gif" width="6" height="20"></td>
              </tr>
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge3.gif" width="6" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge_bottom.gif" width="130" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge4.gif" width="6" height="6"></td>
              </tr>
            </table>
			<!--�� �翹�� Ÿ��Ʋ �ڽ� ��-->
          </td>
        </tr>
        <tr> 
          <td height="40" class="table06">
             <form method=post name=form_month action=admin_vari_reforecast.asp>
			 <!--�� �翹�� ������ ����-->
            <table width="400" border="0" cellspacing="0" cellpadding="0" class="title_01">
              <tr> 
                <td width="18"></td>
                <td><img src="../../enter/images/yellowgreen_triangle2.gif" width="5" height="9"> 
                  ������ : �� �翹�� 
                  <select name="sltGubun">
                    <option value=TAI>�Ե����� �Ǽ��� � ����</option>
                    <option value=TSI>�Ե����� �Ǽ��� �л� ����</option>
                    <option value=TCI>�Ե����� �Ǽ��� ��� ����</option>
                    <option value=ETI>�Ե����� ������ ��ü ����</option>
                    <option value=TAG>�Ե����� �Ǽ��� � ��ü</option>
                    <option value=TSG>�Ե����� �Ǽ��� �л� ��ü</option>
                    <option value=TCG>�Ե����� �Ǽ��� ��� ��ü</option>
                    <option value=ETG>�Ե����� ������ ��ü ��ü</option>
                    <option value=SAR>����� : ���﷣�� �</option>
                    <option value=SSR>����� : ���﷣�� �л�</option>
                    <option value=SCR>����� : ���﷣�� ���</option>
                    <option value=EAR>����� : �������� �</option>
                    <option value=ESR>����� : �������� �л�</option>
                    <option value=ECR>����� : �������� ���</option>
                  </select>
                </td>
              </tr>
            </table>
			<!--�� �翹�� ������ ��-->
          </td>
        </tr>
        <tr> 
          <td height="50" class="table01"> 
		  <!--�� ���� �Է����� ����-->
            <table width="420" border="0" cellspacing="0" cellpadding="0" class="title_01">
              <tr> 
                <td width="18"> </td>
                <td><img src="../../enter/images/yellowgreen_triangle2.gif" width="5" height="9"> 
                  �Է����� : 
                  <select name="sltInput_Year_Start">
                  <% FOR intI=2002 TO 2010 %>
                    <option value=<% =intI %>><% =intI %>��</option>
                  <% NEXT %>
                  </select>                  
                  <select name="sltInput_Month_Start">
                  <% FOR intI=1 TO 12 %>
                    <option value=<% =intI %>><% =intI %>��</option>
                  <% NEXT %>
                  </select>
                  ~ 
                  <select name="sltInput_Year_End">
                  <% FOR intI=2002 TO 2010 %>
                    <option value=<% =intI %>><% =intI %>��</option>
                  <% NEXT %>
                  </select>                  
                  <select name="sltInput_Month_End">
                  <% FOR intI=1 TO 12 %>
                    <option value=<% =intI %>><% =intI %>��</option>
                  <% NEXT %>
                  </select>
                  <input type=hidden name=hidMode value=M>
                  <input type=hidden name=hidInsert value='ok'>
                </td>                
                <td width="53"><input type=image src="../../enter/images/save.gif" width="53" height="26"></td>
              </tr>
            </table>
			<!--�� ���� �Է����� ��-->            
            </form>
          </td>
        </tr>
        <tr> 
          <td height="3"></td>
        </tr>
        <tr> 
          <td height="1"><img src="../../enter/images/point_line7.gif" width="642" height="1"></td>
        </tr>
        <tr> 
          <td height="30"></td>
        </tr>
        <tr> 
          <td height="42" class="table07">
		  <!--�� �翹�� Ÿ��Ʋ �ڽ� ����--> 
            <table border="0" cellspacing="0" cellpadding="0" width="142">
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge1.gif" width="6" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge_top.gif" width="130" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge2.gif" width="6" height="6"></td>
              </tr>
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge_left.gif" width="6" height="20"></td>
                <td class="title_01_c"><img src="../../enter/images/green_buret.gif" width="7" height="7"> 
                  �� �翹��</td>
                <td><img src="../../enter/images/gray_round_s_edge_right.gif" width="6" height="20"></td>
              </tr>
              <tr> 
                <td><img src="../../enter/images/gray_round_s_edge3.gif" width="6" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge_bottom.gif" width="130" height="6"></td>
                <td><img src="../../enter/images/gray_round_s_edge4.gif" width="6" height="6"></td>
              </tr>
            </table>
			<!--�� �翹�� Ÿ��Ʋ �ڽ� ��-->
          </td>
        </tr>
        <tr> 
          <td height="40" class="table06"> 
           <form method=post name=form_day action=admin_vari_reforecast.asp>
		   <!--�� �翹�� ������ ����-->
            <table width="400" border="0" cellspacing="0" cellpadding="0" class="title_01">
              <tr> 
                <td width="18"></td>
                <td><img src="../../enter/images/green_triangle2.gif" width="5" height="9"> 
                  ������ : �� �翹�� 
                  <select name="sltGubun">
                    <option value=SAR>����� : ���﷣�� �</option>
                    <option value=SSR>����� : ���﷣�� �л�</option>
                    <option value=SCR>����� : ���﷣�� ���</option>
                    <option value=EAR>����� : �������� �</option>
                    <option value=ESR>����� : �������� �л�</option>
                    <option value=ECR>����� : �������� ���</option>                    
                  </select>
                </td>
              </tr>
            </table>
			<!--�� �翹�� ������ ��-->
          </td>
        </tr>
        <tr> 
          <td height="50" class="table01">
		  <!--�� �翹�� �Է����� ����--> 
            <table width="535" border="0" cellspacing="0" cellpadding="0" class="title_01">
              <tr> 
                <td width="18"></td>
                <td><img src="../../enter/images/green_triangle2.gif" width="5" height="9"> 
                  �Է����� : 
                  <select name="sltInput_Year_Start">
                  <% FOR intI=2002 TO 2010 %>
                    <option value=<% =intI %>><% =intI %>��</option>
                  <% NEXT %>
                  </select>                  
                  <select name="sltInput_Month_Start">
                  <% FOR intI=1 TO 12 %>
                    <option value=<% =intI %>><% =intI %>��</option>
                  <% NEXT %>
                  </select>
                  <select name="sltInput_Day_Start">
                  <% FOR intI=1 TO 31 %>
                    <option value=<% =intI %>><% =intI %>��</option>
                  <% NEXT %>
                  </select>
                  ~ 
                  <select name="sltInput_Year_End">
                  <% FOR intI=2002 TO 2010 %>
                    <option value=<% =intI %>><% =intI %>��</option>
                  <% NEXT %>
                  </select>                  
                  <select name="sltInput_Month_End">
                  <% FOR intI=1 TO 12 %>
                    <option value=<% =intI %>><% =intI %>��</option>
                  <% NEXT %>
                  </select>                  
                  <select name="sltInput_Day_End">
                  <% FOR intI=1 TO 31 %>
                    <option value=<% =intI %>><% =intI %>��</option>
                  <% NEXT %>
                  </select>
                  <input type=hidden name=hidMode value=D>        
                  <input type=hidden name='hidInsert' value='ok'>          
                </td>
                <td width="53"><input type=image src="../../enter/images/save.gif" width="53" height="26"></td>
              </tr>
            </table>
			<!--�� �翹�� �Է����� ��-->            
            </form>
          </td>
        </tr>
        <tr> 
          <td height="3"></td>
        </tr>
        <tr> 
          <td height="1"><img src="../../enter/images/point_line7.gif" width="642" height="1"></td>
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
</body>
</html>
<!-- #include file="../../enter/script/FnErrorCatch.inc"-->

