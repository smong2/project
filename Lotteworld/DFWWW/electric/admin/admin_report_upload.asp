<%@ENABLESESSIONSTATE=FALSE%>
<%
' ========================================================================================================
' ���α׷�ID : TXBADMINCon
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���⺸�� ���ε� ���� - �˾�â���� Iframe�κ�
' �����ۼ��� : 2003/01/15
' �����ۼ��� : 2003/01/15
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================


%>
<html>
  <head>
    <meta http-equiv=refresh content="1, upload.asp?pid=<%= pid %>">
  </head>

<%
  'GB, MB, KB ����� ����ϴ� �Լ�
  function SizeCalculate(ByteSize)
     if ByteSize >= 1073741824 then
        ByteSize = (ByteSize / 1073741824)
        Position = int(instr(ByteSize, ".")) + 2
        ByteSize = left(ByteSize, Position) & "GB"
     elseif ByteSize >= 1048576 then
        ByteSize = (ByteSize / 1048576)
        Position = int(instr(ByteSize, ".")) + 2
        ByteSize = left(ByteSize, Position) & "MB"
     elseif ByteSize >= 1024 then
        ByteSize = (ByteSize / 1024) & "KB"
     end if

     SizeCalculate = ByteSize
  end function

  '�ð��� ���ڸ��� �϶� �տ� "0"�� �ٿ� ���ڸ����� ����� �Լ�
  function TimeLength(LeavesTime)
     if len(LeavesTime) < 2 then
        LeavesTime = "0" & Cstr(LeavesTime)
     end if

     TimeLength = LeavesTime
  end Function

  response.expires = -10000
  dim pid                            ' Process ID ��
  dim UpState                        ' Upstate ��ü ����
  dim TotalByte                      ' ������ �� ����Ʈ
  dim CurrentByte                    ' ������� ������ ����Ʈ 
  dim TotalSize, CurrentSize         ' GB, MB, KB ������
  dim TransRate                      ' �ʴ� ���۷�( �ʴ� Kbyte���� )
  dim LeavesTime                     ' ���ε� ���� �ð�
  dim ByteSize                       ' GB, MB, KB ����� ����ؼ� ��� ����
  dim position                       ' �Ҽ����� ��ġ�� ��� ����
  dim perscent                       ' ���α׷����� �����Ȳ�� ǥ���ϴ� �ۼ�Ʈ
  dim LTime, LHour, LMinute, LSecond '���� �����ð�, ��, �ʸ� ��� ����
	
  Pid = request("Pid")
  
  Set UpState = Server.CreateObject("UpState.UpStateClass.1")  ' �������� DLL��ü�� �����Ѵ�.
  UpState.SetID(Pid)                                           ' Ű�� �����Ѵ�.
  TotalByte = UpState.GetTotalByte()                           ' ���ε��� �� ����Ʈ���� �����´�.
  CurrentByte = UpState.GetSendByte()                          ' ������� ������ ����Ʈ�� �����´�.
  TransRate =   int(UpState.GetSendRate() + 0.5)               ' ���� ������ ���۵Ǵ� ���۷��� �����´�.
  LTime = UpState.GetRTime()                                   ' ���ε� �����ð��� �����´�.
  UpState.ProcessEnd()                                         ' ���� DLL ����
  Set UpState = Nothing

  '�׷����� �׸��� �ۼ������� ���
  If CurrentByte = -200 or CurrentByte = -400 Then
     perscent = 100
  ElseIf TotalByte = 0 Then
     perscent = 0
  Else
     perscent = Cint((CurrentByte / TotalByte) * 100)
  End If

  '���� ������ ���ε�ǰ� ���� �ð� ���
  LHour = int(LTime / 3600) '���� ���� �ð�
  LHour = TimeLength(LHour)
  LMinute = int((LTime mod 3600) / 60) '���� ���� ��
  LMinute = TimeLength(LMinute)
  LSecond = int((LTime mod 3600) mod 60) '���� ���� ��
  LSecond = TimeLength(LSecond)

%>

  <body bgcolor="#d4d0c8" topmargin=0 scroll=no>
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="361" height="23">
     <tr>
<% 
        If CurrentByte = - 200 Then
%>
           <td><center><font size='2'>�������Դϴ�. ��ø� ��ٷ� �ֽʽÿ�</center></font></td>               
<%        
        Else
%>
           <td><center><font size='2'>���ε� ���Դϴ�.</font></center></td>
<%        
        End If
%>
     </tr>

     <tr>
        <td>
           <table border="1" cellpadding="0" cellspacing="0" width="360" height="22">
              <tr>
                  <td>
                     <table border="0" cellpadding="0" cellspacing="0" width="<%= perscent %>%" height="20">
                        <tr>
                            <td bgcolor="blue" align="center"></td>
                        </tr>
                     </table>
                  </td>
	      </tr>
           </table>
        </td>
     </tr>

   </center>

<%
    TotalSize = SizeCalculate(TotalByte)     '�� ���� �뷮�� GB �Ǵ� MB �Ǵ� KB�� ��ȯ�ؼ� ������ ����
    CurrentSize = SizeCalculate(CurrentByte) '������� �ø� ���� �뷮�� GB �Ǵ� MB �Ǵ� KB�� ��ȯ�ؼ� ������ ����
	


    If CurrentByte <> -400 Then
       If CurrentByte = -200 Then   ' CurrentByte�� -200 �̸� ������ ���������� ��Ÿ����.
          response.write "<tr><td><center><font size='2'>�����մϴ�.</font></center>"
       Else
          response.write "<tr><td><table border='0' width='100%'><tr><td align='left' width='50%'><font size='2'>&nbsp;" & LHour & ":" & LMinute & ":" & LSecond & " left"
          response.write " (At " & TransRate & "k/sec)</font></td>"
          response.write "<td align='right' width='50%'><font size='2'>" & CurrentSize & " / " & TotalSize & " (" & perscent & "%)</font></td></tr></table>"
       End If
	  response.write "</td></tr></table>"
    Else 
%>
       <script Language="JavaScript">
       <!--
          self.close();
       //-->
       </script>
<%
       response.end
    End If

%>

  </body>
</html>
