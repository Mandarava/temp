' 表名
Dim tableName As String
' 表名comment
Dim tableNameComment As String
' 列名
Dim tableColumnName
' 列名comment
Dim tableColumnNameComment
' 列名類型
Dim tableColumnType
' 列名可空
Dim tableColumnNull
' 列名長度
Dim tableColumnLength
' 表主key
Dim tablePk
' 存放Example:DEPTCODE varchar2(4) not null,
Dim tableColumnSql
' 存放Example:COMMENT ON COLUMN M_DEPT.DEPTCODE IS '部門コード';
Dim tableColumnCommentSql
' 計算生成的SQL文件數量
Dim countSQLCreate As Integer
' 計算該文件下的excel文件數量用
Dim countExcel As Integer
' 文件名 路径不能使用 「*」， 所以?里使用「*」来作?文件路径之?的分隔符
Const constFileSplitMark As String = "*"
' 打?文件?型
Dim filetype As String


' 初始化
Sub mainClick()

    ' 從setting得到文件路徑
    Dim filepath As String
    filepath = ThisWorkbook.Sheets("${SETTING}").Range("D8").Text
        ' 判斷文件路徑是否最後面有'\',沒有則加上
    If Right(filepath, 1) <> "\" Then
        filepath = filepath + "\"
    End If
    
    ' 從setting得到文件類型
    filetype = ThisWorkbook.Sheets("${SETTING}").Range("D9").Text
    ' 判斷文件類型是否最前面有'.',沒有則加上
    If Right(filetype, 4) <> "." Then
        filetype = "." + filetype
    End If

    
    ' 初始化該文件下的excel文件數量是0
    countExcel = 0
    ' 初始化生成的SQL文件數量是0
    countSQLCreate = 0
        
    Dim fso As Object, fd As Object
    ' 定義fso對象
    Set fso = CreateObject("Scripting.FileSystemObject")
    ' 得到路徑
    Set fd = fso.GetFolder(filepath)
    
    Call findFilePath(fd)
    
    Set fd = Nothing
    Set fso = Nothing
    
    If countExcel = 0 Then
        MsgBox ("沒有找到後綴名是.xls的EXCEL文件")
    End If
    
    If countSQLCreate <> 0 Then
        MsgBox ("出力成功！！！")
    End If
    
End Sub

Sub findFilePath(fd As Object)
    
    Dim fl As Object
    ' 依次循環找尋文件夾中的所有.xls後綴文件
    For Each fl In fd.Files
        ' 右截4個字符判斷是否是.xls
        If LCase(Right(fl.Name, 4)) = filetype Then
            Call connectSQL(fl.Path)
            countExcel = countExcel + 1
        End If
    Next fl
    
    Dim sfd As Object
    ' 判断是否有子文件?
    If fd.SubFolders.Count <> 0 Then
        For Each sfd In fd.SubFolders
            Call findFilePath(sfd)
        Next
    End If
    

    
    
