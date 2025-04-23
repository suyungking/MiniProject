<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
${member.userid}님 <h2 class="text-danger">정말로 탈퇴하시겠습니까?</h2>
<p class="text-muted">탈퇴하면 모든 정보는 삭제되며 복구할 수 없습니다.</p>

<button id="deleteBtn" class="btn btn-danger">탈퇴하기</button>
<button onclick="location = '${pageContext.request.contextPath}/detailView" class="btn btn-secondary">취소</button>

<script>
let deleteBtn = document.querySelector("#deleteBtn");

if(deleteBtn){
	deleteBtn.addEventListener("click", e => {
	e.preventDefault();	
	
  if (!confirm("진짜로 탈퇴하시겠습니까?")) return;   

  
  fetch("isDelete", {
    method: "post",
    headers: {'Content-Type': 'application/json;charset=utf-8'},
    body: JSON.stringify({ userid: "${member.userid}" })
  })
  .then(r => r.json())
  .then(j => {
	  
	  if(j.status =="error"){
		  alert(j.errorMessage);
	  }
	  else{
    alert("탈퇴 처리 완료");
    location = "${pageContext.request.contextPath}/"; 
    } // 홈으로
  })
});
}
</script>
</body>
</html>