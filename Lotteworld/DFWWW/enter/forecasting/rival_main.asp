<!-- #include file="../../enter/script/FnLoginAuth.inc" -->
<% 
' ========================================================================================================
' ���α׷�ID : RIVAL MAIN
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ����� ���� ����
' �����ۼ��� : 2002/10/24
' �����ۼ��� : 2002/11/21
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

'������ ����
Dim objServer, arrRValue, ArrQuery, Arr '�İ��� ������
Dim rsrival,rsrivalsum, rslotte, rslottesum,rsrivalyear, rsrivalyearsum, rslotteyear, rslotteyearsum '���ڵ��
   '���̹� �� ����, ���� �� �հ�, �Ե� �� ����, �Ե� �� �԰�, ���̹� �� ����, �� ���� �հ�, �Ե� �� ����, �Ե� �� �հ�

ArrQuery = array()

'������ ����
Set objServer = Server.CreateObject("XTEnterRivalMainMTS.clsXTEnterRivalMNTX")

'������Ʈ ȣ�� ������ ����
' ...

'������Ʈ ȣ��
arrRValue = objServer.Query(ArrQuery)
'���ڵ�� ��̸� ���� ���ڵ������ �и�

'ù��° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rsrival,1
'�ι�° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rslotte,2
'����° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rsrivalsum,3
'�׹�° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rslottesum,4
'�ټ���° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rsrivalyear,5
'������° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rslotteyear,6
'�ϰ���° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rsrivalyearsum,7
'������° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rslotteyearsum,8

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
<!-- #include file="../../enter/script/fnnumber_format.inc" -->
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
          <td align="left" height="21"><img src="../../enter/images/title_rival.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="30" valign="top"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--����� �� Ÿ��Ʋ �� ���̺� ����--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="15" height="11" class="table03"><img src="../../enter/images/vermilion_buret.gif" width="7" height="7"></td>
                <td class="title_01">����� <% =rsrival("month") %>�� ����</td>
              </tr>
            </table>
			<!--����� �� Ÿ��Ʋ �� ���̺� ��-->
          </td>
        </tr>
        <tr> 
          <td height="5"><img src="../../enter/images/null.gif" width="1" height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--����� �� ���� ���̺� ����--> 
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr class="list02_bg"> 
                <td width="102">����</td>
                <td width="90">�</td>
                <td width="90">�߰��</td>
                <td width="90">���</td>
                <td width="90">�Ѱ�</td>
                <td width="90">����</td>
                <td width="90">���</td>
              </tr>
              <tr> 
                <td class="list03_bg">�Ե�����</td>
                <td class="list01_bg"><% =FnNumberFormat(rslotte("lotteadult")) %></td>
                <td class="list01_bg"><% =FnNumberFormat(rslotte("lotteschool")) %></td>
                <td class="list01_bg"><% =FnNumberFormat(rslotte("lottechild")) %></td>
                <td class="list01_bg"><% =FnNumberFormat(rslotte("lottetotal")) %></td>
                <td class="list04_bg"><% =FnNumberFormat(rslottesum("lottetotal")) %></td>
                <td class="list05_bg">�����尴</td>
              </tr>
              <tr> 
                <td class="list03_bg2">��������</td>
                <td class="list01_bg2"><% =FnNumberFormat(rsrival("everadult")) %></td>
                <td class="list01_bg2"><% =FnNumberFormat(rsrival("everschool")) %></td>
                <td class="list01_bg2"><% =FnNumberFormat(rsrival("everchild")) %></td>
                <td class="list01_bg2"><% =FnNumberFormat(rsrival("evertotal")) %></td>
                <td class="list04_bg2"><% =FnNumberFormat(rsrivalsum("evertotal")) %></td>
                <td class="list05_bg2">�����尴</td>
              </tr>
              <tr> 
                <td class="list03_bg">���﷣��</td>
                <td class="list01_bg"><% =FnNumberFormat(rsrival("seouladult")) %></td>
                <td class="list01_bg"><% =FnNumberFormat(rsrival("seoulschool")) %></td>
                <td class="list01_bg"><% =FnNumberFormat(rsrival("seoulchild")) %></td>
                <td class="list01_bg"><% =FnNumberFormat(rsrival("seoultotal")) %></td>
                <td class="list04_bg"><% =FnNumberFormat(rsrivalsum("seoultotal")) %></td>
                <td class="list05_bg">�����尴</td>
              </tr>
              <tr bgcolor="#B0DFFD"> 
                <td height="10" colspan="7"></td>
              </tr>
            </table>
			<!--����� �� ���� ���̺� ��-->
          </td>
        </tr>
        <tr> 
          <td height="30"><img src="../../enter/images/null.gif" width="1" height="30"></td>
        </tr>
        <tr> 
          <td> 
		  <!--����� �� Ÿ��Ʋ �� ���̺� ����-->
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="15" height="11" class="table03"><img src="../../enter/images/vermilion_buret.gif" width="7" height="7"></td>
                <td class="title_01">����� <% =rsrival("year") %>�� ����</td>
              </tr>
            </table>
			<!--����� �� Ÿ��Ʋ �� ���̺� ��-->
          </td>
        </tr>
        <tr> 
          <td height="5"><img src="../../enter/images/null.gif" width="1" height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--����� �� ���� ���̺� ����--> 
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr class="list02_bg"> 
                <td width="102">����</td>
                <td width="90">�</td>
                <td width="90">�߰��</td>
                <td width="90">���</td>
                <td width="90">�Ѱ�</td>
                <td width="90">����(2�Ⱓ)</td>
                <td width="90">���</td>
              </tr>
              <tr> 
                <td class="list03_bg">�Ե�����</td>
                <td class="list01_bg"><% =FnNumberFormat(rslotteyear("lotteadult")) %></td>
                <td class="list01_bg"><% =FnNumberFormat(rslotteyear("lotteschool")) %></td>
                <td class="list01_bg"><% =FnNumberFormat(rslotteyear("lottechild")) %></td>
                <td class="list01_bg"><% =FnNumberFormat(rslotteyear("lottetotal")) %></td>
                <td class="list04_bg"><% =FnNumberFormat(rslotteyearsum("lottetotal")) %></td>
                <td class="list05_bg">�����尴</td>
              </tr>
              <tr> 
                <td class="list03_bg2">��������</td>
                <td class="list01_bg2"><% =FnNumberFormat(rsrivalyear("everadult")) %></td>
                <td class="list01_bg2"><% =FnNumberFormat(rsrivalyear("everschool")) %></td>
                <td class="list01_bg2"><% =FnNumberFormat(rsrivalyear("everchild")) %></td>
                <td class="list01_bg2"><% =FnNumberFormat(rsrivalyear("evertotal")) %></td>
                <td class="list04_bg2"><% =FnNumberFormat(rsrivalyearsum("evertotal")) %></td>
                <td class="list05_bg2">�����尴</td>
              </tr>
              <tr> 
                <td class="list03_bg">���﷣��</td>
                <td class="list01_bg"><% =FnNumberFormat(rsrivalyear("seouladult")) %></td>
                <td class="list01_bg"><% =FnNumberFormat(rsrivalyear("seoulschool")) %></td>
                <td class="list01_bg"><% =FnNumberFormat(rsrivalyear("seoulchild")) %></td>
                <td class="list01_bg"><% =FnNumberFormat(rsrivalyear("seoultotal")) %></td>
                <td class="list04_bg"><% =FnNumberFormat(rsrivalyearsum("seoultotal")) %></td>
                <td class="list05_bg">�����尴</td>
              </tr>
              <tr bgcolor="#B0DFFD"> 
                <td height="10" colspan="7"></td>
              </tr>
            </table>
			<!--����� �� ���� ���̺� ��-->
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
</body>
</html>
<!-- #include file="../../enter/script/FnErrorCatch.inc"-->