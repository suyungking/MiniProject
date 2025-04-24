<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 등록</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
	<h2 class="mb-4">게시글 등록</h2>

	<form id="boardInsert" class="card p-4 shadow-sm">
		<div class="mb-3">
			<label for="btitle" class="form-label">제목</label>
			<input type="text" id="btitle" name="btitle" class="form-control" placeholder="제목을 입력해주세요">
		</div>

		<div class="mb-3">
			<label for="bwriter" class="form-label">작성자</label>
			<input type="text" id="bwriter" name="bwriter" class="form-control" value="${member.userid}" readonly="readonly">
		</div>

		<div class="mb-3">
			<label for="bcontent" class="form-label">내용</label>
			<textarea id="bcontent" name="bcontent" class="form-control" rows="5" placeholder="내용을 입력해주세요"></textarea>
		</div>

		<div class="mb-3">
			<label for="bpasswd" class="form-label">비밀번호</label>
			<input type="password" id="bpasswd" name="bpasswd" class="form-control" placeholder="비밀번호 4자이상 입력해주세요"style="width: 250px;" >
		</div>

		<div class="d-flex justify-content-end gap-1">
			<button type="submit" class="btn btn-primary">등록하기</button>
			<button type="reset" class="btn btn-secondary">초기화</button>
			<button type="button" class="btn btn-outline-secondary"
		onclick="location='${pageContext.request.contextPath}/board/boardList'">이전</button>
		</div>
	</form>
</div>

<script>
let boardInsert = document.querySelector("#boardInsert");
if (boardInsert) {
	boardInsert.addEventListener("submit", e => {
		e.preventDefault();
		const btitle = document.querySelector("#btitle");
		const bwriter = document.querySelector("#bwriter");
		const bcontent = document.querySelector("#bcontent");
		const bpasswd = document.querySelector("#bpasswd");

		if (!confirm("등록하시겠습니까?")) return;

		if (btitle.value.trim().length === 0) {
			alert("제목을 입력해주세요");
			btitle.focus();
			return;
		}
		if (bcontent.value.trim().length === 0) {
			alert("내용을 입력해주세요");
			bcontent.focus();
			return;
		}
		if (bpasswd.value.trim().length < 4) {
			alert("비밀번호는 4자 이상 입력해주세요");
			bpasswd.focus();
			return;
		}

		fetch("insert", {
			method: 'post',
			headers: {
				'Content-Type': 'application/json;charset=utf-8'
			},
			body: JSON.stringify({
				btitle: btitle.value,
				bwriter: bwriter.value,
				bcontent: bcontent.value,
				bpasswd: bpasswd.value
			})
		})
		.then(r => r.json())
		.then(j => {
			if (j.status === "error") {
				alert(j.errorMessage);
			} else {
				alert("등록되었습니다.");
				location = "${pageContext.request.contextPath}/board/boardList";
			}
		});
	});
}

</script>

</body>
</html>
