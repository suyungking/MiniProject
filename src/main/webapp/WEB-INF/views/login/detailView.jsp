 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>회원 상세정보</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5" style="max-width: 600px;">
  <h2 class="mb-4 text-center">회원 상세정보</h2>

  <ul class="list-group mb-4">
    <li class="list-group-item"><strong>아이디:</strong> ${member.userid}</li>
    <li class="list-group-item"><strong>이름:</strong> ${member.name}</li>
    <li class="list-group-item"><strong>나이:</strong> ${member.age}</li>
    <li class="list-group-item"><strong>이메일:</strong> ${member.email}</li>
    <li class="list-group-item"><strong>휴대전화:</strong> ${member.phonenumber}</li>
    <li class="list-group-item"><strong>주소:</strong> ${member.address}</li>
    <li class="list-group-item"><strong>상세주소:</strong> ${member.detailaddress}</li>
    <li class="list-group-item"><strong>성별:</strong> ${member.sex}</li>
    <li class="list-group-item"><strong>취미:</strong> ${member.habit}</li>
    <li class="list-group-item"><strong>최근 로그인일시:</strong> ${member.loginTime}</li>
  </ul>

  <div class="text-end">
    <a href="vailedLogin?page=deleteForm" class="btn btn-danger me-2">탈퇴하기</a>
    <a href="vailedLogin?page=updateForm" class="btn btn-secondary me-2">내정보 수정</a>
    <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-primary">이전</a>
    
  </div>
</div>
</body>
</html>
 