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
#top{
	position:relative;
	width:100%;
	height:750px;
	margin-top:4%;
	margin-bottom:3%;
}
#listBtnText{
	position:absolute;
	top:58%;
	right:11%;
	padding:5px 10px;
	text-align: center;
	color:white;
	font-size:1.2em;
	background-color: rgba(0,0,0,0.6);
	opacity:0;
}
#recomBtnText{
	position:absolute;
	top:58%;
	left:11%;
	padding:5px 10px;
	text-align: center;
	color:white;
	font-size:1.2em;
	background-color: rgba(0,0,0,0.6);
	opacity:0;	
}
#listBtn {
    position: absolute;
    top:68%;
    right:18%;
    padding: 20px 40px;
    text-align: center;
    color: #FF5454;
    font-size: 1.2em;
    font-weight: bold;
    background-color: white;
    outline: none;
    border: none;
    cursor: pointer;
    border-radius: 30px; 
}
#recomBtn{
    position: absolute;
    top:68%;
    left:18%;
    padding: 20px 40px;
    text-align: center;
    color: #FF5454;
    font-size: 1.2em;
    font-weight: bold;
    background-color: white;
    outline: none;
    border: none;
    cursor: pointer;
    border-radius: 30px; 
}

#video{
	width:95%;
	margin-left:2.5%;
	height:100%;
	object-fit: cover;
}
/*레시피 추천 div*/
#main{
	height:500px;
	overflow:auto;
	margin-bottom:5%;
}
#head{
	width:100%;
	height:50px;
	line-height:50px;
	text-align: center;
	font-size:1.2em;
	margin-bottom:3%;
}
#recipe_list{
	width:85%;
	border-radius: 20px;
	text-align: center;
	margin-left:7%;
}
.recipe_item{
	display:inline-block;
	position:relative;
	width:22.5%;
	height:350px;
	float:left;
	margin-left:2%;
}
.recipe_img{
	position:relative;
	width:100%;
	height:100%;
	object-fit: cover;
	border-radius:15px;
}
.recipe_info{
	position: absolute;
	left:0;
	top:0;
	width:100%;
	height:100%;
	border-radius:15px;
	background-color: rgba(255,255,255,0.7);
	opacity: 0;
	cursor : pointer;
}
.title, .kcal{
	font-size:20px;
	text-align: center;
	width:100%;
}
.title{
	position: absolute;
	top:35%;
}
.kcal{
	position:absolute;
	top:45%;
}
.recipe_item:hover .recipe_info{
	opacity:1;
	transition:0.4s;
}
.heart1, .heart2{
	position:absolute;
	left:87%;
	top:2%;
	width:10%;
}
.heart2{
	display:none;
}

@media ( min-width: 1800px ) {
	#top{
		width:100%;
		height:1100px;
	}
	#recomBtnText{
		top:58%;
		left:13%;
		font-size:1.4em;
	}
	#listBtnText{
		top:58%;
		right:13%;
		font-size:1.4em;
	}
	#recomBtn, #listBtn{
		top:63%;
		height:65px;
		font-size:1.5em;
	}
	#head{
		font-size:1.7em;
		top:45%;
		left:39%;
	}
	/*추천 레시피 리스트*/
	#main{
		height:750px;
	}
	#recipe_list{
		width:80%;
		margin-left:9%;
	}
	.recipe_item{
		height:550px;
	}
	.title{
		font-size:2em;
		top:36%;
	}
	.kcal{
		font-size:1.8em;
		top:46%;
	}
}

