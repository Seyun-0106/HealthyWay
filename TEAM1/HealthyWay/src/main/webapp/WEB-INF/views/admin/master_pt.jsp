<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<style>
ul, li {
	margin: 0;
	padding: 0;
	list-style: none;
}

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
#container{
	margin:4%;
	padding-top:1%;
	padding-left:4%;
	padding-right:4%;
	font-family: "NanumBarunGothic";
}
/*검색창*/
#searchFrm{
	overflow:auto;
	width:385px;
	margin-right:2%;
	float:right;
}
#searchFrm>input[type=text]{
	width:300px;
	height:30px;
	padding-left:5px;
	border-radius:10px;
	border:1px solid rgb(200,200,200);
}
#searchFrm>input[type=text]:focus{
	outline-color: #FF5454;
}
#searchFrm>input[type=submit]{
	width:75px;
	height:30px;
	margin-left:5px;
	border-radius: 30px;
	border:none;
	background-color: #FF5454;
	color:white;
}
.menu_list {
	text-align: right;
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
.table{
	text-align: center;
	table-layout: fixed;
}

.table td{
	overflow: hidden;
	text-overflow: ellipsis;
}

.table>tbody>tr{
	cursor: pointer;
	overflow:hidden;
	text-overflow:ellipsis;
	white-space:nowrap;
}
#deletBtn{
	width:75px;
	height:30px;
	border-radius: 30px;
	border:none;
	background-color: #FF5454;
	color:white;
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

/*회원 신고 div*/
#reportDiv{
	width:100%;
	height:100%;
	overflow:auto;
	background-color: pink;
	display: none;
}
@media ( min-width: 1800px ) {
	#container{
		padding-left:6%;
		padding-right:6%;
	}
	#searchFrm{
		width:20%;
		margin-right:1%;
	}
}
</style>

<script>

	//pt그룹 삭제
	function deleteGroup(board_num){
		event.stopPropagation();	//tr onclick 이벤트 막기
		
		if(!confirm("그룹을 삭제하시겠습니까?")){
			return false;
		}
		
		$.ajax({
			url: '/master/boardDelete',
			data: 'board_num='+board_num,
			type: 'post',
			success: function(result){
				if(result>0){
					alert("그룹이 삭제되었습니다.");
				}
				location.reload();
			},
			error: function(e){
				console.log(e.responseText);
				alert("그룹 삭제 실패하였습니다.");
			}
		});
	}
</script>

<div id="container">

	<!-- 메뉴 -->
	<ul class="menu_list">
		<li id="menu_ptGroup" class="menu_active">PT 그룹관리</li>
	</ul>
	<form method="get" action="/master/ptGroup" id="searchFrm">
		<input type="text" name="searchWord"/>
		<input type="submit" value="검색"/>
	</form>
	<!-- 회원 관리 -->
	<div id="manageDiv">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>번호</th>
					<th>리더</th>
					<th style="width:10%;">그룹명</th>
					<th style="width:30%;">내용</th>
					<th>참여인원</th>
					<th>생성일</th>
					<th>모집현황</th>	
					<th>삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="vo" items="${vo}">
					<tr onclick="window.open('/board/ptView?board_num=${vo.board_num}');">
						<td>${vo.board_num}</td>
						<td>${vo.user_id}</td>
						<td style="width:10%;">${vo.title}</td>
						<td style="width:30%;">${vo.content}</td>
						<td>${vo.pNum}/${vo.max_user}</td>
						<td>${vo.write_date}</td>
						<td>${vo.state}</td>
						<td><button id="deletBtn" onclick="deleteGroup('${vo.board_num}');">삭제</button></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
			 <!-- 페이징 -->
	    <ul class="paging">
	    	<!-- prev -->
	    	<c:if test="${pVO.pageNum==1}">
	    		<li>◀</li>
	    	</c:if>
	    	<c:if test="${pVO.pageNum>1}">
	    		<li><a href="/master/ptGroup?pageNum=${pVO.pageNum-1}
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
	    			<a href="/master/ptGroup?pageNum=${p}
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
	    		<li><a href="/master/ptGroup?pageNum=${pVO.pageNum+1}
	    			<c:if test='${pVO.searchWord!=null}'>
	    				&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}
	    			</c:if>">▶</a></li>
	    	</c:if>
	    </ul>
    </div>
</div>