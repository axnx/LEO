RunDir = WScript.ScriptFullName
RunDir = Left(RunDir,InStr(RunDir,WScript.ScriptName)-2)

Sub Include( cNameScript )
    Set oFS = CreateObject("Scripting.FileSystemObject")		
    Set oFile = oFS.OpenTextFile( cNameScript )
    ExecuteGlobal oFile.ReadAll()
    oFile.Close
End Sub

Include Rundir & "\Quadrat.vbs.inc"

msgbox quadrat(4)