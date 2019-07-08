VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 2  'RequiresTransaction
END
Attribute VB_Name = "clsXBUSERUIQTX"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
'******************************************************************************
' Component Name: XBUSERUIQMTS.vbp
' Class Name    : XBUSERUIQTX.cls
' ����          : Server������Ʈ ������(COM+) (Transaction)
' �ۼ���        : �ڼ���
' �ۼ�����      : 02/12/3
'******************************************************************************
Option Explicit
'-- ADODB.Connection ��ü ����
Private adoCn As ADODB.Connection
'-- ObjectContext ��ü ����
Private xobjContext As ObjectContext
'-- Ŭ���� �� ��� ����
Private Const CLASS_NAME = "XBUSERUIQMTS.clsXBUSERUIQTX"

'******************************************************************************
' Funtion Name  : Save
' Description   : ����
' Parameters
' �ۼ���        : ???
' �ۼ���        : ???
'******************************************************************************
Public Function Save(ByVal arrM As Variant) As Boolean
'���� ����
Const MODULE_NAME As String = "Save"
   On Error GoTo ErrTrap

   Dim adoCmd As ADODB.Command
   Dim adoRs As ADODB.Recordset
   
   Dim lngTick As Long                      '���� �ð��� �����ϴ� ����
   Dim ii As Long                           '������ ���� ����
   '-- �α� ������ ����
   lngTick = TickCount
  
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
    
    adoCn.Execute "Set TRANSACTION ISOLATION LEVEL READ COMMITTED"
   
    Set adoCmd = New ADODB.Command
    With adoCmd

       Set .ActiveConnection = adoCn
       .CommandText = "dbo.SXWBUserUI"        'Stored Procedure ���� �����Ѵ�.
       .CommandType = adCmdStoredProc       'CommandType�� �ݵ�� ���������� �����Ѵ�.
       .CommandTimeout = 30                 '������ ���� �ð��� ������ ���� �����Ѵ�.
       .Parameters.Refresh
       'SP�� �Ķ���͸� ����
       For ii = 0 To UBound(arrM, 1)
           .Parameters(1 + ii) = arrM(ii)
       Next
       .Execute , , adExecuteNoRecords

   End With
   
   Save = True
   Set adoRs = Nothing
   'DB�� ���ؼ��� ����
   Set adoCmd.ActiveConnection = Nothing
   Set adoCmd = Nothing
   'SetComplete ȣ��
   xobjContext.SetComplete
   '�α� ������ ��
   Call WritePerfLog(CLASS_NAME & "." & MODULE_NAME, DEVELOPER_NAME, lngTick)
   
    adoCn.Close
    Set adoCn = Nothing
  
    Set xobjContext = Nothing
   Exit Function
   
ErrTrap:
   Save = False
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


