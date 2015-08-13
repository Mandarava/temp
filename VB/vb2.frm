VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} UserForm1 
   Caption         =   "UserForm1"
   ClientHeight    =   2688
   ClientLeft      =   36
   ClientTop       =   384
   ClientWidth     =   3720
   OleObjectBlob   =   "vb2.frx":0000
   StartUpPosition =   1  '所有者中心
End
Attribute VB_Name = "UserForm1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim number1 As Double
Dim number2 As Double

Private Sub CommandButton1_Click()

If IsNumeric(TextBox1.Text) = False Or IsNumeric(TextBox2.Text) = False Then
    If IsNumeric(TextBox1.Text) = False And IsNumeric(TextBox2.Text) = False Then
        MsgBox ("都不是数字")
    ElseIf IsNumeric(TextBox1.Text) = False Then
        MsgBox ("第一个不是数字")
    Else
        MsgBox ("第二个不数数字")

End If
End If

If (IsNumeric(TextBox1.Text) = True And IsNumeric(TextBox2.Text) = True) Then
    number1 = TextBox1.Text
    number2 = TextBox2.Text
   If (number1 > number2) Then
        MsgBox ("the first one is larger")
    ElseIf (number1 = number2) Then
        MsgBox ("the same large")
    Else
        MsgBox ("the second one is larger")
End If
End If
End Sub

Private Sub CommandButton2_Click()
TextBox1.Text = ""
TextBox2.Text = ""
End Sub
