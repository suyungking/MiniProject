<%--  <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Home</title>
</head>
<body>

<h2>${member.name}님 환영합니다!</h2>
<ul>
	<c:if test="${member.admin == 'Y'}">
	<li><a href="memberList">회원목록</a></li>
	<li><a href="detailView2?userid=${member.userid}">회원정보 보기</a></li>
	</c:if>
	
	<!-- <li><a href="board/list">게시물목록</a></li> -->
		
		<li><a href="${pageContext.request.contextPath}/detailView">내정보 보기</a></li>
		<li><a href="${pageContext.request.contextPath}/board/boardList">게시글 보기</a></li>
		
		<li><a href="logout">로그아웃</a></li>
	
</ul>

</body>
</html>
  --%>
  
  <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<title>Home</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
	<div class="card shadow-sm p-4">
		<h2 class="mb-4 text-primary">${member.name}님 환영합니다!</h2>

		<ul class="list-group">
			<c:if test="${member.admin == 'Y'}">
				<li class="list-group-item">
					<a class="text-decoration-none" href="memberList">회원 목록 보기</a>
				</li>
			</c:if>
			
			<li class="list-group-item">
				<a class="text-decoration-none" href="${pageContext.request.contextPath}/detailView">내 정보 보기</a>
			</li>
			
			<li class="list-group-item">
				<a class="text-decoration-none" href="${pageContext.request.contextPath}/board/boardList">게시글 목록 보기</a>
			</li>
			
			<li class="list-group-item">
				<a class="text-decoration-none text-danger" href="logout">로그아웃</a>
			</li>
		</ul>
	</div>
</div>

</body>
</html>
  