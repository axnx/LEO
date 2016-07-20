' 
' OfficeImporter.vbs
' 
' 
' Version 1.0
'
Option Explicit  

Const SOURCE_PATH = "C:\OFFICE_IMPORT\"
Const EXTENSION   = "txt"
Const MOVE_PATH   = "C:\OFFICE_IMPORT\importiert\"

Const AD_OPEN_STATIC     = 3 
Const AD_LOCK_OPTIMISTIC = 3 
Const CONNECTION_STRING  = "Provider=SQLOLEDB;Data Source=SERVER\INSTANZ,1433;Initial Catalog=testERP;User ID=sa;Password=PASSWORD;"
Const IMPORT_TABLE       = "EXPORT"

Const DELETE_FILE_AFTER_IMPORT = 1
Const MOVE_FILE_AFTER_IMPORT   = 2
Const SECONDS_POPUP            = 5

Const ELO_USERNAME = "Administrator"
Const ELO_PASSWORD = "admin"
Const ELO_ARCHIV   = "eloOfficeTest"

Dim ELO, iRet

'---------------------------------------------------------------------------------------------------

Class Data
	Private m_filename
	Private m_mandant
	Private m_belegkat
	Private m_belegnr
	Private m_belegFirma
	Private m_belegdatum
	Private m_belegTyp
	Private m_belegGfJahr
	Private m_belegMonat
	Private m_belegParentFolder
	
	Public Property Get FileName
		FileName = m_filename
	End Property 
	
	Public Property Let FileName (strFilename)
		m_filename = strFilename
	End Property 
	
	Public Property Get Mandant
		Mandant = m_mandant
	End Property 
	
	Public Property Let Mandant (strMandant)
		m_mandant = strMandant
	End Property 
	
	Public Property Get Belegkat
		Belegkat = m_belegkat
	End Property 
	
	Public Property Let Belegkat (strBelegkat)
		m_belegkat = strBelegkat
	End Property 
	
	Public Property Get Belegnr
		Belegnr = m_belegnr
	End Property 
	
	Public Property Let Belegnr (strBelegnr)
		m_belegnr = strBelegnr
	End Property 
	
	Public Property Get BelegFirma
		BelegFirma = m_belegFirma
	End Property 
	
	Public Property Let BelegFirma (strBelegFirma)
		m_belegFirma = strBelegFirma
	End Property 
	
	Public Property Get BelegDatum
		BelegDatum = m_belegdatum
	End Property 
	
	Public Property Let BelegDatum (strBelegDatum)
		m_belegdatum = strBelegDatum
	End Property 
	
	Public Property Get BelegTyp
		BelegTyp = m_belegTyp
	End Property 
	
	Public Property Let BelegTyp (strBelegTyp)
		m_belegTyp = strBelegTyp
	End Property 
	
	Public Property Get BelegGfJahr
		BelegGfJahr = m_belegGfJahr
	End Property 
	
	Public Property Let BelegGfJahr (strBelegGfJahr)
		m_belegGfJahr = strBelegGfJahr
	End Property
	
	Public Property Get BelegMonat
		BelegMonat = m_belegMonat
	End Property 
	
	Public Property Let BelegMonat (strBelegMonat)
		m_belegMonat = strBelegMonat
	End Property
	
	Public Property Get BelegParentFolder
		BelegParentFolder = m_belegParentFolder
	End Property 
	
	Public Property Let BelegParentFolder (strBelegParentFolder)
		m_belegParentFolder = strBelegParentFolder
	End Property 
	
	Public Property Get testOutput
		testOutput = m_filename + vbCr +_
					 m_mandant + vbCr +_ 
					 m_belegkat + vbCr +_
					 m_belegnr + vbCr +_
					 m_belegdatum + vbCr +_
					 m_belegtyp+ vbCr +_
					 m_belegGfJahr + vbCr +_
					 m_belegMonat + vbCr +_
					 m_belegParentFolder + vbCr +_
					 m_belegFirma	
		
	End Property 
	
	Public Property Get getEloPath
		getEloPath = "¶" & m_mandant & _
					 "¶" & m_belegGfJahr & _
					 "¶" & m_belegkat & _
					 "¶" & UCase( Left(m_belegFirma,1) ) & _
					 "¶" & m_belegFirma & _
					 "¶" & m_belegTyp & _
					 "¶" & m_belegMonat & _
					 "¶" & m_belegParentFolder
	End Property 
	
End Class  
'---------------------------------------------------------------------------------------------------

Function countFiles(path)
	Set filesys = CreateObject("Scripting.FileSystemObject")
	Set DataFolder = filesys.GetFolder(path)
	Set DataFiles = DataFolder.Files
	NumberOfFiles = DataFiles.Count 
	countFiles = NumberOfFiles
End Function
'---------------------------------------------------------------------------------------------------

