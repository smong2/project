<!-- #include file="../../enter/script/FnLoginAuth_admin.inc" -->
<% 
' ========================================================================================================
' ���α׷�ID : TXBBULLETIN - seoul admin
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���尴 ���� ��� - ���﷣�� ��� ������
' �����ۼ��� : 2002/10/16
' �����ۼ��� : 2002/10/18
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================

'������ ����
Dim ArrRValue, ArrRvalueUI, objserver, Arr '�İ��� ������
Dim ArrQ, ArrUI '���, �Է¿�
Dim rs,rsmodify '���ڵ�� : �� ����Ʈ, ������ ���� ����
Dim varInsertModify,hidInsert  '����,��� ���, ������
Dim varTitle,varContents,intStartYear,intStartMonth,intStartDay,intEndyear,intEndMonth,intEndDay '��������
Dim varParkClass,dtStartDate,dtEndDate '��������
Dim	intIdx,hidIdx,intI : inti=1 'idx ������,form��, �������� �ʱⰪ 1
Dim varMode,hidMode '������ �Ѿ�� mode ��, form���� �Ѿ�� mode ��

'������ ����
intPage=Request.QueryString("intPage") '���ڵ� ������ ����
intIdx=Request.QueryString("intIdx")  '�������� �� ��ȣ ������
varMode=Request.QueryString("varMode") '�ʱ�ȭ������ ���� ������� ����
hidInsert=Request.Form("hidInsert") '������ �ڷᰡ �Ѿ������ Ȯ��

IF hidinsert="ok" THEN
	varTitle=Request.Form("txtSubject") '������ �Ѿ�� ������(�Է�,������ ���) -����
	varContents=Request.Form("txtaMemo") '����
	hidIdx=Request.Form("hidIdx") '������ ���Ǵ� �۹�ȣ
	hidMode=Request.Form("hidMode") '��������, ������� ����
	
	intStartYear=Request.Form("sltStartyear") '�������� -���۳�
	intStartMonth=Request.Form("sltStartmonth")  '���ۿ�
	intStartDay=Request.Form("sltStartday") '������
	intEndYear=Request.Form("sltEndyear") '�����
	intEndMonth=Request.Form("sltEndmonth") '�����
	intEndDay=Request.Form("sltEndday") '������
	dtStartDate=dateserial(intStartYear,intStartMonth,intStartDay) '���۳�¥ ����
	dtEndDate=dateserial(intEndYear,intEndMonth,intEndDay) '���ᳯ¥ ����
	varParkClass=Request.Form("sltParkClass") '��ũ ����
END IF

IF hidMode="MQ" and hidInsert="ok" THEN  '�������� �Է������� ����
	varInsertModify="modify"
ELSEIF hidMode="" and hidInsert="ok" THEN '���Ⱑ �Է� ������ ����.
	varInsertModify="insert"
END IF

'���� ���� ���� ����
IF varmode="" THEN varmode = null '���� ����
IF intIdx="" THEN intIdx = null '���� ����
ArrQ = array(varMode,intIdx,"���﷣��") '���� ���� ����
'�������

'�Է¸���϶� 
IF hidInsert="ok" THEN
	IF hididx="" THEN hidIdx=null '���� ����
	Set objServer = Server.CreateObject("XBbulletinUIQMTS.clsXBbulletinUIQTX")  '�Է� ����
	ArrUI=array(varInsertModify,varParkClass,hididx,varTitle,varContents,dtStartDate,dtEndDate) '����,�Է� ����
	arrRValueUI=objServer.save(ArrUI)  '�Է�����- �Է� �ڵ尡 ������ �� �۵�
	hidInsert="" '�ʱⰪ ���ϰ�..
	
	'�ڿ��� ����
	Set objServer = Nothing
END IF

Set objServer =  Server.CreateObject("XBbulletinUIQMTS.clsXBbulletinUIQNTX") '��� ����

'������Ʈ ȣ��
arrRValue=objServer.Query(ArrQ)

