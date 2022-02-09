<%@page import="test.member.dto.MemberDto"%>
<%@page import="test.member.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	int num=Integer.parseInt(request.getParameter("num"));
	MemberDto dto= MemberDao.getInstance().select(num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateform.jsp</title>
</head>
<body>
<div class="container">
	<h1>회원 정보 수정하기</h1>
	<form action="update.jsp" method="post">
		<!-- 수정할 회원의 primary key는 input type="hidden"을 이용해서 폼에 전송한다. -->
		<input type="hidden" name="num" value="<%=dto.getNum()%>"/>
		<div>
			<label for="num">번호</label>
			
			<!-- disabled는 화면에 표기만 가능하고 그 값을 사용하지는 못한다. -->
			<input type="text" name="num" id="num" value="<%=dto.getNum()%>" disabled/>
		</div>
		<div>
			<label for="name">이름</label>
			<input type="text" name="name" id="name" value="<%=dto.getName()%>" />
		</div>
		<div>
			<label for="addr">주소</label>
			<input type="text" name="addr" id="addr" value="<%=dto.getAddr()%>" />
		</div>
		
		<button type="submit">수정</button>
		<button type="reset">취소</button>
	</form>
</div>

</body>
</html>