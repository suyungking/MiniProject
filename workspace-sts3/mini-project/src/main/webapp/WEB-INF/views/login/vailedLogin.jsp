<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>비밀번호 재확인</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5" style="max-width: 500px;">
  <h2 class="mb-4 text-center">비밀번호 재확인</h2>
  
  <form id="vailedLogin">
    <div class="mb-3">
      <label for="userid" class="form-label">아이디</label>
      <input type="text" class="form-control" id="userid" name="userid" value="${member.userid}" readonly>
    </div>

    <div class="mb-3">
      <label for="passwd" class="form-label">비밀번호</label>
      <input type="password" class="form-control" id="passwd" name="passwd" required placeholder="비밀번호를 입력해주세요">
    </div>
<input type="hidden" id="page" value="${page}">
    <div class="d-grid">
      <input type="submit" value="확인" class="btn btn-primary">
    </div>
  </form>
</div>

<script type="text/javascript">

let vailedLogin = document.querySelector("#vailedLogin");
const userid = document.querySelector("#userid");
const passwd = document.querySelector("#passwd");
const page = document.querySelector("#page").value;

if(vailedLogin){
    vailedLogin.addEventListener("submit",e =>  {
    e.preventDefault();

    const param = {
        userid: userid.value,
        passwd : passwd.value
    };

    fetch("vailed", {
        method :'post',
        headers : {
			'Content-Type': 'application/json;charset=utf-8'
		},
        body : JSON.stringify(param)

    })
    .then(r => r.json())    
    .then(j => {
        if(j.status== "error"){
            alert(j.errorMessage);
			passwd.value = "";
			passwd.focus();
        }
        else{
            alert("성공입니다");
            location = "${pageContext.request.contextPath}/" + page;
        }
    })

    });



}





</script>
</body>
</html> 