Function countFilesExt(path, ext)
	Count = 0 
	Set fso = CreateObject("Scripting.FileSystemObject") 
	Set folder = fso.GetFolder(path) 
	For Each file In folder.files
		If LCase(fso.GetExtensionName(file)) = ext Then 
			Count = Count + 1
		End If
	Next 
	countFilesExt = Count
End Function
'---------------------------------------------------------------------------------------------------

Function fileWalker(path, ext)
	Dim fso, filenameArray, folder, file
	filenameArray = Array()
	Set fso = CreateObject("Scripting.FileSystemObject") 
	Set folder = fso.GetFolder(path) 
	For Each file In folder.files
		If LCase(fso.GetExtensionName(file)) = ext Then 
			Redim Preserve filenameArray(Ubound(filenameArray)+1)
			filenameArray(Ubound(filenameArray)) = CStr(fso.GetFileName(file))
		End If
	Next
	fileWalker = filenameArray
End Function
'---------------------------------------------------------------------------------------------------

Function getConnection
	
	Dim objConnection
	
	Set objConnection = CreateObject("ADODB.Connection") 
	objConnection.Open CONNECTION_STRING						 
	Set getConnection = objConnection
	
End Function
'---------------------------------------------------------------------------------------------------

Function executeSql(objConnection, filenameToSearch)
	
	On Error Resume Next		
	
	Dim objData, rs
	
	Set rs = CreateObject("ADODB.Recordset") 				 
	
    rs.Open "SELECT * FROM " & IMPORT_TABLE & " WHERE filename='" & filenameToSearch & "';" , objConnection, AD_OPEN_STATIC, AD_LOCK_OPTIMISTIC 
 	
 	If (rs.RecordCount = 0) Then  
		Set executeSql = nothing
	Else 
		Set objData = New Data
		While not rs.EOF
			
			rs.MoveFirst 			
			objData.FileName = rs.Fields.Item("filename")
			objData.Mandant = rs.Fields.Item("mandant")
			objData.Belegkat = rs.Fields.Item("belegkat")
			objData.BelegTyp  = rs.Fields.Item("belegtyp")
			objData.Belegnr = rs.Fields.Item("belegnr")
			objData.BelegDatum = rs.Fields.Item("belegdatum")
			objData.BelegFirma = rs.Fields.Item("belegFirma")
			objData.BelegGfJahr = rs.Fields.Item("belegjahr")
			objData.BelegMonat = rs.Fields.Item("belegmonat")
			objData.BelegParentFolder = rs.Fields.Item("belegParentFolder")
			
			rs.MoveNext			
		Wend
		rs.Close
  	  	Set executeSql = objData
	End If
End Function
'---------------------------------------------------------------------------------------------------

Function sqlSetStatus(objConnection, status, filenameToSearch)
	
  Dim rs
  Set rs = CreateObject("ADODB.Recordset") 
  rs.Open "SELECT * FROM " & IMPORT_TABLE & " WHERE filename='" & filenameToSearch & "';" , objConnection, AD_OPEN_STATIC, AD_LOCK_OPTIMISTIC 

  While Not rs.EOF 
    rs.Fields("importiert").value = status
	rs.Fields("importiertAm").value = now()
    rs.Update
    rs.MoveNext
  Wend 
  rs.Close
 
End Function

'---------------------------------------------------------------------------------------------------

Function ConnectToElo  
  On Error Resume Next  
  ConnectToElo=false  
  Set ELO=CreateObject("ELO.office")  
  If ELO.SelectView(1)<0 Then  
    ConnectToElo=false  
  Else  
    ConnectToElo=true  
  End If  
End Function  
'--------------------------------------------------------------------------------------------------- 

Function CreateStructure(strEloPath)
  
  Const LevelSchrank = 1
  Const LevelOrdner = 2
  Const LevelRegister = 3
 
  Const FolderMaskNo = 1
  
  Const ParentId = 1
  Const CreateNewEntry = 0
  
  Dim objIndex, strSplitted, sizeOfArray, i, iParent, CurrentObjectName, CurrentEloPath
  objIndex = 1
  CurrentEloPath = ""
  
  strSplitted = Split(strEloPath,"¶") 
  sizeOfArray = UBound(strSplitted)
  
  iParent=Elo.LookupIndex(strEloPath)  

  If iParent<0 Then
	  While i < sizeOfArray
		 
		CurrentObjectName = strSplitted(i+1)		  
		CurrentEloPath = CurrentEloPath & "¶" + CurrentObjectName
		
		If( Elo.LookupIndex(CurrentEloPath) < 0 ) Then  
		  
			If(i=0 ) Then
			  Elo.PrepareObject CreateNewEntry, LevelSchrank, FolderMaskNo  
			Else
			  Elo.PrepareObject CreateNewEntry, LevelOrdner, FolderMaskNo  
			End If		

			Elo.ObjIndex="#" & objIndex
			Elo.ObjShort=CurrentObjectName
			Elo.ObjFlags=1  
			Elo.UpdateObject
			  
		End If
		iParent=Elo.LookupIndex(CurrentEloPath)
		objIndex = iParent
		i = i + 1
	  Wend 
  End If 
    
  CreateStructure = iParent
  
