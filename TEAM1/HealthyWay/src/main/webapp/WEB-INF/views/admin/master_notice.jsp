<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<style>
/*a태그 설정*/
a:link {
	color: black;
	text-decoration: none;
}

a:visited {
	color: black;
	text-decoration: none;
}

a:hover {
	color: black;
	text-decoration: none;
}

@font-face {
	font-family: 'NanumBarunGothic';
	font-style: normal;
	font-weight: 400;
	src:
		url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.eot');
	src:
		url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.eot?#iefix')
		format('embedded-opentype'),
		url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.woff')
		format('woff'),
		url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.ttf')
		format('truetype');
}

body {
	font-family: "NanumBarunGothic";
}

ul, li {
	margin: 0;
	padding: 0;
	list-style: none;
}

#container{
	margin:4%;
	padding-top:1%;
	padding-left:4%;
	padding-right:4%;
}
#manageDiv{
	position: relative;
}
#searchFrm{
	position:absolute;
	bottom:10px;
	right:58px;
}
#searchFrm>input[type=text]{
	width:250px;
	height:30px;
	padding-left:2%;
	margin-right:5px;
	border-radius:10px;
	border:1px solid rgb(200,200,200);
}
#searchFrm>input[type=text]:focus{
	outline-color: #FF5454;
}
#searchFrm>input[type=submit]{
	width:75px;
	height:30px;
	border-radius: 30px;
	border:none;
	background-color: #FF5454;
	color:white;
}
.menu_list {
	text-align: right;
	overflow: auto;
}
.menu_list>li {
    float: left;
    width: 24.77%;
    text-align: center;
    height: 50px;
    line-height: 50px;
    border: 1px solid #E4E5E5;
    border-bottom: 1px solid gray;
    border-left: none;
    background-color: #FCFCFC;
    cursor: pointer;
    color: gray;
}

.menu_active {
	border: 1px solid gray !important;
	border-bottom: none !important;
	background-color: #fff !important;
	color: #000 !important;
}

.writeBtn_wrap{
	width: 97%;
	text-align: right;
	margin-right: 3%;
	margin-top: 20px;
}

.writeBtn_wrap button{
	background-color: #FF5454;
    color: #fff;
    padding: 5px 20px;
    border: 1.5px solid #ff5454;
    border-radius: 4px;
    height: 33px;
    cursor: pointer;
}

#category_list{
	text-align: right;
}
#category_list>li{
	display:inline-block;
	margin-left:0.6%;
}
#category_list>li:hover{
	text-decoration: underline;
}
.table{
	text-align: center;
}
.table>tbody>tr{
	cursor: pointer;
	overflow:hidden;
	text-overflow:ellipsis;
	white-space:nowrap;
}
#deleteBtn{
	width:75px;
	height:30px;
	border-radius: 30px;
	border:none;
	background-color: #FF5454;
	color: white;

}

.paging{
	text-align: center;
	margin:0 auto;
	margin-top:3%;
	width:85%;
	height:27px;
}
.paging>li{
	display:inline-block;
	width:2%;
	height:27px;
	line-height:30px;
	text-align:center;
	font-size:16px;
	margin-right:0.1%;
	border-radius:10px;
	background-color: rgb(235,235,235);
}
.active, .active>a{
	color:white;
	background-color:#FF5454 !important;
}


@media ( min-width: 1800px ) {
	#container{
		padding-left:7%;
		padding-right:7%;
	}	
	#searchFrm{
		bottom:10px;
		right:125px;
	}
}
</style>

<script>	
$(function(){
	//커뮤니티 관리 메뉴 클릭 이벤트
	$("#menu_community").click(function(){
		console.log("aaa");
		location="/master/community";
	});
		
	//공지사항 메뉴 클릭 이벤트
	$("#menu_notice").click(function(){
		location="/master/notice";
	});
});
	//글 삭제
	function deleteBoard(board_num){
		event.stopPropagation();//tr onclick 중복 제거
		
		if(!confirm("게시글을 삭제하시겠습니까?")){
			return false;
		}
		
		$.ajax({
			url: '/master/boardDelete',
			data: 'board_num='+board_num,
			type: 'post',
			success: function(result){
				if(result>0){
					alert("게시글이 삭제되었습니다.");
				}
				location.reload();
			},
			error: function(e){
				console.log(e.responseText);
				alert("게시글 삭제 실패하였습니다.");
			}
		});
		
	}
</script>

<div id="container">

	<!-- 메뉴 -->
	<ul class="menu_list">
		<li id="menu_community">커뮤니티 관리</li>
		<li id="menu_notice" class="menu_active">공지사항</li>
	</ul>
	<!-- 공지사항 관리 -->
	<div id="manageDiv">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>번호</th>
					<th>작성자</th>
					<th style="width:30%;">제목</th>
					<th>조회수</th>
					<th>작성일</th>
					<th>삭제</th>	
				</tr>
			</thead>
			<tbody>
				<c:forEach var="vo" items="${vo}">
					<c:if test="${vo.type_num==4}">

						<tr onclick="window.open('${url}/board/boardList/${vo.board_num}');">

					</c:if>
						<td>${vo.board_num}</td>
						<td>${vo.user_id}</td>
						<td style="width:35%;">${vo.title}</td>
						<td>${vo.hit}</td>
						<td>${vo.write_date}</td>
						<td><button id="deleteBtn" onclick="deleteBoard('${vo.board_num}');">삭제</button></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	
		<div class="writeBtn_wrap">
			<button id="writeBtn" onclick="location.href='${url}/boardWrite'">글쓰기</button>
		</div>
	<!-- 페이징 -->
	    <ul class="paging">
	    	<!-- prev -->
	    	<c:if test="${pVO.pageNum==1&&pVO.totalRecord>0}">
	    		<li>◀</li>
	    	</c:if>
	    	<c:if test="${pVO.pageNum>1}">
	    		<li><a href="/master/notice?pageNum=${pVO.pageNum-1}
	    		<c:if test='${pVO.searchWord!=null}'>
	    			&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}
	    		</c:if>">◀</a></li>
	    	</c:if>
	    	
	    	<!-- pageNum -->
	    	<c:forEach var="p" begin="${pVO.startPage}" end="${pVO.startPage+pVO.onePageCount-1}">
	    		<c:if test="${p<=pVO.totalPage}">
	    			<c:if test="${p==pVO.pageNum}">
	    				<li class="active">
	    			</c:if>
	    			<c:if test="${p!=pVO.pageNum}">
	    				<li>
	    			</c:if>
	    			<a href="/master/notice?pageNum=${p}
		    			<c:if test='${pVO.searchWord!=null}'>
		    				&searchKey=${pVO.searchKey}
		    				&searchWord=${pVO.searchWord}
		    			</c:if>
	    			">${p}</a></li>
	    		</c:if>
	    	</c:forEach>
	    	
	    	<!-- next -->
	    	<c:if test="${pVO.pageNum==pVO.totalPage}">
	    		<li>▶</li>
	    	</c:if>
	    	<c:if test="${pVO.pageNum<pVO.totalPage}">
	    		<li><a href="/master/notice?pageNum=${pVO.pageNum+1}
	    			<c:if test='${pVO.searchWord!=null}'>
	    				&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}
	    			</c:if>">▶</a></li>
	    	</c:if>
	    </ul>
	    
	    <form method="get" action="/master/notice" id="searchFrm">
	      <input type="text" name="searchWord"/>
	      <input type="submit" value="검색"/>
	    </form>
    </div>
    
</div>