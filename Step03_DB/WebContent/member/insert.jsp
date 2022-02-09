<%@page import="test.member.dto.MemberDto"%>
<%@page import="test.member.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//1. 전송되는 추가할 회원의 이름과 주소 읽어오기
	//한글 깨지지 않도록
	request.setCharacterEncoding("utf-8");

	//폼 전송되는 파라미터 추출
	String name=request.getParameter("name");
	String addr=request.getParameter("addr");
	//콘솔에 출력해 보기
	System.out.println(name);
	System.out.println(addr);
	
//2. MemberDao 객체를 이용해서 DB에  저장하기
	MemberDao dao=MemberDao.getInstance();
	MemberDto dto= new MemberDto();
	dto.setName(name);
	dto.setAddr(addr);

//3. 작업 성공여부를 응답하기
	boolean added=dao.insert(dto);
	System.out.println(added);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/member/insert.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</head>
<body>
	<%if(added!=false){ %>
		<p class="alert alert-success">회원 추가 완료 <a href="list.jsp">목록보기</a></p>
	<%}else{ %>
		<p class="alert alert-success">회원 추가 실패 <a href="insertform.jsp">다시 시도</a></p>
	<%} %>
</body>
</html>