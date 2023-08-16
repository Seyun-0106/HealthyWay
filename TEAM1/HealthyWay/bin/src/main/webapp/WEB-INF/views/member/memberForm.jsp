<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.joinimg {
	width: 100%;
}
.memberForm {
	margin: 0 40% auto;
	padding: 0 auto;
}
.member-input {
	width: 100px;
}
.member-input input {
	width: 300px;
	height: 30px;
}
h1 {
	color: black;
}
</style>
<div>
	<div>
		<img src="../../img/welcomeimg.jpg" class="joinimg" />
	</div>
	<div class="memberForm">
		<form method="post" action="/member/memberOk" id="mFrm" onsubmit="return MemberCheck()">
            <div class="member-input">
                <input type="text" name="user_id" id="user_id" onkeyup="CheckId()" required/>
                <label>아이디</label>
                <span id="stateIdChk" class="state">아이디를 입력하세요</span>
            </div>
            <div class="member-input">
                <input type="text" name="user_nickname" id="user_nickname" onkeyup="CheckNick()" required/>
                <label>닉네임</label>
                <span id="stateNickChk" class="state">닉네임을 입력하세요</span>
            </div>
            <div class="member-input">
                <input type="password" name="user_pw" id="user_pw" required/>
                <label>비밀번호</label>
            </div>
            <div class="member-input">
                <input type="password" name="user_pw2" id="user_pw2" required/>
                <label>비밀번호확인</label>
            </div>
            <div class="member-input">
                <input type="text" name="user_name" id="user_name" required/>
                <label>이름</label>
            </div>
            <div class="radio">
                <label>성별:&nbsp;&nbsp;&nbsp;</label>
                <label><input type="radio" name="gender" value="M" required>남</label>
                &nbsp;&nbsp;&nbsp;
                <label><input type="radio" name="gender" value="W" required>여</label>
            </div>
            
            <div class="tel">
                <input type="text" name="tel" id="tel" maxlength="15" required/>
                <label>연락처</label>
            </div>
            <div class="date">
                <label>나이: </label>
                <input type='text' name='age' required/>
            </div>
            <div class="member-input">
                <input type="text" name="user_email" id="user_email" required/>
                <label>이메일</label>
            </div>
            <div class="join-btn">
                <button type="submit" onclick="MemberCheck()">가입하기</button>
            </div>

        </form>
	</div>
</div>
<script>
function MemberCheck() {
    //비밀번호 체크
    const user_pw = document.getElementById("user_pw");
    const user_pw2 = document.getElementById("user_pw2");
    var pwdCheck = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/;
    if(!user_pw.value || !user_pw2.value){
        alert("비밀번호를 입력하세요");
        user_pw.focus();
        return false;
    }
    if(user_pw.value!=user_pw2.value){
        alert("비밀번호가 일치하지 않습니다.");
        user_pw.focus();
        return false;
    }
    if(!pwdCheck.test(user_pw.value)){
        alert("비밀번호는 영문, 숫자, 특수기호를 조합으로 8~25자를 입력해야합니다.");
        user_pw.focus();
        return false;
    }
    //-----------------------------------------------비밀번호 체크 끝

    //이름 체크
    const user_name = document.getElementById("user_name")
    var nameCheck = /^[가-힣]{2,4}$/;
    if(!user_name.value){
        alert("이름을 입력하세요");
        user_name.focus();
        return false;
    }
    if(!nameCheck.test(user_name.value)){
        alert("한글만 입력 가능합니다.(최대 4글자)");
        user_name.focus();
        return false;
    }
    //--------------------------------------------------이름 끝
    
    //연락처 체크
    const tel = document.getElementById("tel")
    var regExp = /^[0-9]{7,15}$/;
    if(!regExp.test(tel.value)){
        alert("연락처 형식에 맞게 작성해주세요.");
        tel.focus();
        return false;
    }
    
    const user_email = document.getElementById("user_email")
    var emailCheck = /^[a-z0-9\.\-_]+@([a-z0-9\-]+\.)+[a-z]{2,6}$/;

    if(!user_email.value){
        alert("이메일을 입력해주세요.");
        userEmail.focus();
        return false;
    }

    if(!emailCheck.test(user_email.value)) {
        alert("이메일 형식으로 입력해주세요.")
        user_email.focus();
        return false;
    }
}
function CheckTel() {
    const tel = document.getElementById("tel").value;
    const regExp = /^[0-9]{7,15}$/;
    if(!regExp.test(tel)){
        document.getElementById("statePhoneChk").innerText = "연락처 형식에 맞게 입력해주세요";
        return;
    }
    const body = {
    	tel : tel,
    }
    axios.post("/member/checkTel",body)
        .then((res) => {
            if(res.data!=="") {
                document.getElementById("statePhoneChk").innerText = "이미 사용중인 휴대폰 번호입니다";
            } else {
                SendPhoneCheck();
            }
        })
}
function CheckId () {
    const user_id = document.getElementById("user_id").value;
    const idCheck =  /^[A-za-z0-9]{6,15}$/g;
    if(!idCheck.test(user_id)){
        document.getElementById("stateIdChk").innerText = "아이디는 영문, 숫자 조합 6~15자를 입력해야 합니다.";
        document.getElementById("stateIdChk").className = "state"
        return;
    }
    const body = {
		user_id : user_id
    }
    axios.post("/member/checkId", body)
        .then((res) => {
            if(res.data!==""){
                document.getElementById("stateIdChk").innerText = "이미 사용중인 아이디입니다.";
                document.getElementById("stateIdChk").className = "state";
            } else {
                document.getElementById("stateIdChk").innerText = "사용 가능한 아이디입니다.";
                document.getElementById("stateIdChk").className = "stateOk";
            }
        })
        .catch((error) => {
            console.log(error)
        })
}
function CheckNick() {
    const user_nickname = document.getElementById("user_nickname").value;
    if(!nickname){
        document.getElementById("stateNickChk").innerText = "닉네임을 입력하세요";
        document.getElementById("stateNickChk").className = "state";
        return;
    }
    if(nickname.length>10){
        document.getElementById("stateNickChk").innerText = "닉네임은 최대 10글자까지 사용가능합니다.";
        document.getElementById("stateNickChk").className = "state";
        return;
    }
    const body = {
    		user_nickname : user_nickname
    }
    axios.post("/member/checkNick", body)
        .then((res) => {
            if(res.data!==""){
                document.getElementById("stateNickChk").innerText = "이미 사용중인 닉네임입니다.";
                document.getElementById("stateNickChk").className = "state";
            } else {
                document.getElementById("stateNickChk").innerText = "사용 가능한 닉네임입니다.";
                document.getElementById("stateNickChk").className = "stateOk";
                nickPass = true;
            }
        })
        .catch((error) => {
            console.log(error)
        })
}

</script>