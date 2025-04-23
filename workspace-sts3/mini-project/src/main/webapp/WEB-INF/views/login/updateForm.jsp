<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원정보 수정하기 </title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5" style="max-width: 800px;">
  <h1 class="mb-4">회원정보 수정하기</h1>
<form name="updateForm" id="updateForm"  action="update" method="post">
 <div class="mb-3 row align-items-center">
        <label for="userid" class="col-sm-2 col-form-label">아이디</label>
        <div class="col-sm-7">
          <input type="text" class="form-control" id="userid" name="userid" value="${member.userid}" readonly="readonly">
        </div>
        </div>
	
	 <!-- 비밀번호 -->
      <div class="mb-3 row">
        <label for="passwd" class="col-sm-2 col-form-label">비밀번호</label>
        <div class="col-sm-10">
          <input type="password" class="form-control" id="passwd" name="passwd" placeholder="비밀번호를 입력해주세요">
        </div>
      </div>

      <!-- 비밀번호 확인 -->
      <div class="mb-3 row">
        <label for="passwd2" class="col-sm-2 col-form-label">비밀번호 확인</label>
        <div class="col-sm-10">
          <input type="password" class="form-control" id="passwd2" name="passwd2" placeholder="비밀번호를 입력해주세요">
        </div>
      </div>
      
       <!-- 이름 -->
      <div class="mb-3 row">
        <label for="name" class="col-sm-2 col-form-label">이름</label>
        <div class="col-sm-10">
          <input type="text" class="form-control" id="name" name="name"value="${member.name}" >
        </div>
      </div>
         <!-- 이메일 -->
      <div class="mb-3 row">
        <label for="email" class="col-sm-2 col-form-label">이메일</label>
        <div class="col-sm-10">
          <input type="email" class="form-control" id="email" name="email" value="${member.email}" readonly="readonly">
        </div>
      </div>
      <!-- 생년월일 -->
      <div class="mb-3 row">
        <label for="birthday" class="col-sm-2 col-form-label">생년월일</label>
        <div class="col-sm-10">
          <input type="date" class="form-control" id="birthday" name="birthday" value="${member.birthday}">
        </div>
      </div>
      
      <!-- 주소 -->
      <div class="mb-3 row">
        <label for="address" class="col-sm-2 col-form-label">주소</label>
        <div class="col-sm-10">
          <input type="text" class="form-control mb-2" id="address" name="address" value="${member.address}" >
          <input type="text" class="form-control" id="detailaddress" name="detailaddress"value="${member.detailaddress}" >
        </div>
      </div>
      <!-- 성별 -->
      <div class="mb-3 row">
        <label class="col-sm-2 col-form-label">성별</label>
        <div class="col-sm-10 d-flex align-items-center">
          <div class="form-check me-3">
            <input class="form-check-input" type="radio" name="sex" id="btn-male" value="남" checked>
            <label class="form-check-label" for="btn-male">남자</label>
          </div>
          <div class="form-check">
            <input class="form-check-input" type="radio" name="sex" id="btn-female" value="여">
            <label class="form-check-label" for="btn-female">여자</label>
          </div>
        </div>
      </div>
      
      <!-- 휴대전화번호 -->
      <div class="mb-3 row">
        <label for="phonenumber" class="col-sm-2 col-form-label">휴대폰</label>
        <div class="col-sm-10">
          <input type="tel" class="form-control" id="phonenumber" name="phonenumber" value="${member.phonenumber}">
        </div>
      </div>
      
            <!-- 취미 -->
<div class="mb-3 row">
  <label class="col-sm-2 col-form-label">취미</label>
  <div class="col-sm-10">
    <div class="form-check form-check-inline">
      <input class="form-check-input" type="checkbox" name="habit" value="수영" id="check-swim">
      <label class="form-check-label" for="check-swim">수영</label>
    </div>
    <div class="form-check form-check-inline">
      <input class="form-check-input" type="checkbox" name="habit" value="등산" id="check-hiking">
      <label class="form-check-label" for="check-hiking">등산</label>
    </div>
    <div class="form-check form-check-inline">
      <input class="form-check-input" type="checkbox" name="habit" value="게임" id="check-game">
      <label class="form-check-label" for="check-game">게임</label>
    </div>
    <div class="form-check form-check-inline">
      <input class="form-check-input" type="checkbox" name="habit" value="런닝" id="check-running">
      <label class="form-check-label" for="check-running">런닝</label>
    </div>
  </div>
