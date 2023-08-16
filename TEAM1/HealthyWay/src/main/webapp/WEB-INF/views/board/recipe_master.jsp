<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
	background-image:url('/recipeImg/recipe.jpg');
	background-repeat : no-repeat;
    background-size : cover;
}

ul, li {
	margin: 0;
	padding: 0;
	list-style: none;
}

#mainDiv {
	width: 92%;
	height: 500px;
	padding: 4%;
	margin-top: 3%;
	overflow:auto;
}

input, select:focus {
	outline: none;
}
/*재료 추가 폼-----------------------------------*/
#addIngred {
	float: left;
	width: 44%;
	padding: 2%;
	height: 450px;
	margin-right: 4%;
	border-radius: 15px;
	background-color: rgba(255,255,255,0.93);
}

.head {
	font-weight: normal;
	text-align: center;
	font-size: 1.4em;
	margin-bottom: 6%;
}

#addIngred>p { /*텍스트*/
	overflow:auto;
	margin-bottom: 1%;
	padding-left: 2%;
	line-height: 30px;
	font-size: 1em;
	text-align: center;
}

#addIngred>p>select {
	width: 30%;
	height: 30px;
	padding-left: 2%;
	padding-right: 2%;
	margin-left: 2%;
	border-radius: 10px;
	border: 1px solid rgb(200, 200, 200);
	font-size: 0.9em;
	height: 30px;
}

#addIngred>p>input[type=text] {
	width: 100%;
	height: 30px;
	width: 90%;
	padding-left: 2%;
	border-radius: 10px;
	border: 1px solid rgb(200, 200, 200);
	font-size: 0.9em;
}

#btnDiv {
	width: 100%;
	overflow: auto;
	margin-top: 10%;
}

#btnDiv>input[type=submit], #btnDiv>input[type=reset] {
	width: 25%;
	height: 40px;
	border: none;
	border-radius: 30px;
	background-color: #FF5454;
	color: white;
	cursor: pointer;
	float: right;
	margin-right: 15%;
}

#btnDiv>input[type=reset] {
	float: left;
	margin-left: 15%;
}

/*재료 검색, 삭제 -----------------------------------*/
#ingredView {
	float: left;
	width: 44%;
	padding: 2%;
	height: 450px;
	border-radius: 15px;
	background-color: rgba(255,255,255,0.93);
	float: left;
}
#ingredView p{
	text-align: center;
	margin-bottom:7px;
	font-size:1em;
}
#ingredSearch>select{/*카테고리*/
	width:18%;
	height:30px;
	border-radius:10px;
	border-color:rgb(200,200,200);
	font-size:11pt;
	text-align: center;
	margin-left:8%;
}
#ingredSearch>select>option{
	text-align: center;
}
#ingredSearch>input[type=text]{/*검색창*/
	width:50%;
	height:30px;
	padding-left: 2%;
	border-radius:10px;
	border:1px solid rgb(200,200,200);
}
#ingredSearch>input[type=submit]{/*검색 버튼*/
	width:12%;
	height:30px;
	border:none;
	border-radius:30px;
	background-color: #FF5454;
	color:white;
	cursor : pointer;
}
.list-group{
	margin-top:2%;
	margin-left:3.5%;
}
/*재료 리스트 출력*/
.list-group>li{
	width:85%;
	height:37px;
	line-height:30px;
	padding:0;
	padding-left:10px;
	margin-left:4%;
	cursor: pointer;
}
.list-group>li>span{
	margin-left:1%;
	color:#FF5454;
}
.list-group>li:hover{
	background-color: rgba(220,220,220,0.5);
}
/*페이징*/
.paging{
	text-align: center;
	margin-left:1.5%;
	margin-top:2.5%;
}
.paging>a>li{
	display:inline-block;
	width:25px;
	height:25px;
	line-height:24px;
	text-align:center;
	font-size:11pt;
	margin-right:1.5%;
	border-radius:10px;
	background-color: rgb(235,235,235);
}
.active_list{
	color:white;
	background-color:#FF5454 !important;
}

