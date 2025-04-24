<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 삭제 확인</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
	<div class="card shadow-sm p-4">
		
		<c:choose>
			<c:when test="${member.admin eq 'Y'}">
				
			<h4 class="mb-3 text-danger">정말로 삭제하시겠습니까?</h4>
			</c:when>
			
		<c:otherwise>
			<h4 class="mb-3 text-danger">${board.bwriter}님, 정말로 삭제하시겠습니까?</h4>
				<p class="text-muted">삭제하면 게시글을 복구할 수 없습니다.</p>
		
		</c:otherwise>
		</c:choose>
		

		<div class="d-flex justify-content-end gap-2 mt-4">
			<button id="deleteButton" class="btn btn-danger">삭제하기</button>
			<button class="btn btn-secondary"
				onclick="location='${pageContext.request.contextPath}/board/boardView?bno=${board.bno}'">취소</button>
		</div>
	</div>
</div>

<script>
let deleteButton = document.querySelector("#deleteButton");

if (deleteButton) {
	deleteButton.addEventListener("click", e => {
		e.preventDefault();

		if (!confirm("진짜로 삭제하시겠습니까?")) return;

		fetch("isBoardDelete", {
			method: "post",
			headers: { 'Content-Type': 'application/json;charset=utf-8' },
			body: JSON.stringify({ bno: "${board.bno}" })
		})
		.then(r => r.json())
		.then(j => {
			if (j.status === "error") {
				alert(j.errorMessage);
			} else {
				alert("삭제 완료");
				location = "${pageContext.request.contextPath}/board/boardList";
			}
		});
	});
}
</script>


</body>
</html>
