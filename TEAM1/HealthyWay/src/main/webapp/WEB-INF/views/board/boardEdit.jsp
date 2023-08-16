<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="${url}/css/board/boardWrite.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

<script>
$(function() {
	// 글등록 버트 누르면 submit 실행
    $("#writeBtn").on("click",function() {
       if ($("#title").val() == "") {
          alert("글 제목을 입력하세요");
       }else if ($("#content").val() == "") {
           alert("내용을 입력하세요");
           return false;}else{
    	   $("#writeFrm").submit();
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
	 <form id="writeFrm" method="post" action="${url}/board/boardEditOk">
		<ul id="writeFrm_wrap">
			<li>
				<select name="type_num" id="type_num">
					<option id="notice" value="4" selected>공지사항</option>
				</select>
			</li>
			<li id="title_wrap">
				<input type="text" name="title" id="title" placeholder="제목"  value="${bvo.title}">
			</li>
			<li>
				<textarea name="content" id="content" placeholder="내용을 입력해주세요!">${bvo.content}</textarea>
			</li>
			<li><input type="hidden" name="board_num" value="${bvo.board_num}"></li>
		</ul>
	</form>
</div> 
<div class="writeBtn_wrap">
	<input class="writeBtn" type="button" id="writeBtn" value="등록">
</div> 
    