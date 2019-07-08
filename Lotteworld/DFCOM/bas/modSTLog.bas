Attribute VB_Name = "modSTLog"
Option Explicit
Public bPerfLogged As Boolean
Public bErrorLogged As Boolean
Private Const BAS_NAME As String = "modSTLog"

'*****************************************************************************
'  설명   : 호출 시각 받아오기
'  인자  :
' 반환값 : 호출 시각
'*****************************************************************************
Public Function TickCount() As Long
Const MODULE_NAME As String = "TickCount"
    On Error GoTo ErrTrap
    
    Dim objLog As Object
    Dim strReg As String
    
    '레지스트리에서 값을 가져옴
    strReg = GetSetting("LotteWorld", "Logging", "IsPerfLogged")
    If Len(strReg) = 0 Then strReg = "0"
    bPerfLogged = CBool(strReg)
    
    strReg = GetSetting("LotteWorld", "Logging", "IsErrorLogged")
    If Len(strReg) = 0 Then strReg = "0"
    bErrorLogged = CBool(strReg)
    
    '로그 여부를 판단
    If bPerfLogged = True Or bErrorLogged = True Then
        Set objLog = CreateObject("CTSTLogSpyMTS.clsCTSTLogSpyNTX")
        TickCount = objLog.TickCount
    End If
    
    Set objLog = Nothing
    Exit Function
ErrTrap:
    If Not objLog Is Nothing Then Set objLog = Nothing
    If Err.Number = 5 Then
        Err.Description = "로깅에 관한 레지스트리 등록 정보가 없습니다."
    End If
    Err.Source = BAS_NAME & "." & MODULE_NAME & "- " & Err.Source
    Err.Raise Err.Number, Err.Source, Err.Description
End Function

'*****************************************************************************
'  설명   : 수행시간 로깅
'  인자  :
'     Input :
'      ClassAndModuleName : 클래스와 모듈명
'      DeveloperName      : 개발자명
'      lngTick            : 호출 시각
' 반환값 : Nothing
'*****************************************************************************
Public Sub WritePerfLog(ClassAndModuleName As String, DeveloperName As String, lngTick As Long)
'로그에는 에러핸드러를 설치하지 않음
    If bPerfLogged = True Then
        Dim objLog As Object
        Set objLog = CreateObject("CTSTLogSpyMTS.clsCTSTLogSpyNTX")
        objLog.WritePerfLog ClassAndModuleName, DeveloperName, lngTick
        Set objLog = Nothing
    End If
End Sub

'*****************************************************************************
'  설명   : 에러 로깅
'  인자  :
'     Input :
'      ClassAndModuleName : 클래스와 모듈명
'      DeveloperName      : 개발자명
'      ErrMsg             : 에러 메세지
' 반환값 : Nothing
'*****************************************************************************
Public Sub WriteErrLog(ClassAndModuleName As String, DeveloperName As String, ErrMsg As String)
'로그에는 에러핸드러를 설치하지 않음
    If bErrorLogged = True Then
        Dim objLog As Object
        Set objLog = CreateObject("CTSTLogSpyMTS.clsCTSTLogSpyNTX")
        objLog.WriteErrLog ClassAndModuleName, DeveloperName, ErrMsg
        Set objLog = Nothing
    End If
End Sub

