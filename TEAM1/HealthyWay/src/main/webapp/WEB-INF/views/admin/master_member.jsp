<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script   src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script   src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
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
   
   //회원 삭제
   function deleteMember(user_id){
      
      if(!confirm("회원을 삭제하시겠습니까?")){
         return false;
      }
      
      $.ajax({
         url: '/master/member/delete',
         data: 'user_id='+user_id,
         type: 'post',
         success: function(result){
            if(result>0){
               alert("회원이 삭제되었습니다.");
            }
            location.reload();
         },
         error: function(e){
            console.log(e.responseText);
            alert("회원 삭제 실패하였습니다.");
         }
      });
   }
</script>

<div id="container">

   <!-- 메뉴 -->
   <ul class="menu_list">
      <li id="menu_member" class="menu_active">회원관리</li>
      <li id="menu_report">신고관리</li>
   </ul>
   <form method="get" action="/master/member" id="searchFrm">
      <input type="text" name="searchWord"/>
      <input type="submit" value="검색"/>
   </form>
   <!-- 회원 관리 -->
   <div id="manageDiv">
      <table class="table">
         <thead>
            <tr>
               <th>ID</th>
               <th>Passward</th>
               <th>Name</th>
               <th>Nickname</th>
               <th>Gender</th>
               <th>Age</th>
               <th>Email</th>
               <th>Tel</th>            
               <th>탈퇴</th>
            </tr>
         </thead>
         <tbody>
            <c:forEach var="vo" items="${vo}">
               <tr>
                  <td>${vo.user_id}</td>
                  <td>${vo.user_pw}</td>
                  <td>${vo.user_name}</td>
                  <td>${vo.user_nickname}</td>
                  <td>${vo.gender}</td>
                  <td>${vo.age}</td>
                  <td>${vo.user_email}</td>
                  <td>${vo.tel}</td>
                  <td><button id="deletBtn" onclick="deleteMember('${vo.user_id}');">탈퇴</button></td>
               </tr>
            </c:forEach>
         </tbody>
      </table>
       <!-- 페이징 -->
       <ul class="paging">
          <!-- prev -->
          <c:if test="${pVO.pageNum==1}">
             <li>◀</li>
          </c:if>
          <c:if test="${pVO.pageNum>1}">
             <li><a href="/master/member?pageNum=${pVO.pageNum-1}
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
                <a href="/master/member?pageNum=${p}
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
             <li><a href="/master/member?pageNum=${pVO.pageNum+1}
                <c:if test='${pVO.searchWord!=null}'>
                   &searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}
                </c:if>">▶</a></li>
          </c:if>
       </ul>
    </div>

</div>