</div>
<!-- 로그인 시간 -->
      <div class="mb-3 row">
        <label for="text" class="col-sm-2 col-form-label">최근 로그인 시간 </label>
        <div class="col-sm-10">
          <input type="tel" class="form-control" id="loginTime" name="loginTime" value="${member.loginTime}" readonly="readonly">
        </div>
      </div>
	
	<!-- 버튼 -->
      <div class="text-end">
        <input type="submit" class="btn btn-success" value="변경">
        <input type="reset" class="btn btn-secondary" value="초기화">
        <button type="button" class="btn btn-outline-secondary ms-2" onclick="location = '${pageContext.request.contextPath}/detailView'">
        내 정보 보기 </button>
        
      </div>
</form>
</div>
	<script type="text/javascript">
	 	let updateForm = document.querySelector("#updateForm");
		const userid = document.querySelector("#userid");   	   	
	 	if (updateForm) {
	 		//이벤트 핸들러 등록 
	 		updateForm.addEventListener("submit", e => {
				e.preventDefault();  // form의 기본 동작을 취소함.
				
				const passwd = document.querySelector("#passwd");
				const passwd2 = document.querySelector("#passwd2");
				const name = document.querySelector("#name");
				const email = document.querySelector("#email");
				const birthday = document.querySelector("#birthday");
				const address = document.querySelector("#address");
				const detailaddress = document.querySelector("#detailaddress");
				const sex = document.querySelector('input[name="sex"]:checked');
				const phonenumber = document.querySelector("#phonenumber");
				
				const loginTime = document.querySelector("#loginTime");
				const habit = getCheckboxes('input[name="habit"]');
								
				
				
				if (!confirm("수정하시겠습니까?")) return ;
				if (passwd.value != passwd2.value) {
					alert("비밀번호가 맞지 않습니다.");
					passwd.value = "";
					passwd2.value = "";
					passwd.focus();
					return;
				}
				
				const passwordPattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[~!@#$%^&*()_+\[\]{};':"\\|,.<>\/?]).{8,}$/;

				if (!passwordPattern.test(passwd.value)) {
				    alert("비밀번호는 영문자, 숫자, 특수문자를 포함한 8자 이상이어야 합니다.");
				    passwd.focus();
				    return;
				}
				if (name.value.length ==0 ){
					alert("이름을입력해주세요 ");
					name.focus();
					return ;
				}
				const today = new Date();
				const birthDate = new Date(birthday.value);
				if (birthDate > today){
					alert("생년월일은 오늘보다 이후 입력할수 없습니다.");
					birthday.focus();
					return ;
				}
				if (birthday.value.length ==0){
					alert("생년월일을 입력해주세요 ");
					birthday.focus();
					return ;
				}
				
				if (phonenumber.value.length ==0 ){
					alert("전화번호를 입력해주세요 ");
					phonenumber.focus();
					return ;
				}
				
				const phonePattern = /^010-\d{4}-\d{4}$/;
				if (!phonePattern.test(phonenumber.value)) {
					alert("전화번호 형식이 올바르지 않습니다. (예: 010-1234-5678)");
					phonenumber.focus();
					return;
				}
				
				if (address.value.length ==0 ){
					alert("주소를 입력해주세요 ");
					address.focus();
					return ;
				}
				if (detailaddress.value.length ==0 ){
					alert("상세주소를 입력해주세요 ");
					detailaddress.focus();
					return ;
				}
				
				
				//form의 하위 객체를 이름을 사용하여 접근 하는 방법
				const param = {
						userid : userid.value,   	
						passwd : passwd.value,   	
						name : 	 name.value,   	
						birthday : 	birthday.value,
						email : 	email.value,
						address : 	address.value,
						detailaddress : 	detailaddress.value,
						phonenumber : 	phonenumber.value,
						sex  :sex.value,
						habit: habit ,	
						loginTime:loginTime.value
				}
				
				
				fetch("update", { 
					  method: 'post', 
					  headers: {
					    'Content-Type': 'application/json;charset=utf-8'
					  },
					  body: JSON.stringify(param)
					})
			  .then(response => response.json())
			  .then(json => {
				  if (json.status == "error") {
					  alert(json.errorMessage);
					  passwd.value = "";
					  passwd.focus();
				  } else {
					  alert("회원정보가 수정되었습니다");
					  location = "${pageContext.request.contextPath}/detailView" ;//el 구문을 사용한 절대 경로 표기법  
				  }
			   });
				
	 		})
	 	}
	 	
	 	function getCheckboxes(selector) {
	 		  var arr = [];
	 		  var checkboxes = document.querySelectorAll(selector + ":checked");

	 		  for (var i = 0; i < checkboxes.length; i++) {
	 		    arr.push(checkboxes[i].value);
	 		  }
	 		  

	 		  return arr.join(",");
	 		}

	</script>
</body>
</html>