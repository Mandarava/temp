Attribute VB_Name = "Module1"
'�����ތ^
Const fileType As String = ".sql"
'����directory
Const fileDirectory As String = "D:\"
'��������
Const strEncode As String = "UTF-8"
'A1��
Const tableDefineColumn As String = "A1"
' A1��I���e
Const strA1Content As String = "�e�[�u����`"
'�\����        C5
Const tableNameColumn As String = "C5"
'�\���ח�     H5
Const tableNameComment As String = "H5"
'���ږ�(���{��j     B
Const attributeJapColumn As String = "B"
'���ږ��i�p���j      C
Const attributeEngColumn As String = "C"
'��L�[ D
Const primaryKeyColumn As String = "D"
'not NULL        G
Const notNullColumn As String = "G"
'DB�^ H
Const dataTypeColumn As String = "H"
'�����S�� I
Const dataLength As String = "I"
'���������� J
Const dataPointColumn As String = "J"
'�N�n�s 8
Const dataStartRow As Integer = 8

Sub createSql()
    '�����\���
    Dim dropSql As String
    ' �������\���
    Dim createTableStr As String
    '����comments
    Dim commentsStr As String
    ' ����primary key
    Dim primaryKey As String
    '�\�ő�s
    Dim maxLine As Integer
    '�\��
    Dim tableName As String
    '������
    Dim fileName As String
    
    For m = 1 To ThisWorkbook.Sheets.Count
        'judge whether it is the database table
        If (ThisWorkbook.Sheets(m).Range(tableDefineColumn).Text = strA1Content) Then

            'create file
            createTableStr = ""
            commentsStr = ""
            primaryKey = ""
            maxLine = ThisWorkbook.Sheets(m).UsedRange.Rows.Count
            tableName = ThisWorkbook.Sheets(m).Range(tableNameColumn).Text
            FilePath = fileDirectory & tableName & fileType
            Dim fso, tf
            Set fso = CreateObject("Scripting.FileSystemObject")
            Set tf = fso.CreateTextFile(fileDirectory & tableName & fileType, True)
    
            ' change to utf-8
            Dim strFileName As String
            strFileName = fileDirectory & tableName & fileType

            Dim stm
            Set stm = CreateObject("adodb.stream")
            stm.Type = 2
            stm.Mode = 3
            stm.Charset = strEncode
            stm.Open

            'drop table
            dropSql = "DROP TABLE " & tableName
            stm.WriteText (dropSql & vbCrLf & ";" & vbCrLf & vbCrLf)

            'create table
            stm.WriteText ("CREATE TABLE " & tableName & vbCrLf & "(")

            For I = dataStartRow To maxLine
                ' judge if exists
                If ThisWorkbook.Sheets(m).Range(attributeEngColumn & I).Text = "" Then
                    Exit For
                End If
                ' save createTable sentences
                createTableStr = createTableStr & vbCrLf
                createTableStr = createTableStr & ThisWorkbook.Sheets(m).Range(attributeEngColumn & I).Text & " " & ThisWorkbook.Sheets(m).Range(dataTypeColumn & I).Text

                If ThisWorkbook.Sheets(m).Range(dataLength & I).Text = "" Then
                Else
                    createTableStr = createTableStr & "(" & Trim(ThisWorkbook.Sheets(m).Range(dataLength & I).Text)
                End If

                If ThisWorkbook.Sheets(m).Range(dataPointColumn & I).Text = "" And ThisWorkbook.Sheets(m).Range(dataLength & I).Text = "" Then

                ElseIf ThisWorkbook.Sheets(m).Range(dataPointColumn & I).Text = "" Or ThisWorkbook.Sheets(m).Range(dataTypeColumn & I).Text = "varchar2" Then
                    createTableStr = createTableStr & ")"
                Else
                    createTableStr = createTableStr & "," & Trim(ThisWorkbook.Sheets(m).Range(dataPointColumn & I).Text) & ")"
                End If
                'judge column G whether is null
                If ThisWorkbook.Sheets(m).Range(notNullColumn & I).Text = "" Then
                Else
                    createTableStr = createTableStr & " NOT NULL"
                    If (ThisWorkbook.Sheets(m).Range(notNullColumn & (I + 1)).Text <> "") Then
                        createTableStr = createTableStr & ","
                    Else
                    End If
                End If
                'save comment
                commentsStr = commentsStr & " COMMENT ON COLUMN " & tableName & "." & ThisWorkbook.Sheets(m).Range(attributeEngColumn & I).Text & " IS '"
                commentsStr = commentsStr & ThisWorkbook.Sheets(m).Range(attributeJapColumn & I).Text & "';" & vbCrLf

                'save primary key
                If (ThisWorkbook.Sheets(m).Range(primaryKeyColumn & I).Text <> "" And ThisWorkbook.Sheets(m).Range(primaryKeyColumn & I).Text <> "1") Then
                    primaryKey = primaryKey & "," & ThisWorkbook.Sheets(m).Range(attributeEngColumn & I).Text
                End If

                If (ThisWorkbook.Sheets(m).Range(primaryKeyColumn & I).Text = "1") Then
                    primaryKey = primaryKey & ThisWorkbook.Sheets(m).Range(attributeEngColumn & I).Text
                End If
            Next I
            stm.WriteText (createTableStr)
            stm.WriteText (vbCrLf & ")" & vbCrLf & ";" & vbCrLf)
            'write table comments
            stm.WriteText ("COMMENT ON TABLE " & tableName & " IS '" & ThisWorkbook.Sheets(m).Range(tableNameComment).Text & "';" & vbCrLf)
            stm.WriteText (commentsStr)

            ' alter table
            stm.WriteText (vbCrLf & ";" & vbCrLf & "ALTER TABLE " & tableName & vbCrLf & " ADD PRIMARY KEY (" & vbCrLf & primaryKey & vbCrLf & ")" & vbCrLf & ";")

            stm.WriteText (vbCrLf & vbCrLf & ";" & vbCrLf)
            tf.Close

            stm.SaveToFile strFileName, 2
            stm.flush
            stm.Close
            Set stm = Nothing
        End If
    Next m

End Sub





