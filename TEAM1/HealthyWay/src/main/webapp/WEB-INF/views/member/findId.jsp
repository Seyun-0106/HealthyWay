<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link href="${url}/css/member/findId.css" rel="stylesheet" type="text/css">


<!-- Bootstrap core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/modern-business.css" rel="stylesheet">

<!-- Bootstrap core JavaScript -->
<script src="jquery/jquery.min.js"></script>
<script src="js/bootstrap.bundle.min.js"></script>

<div class="findId-body">
	<div class="wrap">
		<section class="findForm">
			<div id="log">
			<h2>아이디 찾기</h2>
				<form method="post" class="form-signin" action="findUserId" name="findform">
					<div class="findFrm_btn_wrap">
						<div>
							<div class="form-label-group">
								<div class="input-area1">
									<label for="user_name">Name</label>
								</div>
								<div class="input-area2">
									<input type="text" id="user_name" name="user_name" class="form-control" />
								</div>			
							</div>
						
							<div class="form-label-group">
								<div class="input-area1">
									<label for="user_email">E-mail</label>
								</div>
								<div class="input-area2">
									<input type="text" id="user_email" name="user_email" class="form-control" />
								</div>
							</div>
						</div>
					
						<div class="find-btn">
							<button type="submit" value="FIND">FIND</button>
						</div>
					</div>
					<div class="bottom-menu">
						<!-- 이름과 이메일이 일치하지 않을 때-->
						<c:if test="${check == 1}">
							<script>
									opener.document.findform.user_name.value = "";
									opener.document.findform.user_email.value = "";
								</script>
							<label>일치하는 회원정보가 존재하지 않습니다.</label><br><br><br>
						</c:if>
					
						<!-- 이름과 이메일이 일치할 때 -->
						<c:if test="${check == 0 }">
							<div class="bottom-flex">
								<div class="bottom-id">
									<label>찾으시는 아이디는 '${user_id}' 입니다.</label>
								</div>
								<div>
									<input type="button" value="LOGIN" onclick="findClose()" class="bottom-btn">
								</div>
							</div>
						</c:if>
					</div>
					<div class="bottom-flex2">
						<div class="bottom-menu-left">Forgot?&nbsp;<a href="${url}/member/findPw" class="hovert">&nbsp;Find PW</a></div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<div>Not a member?&nbsp;<a href="${url}/member/memberForm" class="hovert">Join Us</a></div>
					</div>
				</form>
			</div>
		</section>
	</div>
</div>

<script>
	function findClose() {
		location.href="/member/loginForm";
	}
</script>

