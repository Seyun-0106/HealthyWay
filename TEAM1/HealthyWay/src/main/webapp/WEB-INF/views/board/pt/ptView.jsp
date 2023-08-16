<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="${url}/css/board/pt/ptView.css" type="text/css" />
<link rel="stylesheet" href="https://fonts.sandbox.google.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<script src="${url}/js/board/pt/ptView.js"></script>
<script>

$(function(){
	// 그룹pt 참가신청
	$(".applyBtn").click(function(){
		apply();
	});
	
	// 글작성자일 경우 관리자 메뉴 클릭가능
	if(${lVO.user_id == logId}){
		$("#menu_manage").click(function(){
			$(".all_content").css("display", "none");
			$(".manage_wrap").css("display", "block");

			$(".all_menu").css("background-color", "#FCFCFC");
			$(".all_menu").css("color", "gray");
			$(".all_menu").css("border", "1px solid #E4E5E5").css("border-bottom", "1px solid gray").css("border-left", "none");
			$("#menu_info").css("border-left", "1px solid #E4E5E5");
			
			$(this).css("border", "1px solid gray").css("border-bottom", "none");
			$(this).css("background-color", "#fff").css("color","#000");
			$(this).children('span').text("lock_open");
			$("#menu_qna").children('span').text("lock");
		});
	}
	
	// 참가자 목록 가져오는 함수
	function apply_listAll(){
		var url = "${url}/board/apply_list";
		var params = "board_num=${vo.board_num}";
		
		$.ajax({
			url: url,
			data: params,
			success: function(result){
				if(result.length > 0){
					var $result = $(result);
					var tag = "<li>상태</li>";
						tag += "<li>아이디</li>";
						tag += "<li>닉네임</li>";
						tag += "<li>성별</li>";
						tag += "<li>나이</li>";
						tag += "<li>키</li>";
						tag += "<li>몸무게</li>";
						tag += "<li>&nbsp;</li>";
						tag += "<li>&nbsp;</li>";
						
					var W = "W";
					$result.each(function(idx, vo){
						tag += "<li>" + vo.user_state + "</li>";
						tag += "<li class='apply_id'>" + vo.user_id + "</li>";
						tag += "<li>" + vo.user_nickname + "</li>";
						if(vo.gender == "W"){
							tag += "<li>여</li>";
						}else{
							tag += "<li>남</li>";
						}
						tag += "<li>" + vo.age + "세</li>";
						if(vo.height == 0){
							tag += "<li>미공개</li>";
						}else{
							tag += "<li>" + vo.height + "cm</li>";
						}
						if(vo.weight == 0){
							tag += "<li>미공개</li>";
						}else{
							tag += "<li>" + vo.weight + "kg</li>";
						}
						
						// status가 참여중이라면 숨기기
						if(vo.user_state == "참여중"){
							tag += "<li><button class='resignBtn' style='padding: 3px 6px;'><span class='material-symbols-outlined' style='font-size: 16px; vertical-align: sub;'>warning</span> 탈퇴</button></li>";
							tag += "<li><button class='denyBtn' style='display: none;'>거절</button></li>"
						}else{
							tag += "<li><button class='acceptBtn'>수락</button></li>";
							tag += "<li><button class='denyBtn'>거절</button></li>";
						}
							
					});		
				}else{
					var tag = "아직 참여자가 없습니다.";
				}
				$(".manage_list").html(tag);
				
			},
			error: function(e){
				console.log(e.responseText);
			}
		});
		
	}

	// 관리자 -> 참가 수락
	$(document).on("click", ".acceptBtn", function(){
		if(confirm("수락하시겠습니까?")){
			var url = "/board/applyAccept";
			var params = "board_num=${vo.board_num}&user_id=" + $(this).parent().prev().prev().prev().prev().prev().prev().text() + "&max_user=${vo.max_user}";

			$.ajax({
				url: url,
				data: params,
				success: function(result){
					apply_listAll();
				},
				error: function(e){
					console.log(e.responseText);
				}
			});
		}
	});
	
	// 관리자 -> 참가 거절
	$(document).on("click", ".denyBtn", function(){
		if(confirm("거절하시겠습니까?")){
			var url = "/board/applyDeny";
			var params = "board_num=${vo.board_num}&user_id=" + $(this).parent().prev().prev().prev().prev().prev().prev().prev().text();
			
			$.ajax({
				url: url,
				data: params,
				success: function(result){
					apply_listAll();
				},
				error: function(e){
					console.log(e.responseText);
				}
			});
		}
	});
	
	// 관리자 -> 탈퇴
	$(document).on("click", ".resignBtn", function(){
		if(confirm("선택한 그룹멤버를 탈퇴시겠습니까?")){
			var url = "/board/applyDeny";
			var params = "board_num=${vo.board_num}&user_id=" + $(this).parent().prev().prev().prev().prev().prev().prev().text();
			
			$.ajax({
				url: url,
				data: params,
				success: function(result){
					apply_listAll();
				},
				error: function(e){
					console.log(e.responseText);
				}
			});
		}
	});
	
	// 댓글 목록
	function replyListAll(){
		var url = "${url}/reply/list";
		var params = "board_num=" + ${vo.board_num};
		
		$.ajax({
			url: url,
			data: params,
			success: function(result){
				var $result = $(result);
				
				var tag = "<ul>";
				$result.each(function(idx, vo){
					tag += "<li class='reply_wrap'>";
					tag += "<div class='id_date_wrap'>";
					tag += "<div class='reply_id'>" + vo.user_nickname + " (" +vo.user_id + ")" + "</div>";
					tag += "<div class='reply_date'>" + vo.reply_date + "</div>";
					tag += "</div>";
					tag += "<div class='reply_content'>" + vo.content + "</div>";
					
					/* 수정폼 */
					tag += "<div class='reply_edit_input' style='display: none'>";
					tag += "<form method='post' class='editFrm'>";
					tag += "<input type='hidden' name='reply_num' value='"+vo.reply_num+"'>";
					tag += "<input type='text' name='content' value='" + vo.content + "'>";
					tag += "<input type='submit' value='수정'>";
					tag += "</form></div>";

					
					if(vo.user_id == '${logId}'){
						tag += "<div class='reply_btn_wrap'>";
						
						tag += "<button class='reply_edit_btn'>수정</button>";
						tag += "<button class='reply_del_btn' title='" + vo.reply_num + "'>삭제</button>";
						tag += "</div>";
					}
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
		$(this).parent().prev().prev().css("display", "none");
		$(this).parent().prev().css("display", "block");
		$(this).css("display", "none");
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
	apply_listAll();
	
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

// 글 삭제 확인
function del(){
	if(confirm("삭제하시겠습니까?")){
			// 확인버튼 선택시
			location.href = "${url}/board/ptDel?board_num=${vo.board_num}&pt_img_file=${vo.pt_img_file}";
		}
}
function qnaClick(){
	$("#menu_qna").click(function(){
		$(".all_content").css("display", "none");
		$(".comment_wrap").css("display", "block");

		$(".all_menu").css("background-color", "#FCFCFC");
		$(".all_menu").css("color", "gray");
		$(".all_menu").css("border", "1px solid #E4E5E5").css("border-bottom", "1px solid gray").css("border-left", "none");
		$("#menu_info").css("border-left", "1px solid #E4E5E5");
		
		$(this).css("border", "1px solid gray").css("border-bottom", "none");
		$(this).css("background-color", "#fff").css("color","#000");
		$("#menu_manage").children('span').text("lock");
		
		$(this).children('span').text("lock_open");
	});
}

// 그룹pt 참가신청
function apply(){
	if(confirm("참여하시겠습니까?")){
		event.preventDefault();
		
		$.ajax({
			url: "/board/ptApply?board_num=${vo.board_num}",
			type: 'get',
			success: function(result){
				if(result > 0){
					alert("참가 신청이 완료됐습니다. 리더의 승인이 필요합니다.");
					location = "${url}/board/ptView?board_num=${vo.board_num}";
				}	
			},
			error: function(e){
				console.log(e.responseText);
			}
		});
	}
}
</script>

<div class="wrap">
	<div class="head_wrap">
		<span id="keyword">${vo.keyword}</span>
		<h1>${vo.title}</h1>
		<span id="state">${vo.state}</span>
	</div>
	
	<div class="main_wrap">
		<div class="main_content_wrap">
			<ul class="menu_list">
				<li id="menu_info" class="all_menu">정보</li>
				<li id="menu_member" class="all_menu">멤버</li>
				<li id="menu_qna" class="all_menu"
					<c:choose>
						<c:when test="${empty pList}">
							<c:if test="${lVO.user_id == logId}">
								onclick="qnaClick()";
							</c:if>
							<c:if test="${lVO.user_id != logId}">
								style="cursor: no-drop;"
							</c:if>
						</c:when>
						<c:otherwise>
							<c:set var="pCnt" value="0"/>
							<c:forEach var="pVO" items="${pList}">
								<c:if test="${pVO.user_id == logId}">
									<c:set var="pCnt" value="${pCtn + 1}"/>
								</c:if>
							</c:forEach>
							<c:if test="${pCnt == 0 and lVO.user_id != logId}">
								style="cursor: no-drop;"
							</c:if>
							<c:if test="${pCnt > 0 or lVO.user_id == logId}">
								onclick="qnaClick()";
							</c:if>
						</c:otherwise>
					</c:choose>
				>소통방 <span class="material-symbols-outlined" style="vertical-align: sub;">lock</span></li>
				<li id="menu_manage" class="all_menu" <c:if test="${lVO.user_id != logId}">style="cursor: no-drop;"</c:if>>관리 <span class="material-symbols-outlined" style="vertical-align: sub;">lock</span></li>
			</ul>
			
			<div class="recu_status_wrap all_content">
				<h2>모집 현황</h2>
				<ul>
					<li>리더</li>
					<li>1/1</li>
					<li style="border: none;">&nbsp;</li>
					<li>&nbsp;</li>
					<li>멤버</li>
					<li>${pCount}/${vo.max_user}</li>
					<c:if test="${lVO.user_id == logId}">
						<li style="border: none;">&nbsp;</li>
					</c:if>
					<c:if test="${lVO.user_id != logId and pCount < vo.max_user}">
						<li style="border: none;">&nbsp;</li>
					</c:if>
					<c:if test="${lVO.user_id != logId and pCount == vo.max_user}">
						<li style="border: none;">&nbsp;</li>
					</c:if>
					<li>&nbsp;</li>
				</ul>
				
			</div>
			
			<div class="content_wrap all_content">
				<h2>내용</h2>
				<p>
					${vo.content}
				</p>
			</div>
			
			<div class="member_wrap all_content" style="display: none">
				<h2>-리더</h2>
				<div class="main_member_leader_wrap">
					<div class="member_profile">
						<ul>
							<li class="main_member_img_wrap"><img src="/img/${lVO.profie_img}"></li>
							<li>${lVO.user_nickname} (${lVO.user_id})</li>
							<li>나이 : ${lVO.age}</li>
							<li>
								Height : 
								<c:if test="${lVO.height == null or lVO.height == 0.0}">비공개</c:if>
								<c:if test="${lVO.height != null and lVO.height != 0.0}">${lVO.height}cm</c:if> 
							</li>
							<li>
								성별 : 
								<c:if test="${lVO.gender == 'W'}">여자</c:if>
								<c:if test="${lVO.gender == 'M'}">남자</c:if>
							</li>
							<li>
								Weight : 
								<c:if test="${lVO.weight == null or pVO.weight == 0}">비공개</c:if>
								<c:if test="${lVO.weight != null and pVO.weight != 0}">${lVO.weight}kg</c:if> 
							</li>
						</ul>
					</div>
				</div>
				<h2>-멤버</h2>
				<div class="main_member_wrap">
					<c:forEach var="pVO" items="${pList}">
						<div class="member_profile">
							<ul>
								<li class="main_member_img_wrap"><img src="/img/${pVO.profie_img}"></li>
								<li>${pVO.user_nickname} (${pVO.user_id})</li>
								<li>나이 : ${pVO.age}세</li>
								<li>
									Height : 
									<c:if test="${pVO.height == null or pVO.height == 0.0}">비공개</c:if>
									<c:if test="${pVO.height != null and pVO.height != 0.0}">${pVO.height}cm</c:if> 
								</li>
								<li>
									성별 : 
									<c:if test="${pVO.gender == 'W'}">여자</c:if>
									<c:if test="${pVO.gender == 'M'}">남자</c:if>
								</li>
								<li>
									Weight : 
									<c:if test="${pVO.weight == null or pVO.weight == 0}">비공개</c:if>
									<c:if test="${pVO.weight != null and pVO.weight != 0}">${pVO.weight}kg</c:if> 
								</li>
							</ul>
						</div>
					</c:forEach>
				</div>
			</div>
			
			<div class="comment_wrap all_content" style="display: none">
				<form method="post" id="replyFrm">
					<input type="hidden" name="board_num" value="${vo.board_num}">
					<input type="text" name="content" id="content" placeholder="질문을 입력해주세요.">
					<input type="submit" value="등록하기">
				</form>
				<div id="replyList">
				</div>
				
			</div>
			
			<div class="manage_wrap all_content" style="display: none;">
				<h2>참여자</h2>
				<ul class="manage_list">
				</ul>
			</div>
			
		</div>
		
		<div class="right_wrap">
			<div class="leader_profile_wrap">
				<div class="profile_info_wrap">
					<h4>리더정보</h4>
					<div class="leader_img_wrap"><img src="/img/${lVO.profie_img}"></div>
					<div class="leader_name_wrap">
						${lVO.user_nickname} (${lVO.user_id})
					</div>
				</div>
				<div class="profile_info_wrap">
					<h4>활동 기간</h4>
					${vo.start_date} ~ ${vo.end_date} (${vo.datecal}일)
				</div>
				<div>
					<h4>그룹 멤버 (${pCount}명)</h4>
					<c:forEach var="pVO" items="${pList}">
						<div class="group_member_wrap">
							<div class="member_img_wrap"><img src="/img/${pVO.profie_img}"></div>
							<div class="member_name_wrap">${pVO.user_nickname} (${pVO.user_id})</div>
						</div>
					</c:forEach>
				</div>
				
	
				<c:if test="${vo.state != '모집완료'}">
					<c:choose>
						<c:when test="${empty aList}">
							<button class="applyBtn"<c:if test="${lVO.user_id == logId}">style="display: none;"</c:if>>참여하기</button>
						</c:when>
						<c:otherwise>
							<c:set var="cnt" value="0"/>
								<c:forEach var="aVO" items="${aList}">
									<c:if test="${aVO.user_id == logId}">
										<c:set var="cnt" value="${cnt + 1}"/>
										<c:set var="userState" value="${aVO.user_state}"/>
									</c:if>
								</c:forEach>
								<c:choose>
									<c:when test="${cnt == 0}">
										<button class="applyBtn"<c:if test="${lVO.user_id == logId}">style="display: none;"</c:if>>참여하기</button>
									</c:when>
									<c:otherwise>
										<c:if test="${userState ==  '참여중'}">
											<button style="cursor: initial;<c:if test="${lVO.user_id == logId}">display: none;</c:if>">참여중</button>
										</c:if>
										<c:if test="${userState == '대기중'}">
											<button style="cursor: initial;<c:if test="${lVO.user_id == logId}">display: none;</c:if>">참여 대기중</button>
										</c:if>
									</c:otherwise>
								</c:choose>
						</c:otherwise>
					</c:choose>
				</c:if>
				
				<c:if test="${vo.user_id == logId}">
					<button id="editBtn" onclick="location='/board/ptEdit?board_num=${vo.board_num}'">수정하기</button>
					<button id="delBtn" onclick="location='javascript:del()'">삭제하기</button>
				</c:if>
			</div>
			<div style="text-align: right; margin-top: 5px;">
				<div style="width: 310px;">
					<a class="warnIcon"><img src="/recipeImg/warnIcon.png"/><span> 신고하기 </span></a>
				</div>
			</div>
		</div>
	</div>
	<!-- 신고하기 모달창 추가 -->
	<div class="modal">
	   <div class="modal_content">
	      <div><img src="/recipeImg/warnIcon.png"/>신고하기<img src="/recipeImg/warnIcon.png"/></div>
	      <form method='post' id='reportFrm'>
	         
	         <input type='hidden' name='write_id' value='${vo.user_id}'/>
	         <input type='hidden' name='board_num' value='${vo.board_num}'/>
	         <input type='hidden' name='report_type' value='2'/>
	         
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