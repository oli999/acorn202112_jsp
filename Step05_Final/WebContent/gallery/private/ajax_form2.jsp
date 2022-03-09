<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/gallery/private/ajax_form2.jsp</title>
</head>
<body>
<div class="container" id="app">
	<form ref="insertForm" action="insert.jsp" method="post" >
		<input type="hidden" name="imagePath" v-bind:value="path"/>
		<div>
			<label for="caption">설명</label>
			<input type="text" name="caption" id="caption"/>
		</div>
	</form>
	<form ref="ajaxForm" action="ajax_upload.jsp" method="post"  enctype="multipart/form-data">
		<div>
			<label for="image">이미지</label>
			<input v-on:change="changed" type="file" name="image" id="image" 
				accept=".jpg, .jpeg, .png, .JPG, .JPEG"/>
		</div>
	</form>
	<button @click="submited">등록</button>
	<div class="img-wrapper">
		<img v-bind:src="path"/>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="${pageContext.request.contextPath}/js/gura_util.js"></script>
<script>
	new Vue({
		el:"#app",
		data:{
			path:""
		},
		methods:{
			submited:function(){
				//폼 강제 제출
				this.$refs.insertForm.submit();
			},
			changed:function(){
				// ref="ajaxForm" 이 부여된 문서 객체의 참조값 얻어오기 
				const form=this.$refs.ajaxForm;
				const self=this;
				//util 함수를 이용해서 ajax 전송
				ajaxFormPromise(form)
				.then(function(response){
					return response.json();//Promise 객체
				})
				.then(function(data){
					//data 는  {imagePath:"업로드된 이미지 경로"}
					console.log(data);
					//이미지 경로에 context path 추가하기
					const path="${pageContext.request.contextPath}"+data.imagePath;
					//이미지 경로를 모델의 path 에 넣어준다. 
					self.path=path;
				});
			}
		}
	});
	
</script>
</body>
</html>





