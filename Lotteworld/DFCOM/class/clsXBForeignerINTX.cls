VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 1  'NoTransaction
END
Attribute VB_Name = "clsXBForeignerINTX"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
'******************************************************************************
' Component Name: XBForeignerIMTS.vbp
' Class Name    : XBForeignerITX.cls
' ����          : Server������Ʈ ������(COM+) (NonTransaction)
' �ۼ���        : �ڼ���
' �ۼ�����      : 02/12/09
'******************************************************************************
Option Explicit
'-- ADODB.Connection ��ü ����
Private adoCn As ADODB.Connection
'-- ObjectContext ��ü ����
Private xobjContext As ObjectContext
'-- Ŭ���� �� ��� ����
Private Const CLASS_NAME = "XBForeignerIMTS.clsXBForeignerINTX"

'******************************************************************************
' Funtion Name  : Query
' Description   : ��ȸ
' Parameters
' �ۼ���        : ???
' �ۼ���        : ???
'******************************************************************************
Public Function Query(ByVal arrM As Variant) As Variant
'-- ���� ����
Const MODULE_NAME As String = "Query"
   On Error GoTo ErrTrap

   Dim adoCmd As ADODB.Command
   Dim adoRs As ADODB.Recordset
   
   Dim lngTick As Long                     '���� �ð��� �����ϴ� ����
   Dim i As Long                           '������ ���� ����
   '-- �α� ������ ����
   lngTick = TickCount
   
    '-- �ʿ��� ������ Connection ��ü�� �����Ѵ�.
    Set adoCn = New Connection
    
    Set xobjContext = GetObjectContext
    '******************************************************************************
    ' Funtion Name  : GetConnString
    ' Description   : Connection String �� �����.
    ' Parameters
    '           input
    '                   Server  - ������ (����DB������ �����Ҷ� ����Ѵ�.)
    '                   DBName  - DB ��  (��� DB �� �Է�)
    ' �ۼ���        : ???
    ' �ۼ���        : ???
    '******************************************************************************
    adoCn.Open GetConnString("", "")
   
   Set adoCmd = New ADODB.Command
   With adoCmd
   Set .ActiveConnection = adoCn
       .CommandText = "dbo.SXWBForeignerI"       'Stored Procedure ���� �����Ѵ�.
       .CommandType = adCmdStoredProc       'CommandType�� �ݵ�� ���������� �����Ѵ�.
       .CommandTimeout = 30                 '������ ���� �ð��� ������ ���� �����Ѵ�.
       .Parameters.Refresh
       
       'SP�� �Ķ���͸� ����
       For i = 0 To UBound(arrM, 1)
           .Parameters(1 + i) = arrM(i)
       Next i
   End With
   
   '-- �񿬰� ���ڵ���� ���� �Ӽ��� �����Ѵ�.
   Set adoRs = New ADODB.Recordset
   With adoRs
       .CursorLocation = adUseClient
       .CursorType = adOpenStatic
       .LockType = adLockBatchOptimistic
       .Open adoCmd
   End With
   
   Query = GetRecordSetToArray(adoRs)
   Set adoRs = Nothing
   
   'DB�� ���ؼ��� ����
   Set adoCmd.ActiveConnection = Nothing
   Set adoCmd = Nothing
   
   
   'SetComplete ȣ��
   xobjContext.SetComplete
   '�α� ������ ��
   Call WritePerfLog(CLASS_NAME & "." & MODULE_NAME, DEVELOPER_NAME, lngTick)
   
    Set xobjContext = Nothing
    adoCn.Close
    Set adoCn = Nothing
   
   Exit Function
   
ErrTrap:
   'SetAbort ȣ��
   xobjContext.SetAbort
   '���ҽ� ����
    If Not xobjContext Is Nothing Then Set xobjContext = Nothing
    If Not adoCmd Is Nothing Then Set adoCmd = Nothing
    If Not adoRs Is Nothing Then Set adoRs = Nothing
    If Not adoCn Is Nothing Then Set adoCn = Nothing
   '���� �α�
   Call WriteErrLog(CLASS_NAME & "." & MODULE_NAME, DEVELOPER_NAME, Err.Number & "  " & Err.Description)
   '�����̺�Ʈ �߻�
   Err.Source = CLASS_NAME & "." & MODULE_NAME & "- " & Err.Source
   Err.Raise Err.Number, Err.Source, Err.Description
   
End Function