@media ( min-width: 1800px ) {
	#mainDiv{
		height: 700px;
		margin-top:4%;
	}
	.head{
		font-size:1.6em;
	}
	#addIngred {
		height: 600px;
	}
	#addIngred>p>select{
		width:30%;
		height:40px;
		font-size:1.2em;
	}
	#addIngred>p>input[type=text]{
		width:80%;
		height:40px;
		font-size:1.2em;
	}
	#btnDiv>input[type=submit], #btnDiv>input[type=reset] {
		height: 40px;
		font-size:1.2em;
	}
	#ingredView{
		height: 600px;
	}
	#ingredView p{
		font-size:1.2em;
	}
	#ingredSearch>select, #ingredSearch>input[type=text], #ingredSearch>input[type=submit]{
		height:40px;
		font-size:1.2em;
	}
	.list-group>li{
		height:40px;
		font-size:1.1em;
	}
}
</style>

<script>
	$(function(){
		
		//재료 등록
		$("#addIngred").submit(function(){
			event.preventDefault();
			
			if($("#gred_name").val()==""){
				alert("재료명을 입력하세요.");
				$("#gred_name").focus();
				return false;
			}
			if($("#gred_kcal").val()==""){
				alert("100g당 칼로리 값을 입력하세요.");
				$("#gred_kcal").focus();
				return false;
			}
			
			var params = $("#addIngred").serialize();
			$.ajax({
				url: '/master/ingredInsert',
				data: params,
				type: 'post',
				success: function(result){
					if(result>0){
						alert("재료가 추가되었습니다.");
					}
					$("#btnDiv>input[type=reset]").click();//초기화
				},
				error: function(e){
					console.log(e.responseText);
					alert("재료가 추가되지 않았습니다.");
				}
			});
		});
		
		//재료 검색
		$("#ingredSearch").submit(function(){
			event.preventDefault();
			
			//유효성 검사
			if($("#searchValue").val()==""){
				alert("검색어를 입력하세요.");
				$("#searchValue").focus();
				return false;
			}
			
			var params = $("#ingredSearch").serialize();
			
			$.ajax({
				url: '/recipe/searchIngred',
				data: params,
				type: 'post',
				success: function(result){
					var tag ="";
					$(".list-group").html("");
			
					if(result.length==0){//존재하지 않는 경우
						$(".list-group").append("<br/><p>검색하신 재료가 존재하지 않습니다.</p><br/>");
					}
					
					var pageNum = $("#pageNum").val();
					var onePageRecord = 8;//한 페이지에 출력할 레코드 수
					var onePageCount = 5;//페이지 수
					paging(pageNum, result.length);//페이징 리스트 설정 함수 호출
					
					//리스트 출력
					for(var i=(pageNum-1)*onePageRecord; i<=(onePageRecord-1)+(pageNum-1)*onePageRecord; i++){
						if(result[i]!=null){
							tag = "<li onclick='deleteIngred(&#39;"+result[i].gred_num+"&#39;);'>";
							tag += result[i].gred_name+"<span>&times;</span></li>";
							$(".list-group").append(tag);
						}
					}
					$("#pageNum").val(1);	//페이지 변수값 변경
				},
				error: function(e){
					console.log(e.responseText);
				}
			});
		});
	});
	
	//페이지 클릭 이벤트
	function setPageNum(num){
		$("#pageNum").val(num);	//페이지 변수값 변경
		$("#searchSubmit").trigger("click");	//검색 버튼 강제 클릭
	}
	
	//페이징 설정
	function paging(pageNum, totalRecord){
		var pageNum = parseInt(pageNum);// 현재 페이지
		var onePageRecord = 8;//한 페이지에 출력할 레코드 수
		var onePageCount = 4;//페이지 수
		var totalRecord = parseInt(totalRecord);//검색된 레코드 수
		var totalPage;// 총 페이지 수
		var offsetIndex = parseInt(onePageCount*(pageNum)-1);// 오프셋
		var startPage = Math.floor((pageNum-1)/(onePageCount))*onePageCount+1;
		
		if (totalRecord % onePageRecord == 0) {// 나머지 레코드 없는 경우
			totalPage = totalRecord / onePageRecord;
		}else if(totalRecord<onePageRecord){
			totalPage=1;
		}else {// 나머지 레코드 있는 경우
			totalPage = parseInt(totalRecord / onePageRecord + 1);
		}
		
		var pagingTag = "";
		if(pageNum==1){
			pagingTag += "<a href='javascript:alert(\"이전 페이지가 없습니다.\");'><li>◀</li></a>";
		}else if(pageNum>1){
			var prevPage = pageNum-1;
			pagingTag += "<a href='javascript:void(0);' onclick='setPageNum("+prevPage+")';><li>◀</li></a>";
		}
		
		for(var i=startPage; i<=startPage+onePageCount-1; i++){
			if(i<=totalPage){
				if(i==pageNum){
					pagingTag += "<a href='javascript:void(0);' onclick='setPageNum("+i+");'><li class='active_list'>";
				}else{
					pagingTag += "<a href='javascript:void(0);' onclick='setPageNum("+i+");'><li>";
				}
				pagingTag += i+"</li></a>";
			}
		}

		if(pageNum==totalPage){
			pagingTag += "<a href='javascript:alert(\"다음 페이지가 없습니다.\");'><li>▶</li></a>";
		}else{
			var nextPage = pageNum+1;
			pagingTag += "<a href='javascript:void(0);' onclick='setPageNum("+nextPage+")';><li>▶</li></a>";
		}
		$(".paging").html(pagingTag);
		
	}
	
	//재료 삭제
	function deleteIngred(gred_num){
	
		if(!confirm("재료를 삭제하시겠습니까?")){
			return false;
		}
		
		$.ajax({
			url: '/master/ingredDelete',
			data: "gred_num="+gred_num,
			type: 'post',
			success: function(result){
				if(result>0){
					alert("재료가 삭제되었습니다.");
				}
				location="/master/recipe";
			},
			error: function(e){
				console.log(e.responseText);
				alert("재료가 삭제되지 않았습니다.");
			}
		});
	}
