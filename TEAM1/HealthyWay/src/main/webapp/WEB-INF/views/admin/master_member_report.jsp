<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/emailjs-com@2.4.1/dist/email.min.js"></script>
<link rel="stylesheet" href="/css/master_member.css" type="text/css" />


<script>
$(function(){
	
	//회원관리 메뉴 클릭 이벤트
	$("#menu_member").click(function(){
		location="/master/member";
	});
	
	//신고관리 메뉴 클릭 이벤트
	$("#menu_report").click(function(){
		location="/master/member/report";
	});
});

//경고 버튼 클릭
function warnMember(user_name, report_hit, user_email, userid){
	if(!confirm("회원 경고 메시지를 전송하시겠습니까?")){
		return false;
	}
	var data = {
		    service_id: 'test',
		    template_id: 'test',
		    user_id: 'test',
		    template_params: {
		        'user_name': user_name,
		        'report_hit': report_hit,
		        'user_email': user_email
		    }
		};
		 
		$.ajax('https://api.emailjs.com/api/v1.0/email/send', {
		    type: 'POST',
		    data: JSON.stringify(data),
		    contentType: 'application/json'
		}).done(function() {
		    alert('이메일이 전송되었습니다.');
		    warningState(userid);
		}).fail(function(error) {
		    alert('이메일 전송 실패하였습니다.');
		    console.log(JSON.stringify(error));
		});
}

function warningState(user_id){
	 $.ajax({
		 url: '/master/warningState',
		 data: 'user_id='+user_id,
		 type: 'post',
		 success: function(result){
			 if(result>0){
				  location.reload();
			 }
		 },
		 error: function(e){
			 console.log(e.responsText);
		 }
	 });
}
</script>
<div id="container">
	<!-- 메뉴 -->
	<ul class="menu_list">
		<li id="menu_member">회원관리</li>
		<li id="menu_report" class="menu_active">신고관리</li>
	</ul>
	
    <!-- 회원 신고 -->
    <div id="reportDiv">
    	<table class="table">
			<thead>
				<tr>
					<th>ID</th>
					<th>Name</th>
					<th>Nickname</th>
					<th>Email</th>
					<th>Tel</th>
					<th>횟수</th>			
					<th>처리</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="vo" items="${vo}">
					<tr>
						<td>${vo.user_id}</td>
						<td>${vo.user_name}</td>
						<td>${vo.user_nickname}</td>
						<td>${vo.user_email}</td>
						<td>${vo.tel}</td>
						<td>${vo.report_hit}회</td>
						<c:if test="${vo.report_hit<3}">
							<td><button id="warnBtn" onclick="warnMember('${vo.user_name}','${vo.report_hit}','${vo.user_email}', '${vo.user_id}');">경고</button></td>
						</c:if>
						<c:if test="${vo.report_hit>=3}">
							<td><button id="deletBtn" onclick="deleteMember('${vo.user_id}');">탈퇴</button></td>
						</c:if>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		 <!-- 페이징 -->
	    <ul class="paging">
	    	<!-- prev -->
	    	<c:if test="${pVO.pageNum==1&&pVO.totalRecord>0}">
	    		<li>◀</li>
	    	</c:if>
	    	<c:if test="${pVO.pageNum>1}">
	    		<li><a href="/master/member/report?pageNum=${pVO.pageNum-1}
	    		<c:if test='${pVO.searchWord!=null}'>
	    			&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}
	    		</c:if>">◀</a></li>
	    	</c:if>
	    	
	    	<!-- pageNum -->
	    	<c:forEach var="p" begin="${pVO.startPage}" end="${pVO.startPage+pVO.onePageCount-1}">
	    		<c:if test="${p<=pVO.totalPage}">
	    			<c:if test="${p==pVO.pageNum}">
	    				<li class="active">
	    			</c:if>
	    			<c:if test="${p!=pVO.pageNum}">
	    				<li>
	    			</c:if>
	    			<a href="/master/member/report?pageNum=${p}
		    			<c:if test='${pVO.searchWord!=null}'>
		    				&searchKey=${pVO.searchKey}
		    				&searchWord=${pVO.searchWord}
		    			</c:if>
	    			">${p}</a></li>
	    		</c:if>
	    	</c:forEach>
	    	
	    	<!-- next -->
	    	<c:if test="${pVO.pageNum==pVO.totalPage}">
	    		<li>▶</li>
	    	</c:if>
	    	<c:if test="${pVO.pageNum<pVO.totalPage}">
	    		<li><a href="/master/member/report?pageNum=${pVO.pageNum+1}
	    			<c:if test='${pVO.searchWord!=null}'>
	    				&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}
	    			</c:if>">▶</a></li>
	    	</c:if>
	    </ul>
    </div>
</div>