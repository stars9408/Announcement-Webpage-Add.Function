<!--#include virtual = "/inc/dbcon.asp"-->
<!--#include virtual = "/inc/func.asp"-->
<!--#include virtual = "/inc/upload.asp"-->
<!--#include virtual="/admin/include/admin_check.asp" -->
<%
	Session.CodePage=65001

	UpLoadFolder = Server.MapPath("\") & "\upload\"

	Call UploadSetup(UpLoadFolder, 120, 5048)

	mode = dup("mode")
	bbs = dup("bbs")
	bidx = dup("bidx")
	bGid = dup("bGid")
	bNid = dup("bNid")
	'bThread = dup("bThread")
	bDepth = dup("bDepth")
	bUserId = dup("bUserId")
	bName = dup("bName")
	bUrl = dup("bUrl")
	bShortment = dup("bShortment")

	btitle = Trim(dup("btitle"))
	btitle = replace_quot(btitle)
	bCategory = Trim(dup("bCategory"))
	bperiod1 = Trim(dup("bperiod1"))
	bperiod2 = Trim(dup("bperiod2"))

	bNotice = Trim(dup("bNotice"))
	bdate = Trim(dup("bdate"))
	bSummary = Trim(dup("summary"))

	If bNotice = "" Then
		bNotice = 2
	End If

	bDepth = dup("bDepth")

	If bDepth = "" Then
		bDepth = 1
	End If

	bContent = dup("editor1")
	bContent = replace_quot(bContent)
	bSummary = replace_quot(bSummary)
	
	Dim org_file(2)
	Dim re_file(2)


	For i=1 To 2 Step 1
		org_file(i) = dup("file" & i).Filename

		If org_file(i) = "" Then
		Else
			if mode = "modify" Then
				sql = "select bFileName" & i & " from " & bbs & " where bidx = '" & bidx & "'"

				GetRs Rs,sql

				If Not Rs.EOF Then
					DeleteFileName = Trim(Rs("bFileName"&i))
					Call FileDelete(DeleteFileName,UpLoadFolder)
				End If

				DBCLOSE(Rs)
			End If

			Call DoubleFileChk(org_file(i), bbs)
			re_file(i) = upfilepath
			dup("file" & i).SaveAs dup.DefaultPath & bbs & "\" & re_file(i)
		End If
	Next

	bUserIp = Request.ServerVariables("REMOTE_HOST")

If org_file(1) <> "" Then


	If bbs="data" then

		If Right(re_file(1),3)="exe"  Then
		
			With Response
					.Write "<script language=""javascript"">" & vbcrlf _
						& "<!--" & vbcrlf _
						& "	alert(""실행파일(.exe) 첨부 할 수 없습니다."");" & vbcrlf _
							& "	history.back(-1);" & vbcrlf _
						& "//-->" & vbcrlf _
						& "</script>" & vbcrlf
					.End
			End With
			response.end

		End If 

	Else 
		If Right(re_file(1),3)<>"peg" and Right(re_file(1),3)<>"jpg" and Right(re_file(1),3)<>"gif" and Right(re_file(1),3)<>"png" Then
		
			With Response
					.Write "<script language=""javascript"">" & vbcrlf _
						& "<!--" & vbcrlf _
						& "	alert(""이미지 파일을 첨부 바랍니다.(jpg,gif,png)"");" & vbcrlf _
							& "	history.back(-1);" & vbcrlf _
						& "//-->" & vbcrlf _
						& "</script>" & vbcrlf
					.End
			End With
			response.end

		End If 

	End If 
End if


	' 글 쓰기 시
	If mode = "write" Then
		bIdx = GetMaxID(bbs, "bIdx")
		bOid = GetMaxID(bbs, "bOid")

		sql = "insert into " & bbs & " ( bIdx, bOid, bGid, bNid, bDepth, bTitle, bperiod1, bperiod2, bUrl, bCategory, bName, "
		sql = sql & "bEmail, bSummary, bContent, bFileName1, bOrgFileName1, bFileName2, bOrgFileName2, bPasswd,  "

		If bbs="notice" then
		sql = sql & "bUserIp, bUserId, bNotice, bdate, bShortment, bHit ) values ("
		Else
		sql = sql & "bUserIp, bUserId, bNotice, bHit ) values ("
		End If 
		
		sql = sql & "'" & bidx & "', "
		sql = sql & "'" & bOid & "', "
		sql = sql & "'" & bIdx & "', "
		sql = sql & "'" & bIdx & "', "
		sql = sql & "'" & bDepth & "', "
		sql = sql & "'" & bTitle & "', "
		sql = sql & "'" & bperiod1 & "', "
		sql = sql & "'" & bperiod2 & "', "
		sql = sql & "'" & bUrl & "', "
		sql = sql & "'" & bCategory & "', "
		sql = sql & "'" & bName & "', "
		sql = sql & "'" & bEmail & "', "
		sql = sql & "'" & bSummary & "', "
		sql = sql & "'" & bContent & "', "
		sql = sql & "'" & re_file(1) & "', "
		sql = sql & "'" & org_file(1) & "', "
		sql = sql & "'" & re_file(2) & "', "
		sql = sql & "'" & org_file(2) & "', "
		sql = sql & "'" & bPasswd & "', "
		sql = sql & "'" & bUserIp & "', "
		sql = sql & "'" & bUserId & "', "
		sql = sql & "'" & bNotice & "', "
		If bbs="notice" then
		sql = sql & "'" & bdate & "', "
		sql = sql & "'" & bShortment & "', " '간략글
		End IF
		sql = sql & " 0 )"


		Con.Execute (sql)

		Call msg_go("등록되었습니다.", "index.asp?mode=view&bidx=" & bIdx & "&bbs=" & bbs)
		Response.End
	End If

	' 글 수정 시
	If mode = "modify" Then
		sql = "update " & bbs & " set bTitle = '" & bTitle & "', "
		sql = sql & "bCategory = '" & bCategory & "', "
		sql = sql & "bperiod1 = '" & bperiod1 & "', "
		sql = sql & "bperiod2 = '" & bperiod2 & "', "
		sql = sql & "bName = '" & bName & "', "
		sql = sql & "bEmail = '" & bEmail & "', "
		If bbs="notice" then
		sql = sql & "bShortment = '" & bShortment & "', "
		sql = sql & "bdate = '" & bdate & "', "
		End if
		sql = sql & "bContent = '" & bContent & "', "
		sql = sql & "bSummary = '" & bSummary & "', "

		For i = 1 To 2 Step 1
			If re_file(i) <> "" Then
				sql = sql & "bFileName" & i & " = '" & re_file(i) & "', bOrgFileName" & i & " = '" & org_file(i) & "', "
			End If
		Next

		sql = sql & "bNotice = '" & bNotice & "' where bidx = '" & bidx & "'"

		Con.Execute (sql)
		Call msg_go("수정되었습니다.", "index.asp?mode=view&bidx=" & bIdx & "&bbs=" & bbs)
		Response.End
	End If

	'답변 글 시
	If mode = "reply" Then
		bIdx = GetMaxID(bbs, "bIdx")

		sql = "insert into " & bbs & " ( bIdx, bGid, bNid, bDepth, bTitle, bUrl, bCategory, bName, "
		sql = sql & "bEmail, bSummary, bContent, bFileName1, bOrgFileName1, bFileName2, bOrgFileName2, bPasswd,  "
		If bbs="notice" then
		sql = sql & "bUserIp, bUserId, bNotice, bdate, bShortment,  bHit ) values ("
		Else
		sql = sql & "bUserIp, bUserId, bNotice,  bHit ) values ("		
		End if
		
		sql = sql & "'" & bidx & "', "
		sql = sql & "'" & bGid & "', "
		sql = sql & "'" & bNid & "', "
		sql = sql & "'" & bDepth & "', "
		sql = sql & "'" & bTitle & "', "
		sql = sql & "'" & bUrl & "', "
		sql = sql & "'" & bCategory & "', "
		sql = sql & "'" & bName & "', "
		sql = sql & "'" & bEmail & "', "
		sql = sql & "'" & bSummary & "', "
		sql = sql & "'" & bContent & "', "
		sql = sql & "'" & re_file(1) & "', "
		sql = sql & "'" & org_file(1) & "', "
		sql = sql & "'" & re_file(2) & "', "
		sql = sql & "'" & org_file(2) & "', "
		sql = sql & "'" & bPasswd & "', "
		sql = sql & "'" & bUserIp & "', "
		sql = sql & "'" & bUserId & "', "
		If bbs="notice" then
		sql = sql & "'" & bdate & "', "
		sql = sql & "'" & bShortment & "', " '간략글
		End If 
		sql = sql & "'" & bNotice & "', "
		sql = sql & " 0 )"

		Con.Execute (sql)
		Call msg_go("등록되었습니다.", "index.asp?mode=view&bidx=" & bIdx & "&bbs=" & bbs)
		Response.End
	End If

%>
