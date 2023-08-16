<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link href="/css/home.css" rel="stylesheet" type="text/css"/>
<script src="/js/home.js"></script>
<header class="nav-bar">
  <ul>
  	<li class="logo"><a href="/"><img src="/img/logo/logo7.png"/></a></li>
  </ul>
  <ul>
  	<c:if test="${logStatus != 'Y' }">
  		<li><a href="/member/loginForm">Login</a></li>		
  	</c:if>
  	<c:if test="${logStatus == 'Y' }">  		
  		<li>
  			<div class="profile-container2 dropbtn2">
  			<c:if test="${profie_img != null }">
  				<img src="/img/${profie_img }"/>
  			</c:if>
  			<c:if test="${profie_img == null }">
  				<i class="bi bi-person-fill"></i>
  			</c:if>
  			</div>
  		</li>
  	</c:if>  
  </ul>
</header>

<!-- quick button -->
<div class="quick"><ul></ul></div>

<nav class="dropdown-content2">
	 <ul class="gnb">
	 	<li class="submenu2"><span>마이페이지</span></li>
	 	<li class="submenu2"><span>맞춤설정</span></li>
	 	<li class="submenu2"><span>로그아웃</span></li>
	 </ul>
</nav>

<div class="container">
        <div class="box">
        	<div class="cover">
        		<ul class="copywrite first">
        			<li class="Title-mask"><span class="Title-line Title-effect delayFirst">AI-training</span></li>
        			<li class="Title-mask"><span class="Title-line Title-effect delaySecond"><span class="colors">AI 트레이너</span>와 함께 운동해보세요.</span></li>
        		</ul>
  			 	<section class="btn-container form-move">
				    <button class="blob-btn">
				        <span class="blob-text">Start</span>
				        <span class="blob-btn__inner">
				            <span class="blob-btn__blobs">
				                <span class="blob-btn__blob"></span>
				                <span class="blob-btn__blob"></span>
				                <span class="blob-btn__blob"></span>
				                <span class="blob-btn__blob"></span>
				            </span>
				        </span>
				    </button>
				    <br/>
				    <svg xmlns="http://www.w3.org/2000/svg" version="1.1">
				        <defs>
				            <filter id="goo">
				                <feGaussianBlur in="SourceGraphic" result="blur" stdDeviation="10"></feGaussianBlur>
				                <feColorMatrix in="blur" mode="matrix" values="1 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 21 -7" result="goo">
				                </feColorMatrix>
				                <feBlend in2="goo" in="SourceGraphic" result="mix"></feBlend>
				            </filter>
				        </defs>
				    </svg>
				</section>
        	</div>
        		<img alt="" src="/img/home/trainning07.png">
        </div>
        <div class="box">
        	<div class="cover">
        		<ul class="copywrite second">
        			<li class="Title-mask"><span class="Title-line Title-effect delayFirst">Recipe</span></li>
        			<li class="Title-mask"><span class="Title-line Title-effect delaySecond">건강한 식단을 작성하고 <span class="colors">공유</span>해보세요.</span></li>
        		</ul>
				<section class="btn-container form-move">
				    <button class="blob-btn">
				        <span class="blob-text">Start</span>
				        <span class="blob-btn__inner">
				            <span class="blob-btn__blobs">
				                <span class="blob-btn__blob"></span>
				                <span class="blob-btn__blob"></span>
				                <span class="blob-btn__blob"></span>
				                <span class="blob-btn__blob"></span>
				            </span>
				        </span>
				    </button>
				    <br />				
				    <svg xmlns="http://www.w3.org/2000/svg" version="1.1">
				        <defs>
				            <filter id="goo">
				                <feGaussianBlur in="SourceGraphic" result="blur" stdDeviation="10"></feGaussianBlur>
				                <feColorMatrix in="blur" mode="matrix" values="1 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 21 -7" result="goo">
				                </feColorMatrix>
				                <feBlend in2="goo" in="SourceGraphic" result="mix"></feBlend>
				            </filter>
				        </defs>
				    </svg>
				</section>	
			</div>
        	<img alt="" src="/img/home/diet_true.jpg">
        </div>
        <div class="box">
        	<div class="cover">
				<ul class="copywrite third">
					<li class="Title-mask"><span class="Title-line Title-effect delayFirst">PT Group</span></li>
        			<li class="Title-mask"><span class="Title-line Title-effect delaySecond">홈트레이닝 <span class="colors">함께</span> 해보세요.</span></li>
				</ul>
				<section class="btn-container form-move">
				    <button class="blob-btn">
				        <span class="blob-text">Start</span>
				        <span class="blob-btn__inner">
				            <span class="blob-btn__blobs">
				                <span class="blob-btn__blob"></span>
				                <span class="blob-btn__blob"></span>
				                <span class="blob-btn__blob"></span>
				                <span class="blob-btn__blob"></span>
				            </span>
				        </span>
				    </button>
				    <br />
				
				    <svg xmlns="http://www.w3.org/2000/svg" version="1.1">
				        <defs>
				            <filter id="goo">
				                <feGaussianBlur in="SourceGraphic" result="blur" stdDeviation="10"></feGaussianBlur>
				                <feColorMatrix in="blur" mode="matrix" values="1 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 21 -7" result="goo">
				                </feColorMatrix>
				                <feBlend in2="goo" in="SourceGraphic" result="mix"></feBlend>
				            </filter>
				        </defs>
				    </svg>
				</section>
			</div>
        	<img alt="" src="/img/home/group01.jpg">
        </div>
        <div class="box">
	        <div class="cover">
	        	<ul class="copywrite fourth">
        			<li class="Title-mask"><span class="Title-line Title-effect delayFirst">Community</span></li>
        			<li class="Title-mask"><span class="Title-line Title-effect delaySecond">헬스에 대해 다른사람과 <span class="colors">소통</span>해보세요.</span></li>
        		</ul>
				<!-- <p class="copywrite fourth">
					<span class="blur-animation">It's</span>
					<span class="blur-animation">all</span>
					<span class="blur-animation">becoming</span>
					<span class="blur-animation">clear</span>
					<span class="blur-animation">to</span>
					<span class="blur-animation">me</span>
					<span class="blur-animation">now</span>
				</p> -->
				<section class="btn-container form-move">
				    <button class="blob-btn">
				        <span class="blob-text">Start</span>
				        <span class="blob-btn__inner">
				            <span class="blob-btn__blobs">
				                <span class="blob-btn__blob"></span>
				                <span class="blob-btn__blob"></span>
				                <span class="blob-btn__blob"></span>
				                <span class="blob-btn__blob"></span>
				            </span>
				        </span>
				    </button>
				    <br />
				
				    <svg xmlns="http://www.w3.org/2000/svg" version="1.1">
				        <defs>
				            <filter id="goo">
				                <feGaussianBlur in="SourceGraphic" result="blur" stdDeviation="10"></feGaussianBlur>
				                <feColorMatrix in="blur" mode="matrix" values="1 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 21 -7" result="goo">
				                </feColorMatrix>
				                <feBlend in2="goo" in="SourceGraphic" result="mix"></feBlend>
				            </filter>
				        </defs>
				    </svg>
				</section>
			</div>
	        <img alt="" src="/img/home/community04.jpg">
        </div>
</div>