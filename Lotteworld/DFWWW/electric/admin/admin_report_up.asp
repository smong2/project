<%
' ========================================================================================================
' ���α׷�ID : TXBADMINCon
' ��  ��  �� : ���俹��
' ���α׷��� : �Ե����� ���⺸�� ���� ����
' �����ۼ��� : 2003/01/15
' �����ۼ��� : 2003/01/15
' ��  ��  �� : �ڼ���(kweather)
' ========================================================================================================
%>
<%
	dim pid '�ӽ� ����Ű
	dim Upload '���ε� ����
	' �������� timeout �Ǵ� �ð��� 10000�ʷ� ���δ�.
	Server.ScriptTimeout = 5000
	PID = request("Pid")

	Set Upload = Server.CreateObject("NUpload.upload.1")
        Upload.SetSavePath("c:\dfwww\electric\excel")   ' ���������� ����� ��ġ�� �����Ѵ�.
	Upload.SetId(PID)                ' Ű�� �����Ѵ�.
	Filesize = Upload.Getsize()      ' ���ε� �� ũ�⸦ �����´�.
	Upload.Readformdata()            ' ���ε��Ѵ�.
	Upload.SaveFile(0)
        FileSu = Upload.GetFileNum()     ' ���ε�� ���ϼ��� �����´�. 
%>


<html>
  <head> 
     <title>UpLoad ����1</title>
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

           5���Ŀ� �ڵ����� ���ε� ȭ������ �̵� �˴ϴ�.
        </p>
     </font>

     <script Language="JavaScript">
     <!--
         setTimeout("self.location.href='admin_reportInput.asp';", 5000);
     //-->
     </script>

  </body>	
</html>