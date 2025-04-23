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
      <label for="userid" class="form-label">아이디</label>
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
	 		//이벤트 핸들러 등록 
	 		loginForm.addEventListener("submit", e => {
				e.preventDefault();  // form의 기본 동작을 취소함.

				
				//form의 하위 객체를 이름을 사용하여 접근 하는 방법
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

					  
		//		registerForm.submit();
	 		});
	 	}
	 	/* let validButton = document.querySelector("#validButton");
	 	if (validButton) {
	 		validButton.addEventListener("click", e => {
	 			validClicked = true;
	 			//아이디 중복 검사 기능 구현, 비동기 통신, JSON  
	 			//JSON  
	 			//문자열을 객체로 변환 -> JSON.parse()  
	 			//객체를 문자열로 변화 -> JSON.stringify()
				const userid = document.querySelector("#userid");
	 			if(userid.value.length == 0) {
	 				alert("아이디를 입력해주세요");
	 				userid.focus();
	 				return ;
	 			} 
	 			
				fetch("isExistUserId", { 
				  method: 'post', 
				  headers: {
				    'Content-Type': 'application/json;charset=utf-8'
				  },
				  body: JSON.stringify({userid : userid.value})
				})
				  .then(response => response.json())
				  .then(json => {
					  existUserId = json.existUserId;//서버에서 전달된 값
					  if (existUserId) {
						  alert("[" + userid.value + "] 해당 아이디는 사용 불가능 합니다 ")
					  } else {
						  alert("[" + userid.value + "] 해당 아이디는 사용 가능 합니다 ")
					  }
					  
				  })	 			
	 			
	 		});
	 	} */
	</script>
</body>
</html>