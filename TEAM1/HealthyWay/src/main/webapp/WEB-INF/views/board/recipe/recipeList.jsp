<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
/*a태그 설정*/
a:link { color: black; text-decoration: none;}
a:visited { color: black; text-decoration: none;}
a:hover { color: black; text-decoration: none;}
@font-face {
 font-family: 'NanumBarunGothic';
 font-style: normal;
 font-weight: 400;
 src: url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.eot');
 src: url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.eot?#iefix') format('embedded-opentype'), url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.woff') format('woff'), url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.ttf') format('truetype');
}

body{
	font-family: "NanumBarunGothic";
}
ul,li{
	margin:0;
	padding:0;
	list-style: none;
}

#topImg{
	position:relative;
	width:100%;
	height:250px;
	margin-top:4%;
	margin-bottom:5%;
}
#topImg>img{
	position:absolute;
	width:85%;
	height:100%;
	margin-left:7.5%;
}
#topImg>h1{
	position:absolute;
	top: 25%;
	width:100%;
	heihgt:50px;
	text-align: center;
	line-height:50px;
	font-size:2em;
}
#topImg>p{
	position:absolute;
	top:50%;
	width:100%;
	text-align: center;
	font-size:1.2em;
}
/*검색, 글쓰기 div*/
#top{
	width:98%;
	margin-bottom:5%;
}
#top>ul{
	float:right;
	text-align: center;
	margin-right: 1%;
}
#top>ul>li{
	display: inline-block;
	height:30px;
	line-height: 30px;
}
/*검색폼*/
#searchFrm{
	float:left;
	width:40%;
	margin:0;
}
#searchFrm>input[type=text]{
	width:60%;
	height:27px;
	padding-left:1%;
	border-radius:10px;
	border:1px solid rgb(200,200,200);
}
#searchFrm>input[type=text]:focus{
	outline-color: #FF5454;
}
#searchFrm>input[type=submit]{
	width:10%;
	height:30px;
	border:none;
	border-radius:30px;
	background-color: #FF5454;
	color:white;
	cursor : pointer;
}
/*글쓰기 버튼*/
#writeBtn{
	float:right;
	width:7%;
	height:30px;
	border-radius: 30px;
	border:none;
	background-color: #FF5454;
	color:white;
	cursor : pointer;
	
}
/*레시피 글 목록*/
#recipe_list{
	margin:0 auto;
	width:85%;
	height:45%;
	overflow:auto;
	margin-bottom:2%;
	padding-left:2%;
}
/*레시피 목록*/
.recipe_div{
	position:relative;
	width:23%;
	height:300px;
	float:left;
	margin-right:2%;
	border-radius:15px;
}
.recipe_img{
	width:100%;
	height:100%;
	border-radius:15px;
}
.title{
	position:absolute;
	width:100%;
	top:35%;
	padding-top:2%;
	padding-bottom:2%;
	font-size:1.2em;
	text-align:center;
	background-color: white;
	opacity: 0;
	/*줄바꿈*/
	overflow:hidden;
	white-space:nowrap;
	text-overflow: ellipsis;
	cursor: pointer;
}
.title>span{
	font-size:1em;
}
.recipe_div:hover .title{
	opacity:0.8;
	transition: 0.4s;
}
.recipe_div:hover{
	transform: scale(1.02);
	transition : transform 0.4s;
}
.heart1, .heart2{
	position:absolute;
	left:86%;
	top:1.7%;
	width:11%;
	cursor: pointer;
}
.heart2{
	display:none;
}

/*페이징*/
.paging{
	text-align: center;
	margin:0 auto;
	margin-bottom:3%;
	width:85%;
	height:27px;
}
.paging>a>li{
	display:inline-block;
	width:1.7%;
	line-height:30px;
	height:100%;
	text-align:center;
	font-size:16px;
	margin-right:0.1%;
	border-radius:10px;
	background-color: rgb(235,235,235);
}
.active_list{
	color:white;
	background-color:#FF5454 !important;
}
#nullCheck{
	font-size:22px;
	text-align: center;
	margin-top:10%;;
}

