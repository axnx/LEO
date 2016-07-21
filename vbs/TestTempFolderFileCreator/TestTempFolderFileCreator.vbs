Option Explicit

Dim fso, file, iFile, i2, iMax, iOrdner,folder
Set fso = CreateObject("Scripting.FileSystemObject")

Const PATH = "C:\Test\"
Const MAX_FILES = 20000
Const MAX_FILES_IN_FOLDER = 10

Sub CreateTextFile(folder, filename)
	Set file = fso.CreateTextFile(folder & filename, True)
	file.WriteLine("Dateiname: " & filename )
	file.Close
End Sub 


Sub CreateCSV(folder, filename, text)
	
	Const ForReading = 1, ForWriting = 2, ForAppending = 8
	Dim file
	Set fso = CreateObject("Scripting.FileSystemObject")
	Set file = fso.OpenTextFile(folder & filename, ForAppending, True) 
	file.WriteLine(text)
	file.Close 
	
End Sub 

Function CreateFolder(pOrdnername)
	Set folder = fso.CreateFolder(pOrdnername)
  CreateFolder = folder.Path & "\"
End Function

Sub Main
	
	Dim iFileCounter, iFolderCounter, filename, foldername, currentFolder, iFilesInFolder, textInImportFile
	currentFolder = ""
	iFileCounter = 1
	iFolderCounter = 1
	iFilesInFolder = 1 
	
	For iFile = 1 To MAX_FILES
		
		filename = iFile & ".txt"	
		
		If iFilesInFolder = 1 Then
				foldername = "Ordner_" & iFolderCounter
				currentFolder = CreateFolder(PATH & foldername)
		End If 
		
		CreateTextFile currentFolder, filename
		
		textInImportFile = iFile & ".txt;ABC" & iFile & ".txt"
		CreateCSV PATH, "files.txt", textInImportFile
		iFilesInFolder = iFilesInFolder + 1
		iFileCounter = iFileCounter + 1
		
		If iFilesInFolder > MAX_FILES_IN_FOLDER Then 
		  iFilesInFolder = 1 
			iFolderCounter = iFolderCounter + 1
		End If
		
	Next

End Sub

Main
MsgBox "Script finished"