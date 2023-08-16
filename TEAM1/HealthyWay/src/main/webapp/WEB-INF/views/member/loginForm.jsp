<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link href="${url}/css/member/loginForm.css" rel="stylesheet" type="text/css">
<script>
	$(function(){
		/* var height = window.innerHeight- $("header").height()+"px"
		console.log(height);
		$(".wrap").css("height",height)
		$(".wrap").css("background-size","100% "+height) */
		$("#logFrm").submit(function(){
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
		})
	});
</script>
<div class="loginForm-body">
	<div class="wrap">
		<section class="loginForm">
			<div id="log">
				<form method="post" action="/member/loginOk" id="logFrm">
					<div class="logFrm_btn_wrap">
						<div>	
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
						</div>
						<div class="login-btn">
							<button type="submit" value="로그인" onclick="LogFormCheck()">LOGIN</button>
						</div>
					</div>
					<div class="bottom-menu">
						<div class="bottom-menu-left">Forgot?&nbsp;&nbsp;<a href="${url}/member/findId">Find ID&nbsp;</a>/<a href="${url}/member/findPw">&nbsp;Find PW</a></div>
						<div>Not a member?&nbsp;<a href="${url}/member/memberForm">Join Us</a></div>
					</div>
				</form>
			</div>
		</section>
	</div>
</div>
