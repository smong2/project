<%@ENABLESESSIONSTATE=FALSE%>
<%
' ========================================================================================================
' 프로그램ID : TXBADMINCon
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 전기보고서 업로드 파일 - 팝업창에서 Iframe부분
' 최초작성일 : 2003/01/15
' 최종작성일 : 2003/01/15
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================


%>
<html>
  <head>
    <meta http-equiv=refresh content="1, upload.asp?pid=<%= pid %>">
  </head>

<%
  'GB, MB, KB 사이즈를 계산하는 함수
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

  '시간이 한자리수 일때 앞에 "0"을 붙여 두자리수로 만드는 함수
  function TimeLength(LeavesTime)
     if len(LeavesTime) < 2 then
        LeavesTime = "0" & Cstr(LeavesTime)
     end if

     TimeLength = LeavesTime
  end Function

  response.expires = -10000
  dim pid                            ' Process ID 값
  dim UpState                        ' Upstate 객체 생성
  dim TotalByte                      ' 전송할 총 바이트
  dim CurrentByte                    ' 현재까지 전송한 바이트 
  dim TotalSize, CurrentSize         ' GB, MB, KB 사이즈
  dim TransRate                      ' 초당 전송량( 초당 Kbyte단위 )
  dim LeavesTime                     ' 업로드 남은 시간
  dim ByteSize                       ' GB, MB, KB 사이즈를 계산해서 담는 변수
  dim position                       ' 소숫점의 위치를 담는 변수
  dim perscent                       ' 프로그래스의 진행상황을 표시하는 퍼센트
  dim LTime, LHour, LMinute, LSecond '현재 남은시간, 분, 초를 담는 변수
	
  Pid = request("Pid")
  
  Set UpState = Server.CreateObject("UpState.UpStateClass.1")  ' 상태정보 DLL객체를 생성한다.
  UpState.SetID(Pid)                                           ' 키를 설정한다.
  TotalByte = UpState.GetTotalByte()                           ' 업로드할 총 바이트수를 가져온다.
  CurrentByte = UpState.GetSendByte()                          ' 현재까지 전송한 바이트를 가져온다.
  TransRate =   int(UpState.GetSendRate() + 0.5)               ' 현재 파일이 전송되는 전송률을 가져온다.
  LTime = UpState.GetRTime()                                   ' 업로드 남은시간을 가져온다.
  UpState.ProcessEnd()                                         ' 상태 DLL 종료
  Set UpState = Nothing

  '그래프를 그리는 퍼센테이지 계산
  If CurrentByte = -200 or CurrentByte = -400 Then
     perscent = 100
  ElseIf TotalByte = 0 Then
     perscent = 0
  Else
     perscent = Cint((CurrentByte / TotalByte) * 100)
  End If

  '현재 파일이 업로드되고 남은 시간 계산
  LHour = int(LTime / 3600) '현재 남은 시간
  LHour = TimeLength(LHour)
  LMinute = int((LTime mod 3600) / 60) '현재 남은 분
  LMinute = TimeLength(LMinute)
  LSecond = int((LTime mod 3600) mod 60) '현재 남은 초
  LSecond = TimeLength(LSecond)

%>

  <body bgcolor="#d4d0c8" topmargin=0 scroll=no>
  <center>
  <table border="0" cellpadding="0" cellspacing="0" width="361" height="23">
     <tr>
<% 
        If CurrentByte = - 200 Then
%>
           <td><center><font size='2'>저장중입니다. 잠시만 기다려 주십시오</center></font></td>               
<%        
        Else
%>
           <td><center><font size='2'>업로드 중입니다.</font></center></td>
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
    TotalSize = SizeCalculate(TotalByte)     '총 파일 용량을 GB 또는 MB 또는 KB로 변환해서 변수에 넣음
    CurrentSize = SizeCalculate(CurrentByte) '현재까지 올린 파일 용량을 GB 또는 MB 또는 KB로 변환해서 변수에 넣음
	


    If CurrentByte <> -400 Then
       If CurrentByte = -200 Then   ' CurrentByte가 -200 이면 파일을 저장중임을 나타낸다.
          response.write "<tr><td><center><font size='2'>감사합니다.</font></center>"
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
