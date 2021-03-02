<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--METADATA TYPE= "typelib"  NAME= "ADODB Type Library"
      FILE="C:\Program Files\Common Files\SYSTEM\ADO\msado15.dll"  -->
<%
	 'KISA WEB Security Template
	'Application("CASTLE_ASP_VERSION_BASE_DIR") = "/castle2"
	'Server.Execute(Application("CASTLE_ASP_VERSION_BASE_DIR") & "/castle_referee.asp")

	Response.Expires = -1
	Response.Expiresabsolute = Now() - 1
	Response.AddHeader "pragma","no-cache"
	Response.AddHeader "chche-control", "private"
	Response.CacheControl = "no-cache"
	Session.Timeout = 60

	Set Con = Server.CreateObject("ADODB.Connection")
	Con.open "PROVIDER=SQLOLEDB;DATA SOURCE=192.168.101.240;UID=infrait;PWD=infrait!QAZX;DATABASE=infrait"

	Sub GetRS(RecordSet, SQL)
		Set RecordSet = Con.Execute(SQL)
	End Sub

	Sub GetPage(RecordSet, SQL, PageSize)
		Set RecordSet = Server.CreateObject("ADODB.RECORDSET")
		RecordSet.PageSize = PageSize
		RecordSet.Open SQL, Con, adOpenStatic
	End Sub

	Sub DBCLOSE(Rs)
		Rs.Close
		Set Rs = Nothing
	End Sub

	Sub PageSetup(Cntsql, sql)

		GetRs Rs,Cntsql

			IntTotalCount = Rs(0)
			IntTotalPage = Rs(1)

			If IntTotalPage = 0 Then
				IntTotalPage = 1
			End If
		
		DBCLOSE(Rs)

		GetRs Rs,sql

	End Sub

%>
