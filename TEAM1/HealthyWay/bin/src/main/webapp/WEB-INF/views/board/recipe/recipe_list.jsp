<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
/*a태그 설정*/
a:link { color: black; text-decoration: none;}
a:visited { color: black; text-decoration: none;}
a:hover { color: black; text-decoration: none;}

ul,li{
	margin:0;
	padding:0;
	list-style: none;
}
#top{
	overflow: auto;
	width:1010px;
	margin:0 auto;
	margin-bottom:15px;
}
/*검색폼*/
#searchFrm{
	float:left;
	margin:0;
	margin-right:10px;
}
#searchFrm>input[type=text]{
	width:210px;
	height:27px;
	border-radius:10px;
	border:1px solid rgb(200,200,200);
}
#searchFrm>input[type=text]:focus{
	outline-color: #FF5454;
}
#searchFrm>input[type=submit]{
	width:50px;
	height:27px;
	border:none;
	border-radius:30px;
	background-color: #FF5454;
	color:white;
	cursor : pointer;
}
/*글쓰기 버튼*/
#writeBtn{
	float:right;
	width:75px;
	height:27px;
	border-radius: 30px;
	border:none;
	background-color: #FF5454;
	color:white;
	cursor : pointer;
	
}
/*레시피 글 목록*/
#recipe_list{
	margin:0 auto;
	padding-left:30px;
	margin-bottom:50px;
	width:1040px;
	overflow:auto;
}
.recipe_img{
	position:relative;
	width:230px;
	height:240px;
	float:left;
	margin-right:30px;
	border-radius:15px;
}
.recipe_info>p{
	font-size:20px;
	text-align: center;
}
.recipe_img:hover .recipe_info{
	display:block;
	transition:500ms;
}
.heart1, .heart2{
	position:absolute;
	left:200px;
	top:6px;
	width:25px;
}
/*페이징*/
.paging{
	text-align: center;
}
.paging>a>li{
	display:inline-block;
	width:25px;
	height:25px;
	line-height:24px;
	text-align:center;
	font-size:10pt;
	margin-right:5px;
	border-radius:10px;
	background-color: rgb(235,235,235);
}
.active_list{
	color:white;
	background-color:#FF5454 !important;
}
/*rgb(226,224,250):보라색*/
</style>

<script>

</script>

<div style="margin-top:100px;">
	<div style="background-color:rgb(226,224,250); height:50px; margin-bottom:50px;">&nbsp;</div>
	<!-- 등록/검색 -->
	<div id="top">
		<a href="/recipe/write"><button id="writeBtn">글쓰기</button></a>
		<form id="searchFrm">
			<input type="text"/>
			<input type="submit" value="검색"/>
		</form>
	</div>
	
	<!-- 글 목록 -->
	<div id="recipe_list">
		<div class="recipe_img">
			<a href="javascript:void(0);"><img src="/recipeImg/sample.jpg" class="recipe_img"/></a>
			<a href="javascript:void(0);"><img src="/recipeImg/heart2.png" class="heart2"/></a>
		</div>
		<div class="recipe_img">
			<a href="javascript:void(0);"><img src="/recipeImg/sample.jpg" class="recipe_img"/></a>
			<a href="javascript:void(0);"><img src="/recipeImg/heart1.png" class="heart1"/></a>
		</div>
		<div class="recipe_img">
			<a href="javascript:void(0);"><img src="/recipeImg/sample.jpg" class="recipe_img"/></a>
			<a href="javascript:void(0);"><img src="/recipeImg/heart1.png" class="heart1"/></a>
		</div>
		<div class="recipe_img">
			<a href="javascript:void(0);"><img src="/recipeImg/sample.jpg" class="recipe_img"/></a>
			<a href="javascript:void(0);"><img src="/recipeImg/heart1.png" class="heart1"/></a>
		</div><hr/><br/>
		<div class="recipe_img">
			<a href="javascript:void(0);"><img src="/recipeImg/sample.jpg" class="recipe_img"/></a>
			<a href="javascript:void(0);"><img src="/recipeImg/heart1.png" class="heart1"/></a>
		</div>
		<div class="recipe_img">
			<a href="javascript:void(0);"><img src="/recipeImg/sample.jpg" class="recipe_img"/></a>
			<a href="javascript:void(0);"><img src="/recipeImg/heart1.png" class="heart1"/></a>
		</div>	
		<div class="recipe_img">
			<a href="javascript:void(0);"><img src="/recipeImg/sample.jpg" class="recipe_img"/></a>
			<a href="javascript:void(0);"><img src="/recipeImg/heart1.png" class="heart1"/></a>
		</div>
		<div class="recipe_img">
			<a href="javascript:void(0);"><img src="/recipeImg/sample.jpg" class="recipe_img"/></a>
			<a href="javascript:void(0);"><img src="/recipeImg/heart1.png" class="heart1"/></a>
		</div>
		
	</div>
	<!-- 페이징 -->
	<ul class="paging">
		<a href="#"><li>◀</li></a>
		<a href="#"><li class="active_list">1</li></a>
		<a href="#"><li>2</li></a>
		<a href="#"><li>3</li></a>
		<a href="#"><li>4</li></a>
		<a href="#"><li>▶</li></a>
	</ul>
</div>