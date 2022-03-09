<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/signup_form.jsp</title>
<jsp:include page="/include/resource.jsp"></jsp:include>
</head>
<body>
<div class="container">
	<h1>회원가입 폼 입니다.</h1>
	<form action="signup.jsp" method="post" id="signupForm">
		<div class="mb-3">
			<label class="control-label" for="id">아이디</label>
			<input class="form-control" type="text" name="id" id="id"/>
			<small class="form-text text-muted">영문자 소문자로 시작하고 5글자~10글자 이내로 입력하세요</small>
			<div class="invalid-feedback">사용할 수 없는 아이디 입니다.</div>
		</div>
		<div class="mb-3">
			<label class="control-label" for="pwd">비밀번호</label>
			<input class="form-control" type="password" name="pwd" id="pwd"/>
			<small class="form-text text-muted">특수 문자를 하나 이상 조합하세요.</small>
			<div class="invalid-feedback">비밀 번호를 확인 하세요</div>
		</div>
		<div class="mb-3">
			<label class="control-label" for="pwd2">비밀번호 확인</label>
			<input class="form-control" type="password" name="pwd2" id="pwd2"/>
		</div>
		<div class="mb-3">
			<label class="control-label" for="email">이메일</label>
			<input class="form-control" type="text" name="email" id="email"/>
			<div class="invalid-feedback">이메일 형식에 맞게 입력하세요.</div>
		</div>
		<button class="btn btn-outline-primary" type="submit">가입</button>
	</form>
</div>
<script src="${pageContext.request.contextPath }/js/gura_util.js"></script>
<script>
	//아이디 유효성 여부
	let isIdValid=false;
	//이메일 유효성 여부
	let isEmailValid=false;
	//비밀 번호 유효성 여부
	let isPwdValid=false;

	document.querySelector("#id").addEventListener("input", function(){
		//input 요소의 참조값을 self 에 미리 담아 놓기 
		const self=this;
		//입력한 문자열
		let inputId=self.value;
		//아이디를 검증할 정규표현식 객체
		let reg=/^[a-z].{4,9}$/;
		//일단 2개의 클래스를 모두 제거 한다음 
		self.classList.remove("is-valid");
		self.classList.remove("is-invalid");
		//만일 입력한 아이디가 정규 표현식을 통화 하지 못한다면
		if(!reg.test(inputId)){
			isIdValid=false;
			self.classList.add("is-invalid");
			return;//함수를 여기서 끝내라 
		}
		
		//gura_util.js 에 있는 함수를 이용해서 입력한 아이디를 보내서 해당 아이디가 이미 존재하는지 여부를 응답받기 
		ajaxPromise("checkid.jsp", "get", "inputId="+inputId)
		.then(function(response){
			return response.json();
		})
		.then(function(data){
			//data 는 {isExist:true} or {isExist:false} 형식의 object 이다. 
			if(data.isExist){//이미 존재하면 사용할수 없는 아이디 
				self.classList.add("is-invalid");
				isIdValid=false;
			}else{
				self.classList.add("is-valid");
				isIdValid=true;
			}
		});
		
	});
	
	//비밀번호를 확인 하는 함수 
	function checkPwd(){
		document.querySelector("#pwd").classList.remove("is-valid");
		document.querySelector("#pwd").classList.remove("is-invalid");
		
		const pwd=document.querySelector("#pwd").value;
		const pwd2=document.querySelector("#pwd2").value;
		//비밀번호를 검증할 정규 표현식
		let reg=/[\W]/;
		//만일 비밀번호가 정규 표현식을 통과 하지 못한다면 
		if(!reg.test(pwd)){
			isPwdValid=false;
			document.querySelector("#pwd").classList.add("is-invalid");
			return; //함수를 여기서 끝내라 
		}
		
		if(pwd != pwd2){//만일 비밀번호 입력란과 확인란이 다르다면
			isPwdValid=false;
			document.querySelector("#pwd").classList.add("is-invalid");
		}else{
			isPwdValid=true;
			document.querySelector("#pwd").classList.add("is-valid");
		}
	}
	
	//비밀번호 입력란에 input 이벤트가 일어 났을때 실행할 함수 등록
	document.querySelector("#pwd").addEventListener("input", checkPwd);
	document.querySelector("#pwd2").addEventListener("input", checkPwd);	
	
	//이메일을 입력했을때 실행할 함수 등록
	document.querySelector("#email").addEventListener("input", function(){
		//1. 입력한 이메일을 읽어온다.
		let email=this.value;
		//2. 이메일 형식에 맞는지 확인해서
		let reg=/@/;
		//정규 표현식 통과 여부를 global 변수에 대입한다. 
		isEmailValid=reg.test(email);
		//3. 형식에 맞으면 is-valid 클래스 추가 , 맞지 않으면 is-invalid 클래스 추가
		//일단 2개의 클래스를 모두 제거하고 
		this.classList.remove("is-valid");
		this.classList.remove("is-invalid");
		//하나만 추가해 준다. 
		if(isEmailValid){
			this.classList.add("is-valid");
		}else{
			this.classList.add("is-invalid");
		}
	});
	
	// form 안에 있는 submit 버튼을 누르면 form 에는 "submit" 이라는 이벤트가 발생한다.
	document.querySelector("#signupForm").addEventListener("submit", function(e){
		
		//폼 전체가 유효한지 여부
		let isFormValid= isIdValid && isPwdValid && isEmailValid;
		
		if(!isFormValid){
			//폼 전송 막기
			e.preventDefault();	
		}
	});
</script>
</body>
</html>











