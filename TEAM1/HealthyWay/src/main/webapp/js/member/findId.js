
$("#name").focusout(function() {
	if ($('#name').val() == "") {
		$('#check').text('이름을 입력해주세요.');
		$('#check').css('color', 'red');
	} else {
		$('#check').hide();
	}
});
$("#email").focusout(function() {
	if ($('#email').val() == "") {
		$('#check').text('이메일을 입력해주세요');
		$('#check').css('color', 'red');
	} else {
		$('#check').hide();
	}
});

/*function FindUserId() {
	const user_name = document.getElementById("user_name");
	const user_email = document.getElementById("user_email")
	const body = {
		user_name: user_name.value,
		user_email: user_email.value
	}
	axios.post("/member/findUserId", body)
		.then((res) => {
			if (res.data === '') {
				document.getElementById("showStateFindId").innerText = "일치하는 회원정보가 없습니다";
				document.getElementById("showStateFindId").className = "state";
			} else {
				const encryptionUserId = res.data.userId.replace(/(?<=.{3})./gi, "*");
				document.getElementById("showStateFindId").innerText = `찾으시는 아이디는 ${encryptionUserId} 입니다`;
				document.getElementById("showStateFindId").className = "stateOk";
			}
			document.getElementById("showStateFindPwd").innerText = "가입시 입력한 아이디와 이메일을 입력해주세요";
			document.getElementById("showStateFindPwd").className = "state";
			document.getElementById("findPwdButton").disabled = false;
		})
		.catch((res) => {
			console.log("error");
			console.log(res);
		})

}*/

function closethewindow() {
	if(confirm('로그인 창으로 이동하시겠습니까?')) {
		location.href="/member/loginForm";
	}
}
