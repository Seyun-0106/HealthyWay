<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style>

body,ul,li{
	margin:0px;
	padding:0px;
	list-style:none;
}
#myPageBackground{
	background-image:url(/img/myPageBackground.jpg);
	background-repeat:no-repeat;
	background-size:cover;
	background-attachment: fixed;
	width:100%;
	height:300px;
}
#myPageContainer{
	position:relative;
	top:0px;
	left:0px;
	width:1500px;
	margin:0 auto;
}
#myPageContainer *{
	font-family:"BinggraeReguler";
}
#myPageContainer>section, #myPageContainer>nav{
	float:left;
	background-color:white;	
}
#sidePage{
	width:250px;
	text-align:center;
	position:sticky;
	margin-top:-80px;
	top:20px;
	/*탑 오른쪽 아래 왼쪽*/
	padding:0px 0px 20px 0px;
	box-sizing:border-box;
	box-shadow:0px 0px 5px 0px rgb(196,196,196);
}
#sidePage>div:nth-of-type(2){
	margin-top:20px;
}
#groupPageDiv{
	height:0px;
	overflow:auto;
	padding-bottom:15px;
	border-radius:10px;
	transition-duration:1s;
}
#groupPageDiv::-webkit-scrollbar{
	display:none;
}
.groupPage{
	box-shadow:1px 1px 5px 1px black;
	border-radius:10px;
	width:200px;
	background-color:#ddd;
	height:150px;
	margin:0 auto;
	margin-top:20px;
	box-sizing:border-box;
	overflow:hidden;
	position:relative;
}
.groupPage:hover{
	box-shadow:1px 1px 10px 1px black;
}
.groupPage>div:nth-of-type(1){
	width:100%;
	height:100%;
	overflow:hidden;
	position:relative;
	text-align:left;
}
.groupPage>div>img{
	position:relative;
	width:100%;
	top:50%;
	left:50%;
	transform:translate(-50%,-50%);
}
.groupPage>div:nth-of-type(2){
	background-color:white;
	position:absolute;
	top:0px;
	width:100%;
	height:100%;
	z-index:1;
	text-align:center;
	opacity:0;
	transition-duration:0.5s;
	line-height:130px;
	white-space:nowrap;
	overflow:hidden;
	text-overflow:ellipsis;
	padding:10px;
	box-sizing:border-box;
}
.groupPage>div:nth-of-type(2):hover{
	opacity:0.7;
}
#imgDiv{
	width:100%;
	overflow:hidden;
	margin: 0 auto;
	text-align:left;
}
#imgDiv img{
	text-align:left;
	position:relative;
	left:50%;
	transform:translate(-50%,0%);
	width:100%;
}
#sidePage>div>span{
	font-size:1.2em;
	font-weight:bold;
}
#logout{
	position:relative;
	margin-top:20px;
	width:200px;
	height:40px;
}
.btnClass{
	line-height:0px;
	border-radius:15px;
	border:none;
	color:white;
	overflow:hidden;
	cursor:pointer;
    background:linear-gradient(
    		to right,
            rgba(181, 179, 217, 1) 0%,
            rgb(164,162,208) 20%,
            rgba(117, 114, 184, 1) 100%
            );
}
#seulmun::before{
	position:absolute;
	top:50%;
	left:50%;
	transform: translate(-50%, -50%);
	content:'설문조사';
	width:100%;
	height:100%;
	line-height:40px;
	background:linear-gradient(
    		to right,
            rgba(181, 179, 217, 1) 0%,
            rgb(164,162,208) 20%,
            rgb(145,141,199) 100%
            );
    transition-duration:0.5s;
}
#logout::before{
	position:absolute;
	top:50%;
	left:50%;
	transform: translate(-50%, -50%);
	content:'로그아웃';
	border-radius:15px;
	width:100%;
	height:100%;
	line-height:40px;
	background:linear-gradient(
    		to right,
            rgba(181, 179, 217, 1) 0%,
            rgb(164,162,208) 20%,
            rgb(145,141,199) 100%
            );
    transition-duration:0.5s;
}
.btnClassHover::before{
	opacity:0;
}
#mainPage{
	position:relative;
	left:100px;
	width:1000px;
	z-index:0;
}
#mainPage>div{
	float:left;
	width:100%;
}
#mainPage>div:nth-of-type(1){
	width:1000px;
	/*탑 오른쪽 아래 왼쪽*/
	padding:0px 30px 40px 0px;
	box-sizing:border-box;
}
.clickUpClass+.pageBtn{
	border-left:none;
}
.pageBtn{
	cursor:pointer;
	padding:0px;
	background-color:#FCFCFC;
	height: 50px;
	position:absolute;
	border:none;
	top:-50px;
	width:250px;
	border:1px solid #ddd;
	border-right:none;
	border-bottom:1px solid #E4E5E5;
	color: gray;
	font-size:14px;
}
.inforBtn{
	left:0px;
	z-index:4;
}
.healthBtn{
	left:250px;
	z-index:3;
}
.foodBtn{
	left:500px;
	z-index002;
}
.writeBtn{
	left:750px;
	z-index:1;
}
.clickUpClass{
	background-color:white;
	z-index:5;
	border:1px solid #E4E5E5;
	border-bottom:none;
	color: #000;
}
.pageUpClass{
	display:block !important;
}
.pageView{
	border:none !important;
	position:relative;
	/*탑 오른쪽 아래 왼쪽*/
	margin-bottom:30px;
	padding:40px 40px 0px 40px;
	box-sizing:border-box;
	width:1000px;
	display:none;
}
#sidePage>div:nth-of-type(1):after{
	content : "";
	margin-top : 10%;
	margin-left : 10px; 
	display:block;
	height  : 1px;
	width   : 90%;  /* or 100px */
	border-bottom:1px solid #ddd;
}

