VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "GroupManager"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Attribute VB_Ext_KEY = "RVB_UniqueId" ,"3DB2E496014E"
Attribute VB_Ext_KEY = "RVB_ModelStereotype" ,"Class Module"
'����ͨ���顣

Option Explicit

'##ModelId=3DB2ED560027
Implements IMaintData

'##ModelId=3DB6A749034B
Private Const ErrClassName = "MainBusiness.GroupManager"


'���ָ���û�������ͨѶ��
'##ModelId=3DB5543800E2
Private Function IMaintData_GetListByUserID(UserID As Long) As Recordset
    Const ErrFuncName = "IMaintData_GetListByUserID"
    On Error GoTo ErrHandler

    Dim rs As ADODB.Recordset
    Set rs = CreateObject("ADODB.Recordset")

    rs.ActiveConnection = dbConnString
    rs.Source = "SELECT * FROM ContactGroups WHERE UserID=" & UserID
    rs.LockType = adLockReadOnly
    rs.CursorLocation = adUseClient
    rs.CursorType = adOpenStatic

    rs.Open

    Set rs.ActiveConnection = Nothing
    Set IMaintData_GetListByUserID = rs
    
    Exit Function
ErrHandler:
    ErrorLog ErrClassName, ErrFuncName, Err
    Resume Next
End Function


'����ͨѶ�� ID �õ���Ӧ��¼��
'������
'ID: long
'��ʶ
'##ModelId=3DB3F00401D0
Private Function IMaintData_GetListByID(UserID As Long) As Recordset
    Const ErrFuncName = "IMaintData_GetListByID"
    On Error GoTo ErrHandler

    Dim rs As ADODB.Recordset
    Set rs = CreateObject("adodb.recordset")
    rs.ActiveConnection = dbConnString
    rs.Source = "SELECT * FROM ContactGroups WHERE ID=" & UserID
    rs.LockType = adLockBatchOptimistic
    rs.CursorLocation = adUseClient
    rs.CursorType = adOpenStatic
    
    rs.Open
    
    Set rs.ActiveConnection = Nothing
    Set IMaintData_GetListByID = rs

    Exit Function
ErrHandler:
    ErrorLog ErrClassName, ErrFuncName, Err
    Resume Next
End Function


'�õ��յ�ͨѶ�飬�ȴ��ͻ�������
'##ModelId=3DB3F004022E
Private Function IMaintData_GetEmpty() As Recordset
    Const ErrFuncName = "IMaintData_GetEmpty"
    On Error GoTo ErrHandler

    Dim rs As ADODB.Recordset
    Set rs = CreateObject("ADODB.Recordset")

    rs.CursorLocation = adUseClient
    rs.CursorType = adOpenStatic
    rs.LockType = adLockBatchOptimistic
    rs.Source = "SELECT * FROM ContactGroups WHERE 0=1"
    rs.ActiveConnection = dbConnString
    rs.Open
    rs.AddNew

    Set rs.ActiveConnection = Nothing
    Set IMaintData_GetEmpty = rs

    Exit Function
ErrHandler:
    ErrorLog ErrClassName, ErrFuncName, Err
    Resume Next
End Function


'ɾ��ָ�� ID ��ͨѶ��
'##ModelId=3DB3F004025D
Private Sub IMaintData_Delete(ID As Long)
    Const ErrFuncName = "IMaintData_Delete"
    On Error GoTo ErrHandler

    'delete a department
    Dim conn As ADODB.Connection, rs As ADODB.Recordset
    Set conn = CreateObject("ADODB.Connection")
    Set rs = CreateObject("ADODB.Recordset")
    conn.ConnectionString = dbConnString
    conn.Open
    
    'if there has anyone in this department, u cant delete any dept.
    Dim strSQL As String
    strSQL = "SELECT ID FROM Contacts WHERE GroupID=" & ID
    rs.Open strSQL, conn
    
    If rs.EOF Then
        conn.Execute "DELETE FROM ContactGroups WHERE ID=" & ID
        conn.Close
        Set conn = Nothing
    Else
        conn.Close
        Set conn = Nothing
        On Error GoTo 0
        Err.Raise vbObjectError, "MainBusiness.GroupManager.IMaintData_Delete", "�����л������û����޷�����ɾ��!"
    End If
    
    
    Exit Sub
ErrHandler:
    ErrorLog ErrClassName, ErrFuncName, Err
    Resume Next
End Sub


'δʹ��
'�õ������û�������ͨѶ�顣
'������
'return: recordset
'�������еļ�¼��
'##ModelId=3DB3F00402CA
Private Function IMaintData_GetAll() As Recordset
    '(empty)
End Function


'���浥��ͨѶ����Ϣ
'##ModelId=3DB3F16F0367
Private Sub IMaintData_Save(rs As Recordset)
    Const ErrFuncName = "IMaintData_Save"
    On Error GoTo ErrHandler
    
    rs.ActiveConnection = dbConnString
    rs.UpdateBatch
    
    Exit Sub
ErrHandler:
    ErrorLog ErrClassName, ErrFuncName, Err
    Resume Next
End Sub