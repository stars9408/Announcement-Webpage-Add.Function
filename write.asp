<!--#include virtual="/admin/include/admin_check.asp" -->
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8">
<%
	bbs = Trim(Request.QueryString("bbs"))
	page = Trim(Request.QueryString("page"))
	bidx = Trim(Request.QueryString("bidx"))
	mode = Trim(Request.QueryString("mode"))


	' 수정시
	If mode = "modify" Then
		sql = "select * from " & bbs & " where bidx = '" & bidx & "'"

		GetRs Rs, sql

		If Not Rs.EOF Or Not Rs.BOF Then
			bTitle = Trim(Rs("bTitle"))
			burl = Trim(Rs("burl"))
			m_summary = Trim(Rs("bSummary"))
			m_bcontent = Trim(Rs("bContent"))
			m_bnotice = Trim(Rs("bnotice"))
			m_bcategory = Trim(Rs("bcategory"))
			m_bShortment = Trim(Rs("bShortment"))
			bperiod1 = Trim(Rs("bperiod1"))
			bperiod2 = Trim(Rs("bperiod2"))

		Else
			Response.Write "<script>alert('삭제되었거나 잘못된 접근입니다.');history.go(-1);</script>"
			Response.End
		End If

		DBCLOSE(Rs)
	End If

	'리플시
	If mode = "reply" Then
		sql = "select * from " & bbs & " where bidx = '" & bidx & "'"

		GetRs Rs, sql

		If Not Rs.EOF Or Not Rs.BOF Then
			bGid = Rs("bGid")
			bNid = bidx
			bDepth = Rs("bDepth") + 1
		Else
			Response.Write "<script>alert('삭제되었거나 잘못된 접근입니다.');history.go(-1);</script>"
			Response.End
		End If

		DBCLOSE(Rs)
	End If
%>
<script type="text/javascript" src="/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
	//cheditor 개체를 생성합니다.
	//var myeditor = new cheditor("myeditor");

	//에디터에 입력한 모든 내용을 가져옵니다.
	//myeditor.outputHTML()

	//에디터에 입력한 내용 중 <body>...</body> 내용만 가져옵니다.
	//myeditor.outputBodyHTML()

	//HTML 태그를 제외한 순수 입력 글자들만 가져 옵니다.
	//myeditor.outputBodyText()

	chk_form = function(){
		var f = document.Form_write;

		if(!f.btitle.value){
			alert('제목을 넣어 주세요.');
			f.btitle.focus();
			return false;
		}

		//if(myeditor.outputBodyText() == ''){
		//	alert('내용을 적어 주세요.');
		//	return myeditor.returnFalse();
		//}

		//f.fm_post.value = myeditor.outputBodyHTML();
	}

	chk_notice = function(val){
		for(var i=0; i<2; i++){
			if(i != val)
				document.getElementsByName('bNotice')[i].checked = false;
		}
	}
