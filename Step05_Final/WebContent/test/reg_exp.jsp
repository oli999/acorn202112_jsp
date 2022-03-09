<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>reg_exp.jsp</title>
</head>
<body>
	<input type="text" id="msg" placeholder="입력..."/>
	<button id="checkBtn">검증</button>
	<p>특수 문자는 허용하지 않습니다</p>
	
	<input type="text" id="nick" placeholder="닉네임 입력..."/>
	<button id="checkBtn2">닉네임 검증</button>
	<p>영문자 소문자로 시작하고 최소 5글자 최대 10글자 이내로 입력 하세요</p>
	
	<script>
	
		document.querySelector("#checkBtn2").addEventListener("click", function(){
			//검증 대상 문자열
			let str=document.querySelector("#nick").value;
			//검증할 정규표현식 객체
			let reg=/^[a-z].{4,9}$/; 
			//정규 표현식 객체의 test() 함수를 이용해서 매칭 여부를 얻어낸다.
			let result=reg.test(str);
			if(result){
				alert("pass!");
			}else{
				alert("영문자 소문자로 시작하고 최소 5글자 최대 10글자 이내로 입력 하세요");
			}
		});	
		
	
		document.querySelector("#checkBtn").addEventListener("click", function(){
			//검증 대상 문자열
			let str=document.querySelector("#msg").value;
			//검증할 정규표현식 객체
			let reg=/[^a-zA-Z0-9]/; 
			//정규 표현식 객체의 test() 함수를 이용해서 매칭 여부를 얻어낸다.
			let result=reg.test(str);
			if(result){
				alert("특수 문자는 허용하지 않습니다.");
			}
		});
		
	</script>
</body>
</html>








