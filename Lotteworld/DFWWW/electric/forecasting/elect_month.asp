<!-- #include file="../../electric/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' ���α׷�ID : TXEEACHBUILDMonth
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���� ���� - ��
' �����ۼ��� : 2002/11/26
' �����ۼ��� : 2002/11/26
' ��  ��  �� : �ڼ���(kweather)
' ���    DB : TXEEACHBUILDMonth
' ========================================================================================================

'������ ����
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
Dim rs,rslast, rssum, rslastsum '���ڵ�� (����,���⵿��,�����հ�,���⵿���հ�)
dim intI '��������

ArrQuery = array() '�������� �´� �ڵ� ��������

'������ ����
Set objServer = Server.CreateObject("XEElectMonthQMTS.clsXEElectMonthQNTX")

'������Ʈ ȣ��
arrRValue = objServer.Query(ArrQuery)
'���ڵ�� ��̸� ���� ���ڵ������ �и�

'ù��° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rs,1
'�ι�° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rslast,2
'����° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rssum,3
'�׹�° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rslastsum,4

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
<!-- #include file="../../electric/script/fnnumber_format.inc"-->		
<html>
<head>
<title>�Ե����� ���俹���ý���</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../../electric/css/cs_te.css" type="text/css">
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
  <tr> 
    <td width="49"><img src="../../electric/images/null.gif" width="49" height="1"></td>
    <td width="642" valign="top">
	<!--ū ���̺� ����--> 
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td><img src="../../electric/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
          <td><img src="../../electric/images/title_elect_month.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../electric/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--������ ���̺� ����--> 
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr class="list07_bg3"> 
                <td colspan="2">����</td>
                <% FOR intI=0 TO 2 %>
                <td><% =FnDateFormatMonth(Date(),intI) %></td>
                <% NEXT %>
                <td>����</td>
              </tr>
              <tr> 
                <td rowspan="3" width="92" class="list02_bg2">��ü</td>
                <td width="105" class="list03_bg">������</td>
                <% FOR intI=0 TO 2 %>
                <td width="105" class="list01_bg"><% =FnNumberFormat(rs("total")) %></td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
                <td width="130" class="list04_bg"><% =FnNumberFormat(rssum("total")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg2">�������</td>
				<% FOR intI=0 TO 2 %>
                <td class="list01_bg2"><% =FnNumberFormat(rslast("total")) %></td>
                <% rslast.MOVENEXT : NEXT : rslast.MOVEFIRST %>
                <td class="list04_bg2"><% =FnNumberFormat(rslastsum("total")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg">�����</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg"><% =FnPercentFormat(rs("total"),rslast("total")) %></td>
                <% rs.MOVENEXT : rslast.MOVENEXT : NEXT : rs.MOVEFIRST : rslast.MOVEFIRST %>
                <td class="list04_bg"><% =FnPercentFormat(rssum("total"),rslastsum("total")) %></td>
              </tr>
              <tr align="center"> 
                <td colspan="6"><img src="../../electric/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td rowspan="3" class="list02_bg2">����<br>���Ϸ���</td>
                <td class="list03_bg">������</td>
                <% FOR intI=0 TO 2 %>
                <td width="110" class="list01_bg"><% =FnNumberFormat(rs("magicisland")) %></td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
                <td width="110" class="list04_bg"><% =FnNumberFormat(rssum("magicisland")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg2">�������</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg2"><% =FnNumberFormat(rslast("magicisland")) %></td>
                <% rslast.MOVENEXT : NEXT : rslast.MOVEFIRST %>
                <td class="list04_bg2"><% =FnNumberFormat(rslastsum("magicisland"))%></td>
              </tr>
              <tr> 
                <td class="list03_bg">�����</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg"><% =FnPercentFormat(rs("magicisland"),rslast("magicisland")) %></td>
                <% rs.MOVENEXT : rslast.MOVENEXT : NEXT : rs.MOVEFIRST : rslast.MOVEFIRST %>
                <td class="list04_bg"><% =FnPercentFormat(rssum("magicisland"),rslastsum("magicisland")) %></td>
              </tr>
              <tr align="center"> 
                <td colspan="6"><img src="../../electric/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td rowspan="3" class="list02_bg2">��庥ó</td>
                <td class="list03_bg">������</td>
                <% FOR intI=0 TO 2 %>
                <td width="110" class="list01_bg"><% =FnNumberFormat(rs("adventure")) %></td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
                <td width="110" class="list04_bg"><% =FnNumberFormat(rssum("adventure")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg2">�������</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg"><% =FnNumberFormat(rslast("adventure")) %></td>
                <% rslast.MOVENEXT : NEXT : rslast.MOVEFIRST %>
                <td class="list04_bg"><% =FnNumberFormat(rslastsum("adventure")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg">�����</td>
                <% FOR intI=0 TO 2 %>      
                <td class="list01_bg"><% =FnPercentFormat(rs("adventure"),rslast("adventure")) %></td>
                <% rs.MOVENEXT : rslast.MOVENEXT : NEXT : rs.MOVEFIRST : rslast.MOVEFIRST %>
                <td class="list04_bg"><% =FnPercentFormat(rssum("adventure"),rslastsum("adventure")) %></td>
              </tr>
              <tr align="center"> 
                <td colspan="6"><img src="../../electric/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td rowspan="3" class="list02_bg2">ȣ��</td>
                <td class="list03_bg">������</td>
                <% FOR intI=0 TO 2 %>
                <td width="110" class="list01_bg"><% =FnNumberFormat(rs("hotel")) %></td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
                <td width="110" class="list04_bg"><% =FnNumberFormat(rssum("hotel")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg2">�������</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg2"><% =FnNumberFormat(rslast("hotel")) %></td>
                <% rslast.MOVENEXT : NEXT : rslast.MOVEFIRST %>
                <td class="list04_bg2"><% =FnNumberFormat(rslastsum("hotel")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg">�����</td>
                <% FOR intI=0 TO 2 %>      
                <td class="list01_bg"><% =FnPercentFormat(rs("hotel"),rslast("hotel")) %></td>
                <% rs.MOVENEXT : rslast.MOVENEXT : NEXT : rs.MOVEFIRST : rslast.MOVEFIRST %>
                <td class="list04_bg"><% =FnPercentFormat(rssum("hotel"),rslastsum("hotel")) %></td>
              </tr>
              <tr align="center"> 
                <td colspan="6"><img src="../../electric/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td rowspan="3" class="list02_bg2">��ȭ��</td>
                <td class="list03_bg">������</td>
                <% FOR intI=0 TO 2 %>
                <td width="110" class="list01_bg"><% =FnNumberFormat(rs("departmentstore")) %></td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
                <td width="110" class="list04_bg"><% =FnNumberFormat(rssum("departmentstore")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg2">�������</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg2"><% =FnNumberFormat(rslast("departmentstore")) %></td>
                <% rslast.MOVENEXT : NEXT : rslast.MOVEFIRST %>
                <td class="list04_bg2"><% =FnNumberFormat(rslastsum("departmentstore")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg">�����</td>
                <% FOR intI=0 TO 2 %>    
                <td class="list01_bg"><% =FnPercentFormat(rs("departmentstore"),rslast("departmentstore")) %></td>
                <% rs.MOVENEXT : rslast.MOVENEXT : NEXT : rs.MOVEFIRST : rslast.MOVEFIRST %>
                <td class="list04_bg"><% =FnPercentFormat(rssum("departmentstore"),rslastsum("departmentstore")) %></td>
              </tr>
              <tr align="center"> 
                <td colspan="6"><img src="../../electric/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td rowspan="3" class="list02_bg2">������</td>
                <td class="list03_bg">������</td>
                <% FOR intI=0 TO 2 %>
                <td width="110" class="list01_bg"><% =FnNumberFormat(rs("sports")) %></td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
                <td width="110" class="list04_bg"><% =FnNumberFormat(rssum("sports")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg2">�������</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg2"><% =FnNumberFormat(rslast("sports")) %></td>
                <% rslast.MOVENEXT : NEXT : rslast.MOVEFIRST %>
                <td class="list04_bg2"><% =FnNumberFormat(rslastsum("sports")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg">�����</td>
                <% FOR intI=0 TO 2 %>   
                <td class="list01_bg"><% =FnPercentFormat(rs("sports"),rslast("sports")) %></td>
                <% rs.MOVENEXT : rslast.MOVENEXT : NEXT : rs.MOVEFIRST : rslast.MOVEFIRST %>
                <td class="list04_bg"><% =FnPercentFormat(rssum("sports"),rslastsum("sports")) %></td>
              </tr>
              <tr align="center"> 
                <td colspan="6"><img src="../../electric/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td rowspan="3" class="list02_bg2">���θ�</td>
                <td class="list03_bg">������</td>
                <% FOR intI=0 TO 2 %>
                <td width="110" class="list01_bg"><% =FnNumberFormat(rs("shoppingmall")) %></td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
                <td width="110" class="list04_bg"><% =FnNumberFormat(rssum("shoppingmall")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg2">�������</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg2"><% =FnNumberFormat(rslast("shoppingmall")) %></td>
                <% rslast.MOVENEXT : NEXT : rslast.MOVEFIRST %>
                <td class="list04_bg2"><% =FnNumberFormat(rslastsum("shoppingmall")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg">�����</td>
                <% FOR intI=0 TO 2 %>         
                <td class="list01_bg"><% =FnPercentFormat(rs("shoppingmall"),rslast("shoppingmall")) %></td>
                <% rs.MOVENEXT : rslast.MOVENEXT : NEXT : rs.MOVEFIRST : rslast.MOVEFIRST %>
                <td class="list04_bg"><% =FnPercentFormat(rssum("shoppingmall"),rslastsum("shoppingmall")) %></td>
              </tr>
              <tr align="center"> 
                <td colspan="6"><img src="../../electric/images/point_line3.gif" width="628" height="1"></td>
              </tr>
              <tr> 
                <td rowspan="3" class="list02_bg2">��Ʈ</td>
                <td class="list03_bg">������</td>
                <% FOR intI=0 TO 2 %>
                <td width="110" class="list01_bg"><% =FnNumberFormat(rs("mart")) %></td>
                <% rs.MOVENEXT : NEXT : rs.MOVEFIRST %>
                <td width="110" class="list04_bg"><% =FnNumberFormat(rssum("mart")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg2">�������</td>
                <% FOR intI=0 TO 2 %>
                <td class="list01_bg2"><% =FnNumberFormat(rslast("mart")) %></td>
                <% rslast.MOVENEXT : NEXT : rslast.MOVEFIRST %>
                <td class="list04_bg2"><% =FnNumberFormat(rslastsum("mart")) %></td>
              </tr>
              <tr> 
                <td class="list03_bg">�����</td>
                <% FOR intI=0 TO 2 %>            
                <td class="list01_bg"><% =FnPercentFormat(rs("mart"),rslast("mart")) %></td>
                <% rs.MOVENEXT : rslast.MOVENEXT : NEXT : rs.MOVEFIRST : rslast.MOVEFIRST %>
                <td class="list04_bg"><% =FnPercentFormat(rssum("mart"),rslastsum("mart")) %></td>
              </tr>
              <tr bgcolor="#CECFF5"> 
                <td height="10" colspan="6"></td>
              </tr>
            </table>
			<!--������ ���̺� ��-->
          </td>
        </tr>
        <tr> 
          <td height="10"></td>
        </tr>
        <tr>
		  <td height="34" class="table02">
		  <!--�ϴ� ��ư�� ����--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="637" align="right"><a href="../../electric/excel/elect_month_excel.asp"><img src="../../electric/images/download_button.gif" width="88" height="26" border=0></a></td>
                <td width="5"></td>
              </tr>
            </table>
			<!--�ϴ� ��ư�� ��-->
          </td>
		  </tr>
        <tr> 
          <td height="30"></td>
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