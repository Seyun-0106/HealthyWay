// 제출하기 클릭시
function QuestionCheck() {
	// 키 입력 확인
	let height = document.getElementById("height");
	if(height.value == '') {
		alert("키를 입력하세요");
		height.focus();
		return false;
	}
	
	// 몸무게 입력 확인
	let weight = document.getElementById("weight");
	if(weight.value == '') {
		alert("몸무게를 입력하세요");
		weight.focus();
		return false;
	}
	
	return true;
}