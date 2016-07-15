'VbsEdit 7.4238
'
'
'
Const adOpenStatic = 3 
Const adLockOptimistic = 3 
Const filenameToSearch = "RE1236_1.pdf"
Const connectionString = "Provider=SQLOLEDB;Data Source=SERVER\INSTANZID,1433;Initial Catalog=DATABASENAME;User ID=sa;Password=PASSWORD;"

Class Data
	Private m_filename
	Private m_mandant
	Private m_belegkat
	Private m_belegnr
	Private m_belegEmf
	Private m_belegdatum
	
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
	
	Public Property Get BelegEmf
		BelegEmf = m_belegEmf
	End Property 
	
	Public Property Let BelegEmf (strBelegEmf)
		m_belegEmf = strBelegEmf
	End Property 
	
	Public Property Get BelegDatum
		BelegDatum = m_belegdatum
	End Property 
	
	Public Property Let BelegDatum (strBelegDatum)
		m_belegdatum = strBelegDatum
	End Property 
	
	Public Property Get testOutput
		testOutput = m_filename + vbCr +_
					 m_mandant + vbCr +_ 
	    		 m_belegkat + vbCr +_
					 m_belegnr + vbCr +_
					 m_belegdatum + vbCr +_
					 m_belegEmf	
		
	End Property 
	
End Class  


	
Function getConnection
	
	Set objConnection = CreateObject("ADODB.Connection") 
	objConnection.Open connectionString						 
	Set getConnection = objConnection
	
End Function
	

Function executeSql(objConnection)
			
	Dim objData
	Set objData = New Data	
	
	Set objRecordSet = CreateObject("ADODB.Recordset") 				 
	
    objRecordSet.Open "SELECT * FROM EXPORTDMS WHERE filename='" & filenameToSearch & "';" , objConnection, adOpenStatic, adLockOptimistic 
 
	objRecordSet.MoveFirst 
	
	While not objRecordSet.eof
			
		objData.FileName = objRecordset.Fields.Item("filename")
		objData.Mandant = objRecordset.Fields.Item("mandant")
		objData.Belegkat = objRecordset.Fields.Item("belegkat")
		objData.Belegnr = objRecordset.Fields.Item("belegnr")
		objData.BelegDatum = objRecordset.Fields.Item("belegdatum")
		objData.BelegEmf = objRecordset.Fields.Item("belegEmf")
			
		objRecordset.moveNext
	Wend
	
	Set executeSql = objData
	
End Function


Public Sub Main
	
	Wscript.Echo executeSql(getConnection).testOutput

End Sub


Main