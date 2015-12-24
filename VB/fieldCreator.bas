'项目ID列
Const itemIdColumn As Integer = 15
'项目名称列
Const itemNameColumn As Integer = 4
'项目type列
Const itemTypeColumn As Integer = 25
'起始位置
Const startPosition As Integer = 9
'結束位置
Const endPosition As Integer = 51
'表格所在sheet
Const sheet As Integer = 3
'文件編碼
Const strEncode As String = "UTF-8"
'項目ID
Dim itemId As String
'項目名稱
Dim itemName As String
'項目type
Dim itemType As String
 
Sub autoGetSet()
    '最大行
    Dim maxLine As Integer
    '文件路徑
    Dim filePath As String
     
 
    filePath = "D:\1.java"
    Dim fso,tf
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set tf = fso.CreateTextFile(filePath,True)
    ' change to utf-8
    Dim strFileNasme As String
    strFileName = "D:\1.java"
    Dim stm
    Set stm = CreateObject("adodb.stream")
    stm.Type = 2 
    stm.Mode = 3
    stm.Charset = strEncode
    stm.Open
     
    For m = startPosition To endPostion
        itemId = ThisWorkbook.Sheets(sheet).Cells(m,itemIdColumn).Value
        itemName = Replace(ThisWorkbook.sheets(sheet).Cells(m,itemNameColumn).Value,"","")
        itemType = ThisWorkbook.Sheets(sheet).Cells(m,itemTypeColumn).Value
        stm.writeText("     /**" &vbCrlf)
        stm.writeText("      * " & itemName & vbCrlf)
        stm.writeText("      */" & vbCrlf)
        stm.writeText(" private " & itemType & " " & itemId & " = null;" & vbCrlf)
        stm.writeText(vbCrlf)
    Next M
 
    For m = startPosition To endPosition
        itemId = ThisWorkbook.Sheets(sheet).Cells(m,itemIdColumn).Value
        itemName = Replace(ThisWorkbook.Sheets(sheet).Cells(m,itemNameColumn).Value,"","")
        itemType = ThisWorkbook.Sheets(sheet).Cells(m,itemTypeColumn).Value
        'get comment
        stm.writeText("     /**" & vbCrlf)
        stm.writeText("      * " & itemName & "を取得します。" & vbCrlf)
        stm.writeText("      * " & vbCrlf)
        stm.writeText("      * @ return " itemName & vbCrlf)
        stm.writeText("      */" & vbCrlf)
        'get method 
        stm.writeText(" public " & itemType & " get" & UCase(Left(itemId,1)) & Right(itemId,Len(itemId)-1) & "() {" & vbCrlf)
        stm.writeText("     return " & itemId & ";" & vbCrlf)
        stm.writeText(" }" & vbCrlf)
        stm.writeText(vbCrlf)
        'set comment
        stm.writeText("     /**" & vbCrlf)
        stm.writeText("      * " & itemName & "を設定します。" & vbCrlf)
        stm.writeText("      * " & vbCrlf)
        stm.writeText("      * @param " & itemId & vbCrLf) 
        stm.writeText("      * itemName" & vbCrLf)
        stm.writeText("      */" & vbCrlf)
        'set method
        stm.writeText(" public void set" & UCase(Left(itemId,1)) & Right(itemId,Len(itemId)-1) & "(" &itemType & " " & itemId & ") {" & vbCrlf )
        stm.writeText("     this." & itemId & " = " & itemId & ";" & vbCrLf)
        stm.writeText(" }" & vbCrlf)
        stm.writeText(vbCrlf)
    Next m 
         
    tf.Close
    stm.SaveToFile strFileName,2
    stm.flush
    stm.Close
    Set stm = Nothing
 
End Sub
