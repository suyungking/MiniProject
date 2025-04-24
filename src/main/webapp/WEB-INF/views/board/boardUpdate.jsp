<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
	<h2 class="mb-4">게시글 수정</h2>
	
	<form id="boardUpdate" class="card p-4 shadow-sm" action="update">
		<div class="mb-3">
			<label for="bno" class="form-label">글 번호</label>
			<input type="text" id="bno" name="bno" class="form-control" value="${board.bno}" readonly>
		</div>
		
		<div class="mb-3">
			<label for="btitle" class="form-label">제목</label>
			<input type="text" id="btitle" name="btitle" class="form-control" value="${board.btitle}">
		</div>

		<div class="mb-3">
			<label for="bdate" class="form-label">작성일</label>
			<input type="text" id="bdate" name="bdate" class="form-control" value="${board.bdate}" readonly>
		</div>
		
		<div class="mb-3">
			<label for="bcontent" class="form-label">내용</label>
			<textarea id="bcontent" name="bcontent" class="form-control" rows="5">${board.bcontent}</textarea>
		</div>
		
		<div class="d-flex justify-content-end gap-2">
			<button type="submit" class="btn btn-primary">수정 완료</button>
			<button type="button" class="btn btn-secondary" onclick="location='${pageContext.request.contextPath}/board/boardView?bno=${board.bno}'">취소</button>
		</div>
	</form>
</div>

<script>
let boardUpdate = document.querySelector("#boardUpdate");
if (boardUpdate) {
	boardUpdate.addEventListener("submit", e => {
		e.preventDefault();

		const btitle = document.querySelector("#btitle");
		const bdate = document.querySelector("#bdate");
		const bcontent = document.querySelector("#bcontent");
		const bno = document.querySelector("#bno");

		if (!confirm("수정하시겠습니까?")) return;

		const param = {
			btitle: btitle.value.trim(),
			bdate: bdate.value.trim(),
			bcontent: bcontent.value.trim(),
			bno: bno.value.trim()
		};

		fetch("update", {
			method: 'post',
			headers: {
				'Content-Type': 'application/json;charset=utf-8'
			},
			body: JSON.stringify(param)
		})
		.then(response => response.json())
		.then(json => {
			if (json.status === "error") {
				alert(json.errorMessage);
			} else {
				alert("게시글이 수정되었습니다.");
				location = "${pageContext.request.contextPath}/board/boardView?bno=" + bno.value;
			}
		});
	});
}
</script>


</body>
</html>
