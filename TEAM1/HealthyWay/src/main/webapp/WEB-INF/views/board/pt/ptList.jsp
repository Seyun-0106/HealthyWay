<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="${url}/css/board/pt/ptList.css"
	type="text/css" />
<link rel="stylesheet"
	href="https://fonts.sandbox.google.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<script src="${url}/js/board/pt/ptList.js"></script>
<script>
	$(function() {
		$(document).ready(function() {
			setHeart();
		});

		$(".line_heart").click(function() {
			var num = $(this).attr("id").substring(2);
			insertHeart(num);
			return false;
		});

		$(".fill_heart").click(function() {
			var num = $(this).attr("id").substring(2);
			deleteHeart(num);
			return false;
		});
	});

	function btn_notlogin() {
		alert("로그인 후 이용해 주세요.");
		location.href = "/member/loginForm";
	};

	function setHeart() {
		$.ajax({
			url : "/board/ptSelectHeart",
			type : 'post',
			success : function(result) {
				if (result.length > 0) {
					$(result).each(function() {
						var boardNum = this.board_num;
						$("#u_" + boardNum).css("display", "none");
						$("#f_" + boardNum).css("display", "block");
					});
				}
			}
		});
	};

	function insertHeart(boardNum) {
		$.ajax({
			url : "/board/ptInsertHeart",
			type : "post",
			data : "board_num=" + boardNum,
			success : function(result) {
				$("#u_" + boardNum).css("display", "none");
				$("#f_" + boardNum).css("display", "block");
			},
			error : function(e) {
				console.log(e.responseText);
			}
		});
	}

	function deleteHeart(boardNum) {
		$.ajax({
			url : "/board/ptDeleteHeart",
			type : "post",
			data : "board_num=" + boardNum,
			success : function(result) {
				$("#u_" + boardNum).css("display", "block");
				$("#f_" + boardNum).css("display", "none");
			},
			error : function(e) {
				console.log(e.responseText);
			}
		});

	}
</script>
<div class="head_img">
	<%-- <img src="${url}/img/ptList_top.png"> --%>
	<video muted autoplay loop id="video">
		<source src="${url}/img/ptVideo.mp4" type="video/mp4">
	</video>
	<h1>FIND YOUR HEALHTY MATE</h1>
	<p>당신과 함께 운동할 헬씨 친구들을 찾으세요!</p>
</div>
<div class="wrap">



	<div class="main_wrap">
		<!-- <h2 class="post_head">모집중인 PT그룹</h2> -->
		<div class="pt_top_btn_wrap">
			<div class="top_left_wrap">
				<form method="get" action="${url}/board/ptList" id="recuFrm">
					<input type="hidden" name="state" value="모집중">
					<button id="recu_btn">모집중</button>
				</form>
				<form method="get" action="${url}/board/ptList" id="compleFrm">
					<input type="hidden" name="state" value="모집완료">
					<button id="completed_btn">모집완료</button>
				</form>
			</div>
			<div class="top_right_wrap">
				<!-- 검색 -->
				<form method="get" action="${url}/board/ptList" id="searchFrm">
					<div class="search_box">
						<input type="text" placeholder="Search" name="searchWord"
							id="searchWord">
						<button id="searchBtn">
							<span class="material-symbols-outlined">search</span>
						</button>
					</div>
				</form>
				<!-- 글쓰기 -->
				<c:if test="${logStatus == 'Y'}">
					<button id="write_btn"
						onclick="location.href='${url}/board/ptWrite'">글쓰기</button>
				</c:if>
			</div>
		</div>


		<div class="pt_list_wrap">
			<c:forEach var="vo" items="${ptList}">
				<ul class="pt_post_wrap">
					<li class="main_img_wrap"
						onclick="location.href='${url}/board/ptView?board_num=${vo.board_num}'"><img
						src="/ptImg/${vo.pt_img_file}"></li>
					<li	onclick="location.href='${url}/board/ptView?board_num=${vo.board_num}'">${vo.keyword}</li>
					<li onclick="location.href='${url}/board/ptView?board_num=${vo.board_num}'">${vo.title}</li>
					<li	onclick="location.href='${url}/board/ptView?board_num=${vo.board_num}'">조회수 ${vo.hit}</li>
					<li	onclick="location.href='${url}/board/ptView?board_num=${vo.board_num}'">${vo.write_date}</li>
					<li class="post_bottom" onclick="location.href='${url}/board/ptView?board_num=${vo.board_num}'">${vo.state}&nbsp;&nbsp;${vo.pNum} / ${vo.max_user}</li>
					<li class="post_bottom"
						<c:if test="${logStatus != 'Y'}">onclick="btn_notlogin();"</c:if>>
						<c:choose>
							<%-- 로그인 상태일 때 --%>
							<c:when test="${logStatus == 'Y'}">
								<span class="material-symbols-rounded line_heart"
									id="u_${vo.board_num}">favorite</span>
								<span class="material-symbols-rounded fill_heart"
									id="f_${vo.board_num}" style="display: none;">favorite</span>
							</c:when>

							<%-- 로그인 상태가 아닐 때, 로그인 alert --%>
							<c:otherwise>
								<span class="material-symbols-rounded line_heart">favorite</span>
							</c:otherwise>

						</c:choose>
					</li>

					<li style="display: none;">${vo.board_num}</li>
				</ul>
			</c:forEach>
		</div>

		<!-- 페이징 -->
		<div class="paging_wrap">
			<ul class="paging">
				<!-- 이전페이지 -->
				<c:if test="${pVO.pageNum == 1}">
					<li style="color: lightgray"><</li>
				</c:if>
				<c:if test="${pVO.pageNum > 1}">
					<li><a
						href="${url}/board/ptList?pageNum=${pVO.pageNum-1}<c:if test='${pVO.state!=null}'>&state=${pVO.state}</c:if><c:if test='${pVO.searchWord!=null}'>&searchWord=${pVO.searchWord}</c:if>"><</a></li>
				</c:if>

				<!-- 페이지번호 -->
				<c:forEach var="p" begin="${pVO.startPage}"
					end="${pVO.startPage + pVO.onePageCount-1}">
					<c:if test="${p<=pVO.totalPage}">
						<c:if test="${p==pVO.pageNum}">
							<li class="select_p">
						</c:if>
						<c:if test="${p != pVO.pageNum}">
							<li>
						</c:if>
						<a href="${url}/board/ptList?pageNum=${p}<c:if test='${pVO.state!=null}'>&state=${pVO.state}</c:if><c:if test='${pVO.searchWord!=null}'>&searchWord=${pVO.searchWord}</c:if>">${p}</a>
						</li>
					</c:if>
				</c:forEach>

				<!-- 다음페이지 -->
				<c:if test="${pVO.pageNum != pVO.totalPage}">
					<li><a
						href="${url}/board/ptList?pageNum=${pVO.pageNum+1}<c:if test='${pVO.state!=null}'>&state=${pVO.state}</c:if><c:if test='${pVO.searchWord!=null}'>&searchWord=${pVO.searchWord}</c:if>">></a></li>
				</c:if>
				<c:if test="${pVO.pageNum == pVO.totalPage}">
					<li style="color: lightgray">></li>
				</c:if>
			</ul>
		</div>

	</div>
</div>