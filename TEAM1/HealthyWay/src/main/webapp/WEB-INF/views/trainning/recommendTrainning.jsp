<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/css/train/recommend.css">
    

    <ul id="menu">
        <li><a class="li-a" href="/trainning/trainningHome">트레이닝 센터</a></li>
        <li><a class="li-a" href="/trainning/myTrainning">나만의 운동</a></li>
        <li><a class="active" href="/trainning/recommendTrainning">추천 운동 목록</a></li>
    </ul>
    
    <div class="head_img">
		<%-- <img src="${url}/img/ptList_top.png"> --%>
		<video muted autoplay loop id="video">
			<source src="${url}/img/aiVideo.mp4" type="video/mp4">
		</video>
		<h1>FIND YOUR HEALHTY MATE</h1>
		<P><button class="del-btn" onclick="location.href='/trainning/trainningHome'">해보기</button></P>
	</div>
    
    <div class="mytrain-frm">
        <h2>04 May Wed</h2>
        <h2>추천 운동 루틴</h2>
        
        <div>
            <h3>가슴운동</h3><p>운동 설명 가나다라마바사아자카차타파하</p>
            <p><button class="del-btn">해보기</button></p>
            <ul class="my_trainList">
                <li class="my-list"><a href="#"><img src="/img/이미지 없음.png" alt=""><p>운동이름</p><p>운동설명</p></a></li>
                <li class="my-list"><a href="#"><img src="/img/이미지 없음.png" alt=""><p>운동이름</p><p>운동설명</p></a></li>
                <li class="my-list"><a href="#"><img src="/img/이미지 없음.png" alt=""><p>운동이름</p><p>운동설명</p></a></li>
                <li class="my-list"><a href="#"><img src="/img/이미지 없음.png" alt=""><p>운동이름</p><p>운동설명</p></a></li>
                <li class="my-list"><a href="#"><img src="/img/이미지 없음.png" alt=""><p>운동이름</p><p>운동설명</p></a></li>
            </ul>
            <hr>    
        </div>
	</div>
    