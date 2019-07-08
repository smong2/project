VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 1  'NoTransaction
END
Attribute VB_Name = "clsXTRivalMonthXlsNTX"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
'******************************************************************************
' Component Name: XTRivalMonthXls.vbp
' Class Name    : XTRivalMonthXls.cls
' 개요          : Server컴포넌트 생성기(COM+) (NonTransaction)
' 작성자        : 작성자
' 작성일자      : 작성일자
'******************************************************************************
Option Explicit
'-- ADODB.Connection 객체 선언
Private adoCn As ADODB.Connection
'-- ObjectContext 객체 선언
Private xobjContext As ObjectContext
'-- 클래스 명 상수 정의
Private Const CLASS_NAME = "XTRivalMonXlsMTS.clsXTRivalMonthXlsNTX"

'******************************************************************************
' Funtion Name  : Query
' Description   : 조회
' Parameters
' 작성자        : ???
' 작성일        : ???
'******************************************************************************
Public Function Query(ByVal arrM As Variant) As Variant
'-- 모듈명 선언
Const MODULE_NAME As String = "Query"
   On Error GoTo ErrTrap

   Dim adoCmd As ADODB.Command
   Dim adoRs As ADODB.Recordset
   
   Dim lngTick As Long                     '시작 시간을 저장하는 변수
   Dim i As Long                           '루핑을 위한 변수
   '-- 로그 스파이 시작
   lngTick = TickCount
   
    '-- 필요한 시점에 Connection 객체를 생성한다.
    Set adoCn = New Connection
    
    Set xobjContext = GetObjectContext
    '******************************************************************************
    ' Funtion Name  : GetConnString
    ' Description   : Connection String 을 만든다.
    ' Parameters
    '           input
    '                   Server  - 서버명 (접속DB서버를 변경할때 사용한다.)
    '                   DBName  - DB 명  (사용 DB 를 입력)
    ' 작성자        : ???
    ' 작성일        : ???
    '******************************************************************************
    adoCn.Open GetConnString("", "")
   
   Set adoCmd = New ADODB.Command
   With adoCmd
   Set .ActiveConnection = adoCn
       .CommandText = "dbo.SXWTRivalMonthXlsQ"       'Stored Procedure 명을 삽입한다.
       .CommandType = adCmdStoredProc       'CommandType은 반드시 명시적으로 세팅한다.
       .CommandTimeout = 30                 '쿼리의 수행 시간은 업무에 따라 설정한다.
       .Parameters.Refresh
       
       'SP의 파라미터를 세팅
       For i = 0 To UBound(arrM, 1)
           .Parameters(1 + i) = arrM(i)
       Next i
   End With
   
   '-- 비연결 레코드셋을 위한 속성을 설정한다.
   Set adoRs = New ADODB.Recordset
   With adoRs
       .CursorLocation = adUseClient
       .CursorType = adOpenStatic
       .LockType = adLockBatchOptimistic
       .Open adoCmd
   End With
   
   Query = GetRecordSetToArray(adoRs)
   Set adoRs = Nothing
   
   'DB의 컨넥션을 끊음
   Set adoCmd.ActiveConnection = Nothing
   Set adoCmd = Nothing
   
   
   'SetComplete 호출
   xobjContext.SetComplete
   '로그 스파이 끝
   Call WritePerfLog(CLASS_NAME & "." & MODULE_NAME, DEVELOPER_NAME, lngTick)
   
    Set xobjContext = Nothing
    adoCn.Close
    Set adoCn = Nothing
   
   Exit Function
   
ErrTrap:
   'SetAbort 호출
   xobjContext.SetAbort
   '리소스 해제
    If Not xobjContext Is Nothing Then Set xobjContext = Nothing
    If Not adoCmd Is Nothing Then Set adoCmd = Nothing
    If Not adoRs Is Nothing Then Set adoRs = Nothing
    If Not adoCn Is Nothing Then Set adoCn = Nothing
   '에러 로깅
   Call WriteErrLog(CLASS_NAME & "." & MODULE_NAME, DEVELOPER_NAME, Err.Number & "  " & Err.Description)
   '에러이벤트 발생
   Err.Source = CLASS_NAME & "." & MODULE_NAME & "- " & Err.Source
   Err.Raise Err.Number, Err.Source, Err.Description
   
End Function


