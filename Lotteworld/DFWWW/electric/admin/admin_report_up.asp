<%
' ========================================================================================================
' 프로그램ID : TXBADMINCon
' 업  무  명 : 수요예측
' 프로그램명 : 롯데월드 전기보고서 파일 전송
' 최초작성일 : 2003/01/15
' 최종작성일 : 2003/01/15
' 개  발  자 : 박순몽(kweather)
' ========================================================================================================
%>
<%
	dim pid '임시 생성키
	dim Upload '업로드 변수
	' 페이지가 timeout 되는 시간를 10000초로 늘인다.
	Server.ScriptTimeout = 5000
	PID = request("Pid")

	Set Upload = Server.CreateObject("NUpload.upload.1")
        Upload.SetSavePath("c:\dfwww\electric\excel")   ' 실제파일이 저장될 위치를 지정한다.
	Upload.SetId(PID)                ' 키를 설정한다.
	Filesize = Upload.Getsize()      ' 업로드 할 크기를 가져온다.
	Upload.Readformdata()            ' 업로드한다.
	Upload.SaveFile(0)
        FileSu = Upload.GetFileNum()     ' 업로드된 파일수를 가져온다. 
%>


<html>
  <head> 
     <title>UpLoad 예제1</title>
  </head>

  <body>
     <font size="2">
        <p align="center">
           <br>filesize = <%=filesize%><br>

<%
           for i = 1 to FileSu
              filename = Upload.GetFileName(i-1)
%>
              <br>filename[<%=i%>] = "<%=filename%>"<br>
<%
           next

           Set Upload = Nothing
%>

           5초후에 자동으로 업로드 화면으로 이동 됩니다.
        </p>
     </font>

     <script Language="JavaScript">
     <!--
         setTimeout("self.location.href='admin_reportInput.asp';", 5000);
     //-->
     </script>

  </body>	
</html>