@media ( min-width: 1800px ) {
  	#topImg{
		height:380px;
	}
	#topImg>h1{
		top: 30%;
		width:100%;
		font-size:2em;
	}
	#topImg>p{
		top: 50%;
		width:100%;
		font-size:1.6em;
	}
	#top>ul>li{
		height: 45px;
		line-height: 45px;
		font-size:1.2em;
	}
	.recipe_div{
		height:550px;
	}
	#searchFrm>input[type=text], #searchFrm>input[type=submit]{
		height:45px;
		font-size:1.2em;
	}
	/*글쓰기 버튼*/
	#writeBtn{
		width:6%;
		height:45px;
		font-size:1.2em;
	}
	.title{
		height:55px;
		line-height:60px;
		top:40%;
		font-size:22pt;
	}
	.paging>a>li{
		font-size:1.2em;
	}
}
</style>

<script>
$(function(){
	$(document).ready(function(){
		setHeart();
	});
	
	var href = window.location.href;//현재 url 주소
	//주소에 따라 해당 메뉴 밑줄 css 적용
	if(href=="https://localhost:8088/recipe/list?searchKey=%EC%B9%BC%EB%A1%9C%EB%A6%AC"){
		$("#top>ul>li").eq(0).css("border-bottom", "3px solid #FF5454");	//저칼로리순
	}else if(href=="https://localhost:8088/recipe/list?searchKey=%EC%A1%B0%ED%9A%8C"){
		$("#top>ul>li").eq(1).css("border-bottom", "3px solid #FF5454");	//조회순
	}else if(href=="https://localhost:8088/recipe/list?searchKey=%EB%8C%93%EA%B8%80"){
		$("#top>ul>li").eq(2).css("border-bottom", "3px solid #FF5454");	//댓글순
	}
	
	$(".heart1").click(function(){
		var num = $(this).attr("id").substring(2);
		insertHeart(num);
		return false;
	});
	
	$(".heart2").click(function(){
		var num = $(this).attr("id").substring(2);
		deleteHeart(num);
		return false;
	});
	
	$("#searchFrm").submit(function(){
		if($("#searchFrm>input[type=text]").val()==""){
			alert("검색어를 입력해 주세요.");
			location="/recipe/list";
			return false;
		}
	});
});
function setHeart(){
	
	$.ajax({
		url: "/recipe/selectHeart",
		type: "post",
		success: function(result){
			if(result.length>0){
				$(result).each(function(){
					var boardNum = this.board_num;
					$("#e_"+boardNum).css("display", "none");
					$("#f_"+boardNum).css("display", "block");
				});
			}
		},
		error: function(e){
			console.log(e.responseText);
		}
	});
}