End Sub

  
' sql語句連接
Sub connectSQL(fileName As String)

    Dim xlApp As Excel.Application
    Dim xlBook As Excel.Workbook
   
    Set xlApp = CreateObject("Excel.Application")
    Set xlBook = xlApp.Workbooks.Open(fileName)

    Dim countTable As Integer
    countTable = 0
    
    ' 計算當前excel中的數據庫設計sheet的個數，定義數組用
    For i = 1 To xlBook.Sheets.Count
        If xlBook.Sheets(i).Range(ThisWorkbook.Sheets("${SETTING}").Range("E13").Value).Value = ThisWorkbook.Sheets("${SETTING}").Range("E14").Value Then
            countTable = countTable + 1
        End If
    Next i

    If countTable <> 0 Then
        For i = 1 To xlBook.Sheets.Count
            ' 判斷A1單元格是否是テーブル定義這個字段
            If xlBook.Sheets(i).Range(ThisWorkbook.Sheets("${SETTING}").Range("E13").Value).Value = ThisWorkbook.Sheets("${SETTING}").Range("E14").Value Then
                ' 從setting中得到該表的表名單元格
                tableName = xlBook.Sheets(i).Range(ThisWorkbook.Sheets("${SETTING}").Range("E15").Value).Value
                ' 從setting中得到該表的表名註釋單元格
                tableNameComment = xlBook.Sheets(i).Range(ThisWorkbook.Sheets("${SETTING}").Range("E16").Value).Value
            
                ' 從setting中的到字段的開始行
                Dim rowColumnNameStart As String
                rowColumnNameStart = ThisWorkbook.Sheets(1).Range("E25").Value
                
                ' 存放AlterTable的SQL語句
                Dim alterTableSql As String
                alterTableSql = ""
                ' 存放CreateTable的SQL語句
                Dim createTableSql As String
                createTableSql = ""
                ' 存放CommentTable的SQL語句
                Dim dropTableSql As String
                dropTableSql = ""
                ' 存放CommentTable的SQL語句
                Dim commentSql As String
                commentSql = ""
                ' 存放最終的SQL語句
                Dim SQL As String
                SQL = ""
                ReDim tableColumnName(1 To 100) As String
                ReDim tableColumnNameComment(1 To 100) As String
                ReDim tablePk(1 To 100) As String
                ReDim tableColumnNull(1 To 100) As String
                ReDim tableColumnType(1 To 100) As String
                ReDim tableColumnLength(1 To 100) As String
                ReDim tableColumnPonitLength(1 To 100) As String
                
                For j = rowColumnNameStart To 65536
                    ' 判斷當前行是否存在
                    If xlBook.Sheets(i).Range(ThisWorkbook.Sheets("${SETTING}").Range("E17").Value + CStr(j)).Value = "" Then
                        Exit For
                    End If
                    
                    ' 判斷當前行是否存在
                    If xlBook.Sheets(i).Range(ThisWorkbook.Sheets("${SETTING}").Range("E17").Value + CStr(j)).Value <> "" Then
                        ' 存儲字段名
                        tableColumnName(j) = xlBook.Sheets(i).Range(ThisWorkbook.Sheets("${SETTING}").Range("E19").Value + CStr(j)).Value
                        ' 存儲字段註釋
                        tableColumnNameComment(j) = xlBook.Sheets(i).Range(ThisWorkbook.Sheets("${SETTING}").Range("E18").Value + CStr(j)).Value
                        
                        ' 判斷當前字段是否是主鍵
                        If xlBook.Sheets(i).Range(ThisWorkbook.Sheets("${SETTING}").Range("E20").Value + CStr(j)).Value <> "" Then
                            ' 存儲主鍵
                            tablePk(j) = xlBook.Sheets(i).Range(ThisWorkbook.Sheets("${SETTING}").Range("E19").Value + CStr(j)).Value
                        Else
                            tablePk(j) = ""
                        End If
                        
                        ' 判斷當前字段是否為空
                        If xlBook.Sheets(i).Range(ThisWorkbook.Sheets("${SETTING}").Range("E21").Value + CStr(j)).Value = "○" Then
                            ' 存儲字段可否為空
                            tableColumnNull(j) = "not null"
                        Else
                            tableColumnNull(j) = ""
                        End If
                        
                        ' 存儲字段類型
                        tableColumnType(j) = xlBook.Sheets(i).Range(ThisWorkbook.Sheets("${SETTING}").Range("E22").Value + CStr(j)).Value
                        
                        ' 判斷當前字段長度是否為空（date型無字段長度）
                        If xlBook.Sheets(i).Range(ThisWorkbook.Sheets("${SETTING}").Range("E23").Value + CStr(j)).Value <> "" Then
                            ' 存儲字段長度
                            tableColumnLength(j) = xlBook.Sheets(i).Range(ThisWorkbook.Sheets("${SETTING}").Range("E23").Value + CStr(j)).Value
                        Else
                            tableColumnLength(j) = ""
                        End If
                        
                        ' 判斷當前字段小數部分是否為空（date型無字段長度）或字段小數部分字段為0
                        If xlBook.Sheets(i).Range(ThisWorkbook.Sheets("${SETTING}").Range("E24").Value + CStr(j)).Value <> "" And xlBook.Sheets(i).Range(ThisWorkbook.Sheets("${SETTING}").Range("E24").Value + CStr(j)).Value <> "0" Then
                            ' 存儲字段小數部分長度
                            tableColumnPonitLength(j) = xlBook.Sheets(i).Range(ThisWorkbook.Sheets("${SETTING}").Range("E24").Value + CStr(j)).Value
                        Else
                            tableColumnPonitLength(j) = ""
                        End If
                        ' 測試
                        ' Debug.Print tablePk(j)
                    Else
                        Exit For
                    End If
                Next j
                
                ' 存儲字段名結束的行數
                Dim rowColumnNameEnd As String
                rowColumnNameEnd = j - 1
                
                
                ReDim tableColumnSql(1 To rowColumnNameEnd) As String
                ReDim tableColumnCommentSql(1 To rowColumnNameEnd) As String
                
                For k = rowColumnNameStart To rowColumnNameEnd
                    ' 最後一個字段沒有逗號
                   ' If k = rowColumnNameEnd Then
                        ' 有小數部分
                       ' If tableColumnPonitLength(k) <> "" Then
                        ' tableColumnSql(k) = tableColumnName(k) + " " + tableColumnType(k) + "(" + tableColumnLength(k) + "," + tableColumnPonitLength(k) + ")" + " " + tableColumnNull(k) + vbCrLf
                        ' date型無字段長度
                       ' ElseIf tableColumnLength(k) = "" And tableColumnPonitLength(k) = "" Then
                        '    tableColumnSql(k) = tableColumnName(k) + " " + tableColumnType(k) + " " + tableColumnNull(k) + vbCrLf
                       ' Else
                        '    tableColumnSql(k) = tableColumnName(k) + " " + tableColumnType(k) + "(" + tableColumnLength(k) + ")" + " " + tableColumnNull(k) + " COMMENT '" + "tableColumnNameComment(k)" + "' ," + vbCrLf
                        'End If
                   ' Else
                        ' 有小數部分
                      If tableColumnPonitLength(k) <> "" Then
                         'tableColumnSql(k) = tableColumnName(k) + " " + tableColumnType(k) + "(" + tableColumnLength(k) + "," + tableColumnPonitLength(k) + ")" + " " + tableColumnNull(k) + "," + vbCrLf
                            tableColumnSql(k) = "`" + tableColumnName(k) + "`" + " " + tableColumnType(k) + "(" + tableColumnLength(k) + "," + tableColumnPonitLength(k) + ")" + " " + tableColumnNull(k) + " COMMENT '" + tableColumnNameComment(k) + "' ," + vbCrLf
                        ' date型無字段長度
                       ' ElseIf tableColumnLength(k) = "" And tableColumnPonitLength(k) = "" Then
                           ' tableColumnSql(k) = tableColumnName(k) + " " + tableColumnType(k) + " " + tableColumnNull(k) + "," + vbCrLf
                        Else
                            tableColumnSql(k) = "`" + tableColumnName(k) + "`" + " " + tableColumnType(k) + "(" + tableColumnLength(k) + ")" + " " + tableColumnNull(k) + " COMMENT '" + tableColumnNameComment(k) + "' ," + vbCrLf
                        End If
                    'End If
                ' Debug.Print tableColumnSql(k)
                'tableColumnCommentSql(k) = " COMMENT ON COLUMN " + tableName + "." + tableColumnName(k) + " IS '" + tableColumnNameComment(k) + "';" + vbCrLf
                ' Debug.Print tableColumnCommentSql(k)
                Next k
                
                ' 計算主key的個數
                Dim countPk As Integer
                countPk = 0
                For k = rowColumnNameStart To rowColumnNameEnd
                    If tablePk(k) <> "" Then
                        countPk = countPk + 1
                    End If
                Next k
                ' Debug.Print countPk
                
                Dim tablePkSql As String
                tablePkSql = ""
                
                
                ' 聯合主鍵和唯一主鍵
                For k = rowColumnNameStart To rowColumnNameEnd
                    'If countPk = 1 And tablePk(k) <> "" Then
                    '    tablePkSql = tablePk(k)
                     '   Exit For
                    'Else
                     '   If countPk <> 1 And tablePk(k) <> "" And k = rowColumnNameStart Then
                      '      tablePkSql = tablePk(k)
                      '  ElseIf countPk <> 1 And tablePk(k) <> "" Then
                      If countPk <> 0 And tablePk(k) <> "" Then
                            tablePkSql = tablePkSql + tablePk(k) + ","
                      End If
                    'End If
                Next k
                '生成主key
                If tablePkSql <> "" Then
                tablePkSql = Left(tablePkSql, Len(tablePkSql) - 1)
                'MsgBox (tablePkSql)
                  tablePkSql = "PRIMARY KEY (" + tablePkSql + ")" + "," + vbCrLf
                End If
                ' Debug.Print tablePkSql
                
                ' 寫AlterTable的SQL語句
                'alterTableSql = "ALTER TABLE " + tableName + vbCrLf + " ADD PRIMARY KEY (" + tablePkSql + ")" + vbCrLf + ";" + vbCrLf
                
                ' 寫CreateTable的SQL語句
                For j = rowColumnNameStart To rowColumnNameEnd
                    createTableSql = createTableSql + tableColumnSql(j)
                Next j
                createTableSql = createTableSql + tablePkSql
                createTableSql = Left(createTableSql, Len(createTableSql) - 3)
                 Debug.Print createTableSql
                createTableSql = "CREATE TABLE `" + tableName + "` (" + vbCrLf + createTableSql + vbCrLf + ")ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;" + vbCrLf

                ' 寫Comment的SQL語句
                'For j = rowColumnNameStart To rowColumnNameEnd
                   ' commentSql = commentSql + tableColumnCommentSql(j)
                'Next j
               ' commentSql = "COMMENT ON TABLE " + tableName + " IS '" + tableNameComment + "';" + vbCrLf + commentSql + ";" + vbCrLf

                ' 寫DropTable的SQL語句
                dropTableSql = "DROP TABLE IF EXISTS `" + tableName + "` ;" + vbCrLf

                ' 寫完整的SQL語句
                'SQL = dropTableSql + createTableSql + commentSql + alterTableSql
                SQL = dropTableSql + createTableSql
                ' Debug.Print Sql
                
                Call saveAsUTF8(SQL, tableName)
                countSQLCreate = countSQLCreate + 1
            End If
        Next i
        xlBook.Close False
   
    Else
        MsgBox ("此EXCEL中沒有找到數據庫設計sheet！")
    End If
    
    
