﻿Attribute VB_Name = "模块1"
Sub triangle()
    Dim num(11, 11) As Integer
    Dim sh As Worksheet
    Set sh = Worksheets("sheet1")
    For i = 1 To 10
        For j = 1 To 10
            num(i, 1) = 1
            num(i, i) = 1
            
        Next j
    Next i
    
    For i = 1 To 10
        For j = 1 To i
            num(i + 1, j + 1) = num(i, j) + num(i, j + 1)
        Next j
    Next i
    
    For i = 1 To 10
        For j = 1 To i
            sh.Cells(i, j) = num(i, j)
        Next j
    Next i
End Sub

