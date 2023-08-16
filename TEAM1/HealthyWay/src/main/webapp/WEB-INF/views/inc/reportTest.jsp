<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
.modal{ 
	position:fixed;
	width:100%;
	height:100%;
	background:rgba(0,0,0,0.8);
	top:0;
	left:0;
	display:none;
	z-index:8;
	}
.modal_content{
	width:400px;
	background:#fff; border-radius:10px;
	position:relative; top:50%; left:50%;
	margin-top:-200px; margin-left:-200px;
	box-sizing:border-box;
	line-height:23px;
	z-index:8;
	padding:20px;
}
.modal_content div{
	font-size:1.2em;
	font-weight:bold;
	height:40px;
	line-height:40px;
	border-bottom:1px solid black;
	margin-bottom:20px;
}
.modal_content input[type=radio]{
	margin-bottom:20px;
	margin-left:5px;
	accent-color: red;
}
.modal_content textarea{
	resize:none;
	width:350px;
	height:150px;
}
.modal_content input[type=button]{
	background-color:white;
	height:40px;
	width:100px;
	border-radius:10px;
	margin-left:150px;
	cursor:pointer;
}
.modal_content input[type=submit]{
	background-color:blue;
	color:white;
	height:40px;
	width:100px;
	border-radius:10px;
	cursor:pointer;
}
</style>

<script>
$(()=>{
	$('#reportbtn').click(function(){
		modalIn()
	});
	$('#reportOk').click(function(){
		modalOut()
	});
	let reportCount=0;
	$('#reportFrm').submit(function(){
		event.preventDefault();
		if(confirm('신고하시겠습니까?')){
			if($("#reportContent").val()==""){
				alert('내용을 입력해 주세요');
				return;
			}
			if(reportCount!=0){
				alert('이미 신고한 게시글 입니다!');
				return;
			}
			$.ajax({
				url:"/report",
				data:$("#reportFrm").serialize(),
				type:'post',
				success:function(response){
					reportCount++;
					if(response>0){
						alert('신고함');						
					}else{
						alert('response가 0이네유');
					}
				},error:function(error){
					console.log(error.responseText)
				}
			})
		}else{
			alert('신고 안함');
			return;
		}
	});
})
function modalIn(){
	$(".modal").fadeIn(300);
}
function modalOut(){
	$(".modal").fadeOut(300);
}
</script>

<button id='reportbtn'>신고하기</button>

<div class="modal">
	<div class="modal_content">
		<div>신고하기</div>
		<form method='post' id='reportFrm'>
			
			<input type='hidden' name='board_num' value='258'/>
			<input type='hidden' name='report_type' value='1'/>
			
			<input type="radio" name="report_title" value="게시판 이탈" id='reportRadio1' checked>
			<label for="reportRadio1">게시판 이탈</label>
			<input type="radio" name="report_title" value="광고" id='reportRadio2'>
			<label for="reportRadio2">광고</label>
			<input type="radio" name="report_title" value="욕설" id='reportRadio3'>
			<label for="reportRadio3">욕설</label>
			<input type="radio" name="report_title" value="음란물" id='reportRadio4'>
			<label for="reportRadio4">음란물</label><br/>
			<textarea name='report_content' placeholder="최대 200자까지 작성가능 합니다." maxlength="200" id='reportContent'></textarea>
			<br/>
			<input type='button' value='취소' id='reportOk'/>
			<input type='submit' value='신고하기'/><br/>
  		</form>
	</div>
</div>
