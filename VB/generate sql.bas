Const fileType As String = ".sql"
Const fileDirectory As String = "D:\"
Const strEncode As String = "UTF-8"
Const tableNameColumn As String = "N2"
Const tableNameComment As String = "N1"
Const dataStartRow As Integer = 9
 
 
Sub createSQL()
 
    Dim maxLine As Integer
    Dim tableName As String
    Dim fileName As String
    Dim tableComment As String
     
    For m = 3 To ThisWorkbook.Sheets.Count
     
    'create file
    maxLine = ThisWorkbook.Sheets(m).UsedRange.Rows.Count
    tableName = ThisWorkbook.Sheets(m).Range(tableNameColumn).Text
    tableComment = ThisWorkbook.Sheets(m).Range(tableNameComment).Text
    FilePath = fileDirectory & tableName & fileType
    Dim fso, tf
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set tf = fso.CreateTextFile(fileDirectory & tableName & fileType, True)
     
    'change to utf-8
    Dim strFileName As String
    strFileName = fileDirectory & tableName & fileType
     
    Dim stm
    Set stm = CreateObject("adodb.stream")
    stm.Type = 2
    stm.Mode = 3
    stm.Charset = strEncode
    stm.Open
     
    'drop table
    stm.writeText ("DROP TABLE IF EXISTS `" & tableName & "`;" & vbCrLf)
     
    'create Table
    stm.writeText ("CREATE TABLE `" & tableName & "` (")
    stm.writeText (vbCrLf)
     
    Dim lineCount As Integer
    lineCount = 0
    Dim primaryKeyCount As Integer
    primaryKeyCount = 0
    Dim primaryKey As String
    primaryKey = ""
    For J = dataStartRow To maxLine
        If (ThisWorkbook.Sheets(m).Range("A" & J).Text <> "") Then
            lineCount = lineCount + 1
        End If
    Next J
     
         
        For I = dataStartRow To lineCount + dataStartRow - 1
            Dim types As String
             
            If (ThisWorkbook.Sheets(m).Range("O" & I).Text = "CHR") Then
                types = "char"
            ElseIf (ThisWorkbook.Sheets(m).Range("O" & I).Text = "VCHR" Or ThisWorkbook.Sheets(m).Range("O" & I).Text = "NVCHR") Then
                types = "varchar"
            Else
                types = ThisWorkbook.Sheets(m).Range("O" & I).Text
            End If
         
            stm.writeText ("  `" & ThisWorkbook.Sheets(m).Range("H" & I).Text & "` " & types & "(" & ThisWorkbook.Sheets(m).Range("P" & I).Text & ") ")
             
            If ThisWorkbook.Sheets(m).Range("Q" & I).Text = "N" Then
                stm.writeText ("NOT NULL COMMENT '")
            Else
                stm.writeText ("DEFAULT NULL COMMENT '")
            End If
             
            If (ThisWorkbook.Sheets(m).Range("N" & I).Text <> "") Then
                primaryKeyCount = primaryKeyCount + 1
                If (primaryKeyCount = 1) Then
                    primaryKey = primaryKey & "`" & ThisWorkbook.Sheets(m).Range("H" & I).Text & "`"
                ElseIf (primaryKeyCount > 1) Then
                    primaryKey = primaryKey & ",`" & ThisWorkbook.Sheets(m).Range("H" & I).Text & "`"
                End If
            End If
            stm.writeText (ThisWorkbook.Sheets(m).Range("B" & I).Text & "'," & vbCrLf)
             
        Next I
     
    If (primaryKeyCount > 0) Then
        stm.writeText ("  PRIMARY KEY (")
        stm.writeText (primaryKey)
        stm.writeText (")" & vbCrLf)
    End If
     
    stm.writeText (") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='" & tableComment & "';")
     
    tf.Close
     
    stm.Savetofile strFileName, 2
    stm.flush
    stm.Close
    Set stm = Nothing
    Next m
 
End Sub
