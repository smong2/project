VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 1  'NoTransaction
END
Attribute VB_Name = "clSTDBConNTX"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
'***************************************************************************************
'  개요     : Connection String 생성
'
'  Class 명 : pDataService.cDBConnection
'              GetConString() as string
'
'  작성자   : 통합팀    작성일자  : 2002-04-16
'****************************************************************************************
Private Const clsName As String = "CTSTDataSvcBMTS.clSTDBConBNTX"

'***************************************************************************************
' Description   : SQL Connection String 생성
' Parameters    :
'   Input       : 서버명(Optional), 데이타베이스명(Optional)
' Return Value  : SQL Connection String
'***************************************************************************************
'
Public Function GetConnString(Optional Server As String = "", Optional DBName As String = "") As String
    Const MODULE_NAME As String = "GetConnString"
    On Error GoTo ErrorHandler
    Dim strConnString As String
    strConnString = "Provider=SQLOLEDB"

    If Len(Server) > 0 Then
        strConnString = strConnString & ";Data Source=" & Server
    Else
        strConnString = strConnString & ";Data Source=lwdfs"
    End If
    If Len(DBName) > 0 Then
        strConnString = strConnString & ";Initial Catalog=" & DBName
    Else
        strConnString = strConnString & ";Initial Catalog=lwdf"
    End If

    strConnString = strConnString & ";User ID=dfuser"
    strConnString = strConnString & ";Password=df00"
    GetConnString = strConnString
    Exit Function
ErrorHandler:
    App.LogEvent Err.Number & "    " & Err.Source & "    " & Err.Description
    Err.Raise Err.Number, Err.Source, Err.Description
End Function