End Function
'--------------------------------------------------------------------------------------------------- 

Sub InsertToArchive(iObjId, pData, filename, opt)
	
	Const LevelDocument = 254
	Const MaskNo = 9
	Const CreateNewEntry = 0
	Const ActiveObjectId = -2
	
	Dim DocId, Result
	Call ELO.PrepareObjectEx(CreateNewEntry, LevelDocument, MaskNo)
	ELO.ObjShort = pData.BelegNr
	ELO.ObjIndex = "#" & iObjId
	ELO.ObjXDate = pdata.BelegDatum
	
	Call ELO.SetObjAttrib(0, pData.Mandant)
	Call ELO.SetObjAttrib(1, pData.Belegkat)
	Call ELO.SetObjAttrib(2, pData.BelegFirma)
	Call ELO.SetObjAttrib(3, pData.BelegTyp)
	Call ELO.SetObjAttrib(4, pData.BelegNr)

	If ELO.UpdateObject() < 0 Then 
		Call ELO.MsgBox("Es ist ein Fehler beim Speichern aufgetreten", "ELO", vbOkOnly)
	  Else
		DocId = Elo.GetEntryID(ActiveObjectId)
		Result = Elo.UpdateDocument(DocId, 0 , SOURCE_PATH & filename)
		If Result = 1 Then 			
			If opt = 1 Then
              DeleteAFile SOURCE_PATH & filename 
            ElseIf opt = 2 Then 
              MoveAFile SOURCE_PATH & filename, MOVE_PATH
            End If
		End If
	  If Result<0 then
		call ELO.MsgBox("x2Es ist Fehler beim Speichern aufgetreten: " & Result, "ELO", vbOkOnly)
	  End If
	End If

End Sub
'---------------------------------------------------------------------------------------------------
 
Function FileExists(strPathFilename)
	Dim fso
	Set fso = CreateObject("Scripting.FileSystemObject")
	If fso.FileExists(strPathFilename) Then 
		FileExists = true
	Else
		FileExists = false
	End If
	fso = nothing
End Function
'--------------------------------------------------------------------------------------------------- 

Sub DeleteAFile(strPathFilename)
	Dim fso
	Set fso = CreateObject("Scripting.FileSystemObject")
	If fso.FileExists(strPathFilename) Then 
		fso.DeleteFile strPathFilename
	End If
	'fso = nothing
End Sub
'--------------------------------------------------------------------------------------------------- 

Sub MoveAFile(strSource, strDestination)
   Dim fso
   Set fso = CreateObject("Scripting.FileSystemObject")
   If fso.FileExists(strSource) Then 
		fso.MoveFile strSource, strDestination
   End If
   'fso = nothing
End Sub
'--------------------------------------------------------------------------------------------------- 

Sub MessageX(title, message, seconds)

  Dim WshShell, intResult
  Set WshShell = CreateObject("WScript.Shell")
  intResult = WshShell.Popup(message, seconds, title, vbInformation)

End Sub
'---------------------------------------------------------------------------------------------------

Function LoginElo
  
  Set ELO=CreateObject("ELO.office") 
  LoginElo = ELO.Login(ELO_USERNAME, ELO_PASSWORD, ELO_ARCHIV)
  
End Function
'---------------------------------------------------------------------------------------------------

Function LogoutElo
  
  Set ELO=CreateObject("ELO.office")   
  LogoutElo = ELO.Login("LOGOUT", "", "")
  
End Function
'---------------------------------------------------------------------------------------------------

Sub Main 

  Dim objData1, iObjId, filename, i, filenameArray, sizeOfFilenameArray
  Const IMPORTIERT_STATUS = 1
  
  filenameArray = fileWalker (SOURCE_PATH, EXTENSION)
  sizeOfFilenameArray = Ubound(filenameArray)
   
  If (sizeOfFilenameArray > 0) Then
    For i = 0 to sizeOfFilenameArray
	  
	  filename = filenameArray(i)
	  Set objData1  = executeSql(getConnection(), filename ) 	  
	  
	  If Not objData1 Is Nothing then    	  
	    iObjId = CreateStructure(objData1.getEloPath)
	    InsertToArchive iObjId, objData1, filename, MOVE_FILE_AFTER_IMPORT
	    Call sqlSetStatus(getConnection(), IMPORTIERT_STATUS, filename)
	  End If
	  
    Next
  End If 
  
  MessageX "Information", "ELO Import Script finished !", SECONDS_POPUP
End Sub  
'--------------------------------------------------------------------------------------------------- 
'--------------------------------------------------------------------------------------------------- 

If ConnectToElo = true Then  
  Main
  Call LogoutElo
Else  
  Call LoginElo
  WScript.Sleep 2000
  Main
  Call LogoutElo
End If  