</script>

<div>
	<div id="mainDiv">
		<form method="post" id="addIngred" action="/master/ingredInsert">
			<h1 class="head">재료 추가</h1>
			<p>
				재료 분류<br/>
				<select name="gred_type" id="gred_type">
					<option>곡류</option>
					<option>감자/전분류</option>
					<option>당류</option>
					<option>두류</option>
					<option>견과류/증실류</option>
					<option>채소류</option>
					<option>버섯류</option>
					<option>과실류</option>
					<option>육류</option>
					<option>난류</option>
					<option>어패류/수산물</option>
					<option>해조류</option>
					<option>우유/유제품류</option>
					<option>유지류</option>
					<option>차류</option>
					<option>음료류</option>
					<option>주류</option>
					<option>조미료류</option>
					<option>조리가공품류</option>
					<option>기타</option>
				</select>
			</p>
			<p>재료 이름
				<input type="text" name="gred_name" id="gred_name">
			</p>
			<p>칼로리
				<input type="text" name="gred_kcal" id="gred_kcal" placeholder="100g당 칼로리를 작성해 주세요.">
			</p>
			<div id="btnDiv">
				<input type="reset" value="취소" />
				<input type="submit" value="등록" />
			</div>
		</form>

		<!-- 재료 리스트 -->
		<div id="ingredView">
			<h1 class="head">재료 검색</h1>
			<form method="post" action="/recipe/searchIngred" id="ingredSearch">
				<select name="searchKey">
					<option>재료명</option>
					<option>분류</option>
				</select>
				<input type="text" name="searchValue" id="searchValue" />
				<input type="hidden" name="pageNum" id="pageNum" value="1" />
				<input type="submit" value="검색" id="searchSubmit" />
			</form>
			<ul class="list-group">
				<br/><p>검색어를 입력해 재료를 검색하세요.<br/><br/>검색된 재료를 클릭하면 삭제됩니다.</p><br/>
			</ul>
			<!-- 페이징 -->
			<ul class="paging">
			</ul>
		</div>
	</div>
</div>