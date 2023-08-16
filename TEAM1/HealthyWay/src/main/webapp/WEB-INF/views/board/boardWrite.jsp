<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="${url}/css/board/boardWrite.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

<script>
$(function() {
	// 글등록 버튼 누르면 submit 실행
    $("#writeBtn").on("click",function() {
       if ($("#title").val() == "") {
          alert("글 제목을 입력하세요");
       }else if ($("#content").val() == "") {
           alert("내용을 입력하세요");
       }else{
    	   event.preventDefault();

			var params = new FormData($("#writeFrm")[0]);

			$.ajax({
				url : "${url}/boardWrite",
				data : params,
				method : 'post',
				processData : false,
				contentType : false,
				success : function(result) {
					alert("공지사항 글등록이 되었습니다.");
					location = "/master/notice";
				},
				error : function(e) {
					alert("공지사항 글등록에 실패했습니다.");
					console.log(e.responseText);
				}
			});
       }
    });
	
	// 글등록 버튼 색변경
	$("#writeBtn").hover(function(){
		$(this).css("background-color", "#fff").css("border", "1px solid #bdbdbd").css("color", "#000");
	}, function(){
		$(this).css("background-color", "#ff5454").css("border", "1px solid #ff5454").css("color", "#fff");
	});
 });
</script>

<div class="wrap">
	 <form id="writeFrm" method="post" action="${url}/boardWrite">
		<ul id="writeFrm_wrap">
			<li>
				<select name="type_num" id="type_num">
					<option id="notice" value="4" selected>공지사항</option>
				</select>
			</li>
			<li id="title_wrap">
				<input type="text" name="title" id="title" placeholder="제목">
			</li>
			<li>
				<textarea name="content" id="content" placeholder="내용을 입력해주세요!"></textarea>
			</li>
		</ul>
	</form>
</div> 
<div class="writeBtn_wrap">
	<input class="writeBtn" type="button" id="writeBtn" value="등록">
</div> 