<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>로그인</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5" style="max-width: 500px;">
  <h2 class="mb-4 text-center">로그인</h2>
  
  <form name="loginForm" id="loginForm">
    <div class="mb-3">
      <label for="userid" class="form-label" >아이디</label>
      <input type="text" class="form-control" id="userid" name="userid" required placeholder="아이디를 입력해주세요">
    </div>
    
    <div class="mb-3">
      <label for="passwd" class="form-label">비밀번호</label>
      <input type="password" class="form-control" id="passwd" name="passwd" required placeholder="비밀번호를 입력해주세요">
    </div>
    
    <div class="d-grid gap-2">
      <button type="submit" class="btn btn-primary">로그인</button>
      <button type="button" class="btn btn-outline-secondary" onclick="location='${pageContext.request.contextPath}/registerForm'">회원가입</button>
    </div>
  </form>
</div>
	<script type="text/javascript">
	 	let loginForm = document.querySelector("#loginForm");
		const userid = document.querySelector("#userid");   	
		const passwd = document.querySelector("#passwd");   	
	 	if (loginForm) {
 
	 		loginForm.addEventListener("submit", e => {
				e.preventDefault();

				
				
				const param = {
					userid : userid.value,   	
					passwd : passwd.value   	
				}
				fetch("login", { 
					  method: 'post', 
					  headers: {
					    'Content-Type': 'application/json;charset=utf-8'
					  },
					  body: JSON.stringify(param)
					})
					  .then(r => r.json())
					  .then(j => {
						  if (j.status == "error") {
							  alert(j.errorMessage);
							  userid.value = "";
							  passwd.value = "";
							  userid.focus();
						  } else {
							  alert("로그인 성공했습니다.");
//							  location = "/hello/"; //절대경로 
//							  location = "./"; //상대 경로 
							  location = "${pageContext.request.contextPath}/home"; //el 구문을 사용한 절대 경로 표기법  
						  }
				})	 			

					  
		
	 		});
	 	}
	 	
	</script>
</body>
</html>