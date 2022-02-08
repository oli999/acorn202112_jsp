<%@page import="test.member.dao.MemberDao"%>
<%@page import="test.member.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));

	boolean isDeleted=MemberDao.getInstance().delete(num);
	System.out.println(isDeleted);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/member/delete.jsp</title>
</head>
<body>
	<%if(isDeleted){ %>
	<script>
		alert("삭제 성공");
		location.href="list.jsp";
	</script>
	<%}else{%>
	<script>
		alert("삭제 실패");
		location.href="list.jsp";
	</script>
	<%} %>
</body>
</html>