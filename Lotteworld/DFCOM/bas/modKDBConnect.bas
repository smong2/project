Attribute VB_Name = "modKDBConnect"
Option Explicit

Public Const CNST_ISMTS = False

Public Function GetRecordSetToArray(objRecordset As ADODB.Recordset) As Variant
    On Error GoTo GetRecordSetToArrayErr:
    
    Dim intCnt As Integer
    Dim vntArray() As Variant

    Do
        If objRecordset Is Nothing Then
            Exit Do
        End If
        intCnt = intCnt + 1
        ReDim Preserve vntArray(intCnt)
        Set vntArray(intCnt) = objRecordset
        Set objRecordset = objRecordset.NextRecordset
    Loop
    
    Dim vntReturn() As Variant
    
    ReDim Preserve vntReturn(intCnt)
    
    For intCnt = 1 To UBound(vntArray)
        If vntArray(intCnt).State = 1 Then
            Set vntArray(intCnt).ActiveConnection = Nothing
            
            Set vntReturn(intCnt) = vntArray(intCnt).Clone
        End If
    Next
        
    GetRecordSetToArray = vntReturn
    Erase vntArray
    Erase vntReturn
    
    Exit Function
    
GetRecordSetToArrayErr:
    Resume Next
End Function

Public Function GetRecordSetToArray2(objRecordset As ADODB.Recordset) As Variant
    On Error GoTo GetRecordSetToArray2Err:
    
    Dim intCnt As Integer
    Dim vntArray() As Variant

    Do
        If objRecordset Is Nothing Then
            Exit Do
        End If
        intCnt = intCnt + 1
        ReDim Preserve vntArray(intCnt)
        Set vntArray(intCnt) = objRecordset
        Set objRecordset = objRecordset.NextRecordset
    Loop
    
    Dim vntReturn() As Variant
    
    If vntReturn(intCnt).State = 0 Then
        intCnt = intCnt - 1
    End If
    
    ReDim Preserve vntReturn(intCnt)
    
    For intCnt = 1 To UBound(vntArray)
        If vntArray(intCnt).State = 1 Then
            Set vntArray(intCnt).ActiveConnection = Nothing
            
            Set vntReturn(intCnt) = vntArray(intCnt).Clone
        End If
    Next
        
    GetRecordSetToArray2 = vntReturn
    Erase vntArray
    Erase vntReturn
    
    Exit Function
    
GetRecordSetToArray2Err:
    Resume Next
End Function

Public Function GetRecordSetToArrayCount(objRecordset As ADODB.Recordset, intItemCount As Integer) As Variant
    On Error GoTo GetRecordSetToArrayCountErr:
    
    Dim intCnt As Integer
    Dim vntArray() As Variant

    Do
        If objRecordset Is Nothing Then
            Exit Do
        End If
        intCnt = intCnt + 1
        ReDim Preserve vntArray(intCnt)
        Set vntArray(intCnt) = objRecordset
        Set objRecordset = objRecordset.NextRecordset
    Loop
    
    Dim vntReturn() As Variant
    
    If vntReturn(intCnt).State = 0 Then
        intCnt = intCnt - 1
    End If
    
    ReDim Preserve vntReturn(intItemCount)
    
    For intCnt = 1 To intItemCount
        If vntArray(intCnt).State = 1 Then
            Set vntArray(intCnt).ActiveConnection = Nothing
            
            Set vntReturn(intCnt) = vntArray(intCnt).Clone
        End If
    Next
        
    GetRecordSetToArrayCount = vntReturn
    Erase vntArray
    Erase vntReturn
    
    Exit Function
    
GetRecordSetToArrayCountErr:
    Resume Next
End Function

