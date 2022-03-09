<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//session scope 에 저장된 아이디를 이용해서 
	String id=(String)session.getAttribute("id");
	//수정할 회원의 정보를 얻어온다.
	UsersDto dto=UsersDao.getInstance().getData(id);
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/private/updateform2.jsp</title>
<style>
	/* 프로필 이미지를 작은 원형으로 만든다 */
	#profileImage{
		width: 50px;
		height: 50px;
		border: 1px solid #cecece;
		border-radius: 50%;
	}
	#imageForm{
		display: none;
	}
</style>
</head>
<body>
<div class="container" id="app">
	<h1>가입정보 수정 폼 입니다.</h1>
	<a ref="profileLink" @click="profileClicked" href="javascript:">
		<%if(dto.getProfile()==null){ %>
			<svg id="profileImage" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
				  <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
				  <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
			</svg>
		<%}else{ %>
			<img id="profileImage" 
				src="<%=request.getContextPath() %><%=dto.getProfile() %>" />
		<%} %>
	</a>	
	<form action="update.jsp" method="post">
		<input type="hidden" name="profile" v-bind:value="path"/>
		<div>
			<label for="id">아이디</label>
			<input type="text" id="id" value="<%=dto.getId() %>" disabled/>
		</div>
		<div>
			<label for="email">이메일</label>
			<input type="text" id="email" name="email" value="<%=dto.getEmail()%>"/>
		</div>
		<button type="submit">수정확인</button>
		<button type="reset">취소</button>
	</form>
	
	<form ref="imageForm" id="imageForm" action="ajax_profile_upload.jsp" method="post" 
				 enctype="multipart/form-data">
		<input ref="image" @change="changed" type="file" name="image"
			accept=".jpg, .jpeg, .png, .JPG, .JPEG, .gif"/>
	</form>
</div>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="<%=request.getContextPath() %>/js/gura_util.js"></script>
<script>
	new Vue({
		el:"#app",
		data:{
			path:"<%=dto.getProfile()==null ? "empty" : dto.getProfile()%>"
		},
		methods:{
			profileClicked:function(){
				this.$refs.image.click();
			},
			changed:function(){
				let form=this.$refs.imageForm;
				const self=this;
				// gura_util.js 에 정의된 함수를 호출하면서 ajax 전송할 폼의 참조값을 전달하면 된다. 
				ajaxFormPromise(form)
				.then(function(response){
					return response.json();
				})
				.then(function(data){
					// data 는 {imagePath:"/upload/xxx.jpg"} 형식의 object 이다.
					console.log(data);
					let img=`<img id="profileImage" src="${pageContext.request.contextPath }\${data.imagePath}"/>`;
					self.$refs.profileLink.innerHTML=img;
					// input name="profile" 요소의 value 값으로 이미지 경로 넣어주기
					self.path=data.imagePath;
				});
				
			}
		}
	});
</script>
</body>
</html>






