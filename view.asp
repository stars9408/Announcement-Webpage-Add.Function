<!--#include virtual="/admin/include/admin_check.asp" -->
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8">
<%
	bidx = Request.QueryString("bidx")
	page = Request.QueryString("page")
	search = Request.QueryString("search")
	keyword = Request.QueryString("keyword")
	bbs = Request.QueryString("bbs")

	sql = "select * from " & bbs & " where bidx = '" & bidx & "'"

	GetRs Rs, sql

	If Not Rs.EOF Or Not Rs.BOF Then
		bTitle = Rs("bTitle")
		bRegdate = Left(Rs("bregdate"), 10)
		bContent = reverse_quot(Rs("bContent"))

		Dim file(1), ofile(1)

		file(0) = Rs("bOrgFileName1")
		file(1) = Rs("bOrgFileName2")

		ofile(0) = Rs("bFileName1")
		ofile(1) = Rs("bFileName2")
	Else
		Response.Write "<Script>alert('잘못된 접근입니다.');history.go(-1);</script>"
		Response.End
	End If

	DBCLOSE(Rs)
%>
<script src="/cheditor/cheditor.js"></script>
<script>
	chk_del = function(bidx, bbs){
		if(confirm('정말 삭제하시겠습니까?')){
			location.href = 'del.asp?mode=del&bidx=' + bidx + '&bbs=' + bbs;
		}
		else{
			return false;
		}
	}
</script>
<script type="text/javascript" language="javascript" src="/cheditor/imageUtil.js"></script>
<script type="text/javascript">
	hs.iconsPath = '/cheditor/icons/imageutil/';
