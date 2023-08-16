<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${url}/css/member/memberForm.css">
<script src="/js/member/memberForm.js"></script>
<div class="memberForm-body">
	<div class="wrap">
		<div class="memberForm">
			<h1>Healthy Way와 함께<br>
				건강한 운동 경험을 얻어가세요!</h1>
			<form method="post" action="/member/memberOk" id="mFrm" onsubmit="return MemberCheck()">
	            <ul>
	            	<li>아이디</li>
	            	<li>
	            		<input type='text' name='user_id' id='user_id' placeholder='아이디 입력' required/><br>
						<span id='chk'></span>
						<input type="text" id='idchk' value="N" style="display:none;">
	            	</li>
					<li>닉네임</li>
					<li>
		            	<input type='text' name='user_nickname' id='user_nickname' placeholder='닉네임 입력' required/><br>
						<span id='chkN'></span>
						<input type="text" id='stateNickChk' value="N" style="display:none;">
					</li>
					<li>비밀번호</li>
					<li>
						<input type="password" name="user_pw" id="user_pw" autocomplete="off" required/>
					</li>
					<li>비밀번호 확인</li>
					<li>
						<input type="password" name="user_pw2" id="user_pw2" autocomplete="off" required/>
					</li>
					<li>이름</li>
					<li>
						<input type="text" name="user_name" id="user_name" required/>
					</li>
					<li>연락처</li>
					<li>
						<input type='text' name='tel' id='tel' placeholder='예시) 01012341234' required/><br>
						<span id='chkT'></span>
						<input type="text" id='telChk' value="N" style="display:none;">
					</li>
					<li>이메일</li>
					<li>
		            	<input type='text' name='user_email' id='user_email' placeholder='예시) healthyWay@naver.com' required/><br>
						<span id='chkE'></span>
						<input type="text" id='EmailChk' value="N" style="display:none;">
					</li>
					<li>나이</li>
					<li>
						<input type='text' name='age' required/>
					</li>
					<li style="float: left; margin-right: 30px;">성별</li>
					<li  style="margin-top: 10px;">
						<label><input type="radio" name="gender" value="M" required>남</label>&nbsp;&nbsp;&nbsp;
						<label><input type="radio" name="gender" value="W" required>여</label>
					</li>
					<li>
	            		<button type="submit" onclick="MemberCheck()">가입하기</button>
	            	</li>
	    		</ul>
	        </form>
	        <div class="check_account">이미 계정이 있으신가요?&nbsp;&nbsp;<a href="${url}/member/loginForm">로그인</a></div>
	
		</div>
		<div class="img_wrap">
			<img src="${url}/img/join_img.jpeg">
		</div>
	</div>
</div>

