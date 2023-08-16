<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="${url}/css/board/boardList.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@48,400,0,0" />
<script>
	$(function(){
		$("#searchFrm").submit(function(){
			if($("#searchWord").val()==""){
				alert("검색어를 입력하세요");
				return false;
			}
		});
	});
</script>
	

<!-- <div class="top_img_wrap">
	<img src="/img/board2.jpg">
</div> -->

<div class="wrap">
	<div class="menu_wrap">
		<ul class="menu_list">
			<li>Community</li>
			<li>
				<div class="selected_menu">
					<div class="selected"><a href="${url}/boardList">공지사항</a></div>
					<div><span class="material-symbols-rounded">arrow_forward_ios</span></div>
				</div>
			</li>
			<li><a href="${url}/board/suggestionList">자유게시판</a></li>
			<li><a href="${url}/successList">성공스토리</a></li>
		</ul>
	</div>
	
	<div class="main_wrap">
		<h1>공지사항</h1>
		<!-- 검색 -->
		<div class="search_wrap">
			<form method="get" action="" id="searchFrm">
				<select name="searchKey" class="search_cate">
					<option value="title">제목</option>
					<option value="content">글 내용</option>
					<option value="user_id">작성자</option>
				</select> 
				<input type="text" name="searchWord" id="searchWord"/> 
				<input type="submit" value="Search" class="search_btn" />
			</form>
		</div>
		
		<ul class="notice_list">
			<li>번호</li>
			<li>작성자</li>
			<li>제목</li>
			<li>조회수</li>
			<li>작성일</li>
			
			<c:forEach var="vo" items="${boardList}">
				<li><img src="${url}/img/pin.png"></li>
				<li>${vo.user_id}</li>
				<li><a href="${url}/board/boardList/${vo.board_num}"> ${vo.title} </a></li>
				<li>${vo.hit}</li>
				<li>${vo.write_date}</li>
			</c:forEach>
		</ul>
		
		<div class="paging_wrap" style="margin-top: 40px;">
			<!-- 페이징 -->
			<ul class="paging">
				<!-- 이전페이지 -->
				<c:if test="${pvo.pageNum==1 }">
					<li><</li>
				</c:if>
				<c:if test="${pvo.pageNum>1 }">
					<li><a
						href="${url}/boardList?pageNum=${bvo.pageNum-1}<c:if test='${bvo.searchWord!=null}'>&searchWord=${bvo.searchWord}</c:if>"><</a></li>
				</c:if>
				<!-- 페이지 번호  -->
				<c:forEach var="p" begin="${pvo.startPage}"
					end="${pvo.startPage+pvo.onePageCount}">
					<!-- 총 페이지수 보다 출력할 페이지 번호가 작을 때 -->
					<c:if test="${p <= pvo.totalPage}">
						<c:if test="${p==pvo.pageNum }">
							<li style=""><a href="${url}/board?pageNum=${p}">${p}</a></li>
						</c:if>
						<c:if test="${p!=pvo.pageNum }">
							<li><a href=${url}/boardList?pageNum=${p}
								<c:if test='${pvo.searchWord!=null}'>&searchWord=${pvo.searchWord}</c:if>>${p}</a></li>
						</c:if>
					</c:if>
				</c:forEach>
				<!-- 다음 페이지  -->
				<c:if test="${pvo.pageNum == pvo.totalPage }">
					<li>></li>
				</c:if>
				<c:if test="${pvo.pageNum < pvo.totalPage }">
					<li><a
						href="${url}/boardList?pageNum=${pvo.pageNum+1}<c:if test='${pvo.searchWord!=null}'>&searchWord=${pvo.searchWord}</c:if>">></a></li>
				</c:if>
			</ul>
		</div>
	</div>
</div>

