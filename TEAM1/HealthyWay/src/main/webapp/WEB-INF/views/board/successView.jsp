<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="${url}/css/board/boardView.css">

<script>
$(function() {
	// 댓글 목록
	function replyListAll(){
		var url = "${url}/reply/list";
		var params = "board_num=" + ${bvo.board_num};
		
		$.ajax({
			url: url,
			data: params,
			success: function(result){
				var $result = $(result);
				var tag = "<ul>";
				$result.each(function(idx, vo){
					tag += "<li class='reply_wrap'>";
					tag += "<div class='id_date_wrap'>";
					tag += "<div class='reply_id'>" + vo.user_id + "</div>";
					tag += "<div class='reply_date'>" + vo.reply_date + "</div>";
					tag += "</div>";
					tag += "<div class='content_btn_wrap'>";
					tag += "<div class='reply_contnet'>" + vo.content + "</div>";
					tag += "<div class='reply_btn_wrap'>";
					
					if(vo.user_id == '${logId}'){
						tag += "<button class='reply_edit_btn'>수정</button>";
						tag += "<button class='reply_del_btn' title='" + vo.reply_num + "'>삭제</button>";
					}
					tag += "</div>";
					tag += "</div>";
					
					/* 수정폼 */
					tag += "<div class='reply_edit_input' style='display: none'>";
					tag += "<form method='post' class='editFrm'>";
					tag += "<input type='hidden' name='reply_num' value='"+vo.reply_num+"'>";
					tag += "<input type='text' name='content' value='" + vo.content + "'>";
					tag += "<input type='submit' value='수정'>";
					tag += "</form></div>";
					tag += "</li>";
				});
				tag += "</ul>";
				
				$("#replyList").html(tag);
			},
			error: function(e){
				console.log(e.responseText);
			}
		});
	}
	
	// 댓글 등록
	$("#replyFrm").submit(function(){
		event.preventDefault();
		
		if($("#content").val() == ''){
			alert("내용을 입력 후 등록해 주세요.");
			return false;
		}else{
			var params = $("#replyFrm").serialize();
			
			$.ajax({
				url : "${url}/reply/writeOk",
				data : params,
				type : "post",
				success : function(result){
					$("#content").val("");
					
					// 댓글 목록 초기화
					replyListAll();
				},
				error : function(e){
					console.log(e.responseText)
				}
			});
		}
	});
	
	// 댓글 수정 버튼 누르면 폼 노출
	$(document).on("click", ".reply_edit_btn", function(){
		$(this).parent().parent().css("display", "none");
		$(this).parent().parent().next().css("display", "block");
	});
	
	// 댓글 수정(DB)
	$(document).on("submit", ".editFrm", function(){
		event.preventDefault();
		
		var url = "${url}/reply/editOk";
		var params = $(this).serialize();
		
		$.ajax({
			url: url,
			data: params,
			type: 'post',
			success: function(result){
				replyListAll();
			},
			error: function(e){
				console.log(e.responseText);
			}
		});
	});
	
	// 댓글 삭제(DB)
	$(document).on("click", ".reply_del_btn", function(){
		if(confirm("댓글을 삭제하시겠습까?")){
			var params = "reply_num="+$(this).attr("title");
			
			$.ajax({
				url : '${url}/reply/del',
				data : params,
				success : function(result){
					replyListAll();
				},
				error : function(e){
					console.log(e.responseText);
				}
			});
		}
	});
		
	replyListAll();
    
  	//신고하기 모달 jquery작성
    $('.warnIcon').click(function(){
       $(".modal").fadeIn(300);
    });
    
    $('#reportOk').click(function(){
       $(".modal").fadeOut(300);
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
             url:"/master/reportInsert",
             data:$("#reportFrm").serialize(),
             type:'post',
             success:function(response){
                reportCount++;
                if(response>0){
                   alert('신고가 접수되었습니다.');                  
                }else{
                   alert('신고가 되지 않았습니다. - 이유 불명 - ');
                }
                $(".modal").fadeOut(300);
             },error:function(error){
                console.log(error.responseText)
             }
          })
       }else{
          alert('신고 안함');
          return;
       }
    });
 });
 
//글 삭제 확인
function del(){
	if(confirm("삭제하시겠습니까?")){
			// 확인버튼 선택시
			location.href = "${url}/successDel?board_num=${bvo.board_num}&img_file1=${bvo.img_file1}&img_file2=${bvo.img_file2}";
		}
}
</script>

<div class="wrap">
	<h1>성공스토리</h1>
	<ul id="viewList">
		<li class="title">${bvo.title}</li>
		<li class="write_date">${bvo.write_date}</li>
		<li class="hit">조회수 ${bvo.hit}</li>
		<li class="img">
			<div class="img_wrap" id="before_img">
				<div class="real_img_wrap"><img src="/successImg/${bvo.img_file1}"></div>
				<div id="before_bottom">BEFORE</div>
			</div>
			<div class="img_wrap" id="after_img">
				<div class="real_img_wrap"><img src="successImg/${bvo.img_file2}"></div>
				<div id="after_bottom">AFTER</div>
			</div>
		</li>
		<li class="content" style="height: 20vh">
			<textarea class="content_text" readonly>${bvo.content}</textarea>
		</li>
		<li class="writer">
			<div class="writer_profile">
				<div class="writer_img"><img src="${url}/img/${bvo.profie_img}"></div>
				<div class="writer_id">${bvo.user_id}</div>
			</div>
		</li>
		<li class="report">
			<button class="warnIcon"><img src="${url}/img/report_img.png"> 신고</button>
		</li>
		<li class="edit_del_wrap">
			<c:if test="${bvo.user_id == logId}">
				<button onclick="location='/successEdit?board_num=${bvo.board_num}'">수정</button>
				<button id="btn_delete" onclick="location='javascript:del()'">삭제</button>
			</c:if>
		</li>
	</ul>
	<!-- 댓글 -->
	<div class="reply_all_wrap">
		<h3>댓글</h3>
		<form method="post" id="replyFrm">
			<input type="hidden" name="board_num" value="${bvo.board_num}">
			<div class="reply_write_wrap">
			<input type="text" name="content" id="content" placeholder="댓글을 입력해주세요">
			<input type="submit" value="등록">
			</div>
		</form>
		<!-- 댓글 리스트 들어가는 자리 -->
		<div id="replyList"></div>
	</div>
	<div id="backBtn_wrap">
		<button onclick="location.href='/successList'">목록</button>
	</div>
	
	<!-- 신고하기 모달창 추가 -->
	<div class="modal">
	   <div class="modal_content">
	      <div><img src="/recipeImg/warnIcon.png"/>신고하기<img src="/recipeImg/warnIcon.png"/></div>
	      <form method='post' id='reportFrm'>
	         
	         <input type='hidden' name='write_id' value='${bvo.user_id}'/>
	         <input type='hidden' name='board_num' value='${bvo.board_num}'/>
	         <input type='hidden' name='report_type' value='3'/>
	         
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
	         <ul class="modalBtn">
	            <li><input type='button' value='취소' id='reportOk'/></li>
	            <li><input type='submit' value='신고하기'/><br/></li>
	         </ul>
	        </form>
	   </div>
	</div>
</div>