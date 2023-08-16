<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${cnt>0 and cnt2>0}">
	<script>
		alert("설문조사를 완료했습니다");
		location.href="/";
	</script>
</c:if>

<c:if test="${(cnt==null || cnt==0) and (cnt2==null || cnt2==0)}">
	<script>
		alert("설문조사에 실패하였습니다.");
		history.go(-1);
	</script>
</c:if>