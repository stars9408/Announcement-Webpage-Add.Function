<meta charset="utf-8">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- #include virtual="/board/board_config.asp" -->
<!-- #include virtual="/inc/func.asp" -->
<%
	mode = Request("mode")
	If mode = "" Then
		If bbs = "movie" or bbs = "movie2"  Then
%>
			<!-- #include virtual="/board/mlist.asp" -->
<%
		ElseIf bbs = "faq" Then
%>
			<!-- #include virtual="/board/flist.asp" -->
<%
		ElseIf bbs = "theory" Then
%>
			<!-- #include virtual="/board/tlist.asp" -->
<%
		Else
%>
			<!-- #include virtual="/board/list.asp" -->
<%
		End If

	ElseIf mode = "view" Then

		'If CInt(Session("user_lv")) < CInt(board_read) Then
			'Request.ServerVariables("URL")
			'Response.Write "<script>location.href='/mem/join1_main.asp?topNum=7&subNum=2'</script>"
			'Response.Write "<script>location.href='" & Request.ServerVariables("URL") & "?bbs=" & bbs & "&login=on'</script>"
			'Response.End
		'End If

		If bbs = "movie" or bbs = "movie2" Then
%>
			<!-- #include virtual="/board/mview.asp" -->

<%
		ElseIf bbs = "faq" Then
%>
			<!-- #include virtual="/board/fview.asp" -->
<%
		'ElseIf bbs = "qna" Then
%>
<%
		Else

%>
			<!-- #include virtual="/board/view.asp" -->
<%
		End If
	End If

	If mode = "write" Or mode = "modify" Then
%>
			<!-- #include virtual="/board/write.asp" -->
<%
	End If
	If mode = "delete" Then
%>
			<!-- #include virtual="/board/delete.asp" -->
<%
	End If
%>