#groupShow {
	margin:10px 0 10px 0;
	width:10%;
	cursor:pointer;
	animation-duration: 0.5s;
	animation-name: imgUpDown;
	animation-iteration-count: infinite;
	animation-direction: alternate;
	animation-timing-function:linear;
}
@keyframes imgUpDown{
	0% {
		transform: translate(0, -3px);
	}
	100% {
		transform: translate(0, 3px);
	}
}
</style>
<script>
$(()=> {
	let groupShow=false;
	$("#groupShow").click(function(){
		if(groupShow==false && "${PTboardData}".length!=2){
			$("#groupPageDiv").css("height","170px");
			groupShow=true;
		}else{
			$("#groupPageDiv").css("height","0px");
			groupShow=false;
		}
	});
	//로그아웃 버튼 색변화 이벤트
	$('.btnClass').hover(function(){
		$(event.target).addClass('btnClassHover')
	},function(){
		$(event.target).removeClass('btnClassHover')
	})
	//페이지 네이션 처리 이벤트
	var indexPrev = 0;
	heightSize(indexPrev)
	$('.pageBtn').eq(indexPrev).addClass('clickUpClass');
	$('.pageView').eq(indexPrev).addClass('clickUpClass pageUpClass');
	$(".pageBtn").on('click',function(){
		var index = $(event.target).index();
		if(index!=indexPrev){
			$('.pageBtn').eq(index).addClass('clickUpClass');
			$('.pageBtn').eq(indexPrev).removeClass('clickUpClass');
			$('.pageView').eq(index).addClass('clickUpClass pageUpClass');
			$('.pageView').eq(indexPrev).removeClass('clickUpClass pageUpClass');
			indexPrev = index;
		}
		heightSize(index);
	});
	let scrollTop=0;
	//MyGroup 항목 무한 스크롤 비슷하게 구현
	$("#groupPageDiv").scroll(function(){
		if($(this).scrollTop()<scrollTop){
			$(this).scrollTop(scrollTop);
			return;
		}
		scrollTop=$(this).scrollTop();
		if(Math.ceil($(this).scrollTop()) + Math.ceil($(this).innerHeight()) >= Math.floor($(this)[0].scrollHeight)) {
			$(this).scrollTop(0);
			scrollTop=0;
		}
	})
});
function heightSize(indexPrev){
	if(indexPrev==0){
		$('#myPageContainer').css('height','850px');
	}else if(indexPrev==1){
		if(checkRountineData==false){
			$('#myPageContainer').css('height','1400px');
		}else{
			$('#myPageContainer').css('height','1900px');
		}
	}else if(indexPrev==2){
		$('#myPageContainer').css('height','850px');
	}else{
		$('#myPageContainer').css('height','850px');
	}
}

function logOut(){
	location.href='/member/logout';
}

</script>
<!-- 뒷 배경 -->
<div id='myPageBackground'></div>
<!-- 마이페이지 전체 컨트롤러 -->
<section id='myPageContainer'>
	<!-- 사이드 메뉴: 20% -->
	<nav id='sidePage'>
		<div>
			<div id="imgDiv">
				<img src='/img/${userData.profie_img }' id='View'/>
			</div>
			<br/>
			<span>${userData.user_id }</span><br/>
			<button id='logout' class='btnClass' onclick='logOut()'>로그아웃</button>
		</div>
		<div>
			<span>My Group</span>
			<br/>
			<img src='/img/groupShow.png' id="groupShow"/>
			<br/>
			<div id="groupPageDiv">
				<c:forEach items="${PTboardData}" var="item">
					<a href='/board/ptView?board_num=${item.board_num }'>
						<div class="groupPage">
							<div>
								<img src='/ptImg/${item.pt_img_file }'/>
							</div>
							<div>
								<span>${item.title }</span>
							</div>
						</div>
					</a>
				</c:forEach>
			</div>
		</div>
	</nav>
	<!-- 메인메뉴 : 80% -->
	<!-- 메인메뉴 : 전체 데이터는 다 이 페이지로 가져오고, 페이지 네이션은 include방식으로 -->
	<section id='mainPage'>
		<!-- 페이지 출력 -->
		<div>
			<button class='pageBtn inforBtn'>개인 정보</button>
			<button class='pageBtn healthBtn'>운동 관리</button>
			<button class='pageBtn foodBtn'>식단 관리</button>
			<button class='pageBtn writeBtn'>내글 관리</button>
			<div class='pageView'>
				<%@ include file="/WEB-INF/views/mypage/inforPage.jspf" %>
			</div>
			<div class='pageView'>
				<%@ include file="/WEB-INF/views/mypage/healthPage.jspf" %>
			</div>
			<div class='pageView'>
				<%@ include file="/WEB-INF/views/mypage/foodPage.jspf" %>
			</div>
			<div class='pageView'>
				<%@ include file="/WEB-INF/views/mypage/myWritePage.jspf" %>
			</div>
		</div>
	</section>
</section>