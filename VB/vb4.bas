Attribute VB_Name = "Ä£¿é1"
Dim tableName As String 'get table name
Dim fileName As String  'set fileName
Dim dropSql As String   'drop table sql sentence
Dim maxLine As Integer
Dim maxColumn As Integer
Dim createTableStr As String ' to save create table sentences
Dim commentsStr As String 'to save comments
Dim primaryKey As String ' to save primary key
Const maxSheet As Integer = 3
Const strEncode As String = "UTF-8"

Sub createSql()

For m = 2 To maxSheet
    'create file
    createTableStr = ""
    commentsStr = ""
    primaryKey = ""
    maxLine = ThisWorkbook.Sheets(m).UsedRange.Rows.Count
    maxColumn = ThisWorkbook.Sheets(m).UsedRange.Columns.Count
    tableName = ThisWorkbook.Sheets(m).Range("C5").Text
    FilePath = "d:\" & tableName & ".sql"
    Dim fso, tf
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set tf = fso.CreateTextFile("d:\" & tableName & ".sql", True)
    
    ' change to utf-8
    Dim Mazmun As String
    Dim strFileName As String
    strFileName = "D:\" & tableName & ".sql"

    Dim stm
    Set stm = CreateObject("adodb.stream")
    stm.Type = 2
    stm.Mode = 3
    stm.Charset = "utf-8"
    stm.Open

    'drop table
    dropSql = "DROP TABLE " & tableName
    stm.WriteText (dropSql & vbCrLf & ";" & vbCrLf & vbCrLf)
    
    'create table
    stm.WriteText ("CREATE TABLE " & tableName & vbCrLf & "(")
    
    For i = 8 To maxLine
        ' judge if exists
        If ThisWorkbook.Sheets(m).Range("C" & i).Text = "" Then
            Exit For
        End If
        ' save createTable sentences
            createTableStr = createTableStr & vbCrLf
            createTableStr = createTableStr & ThisWorkbook.Sheets(m).Range("C" & i).Text & " " & ThisWorkbook.Sheets(m).Range("H" & i).Text
        
        If ThisWorkbook.Sheets(m).Range("I" & i).Text = "" Then
        Else
            createTableStr = createTableStr & "(" & Trim(ThisWorkbook.Sheets(m).Range("I" & i).Text)
        End If
        
        If ThisWorkbook.Sheets(m).Range("J" & i).Text = "" And ThisWorkbook.Sheets(m).Range("I" & i).Text = "" Then
           
        ElseIf ThisWorkbook.Sheets(m).Range("J" & i).Text = "" Or ThisWorkbook.Sheets(m).Range("H" & i).Text = "varchar2" Then
            createTableStr = createTableStr & ")"
        Else
            createTableStr = createTableStr & "," & Trim(ThisWorkbook.Sheets(m).Range("J" & i).Text) & ")"
        End If
        
        If ThisWorkbook.Sheets(m).Range("G" & i).Text = "" Then 'judge column G whether is null
        Else
            createTableStr = createTableStr & " NOT NULL"
            If (ThisWorkbook.Sheets(m).Range("G" & (i + 1)).Text <> "") Then
                createTableStr = createTableStr & ","
            Else
            End If
        End If
        'save comment
        commentsStr = commentsStr & " COMMENT ON COLUMN " & tableName & "." & ThisWorkbook.Sheets(m).Range("C" & i).Text & " IS '"
        commentsStr = commentsStr & ThisWorkbook.Sheets(m).Range("B" & i).Text & "';" & vbCrLf
        
        'save primary key
        If (ThisWorkbook.Sheets(m).Range("D" & i).Text <> "" And ThisWorkbook.Sheets(m).Range("D" & i).Text <> "1") Then
            primaryKey = primaryKey & "," & ThisWorkbook.Sheets(m).Range("C" & i).Text
        End If
        
        If (ThisWorkbook.Sheets(m).Range("D" & i).Text = "1") Then
                primaryKey = primaryKey & ThisWorkbook.Sheets(m).Range("C" & i).Text
        End If
    Next i
        stm.WriteText (createTableStr)
        stm.WriteText (vbCrLf & ")" & vbCrLf & ";" & vbCrLf)
        stm.WriteText ("COMMENT ON TABLE " & tableName & " IS '" & ThisWorkbook.Sheets(m).Range("H" & 5).Text & "';" & vbCrLf) 'write table comments
        stm.WriteText (commentsStr)
        
    ' alter table
        stm.WriteText (vbCrLf & ";" & vbCrLf & "ALTER TABLE " & tableName & vbCrLf & " ADD PRIMARY KEY (" & vbCrLf & primaryKey & vbCrLf & ")" & vbCrLf & ";")
         
        stm.WriteText (vbCrLf & vbCrLf & ";" & vbCrLf)
    tf.Close

    stm.SaveToFile strFileName, 2
    stm.flush
    stm.Close
    Set stm = Nothing

Next m

End Sub





