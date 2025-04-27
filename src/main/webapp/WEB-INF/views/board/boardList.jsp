<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시물 목록</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body>

	<div class="container-fluid my-4 ps-2" style="max-width: 1800px;">
		<h2 class="mb-4">게시물 목록</h2>

		<form id="searchForm" name="searchForm" action="boardList"
			method="post" class="mb-4">
			<input type="hidden" name="pageNo" id="pageNo"
				value="${pageResponse.pageNo}">

			<div class="d-flex align-items-center gap-2 ms-2 mb-2">

				<!-- 검색어 입력창 -->
				<input type="text" class="form-control" name="searchValue"
					id="searchValue" value="${param.searchValue}" placeholder="제목 검색"
					style="width: 300px;">

				<!-- 검색 버튼 -->
				<button type="submit" class="btn btn-primary">검색</button>

				<!-- 건수 선택 -->
				<label for="size" class="form-label mb-0 ms-3 me-2">건수</label> <select
					class="form-select form-select-sm me-2" id="size" name="size"
					style="width: 80px;">
					<c:forTokens items="10,30,50,100" delims="," var="size">
						<option value="${size}"
							${pageResponse.size == size ? 'selected' : ''}>${size}</option>
					</c:forTokens>
				</select>

				<!-- 페이지 정보 -->
				<span class="text-muted">(${pageResponse.pageNo} /
					${pageResponse.totalPage})</span>
			</div>
		</form>

		<table
			class="table table-bordered table-hover align-middle text-center"
			style="table-layout: fixed; width: 100%;">
			<thead class="table-light">
				<tr class="align-middle text-nowrap small">
					<th style="width: 80px;">번호</th>
					<th style="width: 120px;">제목</th>
					<th style="width: 180px;">작성자</th>
					<th style="width: 180px;">작성일</th>
					<th style="width: 100px;">조회수</th>

				</tr>
			</thead>
			<tbody>
				<c:forEach items="${pageResponse.list}" var="item"
					varStatus="status">

					<tr class="text-nowrap">

						<td>${pageResponse.totalCount - (status.count + (pageResponse.pageNo - 1) * pageResponse.size) + 1}</td>
						<td>
						<a
							href="${pageContext.request.contextPath}/board/boardView?bno=${item.bno}"
							class="text-decoration-none">${item.btitle}</a></td>
						<td>${item.bwriter}</td>
						<td>${item.bdate}</td>
						<td>${item.view_cnt}</td>

					</tr>

				</c:forEach>

				<c:if test="${empty pageResponse.list}">
					<tr>
						<td colspan="5">검색 결과가 없습니다</td>
					</tr>
				</c:if>


			</tbody>
		</table>
		<c:import url="/WEB-INF/views/inc/pageNav.jsp" />

		<div class="text-end">
			<a href="${pageContext.request.contextPath}/member/home"
				class="btn btn-outline-primary">이전</a> <a
				href="${pageContext.request.contextPath}/board/boardRegister"
				class="btn btn-outline-primary">글쓰기</a>
		</div>
	</div>

	<script>
    const size = document.querySelector("#size");
    const searchValue = document.querySelector("#searchValue");

    size.addEventListener("change", () => {
        location = "${pageContext.request.contextPath}/board/boardList?pageNo=1&size=" + size.value + "&searchValue=" + searchValue.value;
    });

    function pageMove(pageNo) {
        document.querySelector("#pageNo").value = pageNo;
        document.querySelector("#searchForm").submit();
    }
</script>


</body>
</html>


