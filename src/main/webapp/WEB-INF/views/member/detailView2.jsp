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
    <li class="list-group-item"><strong>아이디 :</strong> ${member.userid}</li>
    <li class="list-group-item"><strong>이름 :</strong> ${member.name}</li>
    <li class="list-group-item"><strong>생년월일 :</strong> ${member.birthday}</li>
    <li class="list-group-item"><strong>나이 :</strong> ${member.age}</li>
    <li class="list-group-item"><strong>이메일 :</strong> ${member.email}</li>
    <li class="list-group-item"><strong>휴대전화 :</strong> ${member.phonenumber}</li>
    <li class="list-group-item"><strong>주소 :</strong> ${member.address}</li>
    <li class="list-group-item"><strong>상세주소 :</strong> ${member.detailaddress}</li>
    <li class="list-group-item"><strong>최근 로그인일시 :</strong> ${member.loginTime}</li>
    <li class="list-group-item"><strong>관리자 여부 :</strong> ${member.admin}</li>
    <li class="list-group-item"><strong>로그인실패 횟수 :</strong> ${member.failcount}</li>
    <li class="list-group-item"><strong>로그인 잠김여부 :</strong> ${member.locked}</li>
    <li class="list-group-item"><strong>탈퇴여부 :</strong> ${member.deleteyn}</li>
  </ul>

  <div class="text-end">
  <c:if test="${member.deleteyn eq 'N'}">
    <input type ="button" class ="btn btn-danger me-2" value ="계정삭제" id = "deletButton" >    
    <input type="button" class="btn btn-secondary me-2" value="관리자 권한 주기 " id="adminButton">
    </c:if>
    <c:if test="${member.locked eq 'Y'}">
    <input type="button" class="btn btn-warning me-2" value="잠김해제 " id="clearButton">
    </c:if>
    
    <c:if test="${member.deleteyn eq 'Y'}">
    <input type="button" class="btn btn-danger" value="복구" id="restorationButton">
    </c:if>
    <button type="button" class="btn btn-outline-secondary ms-2" onclick="history.back()">이전</button>
    
  </div>
</div>


<script type="text/javascript">


let adminButton = document.querySelector("#adminButton");
	if (adminButton) {
		adminButton.addEventListener("click", e => {
			const userid = "${member.userid}";
			
			if (!confirm("관리자 권한을 주시겠습니까?")) return;

		
		fetch("isAdmin", { 
		  method: 'post', 
		  headers: {
		    'Content-Type': 'application/json;charset=utf-8'
		  },
		  body: JSON.stringify({userid : userid})
		})
		  .then(r => r.json())
		  .then(j => {
			  
			  if (j.status== "error") {
				  alert(j.errorMessage);
				  
			  } else {
				  alert("[" + userid + "] 해당  아이디에게 관리자 권한을 설정하습니다.")
				  location.reload();
			  }
			   
		  })	 			
			
		});
	}


	let clearButton = document.querySelector("#clearButton");
	if (clearButton) {
		clearButton.addEventListener("click", e => {
			const userid = "${member.userid}";
			
			if (!confirm("로그인 잠금을 해제하시겠습니까?")) return;

		
		fetch("isClear", { 
		  method: 'post', 
		  headers: {
		    'Content-Type': 'application/json;charset=utf-8'
		  },
		  body: JSON.stringify({userid : userid})
		})
		  .then(r => r.json())
		  .then(j => {
			  
			  if (j.status== "error") {
				  alert(j.errorMessage);
				  
			  } else {
				  alert("[" + userid + "] 해당  아이디 잠금을 해제하였습니다.");
				  location.reload();
			  }
			   
		  })	 			
			
		});
	}
	let deletButton = document.querySelector("#deletButton");
	if(deletButton){
		deletButton.addEventListener("click", e =>{
			const userid = "${member.userid}";
			if (!confirm("회원 계정을 삭제하시겠습니까?")) return;
			
			fetch("isDelete",{
				method : 'post',
				headers : {
					'Content-Type': 'application/json;charset=utf-8'
				},
				body : JSON.stringify({userid :userid })
			})
			.then(r=> r.json())
			.then(j=> {
				if(j.status =="error"){
					alert(j.errorMessage);
				}else{
					alert("[" + userid + "] 해당 아이디를 삭제합니다.");
					 location.reload();
				}
			})
			
			
			
		});
		
	}

	
	
	
	let restorationButton = document.querySelector("#restorationButton");
	if(restorationButton){
		restorationButton.addEventListener("click", e =>{
			const userid = "${member.userid}";
			if (!confirm("회원 계정을 복구시키겠습니까??")) return;
			
			fetch("isRestoration",{
				method : 'post',
				headers : {
					'Content-Type': 'application/json;charset=utf-8'
				},
				body : JSON.stringify({userid :userid })
			})
			.then(r=> r.json())
			.then(j=> {
				if(j.status =="error"){
					alert(j.errorMessage);
				}else{
					alert("[" + userid + "] 해당 아이디를 복구합니다.");
					 location.reload();
				}
			})
			
			
			
		});
		
	}
</script>
</body>
</html>
 