</script>
<link rel="stylesheet" type="text/css" href="/cheditor/imageUtil.css">
<div id="lightbox-container"></div>
<table cellspacing="0" cellpadding="0" border="0" width="100%" bgcolor="#ffffff">
	<tr>
		<td width="15">&nbsp;</td>
		<td width="700">
			<table cellspacing="0" cellpadding="0" border="0" width="700" >
				<tr>
					<td colspan="3" bgcolor="ff9999" height="2"></td>
				</tr>
				<tr>
					<td colspan="3"  width="700" valign="top">
						<table cellspacing="0" cellpadding="0" border="0" id="cont" height="32" width="100%">
							<tr bgcolor="#f9f9f9" class="tr1">
								<td class="title1 fw" colspan="3" height="32" style="padding-left:3px;"><%=bTitle%></td>
								<td align="right"> 등록일&nbsp;| <%=bRegdate%></td>
							</tr>
							<%
								For i = 0 To 1 Step 1
									If file(i) <> "" Then
							%>
							<tr height="30">
								<td colspan="4" align="right"><a href="filedown.asp?bbs=<%=bbs%>&idx=<%=bidx%>&num=<%=i+1%>"><img src="/images/board/btn_download.gif" align="absmiddle"></a><%=file(i)%></td>
							</tr>
							<%
									End If
								Next
							%>
							<tr>
								<td colspan="4" height="16">&nbsp;</td>
							</tr>
							<tr>
								<td class="title3" colspan="4" style="padding-left:3px; margin-top:5px;">
								<%
									If board_type = "movie" Then
										For i=0 To 1 Step 1
											If file(i) <> "" Then
												Ext = LCase(Mid(file(i), Instr(file(i), ".") + 1))

												If Ext = "avi" Or Ext = "wmv" Or Ext = "asf" Then
								%>
									<embed src="/upload/<%=bbs%>/<%=ofile(i)%>" width="640" height="480"></embed>
								<%
												ElseIf Ext = "swf" Then
								
								%>
									<EMBED src="/upload/movie/<%=ofile(i)%>" width="640" height="480" type="application/x-shockwave-flash"></EMBED>
								<%
												Else
												End If
											End If
										Next
									End If
								%>
								<%
									If board_type = "mapmovie" Then
										For i=0 To 1 Step 1
											If file(i) <> "" Then
												Ext = LCase(Mid(file(i), Instr(file(i), ".") + 1))

												If Ext = "avi" Or Ext = "wmv" Or Ext = "asf" Then
								%>
									<embed src="/upload/<%=bbs%>/<%=ofile(i)%>" width="640" height="480"></embed>
								<%
												ElseIf Ext = "swf" Then
								
								%>
									<EMBED src="/upload/mapmovie/<%=ofile(i)%>" width="640" height="480" type="application/x-shockwave-flash"></EMBED>
								<%
												Else
												End If
											End If
										Next
									End If
								%>


									<%=bContent%>
								<%
									If bbs = "qna" Then
										'sql = "select Top 2 btitle, bcontent from " & bbs & " where bgid = '" & bidx & "' and bDepth > 1 order by bidx asc"
										sql = "select bidx, btitle, bcontent, bOrgFileName1, bOrgFileName2, bFileName1, bFileName2  from " & bbs & " where bgid = '" & bidx & "' and bDepth > 1 order by bidx asc"

										GetRs Rs, sql

										If Not Rs.EOF Or Not Rs.BOF Then
											Do Until Rs.EOF

											Dim re_file(1), re_ofile(1)

											re_file(0) = Rs("bOrgFileName1")
											re_file(1) = Rs("bOrgFileName2")

											re_ofile(0) = Rs("bFileName1")
											re_ofile(1) = Rs("bFileName2")

											rebidx = Rs("bidx")
									
											Response.Write "<br><br><img src='/images/board/faq_ok.gif' border='0' align='absmiddle'> " & Rs("btitle")


											For j = 0 To 1 Step 1
													If re_file(j) <> "" Then
														response.write "<br><br><a href='filedown.asp?bbs="& bbs &"&idx="& Rs("bidx") &"&num="& j+1 &"'><img src='/images/board/btn_download.gif' align='absmiddle'></a>&nbsp;"& re_file(j)
													End If 
											next


											Response.Write "<br><br>" & reverse_quot(Rs("bcontent"))

											Rs.MoveNext
											Loop



										End If

										DBCLOSE(Rs)
									End If
								%>
								</td>
							</tr>
							<tr>
								<td height="20" colspan="4">&nbsp;</td>
							</tr>
							<%If rebidx<>"" Then%>
							<tr>
								<td height="12" align="left"><%If Session("Admin_id")<>"" Then%><a href="index.asp?mode=modify&bidx=<%=rebidx%>&bbs=<%=bbs%>"><img src="/images/board/view_btn_modify.gif" align="absmiddle"></a><%End If%></td>
							</tr>
							<%End If%>
							
							<tr>
								<td height="58" colspan="4">&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="6px;" colspan="3"></td>
				</tr>
				
				<!-- 이전글 -->
				<%
					If bbs = "qna" Then
						sql = "select top 1 bidx, btitle from " & bbs & " where bnotice = 2 and bDepth = 1 and bidx < " & bidx
					Else
						sql = "select top 1 bidx, btitle from " & bbs & " where bnotice = 2 and bidx < " & bidx
					End If

					GetRs Rs, sql

					If Not Rs.EOF Or Not Rs.BOF Then
				%>
				<tr bgcolor="#f9f9f9" class="odd">
					<td height="21" colspan="3" style="padding-left:24px;" class="title3"><img src="/images/board/view_icon2.gif" align="absmiddle"><span style="padding-left:9px;"><a href="index.asp?mode=view&bbs=<%=bbs%>&bidx=<%=Rs("bidx")%>"><%=Rs("btitle")%></a></span></td>
				</tr>
				<%
					End If

					DBCLOSE(Rs)

					If bbs = "qna" Then
						sql = "select top 1 bidx, btitle from " & bbs & " where bnotice = 2 and bDepth = 1 and bidx > " & bidx
					Else
						sql = "select top 1 bidx, btitle from " & bbs & " where bnotice = 2 and bidx > " & bidx
					End If

					GetRs Rs, sql

					If Not Rs.EOF Or Not RS.BOF Then
				%>
				<tr bgcolor="#f9f9f9" class="odd2">
					<td height="21" colspan="3" style="padding-left:24px;" class="title3"><img src="/images/board/view_icon2.gif" align="absmiddle"><span style="padding-left:9px;"><a href="index.asp?mode=view&bbs=<%=bbs%>&bidx=<%=Rs("bidx")%>"><%=Rs("btitle")%></a></td>
				</tr>
				<%
					End If

					DBCLOSE(Rs)
				%>

				<tr>
					<td align="right" colspan="3"><br><a href onclick="chk_del('<%=bidx%>', '<%=bbs%>'); return false;" style="cursor:pointer;"><img src="/images/board/del_btn_list.gif" align="absmiddle"></a>&nbsp;<a href="index.asp?mode=write&bbs=<%=bbs%>"><img src="/images/board/list_btn_write.gif" border="0" align="absmiddle"></a>&nbsp;<a href="index.asp?mode=modify&bidx=<%=bidx%>&bbs=<%=bbs%>"><img src="/images/board/view_btn_modify.gif" align="absmiddle"></a><%If rebidx="" Then%>&nbsp;<a href="index.asp?mode=reply&bidx=<%=bidx%>&bbs=<%=bbs%>"><img src="/images/board/view_btn_reply.gif" align="absmiddle"></a>
					<%End If%>&nbsp;<a href="index.asp?bbs=<%=bbs%>&search=<%=search%>&keyword=<%=keyword%>&page=<%=page%>"><img src="/images/board/view_btn_list.gif" align="absmiddle"></a></td>
				</tr>
				<tr>
					<td height="700">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="15">&nbsp;</td>
	</tr>
</table>