function insertHeart(boardNum){
	
	$.ajax({
		url: "/recipe/insertHeart",
		type: "post",
		data: "board_num="+boardNum,
		success: function(result){
			$("#e_"+boardNum).css("display", "none");
			$("#f_"+boardNum).css("display", "block");
		},
		error: function(e){
			console.log(e.responseText);
		}
	});
	
	return false;
}
function deleteHeart(boardNum){
	
	$.ajax({
		url: "/recipe/deleteHeart",
		type: "post",
		data: "board_num="+boardNum,
		success: function(result){
			$("#e_"+boardNum).css("display", "block");
			$("#f_"+boardNum).css("display", "none");
		},
		error: function(e){
			console.log(e.responseText);
		}
	});
	
	return false;
}
</script>
<!-- <a href='https://kr.freepik.com/psd/banner'>Banner psd는 freepik - kr.freepik.com가 제작함</a>-->
<div style="margin-top:50px; margin-bottom:30px;">
	<div id="topImg">
		<img src="/recipeImg/banner2.jpg"/>
		<h1>SHARE YOUR RECIPES</h1>
		<p>당신의 레시피를 공유하세요!</p>
	</div>

	<!-- 글 목록 -->
	<div id="recipe_list">
		<!-- 등록/검색 -->
		<div id="top">
			<c:if test="${logId!=null}">
				<a href="/recipe/write"><button id="writeBtn">글쓰기</button></a>
			</c:if>
			<form id="searchFrm" action="/recipe/list">
				<input type="hidden" name="searchKey" value="all"/>
				<input type="text" name="searchValue"/>
				<input type="submit" value="검색"/>
			</form>
			<ul>
				<li><a href="/recipe/list?searchKey=칼로리">저칼로리순</a></li>
				<li><a href="/recipe/list?searchKey=조회">조회순</a></li>
				<li><a href="/recipe/list?searchKey=댓글">댓글순</a></li>
			</ul>
		</div>
		<c:if test="${not empty vo}">
			<c:forEach var="vo" items="${vo}">
				<div class="recipe_div" style="margin-bottom:30px;">
					<a href="/recipe/view?board_num=${vo.board_num}"><img src="/recipeImg/upload/${vo.recipe_img_file}" class="recipe_img"/></a>
					<c:if test="${logId!=null}">	<!-- 로그인 한 경우만 찜하기 가능 -->
						<img src="/recipeImg/heart1.png" class="heart1" id="e_${vo.board_num}"/>
						<img src="/recipeImg/heart2.png" class="heart2" id="f_${vo.board_num}"/>
					</c:if>
					<p class="title"><a href="/recipe/view?board_num=${vo.board_num}">${vo.title}<br/><span>${vo.total_kcal}kcal</span></a></p>
				</div>
			</c:forEach>
		<c:if test="${empty vo}">
			<p id="nullCheck">검색하신 레시피가 존재하지 않습니다.</p>
		</c:if>
	</div>
	<c:if test="${not empty vo}">
			<!-- 페이징 -->
			<ul class="paging">
				<!-- prev -->
				<c:if test="${pVO.pageNum==1}">
					<a href="javascript:alert('이전 페이지가 존재하지 않습니다');"><li>◀</li></a>
				</c:if>
				<c:if test="${pVO.pageNum>1}">
		    		<a href="/recipe/list?pageNum=${pVO.pageNum-1}
		    			<c:if test='${pVO.searchValue!=null}'>
		    				&searchKey=${pVO.searchKey}&searchValue=${pVO.searchValue}
		    			</c:if>
		    		"><li>◀</li></a>
		    	</c:if>
		    	
		    	<!-- page -->
		    	<c:forEach var="i" begin="${pVO.startPage}" end="${pVO.startPage+pVO.onePageCount-1}">
			    	<c:if test="${i<=pVO.totalPage}">
			    		<a href="/recipe/list?pageNum=${i}
			    			<c:if test='${pVO.searchValue!=null}'>
				    			&searchKey=${pVO.searchKey}
				    			&searchValue=${pVO.searchValue}
				    		</c:if>
				    	">
			    		<c:if test="${i==pVO.pageNum}">
			    			<li class="active_list">
			    		</c:if>
			    		<c:if test="${i!=pVO.pageNum}">
			    			<li>
			    		</c:if>
			    		${i}</li></a>
			    	</c:if>
		    	</c:forEach>
		    	
		    	<!-- next -->
		    	<c:if test="${pVO.pageNum==pVO.totalPage}">
		    		<a href="javascript:alert('다음 페이지가 존재하지 않습니다');"><li>▶</li></a>
		    	</c:if>
		    	<c:if test="${pVO.pageNum<pVO.totalPage}">
		    		<a href="/recipe/list?pageNum=${pVO.pageNum+1}
		    		<c:if test='${pVO.searchValue!=null}'>
				  		&searchKey=${pVO.searchKey}
				    	&searchValue=${pVO.searchValue}
				    </c:if>
				    "><li>▶</li></a>
		    	</c:if>
			</ul>
		</c:if>
	</c:if>
</div>