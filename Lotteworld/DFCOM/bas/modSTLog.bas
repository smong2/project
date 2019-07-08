Attribute VB_Name = "modSTLog"
Option Explicit
Public bPerfLogged As Boolean
Public bErrorLogged As Boolean
Private Const BAS_NAME As String = "modSTLog"

'*****************************************************************************
'  ����   : ȣ�� �ð� �޾ƿ���
'  ����  :
' ��ȯ�� : ȣ�� �ð�
'*****************************************************************************
Public Function TickCount() As Long
Const MODULE_NAME As String = "TickCount"
    On Error GoTo ErrTrap
    
    Dim objLog As Object
    Dim strReg As String
    
    '������Ʈ������ ���� ������
    strReg = GetSetting("LotteWorld", "Logging", "IsPerfLogged")
    If Len(strReg) = 0 Then strReg = "0"
    bPerfLogged = CBool(strReg)
    
    strReg = GetSetting("LotteWorld", "Logging", "IsErrorLogged")
    If Len(strReg) = 0 Then strReg = "0"
    bErrorLogged = CBool(strReg)
    
    '�α� ���θ� �Ǵ�
    If bPerfLogged = True Or bErrorLogged = True Then
        Set objLog = CreateObject("CTSTLogSpyMTS.clsCTSTLogSpyNTX")
        TickCount = objLog.TickCount
    End If
    
    Set objLog = Nothing
    Exit Function
ErrTrap:
    If Not objLog Is Nothing Then Set objLog = Nothing
    If Err.Number = 5 Then
        Err.Description = "�α뿡 ���� ������Ʈ�� ��� ������ �����ϴ�."
    End If
    Err.Source = BAS_NAME & "." & MODULE_NAME & "- " & Err.Source
    Err.Raise Err.Number, Err.Source, Err.Description
End Function

'*****************************************************************************
'  ����   : ����ð� �α�
'  ����  :
'     Input :
'      ClassAndModuleName : Ŭ������ ����
'      DeveloperName      : �����ڸ�
'      lngTick            : ȣ�� �ð�
' ��ȯ�� : Nothing
'*****************************************************************************
Public Sub WritePerfLog(ClassAndModuleName As String, DeveloperName As String, lngTick As Long)
'�α׿��� �����ڵ巯�� ��ġ���� ����
    If bPerfLogged = True Then
        Dim objLog As Object
        Set objLog = CreateObject("CTSTLogSpyMTS.clsCTSTLogSpyNTX")
        objLog.WritePerfLog ClassAndModuleName, DeveloperName, lngTick
        Set objLog = Nothing
    End If
End Sub

'*****************************************************************************
'  ����   : ���� �α�
'  ����  :
'     Input :
'      ClassAndModuleName : Ŭ������ ����
'      DeveloperName      : �����ڸ�
'      ErrMsg             : ���� �޼���
' ��ȯ�� : Nothing
'*****************************************************************************
Public Sub WriteErrLog(ClassAndModuleName As String, DeveloperName As String, ErrMsg As String)
'�α׿��� �����ڵ巯�� ��ġ���� ����
    If bErrorLogged = True Then
        Dim objLog As Object
        Set objLog = CreateObject("CTSTLogSpyMTS.clsCTSTLogSpyNTX")
        objLog.WriteErrLog ClassAndModuleName, DeveloperName, ErrMsg
        Set objLog = Nothing
    End If
End Sub

