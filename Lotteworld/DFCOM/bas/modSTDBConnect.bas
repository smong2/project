Attribute VB_Name = "modSTDBConnect"
Option Explicit
Private Const BAS_NAME As String = "modSTDBConnect"
'*****************************************************************************
'  설명   : 컨넥션 스트링을 리턴
'  인자  :
'     Input :
'      Server : optional DB 서버명
'      DBName : optional DB 명
'   OutPut:   : Nothing
' 반환값 : Connection String
'*****************************************************************************
Public Function GetConnString(Optional ByVal Server As String = "" _
                            , Optional ByVal DBName As String = "") As String
Const MODULE_NAME As String = "GetConnString"
    On Error GoTo ErrTrap
    'Connection String 컴포넌트 선언
    Dim objDBCon As Object
    Set objDBCon = CreateObject("CTSTDataSvcMTS.clSTDBConNTX")
    GetConnString = objDBCon.GetConnString(Server, DBName)
    Set objDBCon = Nothing
    Exit Function
    
ErrTrap:
    '오브젝트 Free
    If Not objDBCon Is Nothing Then Set objDBCon = Nothing
    '에러 로깅
    'Call WriteErrLog(CLASS_NAME & "." & MODULE_NAME, DEVELOPER_NAME, Err.Number & "  " & Err.Description)
    '----------------------------------------------------------------------
    ' modSTDBConnect 의 Connection 에러로 제정의
    '----------------------------------------------------------------------
    Call WriteErrLog("GetConnString" & "." & MODULE_NAME, DEVELOPER_NAME, Err.Number & "  " & Err.Description)
    
    '에러 발생
    Err.Source = BAS_NAME & "." & MODULE_NAME & "- " & Err.Source
    Err.Raise Err.Number, Err.Source, Err.Description
    
End Function