End Sub

' 根據存儲路徑存儲為UTF-8的格式
Sub saveAsUTF8(SQL As String, tableName As String)

    ' 固定設定
    Const adTypeText = 2
    ' 文件編碼
    Dim strEncode As String
    strEncode = ThisWorkbook.Sheets("${SETTING}").Range("D11").Value
    
    Dim savaPath As String
    savaPath = ""
    savePath = ThisWorkbook.Sheets("${SETTING}").Range("D10").Value

    Dim src As Object
    
    ' 写文件
    Set DST = CreateObject("ADODB.Stream")
    With DST
        .Open
        '文件編碼定
        .Charset = strEncode
        '文件類型 此處固定[2]
        .Type = adTypeText
    End With
    
    ' 文件出力的
    DST.WriteText SQL, adWriteLine
        
    ' 目標文件保存
    DST.SaveToFile (savePath + "\" + tableName + ".sql"), 2
    ' 關目標文件
    DST.Close
    Set DST = Nothing
End Sub






VBA 建表SQL語句生成工具					
					
按钮部					
					
					
					
文件物理位置					
1	文件路徑	D:\DB_definition			
2	文件类型	xls			
3	保存路徑	D:\DB_Ceaat_table_SQL			
4	存儲格式	utf-8			
文件逻辑设置					
1	判此SHEET是否需建表		A1		
	A1的内容		テーブル定義		
2	テーブル／ファイルID		C5		
3	テーブル／ファイル名		H5		
4	行号		A		
5	項目名(日本語）		B		
6	項目名（英字）		C		
7	主キー		D		
8	not NULL		G		
9	ＤＢ型		H		
10	桁数全体		I		
11	桁数小数部		J		
12	起始行		8		
