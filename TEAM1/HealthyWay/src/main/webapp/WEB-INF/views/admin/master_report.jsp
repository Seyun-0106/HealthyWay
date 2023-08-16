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
/*a태그 설정*/
ul, li {
	margin: 0;
	padding: 0;
	list-style: none;
}
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
#searchFrm{
	overflow:auto;
	width:30%;
	float:right;
}
#searchFrm>input[type=text]{
	width:74%;
	height:30px;
	padding-left:2%;
	border-radius:10px;
	border:1px solid rgb(200,200,200);
}
#searchFrm>input[type=text]:focus{
	outline-color: #FF5454;
}
#searchFrm>input[type=submit]{
	width:25%;
	height:30px;
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
#reportBtn{
	width:75px;
	height:30px;
	border-radius: 30px;
	border:none;
	background-color: #FF5454;
	color: white;

}
#deleteReport{
	width:75px;
	height:30px;
	border-radius: 30px;
	border: 1px solid rgb(200,191,231);
	background-color:white;
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
		padding-left:7%;
		padding-right:7%;
	}
	#searchFrm{
		width:20%;
		margin-right:1%;
	}
}
</style>

<script>	
$(function(){
	var href = window.location.href;//현재 url 주소

	//주소에 따라 해당 카테고리 밑줄 css 적용
	if(href=="https://localhost:8088/master/report"){
		$("#category_list>li>a").eq(0).css("border-bottom", "3px solid #FF5454");	//전체
	}else if(href=="https://localhost:8088/master/report?searchKey=%EB%A0%88%EC%8B%9C%ED%94%BC"){
		$("#category_list>li>a").eq(1).css("border-bottom", "3px solid #FF5454");	//레시피
	}else if(href=="https://localhost:8088/master/report?searchKey=PT%EA%B7%B8%EB%A3%B9"){
		$("#category_list>li").eq(2).css("border-bottom", "3px solid #FF5454");	//pt그룹
	}else if(href=="https://localhost:8088/master/report?searchKey=%EC%84%B1%EA%B3%B5%EC%8A%A4%ED%86%A0%EB%A6%AC"){
		$("#category_list>li").eq(3).css("border-bottom", "3px solid #FF5454");	//성공스토리
	}else if(href=="https://localhost:8088/master/report?searchKey=%EC%9E%90%EC%9C%A0%EA%B2%8C%EC%8B%9C%ED%8C%90"){
		$("#category_list>li").eq(4).css("border-bottom", "3px solid #FF5454");	//자유게시판
	}
	
});
	//신고처리
	function reportProcess(board_num, write_id){
		event.stopPropagation();//tr onclick 중복 제거
		if(!confirm("신고 처리를 진행하시겠습니까?")){
			return false;
		}
		
		$.ajax({
			url: '/master/reportProcess',
			data: 'board_num='+board_num+'&write_id='+write_id,
			type: 'post',
			success: function(result){
				if(result>0){
					alert("신고 처리가 완료되었습니다.");
				}
				location.reload();
			},
			error: function(e){
				console.log(e.responseText);
				alert("신고 처리 실패하였습니다.");
			}
		});
	}
	
	//신고글 삭제
	function deleteReport(report_num){
		event.stopPropagation();//tr onclick 중복 제거
		
		if(!confirm("신고글을 삭제하시겠습니까?")){
			return false;
		}
		
		$.ajax({
			url: '/master/reportDelete',
			data: 'report_num='+report_num,
			type: 'post',
			success: function(result){
				if(result>0){
					alert("신고글 삭제되었습니다.");
				}
				location.reload();
			},
			error: function(e){
				console.log(e.responseText);
				alert("신고글 삭제 실패하였습니다.");
			}
		});
		
	}
</script>

<div id="container">

	<!-- 메뉴 -->
	<ul class="menu_list">
		<li class="menu_active">신고관리</li>
	</ul>
	<ul id="category_list">
		<li><a href="/master/report" class="category">전체</a></li>
		<li><a href="/master/report?searchKey=레시피" class="category">레시피</a></li>
		<li><a href="/master/report?searchKey=PT그룹" class="category">PT그룹</a></li>
		<li><a href="/master/report?searchKey=성공스토리" class="category">성공스토리</a></li>
		<li><a href="/master/report?searchKey=자유게시판" class="category">자유게시판</a></li>
	</ul>
	<!-- 회원 관리 -->
	<div id="manageDiv">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>신고번호</th>
					<th>신고자</th>
					<th>작성자</th>
					<th>분류</th>
					<th style="width:50%;">내용</th>	
					<th>신고처리</th>
					<th>허위신고</th>	
				</tr>
			</thead>
			<tbody>
				<c:forEach var="vo" items="${vo}">
					<c:if test="${vo.report_type==1}">
						<tr onclick="window.open('/recipe/view?board_num=${vo.board_num}');">
					</c:if>
					<c:if test="${vo.report_type==2}">
						<tr onclick="window.open('/board/ptView?board_num=${vo.board_num}';">
					</c:if>
					<c:if test="${vo.report_type==3}">
						<tr onclick="window.open('/recipe/view?board_num=${vo.board_num}');">
					</c:if>
					<c:if test="${vo.report_type==5}">
						<tr onclick="window.open('/board/boardList/${vo.board_num}');">
					</c:if>
						<td>${vo.board_num}</td>
						<td>${vo.user_id}</td>
						<td>${vo.write_id}</td>
						<td>${vo.report_title}</td>
						<td style="width:40%;">${vo.report_content}</td>
						<td><button id="reportBtn" onclick="reportProcess('${vo.board_num}','${vo.write_id}');">신고처리</button></td>
						<td><button id="deleteReport" onclick="deleteReport('${vo.report_num}');">허위신고</button></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
			 <!-- 페이징 -->
	    <ul class="paging">
	    	<!-- prev -->
	    	<c:if test="${pVO.pageNum==1&&pVO.totalRecord>0}">
	    		<li>◀</li>
	    	</c:if>
	    	<c:if test="${pVO.pageNum>1}">
	    		<li><a href="/master/report?pageNum=${pVO.pageNum-1}
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
	    			<a href="/master/report?pageNum=${p}
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
	    		<li><a href="/master/report?pageNum=${pVO.pageNum+1}
	    			<c:if test='${pVO.searchWord!=null}'>
	    				&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}
	    			</c:if>">▶</a></li>
	    	</c:if>
	    </ul>
    </div>
    
</div>