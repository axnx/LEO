'SplitString.vbs
Option Explicit
Dim strEloPath, strSplitted, x, i, sizeOfArray
i = 0
strEloPath = "¶TestA¶TestB¶TestC¶TestD"
strSplitted = Split(strEloPath,"¶")

'for each x In strSplitted
'   If(i>0) Then MsgBox x 
'   i = i + 1	
'Next

sizeOfArray = UBound(strSplitted)
While i < sizeOfArray
  MsgBox strSplitted(i+1)
  i = i + 1	
Wend