'���ڵ�� ��̸� ���� ���ڵ������ �и�
'ù��° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rs,1 '����Ʈ ���ڵ�

IF varMode="MQ" THEN '������ ���� �۹�ȣ ��������
'�ι�° ���ڵ���� ��̷� ��ȯ
FnSplitRSArray arrRValue,rsmodIFy,2 '���� ���� ���ڵ�
END IF 

'�ڿ��� ����
Set objServer = Nothing

IF varMode="MQ" and hidinsert="" THEN  '���� ���� �϶� �۹�ȣ�� �ش�Ǵ� �ڷ� ������
	intStartyear=year(rsmodify("startdate"))
	intStartmonth=month(rsmodify("startdate"))
	intStartday=day(rsmodify("startdate"))
	intEndyear=year(rsmodify("enddate"))
	intEndmonth=month(rsmodify("enddate"))
	intEndday=day(rsmodify("enddate"))
	varTitle=rsmodify("title")
	varContents=rsmodify("contents")
END IF

'������ ó��
IF Err.Number <> 0 THEN 
	Response.Write Err.Number, Err.Source, Err.Description
	Set objServer = Nothing
	objserver.close
END IF
%>
<!-- #include file="../../enter/script/FnProgramProcess.vbs" -->
<!-- #include file="../../enter/script/fnadmin_event_input.inc" -->
<html>
<head>
<title>�Ե����� ���俹���ý���</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<script language="JavaScript" src=../../enter/script/Fnadmin_event_input.js></script>
<link rel="stylesheet" href="../../enter/css/cs_tx.css" type="text/css">
</head>

