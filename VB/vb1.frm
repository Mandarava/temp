VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} UserForm1 
   Caption         =   "UserForm1"
   ClientHeight    =   3180
   ClientLeft      =   36
   ClientTop       =   384
   ClientWidth     =   4728
   OleObjectBlob   =   "vb1.frx":0000
   StartUpPosition =   1  '所有者中心
End
Attribute VB_Name = "UserForm1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim flag As Boolean


Private Sub CommandButton1_Click()
If IsNumeric(TextBox1.Text) = True Then
    flag = True
Else
    flag = False
End If

Label1.Caption = flag

End Sub

Private Sub TextBox1_Change()

End Sub
