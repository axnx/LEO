Option Explicit
 'On Error Resume Next
 Dim objFSO, strTopFolder, intFileCount, outFile, objFile
 strTopFolder = "Z:\--- BEREITS IMPORTIERT ---"
 outFile = "Z:\filesInFolder.txt"
 Set objFSO = CreateObject("Scripting.FileSystemObject")
 CountFiles(strTopFolder)
 MsgBox "Script finished!"
 Sub CountFiles(strFolder)
    'On Error Resume Next
    intFileCount = 0
    Dim objFolder, objFiles, subfolder   
    Set objFolder = objFSO.GetFolder(strFolder) 
    Set objFiles = objFolder.Files 
    intFileCount = objFiles.Count
    WriteFile strFolder, intFileCount
    For Each subfolder In objFolder.SubFolders
        CountFiles(subfolder.Path)
    Next
 End Sub

Sub WriteFile(strCurrentFolder, intCountedFiles)
	Const ForReading = 1, ForWriting = 2, ForAppending = 8 
	Set objFile = objFSO.OpenTextFile(outFile,ForAppending, True)
	objFile.WriteLine strCurrentFolder & ";" & intCountedFiles
	objFile.Close
End Sub