<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="${url}/css/board/boardList.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@48,400,0,0" />

<script>
	$(function() {
		$("#searchFrm").submit(function(event) {

			if ($("#searchWord").val() == "") {
				alert("검색어를 입력하세요");
				return false;
			}
		});

		$("#writeBtn").hover(
				function() {
					$(this).css("background-color", "#fff").css("border",
							"1.5px solid #d3d3d3").css("color", "#000");
				},
				function() {
					$(this).css("background-color", "#ff5454").css("border",
							"1.5px solid #ff5454").css("color", "#fff");
				});
	});
</script>


<div class="wrap">
	<div class="menu_wrap">
		<ul class="menu_list">
			<li>Community</li>
			<li><a href="${url}/boardList">공지사항</a></li>
			<li><a href="${url}/board/suggestionList">자유게시판</a></li>
			<li>
				<div class="selected_menu">
					<div class="selected">
						<a href="${url}/successList">성공스토리</a>
					</div>
					<div>
						<span class="material-symbols-rounded">arrow_forward_ios</span>
					</div>
				</div>
			</li>
		</ul>
	</div>

	<div class="main_wrap">
		<h1>성공스토리</h1>
		<!-- 검색 -->
		<div class="search_wrap">
			<form method="get" action="" id="searchFrm">
				<select name="searchKey" class="search_cate">
					<option value="title">제목</option>
					<option value="content">글 내용</option>
					<option value="user_id">작성자</option>
				</select> <input type="text" name="searchWord" id="searchWord" /> <input
					type="submit" value="Search" class="search_btn" />
			</form>
		</div>

		<div class="all_post_wrap">
			<ul>
				<c:forEach var="vo" items="${list}">
					<li
						onclick="location.href='/successView?board_num=${vo.board_num}'">
						<div class="post_wrap">
							<div class="img_wrap">
								<div class="before_img">
									<img src="/successImg/${vo.img_file1}">
								</div>
								<div class="after_img">
									<img src="/successImg/${vo.img_file2}">
								</div>
							</div>
							<div class="content_wrap">
								<div class="title">${vo.title}</div>
								<div class="hit_date_wrap">
									<div class="hit">조회수 ${vo.hit}</div>
									<div class="date">${vo.write_date}</div>
								</div>
							</div>
						</div>
					</li>
				</c:forEach>
			</ul>
		</div>
		<div class="writeBtn_wrap">
			<button id="writeBtn" onclick="location.href='${url}/successWrite'">글쓰기</button>
		</div>
	</div>
</div>

