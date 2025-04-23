
 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
 <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
	<h2 class="mb-4">게시글 상세 보기</h2>

	<div class="card shadow-sm">
		<div class="card-header bg-primary text-white">
			<h5 class="mb-0">${board.btitle}</h5>
		</div>
		<div class="card-body">
			<p><strong>작성자:</strong> ${board.bwriter}</p>
			<p><strong>작성일:</strong> ${board.bdate}</p>
			<p><strong>조회수:</strong> ${board.view_cnt}</p>
			<hr>
			<p>${board.bcontent}</p>
		</div>
	</div>

<div class="mt-4 d-flex justify-content-end gap-2">
	<c:choose>
		<c:when test="${board.bwriter eq member.userid}">
			<button class="btn btn-danger" onclick="passwd('boardDelete')">삭제하기</button>
			<button class="btn btn-secondary" onclick="passwd('boardUpdate')">수정하기</button>
		</c:when>

		<c:when test="${member.admin eq 'Y'}">
			<button class="btn btn-danger"
				onclick="location='${pageContext.request.contextPath}/board/boardDelete?bno=${board.bno}'">삭제하기</button>
		</c:when>
	</c:choose>

	<button class="btn btn-secondary ms-2"
		onclick="location='${pageContext.request.contextPath}/board/boardList'">이전</button>
</div>
</div>

<script>
function passwd(page) {
	const passwd = prompt("게시글 비밀번호를 입력하세요:");
	if (!passwd) return;
	fetch("vailed", {
		method: 'post',
		headers: { 'Content-Type': 'application/json;charset=utf-8' },
		body: JSON.stringify({ passwd: passwd, bno: ${board.bno} })
	})
	.then(r => r.json())
	.then(j => { 
		if (j.status == "error") {
			alert(j.errorMessage);
			location = "${pageContext.request.contextPath}/board/boardView?bno=${board.bno}";
		} else {
			alert("성공입니다.");
			
			
			if (page === 'boardDelete') {
				location = "${pageContext.request.contextPath}/board/boardDelete?bno=${board.bno}";
			} else if(page === 'boardUpdate') {
				location = "${pageContext.request.contextPath}/board/boardUpdate?bno=${board.bno}";
			}
		}
	});
}
</script>

</body>
</html> 
