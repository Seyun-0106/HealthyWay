<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<link rel="stylesheet" href="${url}/css/board/boardList.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@48,400,0,0" />

<script>
	$(function(){
		$("#searchFrm").submit(function(event){
			
			if($("#searchWord").val()== ""){
				alert("검색어를 입력하세요");
				return false;
			}
		});
		
		$("#writeBtn").hover(function(){
			$(this).css("background-color", "#fff").css("border", "1.5px solid #d3d3d3").css("color", "#000");
		}, function(){
			$(this).css("background-color", "#ff5454").css("border", "1.5px solid #ff5454").css("color", "#fff");
		});
	});

	
	
</script>

<div class="wrap">
	<div class="menu_wrap">
		<ul class="menu_list">
			<li>Community</li>
			<li><a href="${url}/boardList">공지사항</a></li>
			<li>
				<div class="selected_menu">
					<div class="selected"><a href="${url}/board/suggestionList">자유게시판</a></div>
					<div><span class="material-symbols-rounded">arrow_forward_ios</span></div>
				</div>
			</li>
			<li><a href="${url}/successList">성공스토리</a></li>
		</ul>
	</div>
	
	<div class="main_wrap">
		<h1>자유게시판</h1>
		<!-- 검색 -->
		<div class="search_wrap">
			<form method="get" action="" id="searchFrm">
				<select name="searchKey" class="search_cate">
					<option value="title">제목</option>
					<option value="content">글 내용</option>
					<option value="user_id">작성자</option>
				</select> 
				<input type="text" name="searchWord" id="searchWord" /> 
				<input type="submit" value="Search" class="search_btn" />
			</form>
		</div>
		
		<ul class="notice_list">
			<li>번호</li>
			<li>작성자</li>
			<li>제목</li>
			<li>조회수</li>
			<li>작성일</li>
			
			<c:forEach var="vo" items="${suggestionList}">
				<li>${vo.board_num}</li>
				<li>${vo.user_id}</li>
				<li><a href="${url}/board/suggestionList/${vo.board_num}"> ${vo.title} </a></li>
				<li>${vo.hit}</li>
				<li>${vo.write_date}</li>
			</c:forEach>
		</ul>
		<div class="writeBtn_wrap">
			<button id="writeBtn" onclick="location.href='${url}/suggestionWrite'">글쓰기</button>
		</div>
		
		<div class="paging_wrap">
			<!-- 페이징 -->
			<ul class="paging">
				<!-- 이전페이지 -->
				<c:if test="${spvo.pageNum==1 }">
				<li><</li>
				</c:if>
				<c:if test="${spvo.pageNum>1 }">
				<li><a href="${url}/board/suggestionList?pageNum=${bvo.pageNum-1}<c:if test='${bvo.searchWord!=null}'>&searchWord=${bvo.searchWord}</c:if>"><</a></li>
				</c:if>
				<!-- 페이지 번호  -->
				<c:forEach var="p" begin="${spvo.startPage}" end="${spvo.startPage+spvo.onePageCount}">
					<!-- 총 페이지수 보다 출력할 페이지 번호가 작을 때 -->
					<c:if test ="${p <= spvo.totalPage}">
						<c:if test="${p==spvo.pageNum }">
							<li style="font-size= 20px"><a href="${url}/board?pageNum=${p}">${p}</a></li>
						</c:if>
						<c:if test="${p!=spvo.pageNum }">
							<li><a href=${url}/board/suggestionList?pageNum=${p}<c:if test='${spvo.searchWord!=null}'>&searchWord=${spvo.searchWord}</c:if>>${p}</a></li>
						</c:if>
					</c:if>
				</c:forEach>
				<!-- 다음 페이지  -->
				<c:if test="${spvo.pageNum == spvo.totalPage }">
					<li>></li>
				</c:if>
				<c:if test="${spvo.pageNum < spvo.totalPage }">
					<li><a href="${url}/board/suggestionList?pageNum=${spvo.pageNum+1}<c:if test='${spvo.searchWord!=null}'>&searchWord=${spvo.searchWord}</c:if>">></a></li>
				</c:if>
			</ul>
		</div>
	</div>
</div>