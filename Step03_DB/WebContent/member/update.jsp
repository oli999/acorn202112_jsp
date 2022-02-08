<%@page import="test.member.dto.MemberDto"%>
<%@page import="test.member.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한글 깨지지 않도록
	request.setCharacterEncoding("utf-8");

	//폼 전송되는 파라미터 추출
	int num=Integer.parseInt(request.getParameter("num"));
	String name=request.getParameter("name");
	String addr=request.getParameter("addr");
	//콘솔에 출력해 보기
	System.out.println(num);
	System.out.println(name);
	System.out.println(addr);
	
//2. MemberDao 객체를 이용해서 DB에  저장하기
	MemberDao dao=MemberDao.getInstance();
	MemberDto dto= new MemberDto();
	dto.setNum(num);
	dto.setName(name);
	dto.setAddr(addr);

//3. 작업 성공여부를 응답하기
	Boolean updated=dao.update(dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/member/update.jsp</title>
</head>
<body>
	<%if(updated!=false){ %>
		<p>회원 정보 수정 완료 <a href="list.jsp">목록보기</a></p>
	<%}else{ %>
		<p>회원 정보 수정 실패 <a href="updateform.jsp">다시 시도</a></p>
	<%} %>
</body>
</html>