</script>
<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%" bgcolor="#ffffff">
	<tr>
		<td width="15">&nbsp;</td> <!-- 첫칸 -->
		<td width="700"> <!-- 둘째칸 -->
			<table cellspacing="0" cellpadding="0" border="0" width="700" >
				<tr>
					<td colspan="3"><img src="/images/base/line.gif"></td>
				</tr>
				<form name="Form_write" enctype="multipart/form-data" method="post" action="save.asp" onSubmit="return chk_form();">
				<input type="hidden" name="mode" value="<%=mode%>">
				<input type="hidden" name="bbs" value="<%=bbs%>">
				<input type="hidden" name="page" value="<%=page%>">
				<input type="hidden" name="bidx" value="<%=bidx%>">
				<input type="hidden" name="bGid" value="<%=bGid%>">
				<input type="hidden" name="bNid" value="<%=bNid%>">
				<input type="hidden" name="bDepth" value="<%=bDepth%>">
				<input type="hidden" name="bUserid" value="<%=Session("Admin_id")%>">
				<input type="hidden" name="bName" value="<%=Session("Admin_name")%>">

				<tr>
					<td colspan="3"  width="700" valign="top">
						<table cellspacing="0" cellpadding="0" border="0" id="cont" bgcolor="#f9f9f9" height="376" width="100%">
							<tr>
								<td width="85" height="36" align="center" valign="center" class="title7 fw">제목</td>
								<td><input type="text" name="btitle" size="73" value="<%=btitle%>"></td>
							</tr>
						<%If bbs="movie" Or bbs="movie2" Then%>
							<tr>
								<td width="85" height="36" align="center" valign="center" class="title7 fw">링크URL</td>
								<td><input type="text" name="burl" size="73" value="<%=burl%>"></td>
							</tr>
						<%End If %>

							<tr>
								<td width="85" height="36" align="center" valign="center" class="title7 fw">옵션</td>
								<td><!--<input type="checkbox" name="bShortment" value="1" style="border:0px;" <% If m_bShortment = "1" Then Response.Write "checked" End If %>>간략글 없음(이벤트/공지 간략글 표시 안함) &nbsp;--><input type="checkbox" name="bNotice" value="1" style="border:0px;" <% If m_bNotice = 1 Then Response.Write "checked" End If %> onclick="chk_notice(0);" >공지글 &nbsp;<input type="checkbox" name="bNotice" value="3" style="border:0px;" <% If m_bNotice = 3 Then Response.Write "checked" End If %> onclick="chk_notice(1);" >이벤트 &nbsp;</td>
							</tr>
							<tr>
								<td width="85" height="36" align="center" valign="center" class="title7 fw">기간</td>
								<td><input type="date" name="bperiod1" size="73" value="<%=bperiod1%>"> ~
								<input type="date" name="bperiod2" size="73" value="<%=bperiod2%>"></td>
							</tr>
							<%
								If board_temp <> "" Then
							%>
				
							<tr>
								<td width="85" height="36" align="center" valign="center" class="title7 fw">카테고리</td>
								<td>
									<select name="bCategory">
										<option value="">====</option>
									<%
										For i=0 To board_category_len Step 1
									%>
										<option value="<%=board_category(i)%>" <% If m_bcategory = Trim(board_category(i)) Then Response.Write "selected" End If %> ><%=board_category(i)%></option>
									<%
										Next
									%>
									</select>
								</td>
							</tr>
					
							<%
								End If
							%>
							<tr>
								<td valign="middle" width="85" align="center" class="title7 fw">간략내용</td>
								<td valign="top" >
								<textarea id="" name="Summary" style="width:100%;height:70px;"><%=m_summary%></textarea> 
								</td>
							</tr>
							<tr>
								<td valign="middle" width="85" align="center" class="title7 fw">내용</td>
								<td valign="top" >
								<textarea id="editor1" name="editor1" style="width:100%;height:200px;"><%=m_bcontent%></textarea> 
								<script>
									var editor = CKEDITOR.replace('editor1',
									 {
										// height: "300";
										filebrowserImageUploadUrl : '/ckeditor/upload_file.asp?command=QuickUpload&type=Images'

									 }); 
								</script>
								</td>
							</tr>
							<tr>
								<td height="10" colspan="2"></td>
							</tr>

						<%If Trim(bbs)="notice" Then%>
							<tr >
								<td width="85" height="36" align="center" valign="center" class="title7 fw">메인이미지</td>
								<td><input type="file" name="file1" size="73"><br>(JPG, GIF, PNG)</td>
							</tr>
							<tr >
								<td width="85" height="36" align="center" valign="center" class="title7 fw">서브이미지</td>
								<td><input type="file" name="file2" size="73"><br>(JPG, GIF, PNG)</td>
							</tr>

						<%Else%>
							<tr >
								<td width="85" height="36" align="center" valign="center" class="title7 fw">첨부파일</td>
								<td><input type="file" name="file2" size="73"></td>
							</tr>
						<%End If%>					
						</table>
					</td>
				</tr>
				<tr>
					<td align="right" colspan="3" style="padding-top:6px;"><input type="image" src="/images/board/write_btn_ok.gif">&nbsp;<a href="index.asp?bbs=<%=bbs%>&page=<%=page%>"><img src="/images/board/write_btn_list.gif"></a></td>
				</tr>
				</form>
				<tr>
					<td height="253"></td>
				</tr>
			</table>
		</td>
		<td width="15">&nbsp;</td><!-- 세째칸 -->
	</tr>
</table>
