<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.joinimg {
	width: 100%;
}

.loginForm {
	margin: 0 auto;
}

#log {
	text-align: center;
}
.input-id {
	justify-content: center;
	text-align: center;
	display: flex;
}
.input-area1 {
	text-align: left;
	width: 120px;
}
.input-area2 {
	width: 300px;
	height: 30px;
}

.input-area2 input {
	width: 90%;
	height: 30px;
}

.login-btn {
	top-margin: 5px;
}
.login-btn button {
	height: 30px;
	width: 390px;
}

</style>

<div>
	<div>
		<img src="../../img/loginimg.jpg" class="joinimg" />
	</div>
	<section class="loginForm">
		<div id="log">
			<h1>Login</h1>
			<form method="post" action="/member/loginOk" id="logFrm" onsubmit="return logFormCheck()">
				
				<div class="input-id">
					<div class="input-area1">
						<label for="user_id">ID</label> 
					</div>
					<div class="input-area2">
						<input type="text" name="user_id" id="user_id" required />
					</div>
				</div>
				<div class="input-id">
					<div class="input-area1">
						<label for="user_pw">Password</label>
					</div>
					<div class="input-area2">
						<input type="password" name="user_pw" id="user_pw" autocomplete="off" required>
					</div>
				</div>
				<div class="login-btn">
					<button type="submit" value="로그인" onclick="LogFormCheck()">Login</button>
				</div>
				<div class="bottom-menu">
					<a href="${url}/member/memberFind">아이디/비밀번호 찾기</a>&nbsp;&nbsp;|&nbsp;&nbsp;
					<a href="${url}/member/memberForm">회원가입
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</div>
			</form>
		</div>
	</section>
</div>
<script>
=
	var id = document.getElementById("user_id");
	if (id.value == "") {//아이디가 없을 때
		alert("아이디를 입력하세요.");
		id.focus();//focus : 커서를 해당 객체에 위치시킨다.
		return false;
	}
	if (document.querySelector("#user_pw").value == "") {
		alert("비밀번호를 입력하세요.");
		document.querySelector("#user_pw").focus();
		return false;
	}
	//아이디와 비밀번호가 모두 입력되었을 떄    
	return true;
</script>