</style>
<script>
$(function(){
	
	//doucment가 ready되면 하트 세팅하기
	$(document).ready(function(){
		setHeart();
	});
	
	//리스트 페이지로 이동하는 버튼 hover 효과
	$("#listBtn").mouseover(function(){
		$("#listBtnText").css("opacity", "1").css("transition-duration","200ms");
		$(this).css("background-color", "#FF5454").css("color","white").css("transition-duration","400ms");
	});
	$("#listBtn").mouseout(function(){
		$("#listBtnText").css("opacity", "0").css("transition-duration","200ms");
		$(this).css("background-color", "white").css("color","#FF5454").css("transition-duration","400ms");
	});
	
	//추천 레시피 스크롤 이동하는 버튼 hover 효과
	$("#recomBtn").mouseover(function(){
		$("#recomBtnText").css("opacity", "1").css("transition-duration","200ms");
		$(this).css("background-color", "#FF5454").css("color","white").css("transition-duration","400ms");
	});
	$("#recomBtn").mouseout(function(){
		$("#recomBtnText").css("opacity", "0").css("transition-duration","200ms");
		$(this).css("background-color", "white").css("color","#FF5454").css("transition-duration","400ms");
	});
	
	//추천 버튼 클릭 이벤트(스크롤 이동)
	$("#recomBtn").click(function(){
		var offset = $('#recipe_list').offset(); //선택한 태그의 위치를 반환
        $('html').animate({scrollTop : offset.top}, 500);

	});
	
	//빈 하트 클릭했을 때(db 추가)
	$(".heart1").click(function(){
		var num = $(this).attr("id").substring(2);
		insertHeart(num);
		return false;
	});
	
	//채워진 하트 클릭했을 때(db 삭제)
	$(".heart2").click(function(){
		var num = $(this).attr("id").substring(2);
		deleteHeart(num);
		return false;
	});
});

//하트 세팅
function setHeart(){
	$.ajax({
		url: "/recipe/selectHeart",
		type: "post",
		success: function(result){
			if(result.length>0){
				$(result).each(function(){
					var boardNum = this.board_num;
					$("#e_"+boardNum).css("display", "none");
					$("#e-"+boardNum).css("display", "none");
					$("#f_"+boardNum).css("display", "block");
					$("#f-"+boardNum).css("display", "block");
				});
			}
		},
		error: function(e){
			console.log(e.responseText);
		}
	});
}

//하트 추가
function insertHeart(boardNum){
	
	$.ajax({
		url: "/recipe/insertHeart",
		type: "post",
		data: "board_num="+boardNum,
		success: function(result){
			setHeart();	//다시 하트 세팅
		},
		error: function(e){
			console.log(e.responseText);
		}
	});
	
	return false;
}
//하트 삭제
function deleteHeart(boardNum){
	
	$.ajax({
		url: "/recipe/deleteHeart",
		type: "post",
		data: "board_num="+boardNum,
		success: function(result){
			setHeart(); //다시 하트 세팅
		},
		error: function(e){
			console.log(e.responseText);
		}
	});
	
	return false;
}


</script>
<div>
	<!-- 배너-->
	<div id="top">
		<video muted autoplay loop id="video">
	    	<source src="/recipeImg/video.mp4" type="video/mp4">
	  	</video>
	  	<p id="listBtnText">다양한 레시피를 확인하고 나만의 레시피를 공유하세요!</p>
		<button id="listBtn" onclick="location='/recipe/list';">MORE RECIPES</button>
		
		<p id="recomBtnText">매번 먹던 레시피는 그만! 오늘의 추천 레시피로 해결하세요.</p>
		<button id="recomBtn">TODAY'S RECIPES</button>
	</div>
	<div id="main">
		<p id="head">▼ 오늘의 추천 레시피를 확인하세요! ▼</p>
		<!-- 레시피 목록 -->
		<ul id="recipe_list">
			<c:if test="${not empty vo}">
				<c:forEach var="vo" items="${vo}">
					<li class="recipe_item">
						<img src="/recipeImg/upload/${vo.recipe_img_file}" class="recipe_img"/>
						<c:if test="${logId!=null}">
							<img src="/recipeImg/heart1.png" class="heart1" id="e_${vo.board_num}"/>
							<img src="/recipeImg/heart2.png" class="heart2" id="f_${vo.board_num}"/>
						</c:if>
						<div class="recipe_info" onclick="javascript:location='/recipe/view?board_num=${vo.board_num}';">
						<c:if test="${logId!=null}">
							<img src="/recipeImg/heart1.png" class="heart1" id="e-${vo.board_num}"/>
							<img src="/recipeImg/heart2.png" class="heart2" id="f-${vo.board_num}"/>
						</c:if>
							<p class="title">${vo.title}</p>
							<p class="kcal">${vo.total_kcal}kcal</p>
			            </div>
					</li>
				</c:forEach>
			</c:if>
		</ul>
	</div>
</div>