Attribute VB_Name = "modSTDBConnect"
Option Explicit
Private Const BAS_NAME As String = "modSTDBConnect"
'*****************************************************************************
'  ����   : ���ؼ� ��Ʈ���� ����
'  ����  :
'     Input :
'      Server : optional DB ������
'      DBName : optional DB ��
'   OutPut:   : Nothing
' ��ȯ�� : Connection String
'*****************************************************************************
Public Function GetConnString(Optional ByVal Server As String = "" _
                            , Optional ByVal DBName As String = "") As String
Const MODULE_NAME As String = "GetConnString"
    On Error GoTo ErrTrap
    'Connection String ������Ʈ ����
    Dim objDBCon As Object
    Set objDBCon = CreateObject("CTSTDataSvcMTS.clSTDBConNTX")
    GetConnString = objDBCon.GetConnString(Server, DBName)
    Set objDBCon = Nothing
    Exit Function
    
ErrTrap:
    '������Ʈ Free
    If Not objDBCon Is Nothing Then Set objDBCon = Nothing
    '���� �α�
    'Call WriteErrLog(CLASS_NAME & "." & MODULE_NAME, DEVELOPER_NAME, Err.Number & "  " & Err.Description)
    '----------------------------------------------------------------------
    ' modSTDBConnect �� Connection ������ ������
    '----------------------------------------------------------------------
    Call WriteErrLog("GetConnString" & "." & MODULE_NAME, DEVELOPER_NAME, Err.Number & "  " & Err.Description)
    
    '���� �߻�
    Err.Source = BAS_NAME & "." & MODULE_NAME & "- " & Err.Source
    Err.Raise Err.Number, Err.Source, Err.Description
    
End Function

