//아이디 정규식
var idJ = /^[a-z0-9]{5,20}$/;

$("#member_id").focusout(function() {
	if ($('#member_id').val() == "") {
		$('#checks').text('아이디를 입력해주세요.');
		$('#checks').css('color', 'red');
	}
});

$("#member_id").focusout(function() {
	if (!idJ.test($(this).val())) {
		$('#checks').text('5~20자의 영문 소문자, 숫자만 사용가능합니다');
		$('#checks').css('color', 'red');
	}
});

$("#name").focusout(function() {
	if ($('#name').val() == "") {
		$('#checks').text('이름을 입력해주세요.');
		$('#checks').css('color', 'red');
	}
});

$("#email").focusout(function() {
	if ($('#email').val() == "") {
		$('#checks').text('이메일을 입력해주세요');
		$('#checks').css('color', 'red');
	}
});