<body bgcolor="#F5F5F5" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="MM_preloadImages('../../enter/images/tap_ever2.gif','../../enter/images/tap_seoul2.gif');Fn_clearModify();document.form.txtSubject.focus()" >
<form method=post action='admin_event_lotte.asp' name=form>
<input type=hidden name=hidmode value=<% =varmode %>>
<input type=hidden name=hidIdx value=<% =intIdx %>>
<input type=hidden name=hidInsert value=ok>
<table width="743" border="0" cellspacing="0" cellpadding="0" height="100%" bgcolor="#FFFFFF">
  <tr> 
    <td width="49"><img src="../../enter/images/null.gif" width="49" height="1"></td>
    <td width="642" valign="top">
	<!--ū ���̺� ����--> 
      <table width="642" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="24" colspan="2"><img src="../../enter/images/null.gif" width="1" height="24"></td>
        </tr>
        <tr> 
          <td align="left" colspan="2"><img src="../../enter/images/title_admin_event.gif" width="200" height="21"></td>
        </tr>
        <tr> 
          <td height="40" valign="top" colspan="2"><img src="../../enter/images/title_bar.gif" width="642" height="5"></td>
        </tr>
        <tr> 
          <td>
		  <!--��ü �Է�â ����--> 
            <table width="150" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="title_01_c"><img src="../../enter/images/yellowgreen_buret.gif" width="7" height="7"> 
                  ��ü 
                  <select name="sltParkClass">                                     
                    <option value=�Ե�����>�Ե�����</option>
                    <option value=��������>��������</option>
                    <option value=���﷣�� selected>���﷣��</option>                    
                  </select>
                </td>
              </tr>
            </table>
			<!--��ü �Է�â ��-->
          </td>
          <td>
		  <!--���Ⱓ �Է� ����--> 
            <table width="492" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="title_01_r"><img src="../../enter/images/yellowgreen_buret.gif" width="7" height="7"> 
                  ���Ⱓ 
                  <select name="sltStartyear">                  
                <% FOR intI=2002 to 2010 
                   IF intStartyear=intI THEN
                   Response.Write "<option selected value='" & intI & "'>"& intI & "��</option>"
                   ELSE
                   Response.Write "<option value='" & intI & "'>"& intI & "��</option>"
                   END IF : NEXT %>
                  </select>
                  <select name="sltStartmonth">
                   <% FOR IntI=01 to 12
                    IF intStartmonth=intI THEN
                   Response.Write "<option selected value='" & intI & "'>"& intI & "��</option>"
                   ELSE
                   Response.Write "<option value='" & intI & "'>"& intI & "��</option>"
                   END IF : NEXT %>
                  </select>
                  <select name="sltStartday">
                   <% FOR IntI=01 to 31
                    IF intStartday=intI THEN
                   Response.Write "<option selected value='" & intI & "'>"& intI & "��</option>"
                   ELSE
                   Response.Write "<option value='" & intI & "'>"& intI & "��</option>"
                   END IF : NEXT %>
                  </select>
                  ~ 
                   <select name="sltEndyear">
                  <% FOR IntI=2002 to 2010 
                   IF intEndyear=intI THEN
                   Response.Write "<option selected value='" & intI & "'>"& intI & "��</option>"
                   ELSE
                   Response.Write "<option value='" & intI & "'>"& intI & "��</option>"
                   END IF : NEXT %>
                  </select>
                  <select name="sltEndmonth">
                   <% FOR IntI=01 to 12
                    IF intEndmonth=intI THEN
                   Response.Write "<option selected value='" & intI & "'>"& intI & "��</option>"
                   ELSE
                   Response.Write "<option value='" & intI & "'>"& intI & "��</option>"
                   END IF : NEXT %>
                  </select>
                  <select name="sltEndday">
                   <% FOR IntI=01 to 31
                    IF intEndday=intI THEN
                   Response.Write "<option selected value='" & intI & "'>"& intI & "��</option>"
                   ELSE
                   Response.Write "<option value='" & intI & "'>"& intI & "��</option>"
                   END IF : NEXT %>
                  </select>
                </td>
              </tr>
            </table>
			<!--���Ⱓ �Է� ��-->
          </td>
        </tr>
        <tr> 
          <td height="7" colspan="2"></td>
        </tr>
        <tr> 
          <td colspan="2">
		  <!--��� �Է� ���̺� ����--> 
            <table width="642" border="0" cellspacing="1" cellpadding="7">
              <tr bgcolor="#B0DFFD"> 
                <td height="7" colspan="2"></td>
              </tr>
              <tr> 
                <td width="100" class="list13_bg">����</td>
                <td class="table01"> 
                  <input type="text" name="txtSubject" size="65" maxlength=70 value='<% =varTitle %>'>
                </td>
              </tr>
              <tr> 
                <td class="list13_bg">����</td>
                <td class="table01"> 
                  <textarea cols="65" rows="12" name=txtaMemo><% =varContents %></textarea>
                </td>
              </tr>
              <tr bgcolor="#B0DFFD"> 
                <td height="7" colspan="2"></td>
              </tr>
            </table>
			<!--��� �Է� ���̺� ��-->
          </td>
        </tr>
        <tr> 
          <td height="10" colspan="2"></td>
        </tr>
        <tr> 
          <td height="34" colspan="2" class="table02">
		  <!--�ϴ� ��ư �� ���̺� ����--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td align="right"><input type=image src="../../enter/images/save.gif" width="53" height="26" border="0" onclick='return Fn_check()' id=image1 name=image1></td>
                <td width="5"></td>
              </tr>
            </table>
			<!--�ϴ� ��ư �� ���̺� ��-->
          </td>
        </tr>
        <tr> 
          <td height="30" colspan="2"></td>
        </tr>
        <tr>
          <td colspan="2">
		  <!--�Ե�����/��������/���﷣�� ��������Խ��� �ѿ��� �� ����-->
            <table width="217" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><a href="admin_event_lotte.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image40','','../../enter/images/tab_lotte.gif',1)"><img name="Image40" border="0" src="../../enter/images/tab_lotte2.gif" width="73" height="24"></a></td>
                <td><a href="admin_event_ever.asp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image41','','../../enter/images/tab_ever.gif',1)"><img name="Image41" border="0" src="../../enter/images/tab_ever2.gif" width="72" height="24"></a></td>
                <td><img src="../../enter/images/tab_seoul.gif" width="72" height="24"></td>
              </tr>
            </table>
			<!--�Ե�����/��������/���﷣�� ��������Խ��� �ѿ��� �� ��-->
          </td>
        </tr>
        <tr valign="top"> 
          <td height="350" colspan="2">
		  <!--���﷣�� ������� �Խ��� ����--> 
            <table width="642" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td><img src="../../enter/images/gray_edge2.gif" width="15" height="15"></td>
                <td width="612" align="right" bgcolor="#F4F4F4"><img src="../../enter/images/gray_round_edge_top.gif" width="555" height="15"></td>
                <td><img src="../../enter/images/gray_round_edge2.gif" width="15" height="15"></td>
              </tr>
              <tr> 
                <td width="15" background="../../enter/images/gray_round_edge_left.gif"></td>
                <td class="table03">
				<!--�Խ��� ��� ����--> 
                  <table width="523" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td colspan="4" height="20"></td>
                    </tr>
                       <% do while not rs.EOF and intTotalPage>0 %>
                    <tr> 
                      <td width="50" height="19" class="list10_1"><% =rs("IDX") %></td>
                      <td width="316" class="list05"><a href="../../enter/event/event_seoul_view.asp?intIdx=<% =rs("IDX") %>" title='<% =rs("TITLE") %>'><% =left(rs("title"),30) %>...</a></td>
                      <td width="107" align="right"><img src="../../enter/images/modIFy_small_bu.gif" width="52" height="13" onclick="location.href('admin_event_seoul.asp?intIdx=<%=rs("IDX") %>&varMode=MQ')"></td>
                      <td width="60" align="right"><img src="../../enter/images/delete_small_bu.gif" width="52" height="13"  onclick="location.href('admin_event_delete.asp?code=seoul&intIdx=<%=rs("Idx") %>')"></td>
                    </tr>
                    <tr> 
                      <td colspan="4"><img src="../../enter/images/point_line5.gif" width="523" height="1"></td>
                    </tr>
                    <tr> 
                      <td colspan="4" height="10"></td>
                    </tr>
                      <% intTotalPage=intTotalPage-1 : rs.MOVENEXT : LOOP %>
                    <tr class="table04"> 
                      <td colspan="4" height="20">
					  <!--������ ��ȣ ���̺� ����--> 
                        <table width="268" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td width="64" class="list13_1">
								 <%	IF intCurPage >1 THEN
										Response.Write "<a href='admin_event_seoul.asp?intPage=" & intCurPage-1 & "'>�� ����</a>"
									ELSE
										Response.Write "<font color=#f5f5f5>�� ����</font>"
									END IF %></td>
										<td width="140" class="list14_1">
									<div align="center">
								<%	FOR intI=intStartPage to intStartPage-1+intLimit
										Response.Write "<a href='admin_event_seoul.asp?intPage=" & intI & "'>" & intI & "</a> "
											IF intI>=intLastPage THEN
											exit for
											END IF
									NEXT %>
									</div>
									</td>
										<td width="64" class="list13_2">
								<%	IF intCurPage - intLastPage <0 THEN
										Response.Write "<a href='admin_event_seoul.asp?intPage=" & intCurpage+1 & "'>���� ��</a>"
									ELSE
										Response.Write "<font color=#f5f5f5>���� ��</font></a>"
									END IF %></td>
                          </tr>
                        </table>
						<!--������ ��ȣ ���̺� ��-->
                      </td>
                    </tr>
                    <tr> 
                      <td colspan="4" height="10"></td>
                    </tr>
                  </table>
				  <!--�Խ��� ��� ��-->
                </td>
                <td width="15" background="../../enter/images/gray_round_edge_right.gif"></td>
              </tr>
              <tr> 
                <td><img src="../../enter/images/gray_round_edge3.gif" width="15" height="15"></td>
                <td><img src="../../enter/images/gray_round_edge_bottom.gif" width="612" height="15"></td>
                <td><img src="../../enter/images/gray_round_edge4.gif" width="15" height="15"></td>
              </tr>
            </table>
			<!--���﷣�� ������� �Խ��� ��-->
          </td>
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
