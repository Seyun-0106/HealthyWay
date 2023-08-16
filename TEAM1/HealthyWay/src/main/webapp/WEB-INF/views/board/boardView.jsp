<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="${url}/css/board/boardView.css">

<script>
$(function(){
	// 댓글 목록
	function replyListAll(){
		var url = "${url}/reply/list";
		var params = "board_num=" + ${bvo.board_num};
		
		$.ajax({
			url: url,
			data: params,
			success: function(result){
				var $result = $(result);
				var tag = "<ul>";
				$result.each(function(idx, vo){
					tag += "<li class='reply_wrap'>";
					tag += "<div class='id_date_wrap'>";
					tag += "<div class='reply_id'>" + vo.user_id + "</div>";
					tag += "<div class='reply_date'>" + vo.reply_date + "</div>";
					tag += "</div>";
					tag += "<div class='content_btn_wrap'>";
					tag += "<div class='reply_contnet'>" + vo.content + "</div>";
					tag += "<div class='reply_btn_wrap'>";
					
					if(vo.user_id == '${logId}'){
						tag += "<button class='reply_edit_btn'>수정</button>";
						tag += "<button class='reply_del_btn' title='" + vo.reply_num + "'>삭제</button>";
					}
					tag += "</div>";
					tag += "</div>";
					
					/* 수정폼 */
					tag += "<div class='reply_edit_input' style='display: none'>";
					tag += "<form method='post' class='editFrm'>";
					tag += "<input type='hidden' name='reply_num' value='"+vo.reply_num+"'>";
					tag += "<input type='text' name='content' value='" + vo.content + "'>";
					tag += "<input type='submit' value='수정'>";
					tag += "</form></div>";
					tag += "</li>";
				});
				tag += "</ul>";
				
				$("#replyList").html(tag);
			},
			error: function(e){
				console.log(e.responseText);
			}
		});
	}
	
	// 댓글 등록
	$("#replyFrm").submit(function(){
		event.preventDefault();
		
		if($("#content").val() == ''){
			alert("내용을 입력 후 등록해 주세요.");
			return false;
		}else{
			var params = $("#replyFrm").serialize();
			
			$.ajax({
				url : "${url}/reply/writeOk",
				data : params,
				type : "post",
				success : function(result){
					$("#content").val("");
					
					// 댓글 목록 초기화
					replyListAll();
				},
				error : function(e){
					console.log(e.responseText)
				}
			});
		}
	});
	
	// 댓글 수정 버튼 누르면 폼 노출
	$(document).on("click", ".reply_edit_btn", function(){
		$(this).parent().parent().css("display", "none");
		$(this).parent().parent().next().css("display", "block");
	});
	
	// 댓글 수정(DB)
	$(document).on("submit", ".editFrm", function(){
		event.preventDefault();
		
		var url = "${url}/reply/editOk";
		var params = $(this).serialize();
		
		$.ajax({
			url: url,
			data: params,
			type: 'post',
			success: function(result){
				replyListAll();
			},
			error: function(e){
				console.log(e.responseText);
			}
		});
	});
	
	// 댓글 삭제(DB)
	$(document).on("click", ".reply_del_btn", function(){
		if(confirm("댓글을 삭제하시겠습까?")){
			var params = "reply_num="+$(this).attr("title");
			
			$.ajax({
				url : '${url}/reply/del',
				data : params,
				success : function(result){
					replyListAll();
				},
				error : function(e){
					console.log(e.responseText);
				}
			});
		}
	});
		
	replyListAll();
});
   

//글 삭제 확인
 function del(){
 	if(confirm("삭제하시겠습니까?")){
 			// 확인버튼 선택시
 			location.href = "${url}/boardDel?board_num=${bvo.board_num}";
 		}
 }
</script>

<div class="wrap">
	<h1>공지사항</h1>
	<ul id="viewList">
		<li class="title">${bvo.title}</li>
		<li class="write_date">${bvo.write_date}</li>
		<li class="hit">조회수 ${bvo.hit}</li>
		<li class="content">
			<textarea class="content_text" readonly>${bvo.content}</textarea>
		</li>
		<li class="writer">
			<div class="writer_profile" style="margin-bottom: 15px;">
				<div class="writer_img"><img src="${url}/img/${bvo.profie_img}"></div>
				<div class="writer_id">${bvo.user_id}</div>
			</div>
		</li>
		<c:if test="${logId == 'admin'}">
			<li class="report" style="border-bottom: none; margin: 15px 0 0;"></li>
			<li class="edit_del_wrap" style="border-bottom: none; margin: 15px 0 0;">
				<c:if test="${bvo.user_id == logId}">
					<button onclick="location='/board/boardEdit?board_num=${bvo.board_num}'">수정</button>
					<button id="btn_delete" onclick="location='javascript:del()'">삭제</button>
				</c:if>
			</li>
		</c:if>

	</ul>
	<!-- 댓글 -->
	<div class="reply_all_wrap" style="border-top: 1px solid #a4a4a4;">
		<h3>댓글</h3>
		<form method="post" id="replyFrm">
			<input type="hidden" name="board_num" value="${bvo.board_num}">
			<div class="reply_write_wrap">
			<input type="text" name="content" id="content" placeholder="댓글을 입력해주세요">
			<input type="submit" value="등록">
			</div>
		</form>
		<!-- 댓글 리스트 들어가는 자리 -->
		<div id="replyList">
		
		</div>
	</div>
	<div id="backBtn_wrap">
		<button onclick="location.href='/boardList'">목록</button>
	</div>
</div>