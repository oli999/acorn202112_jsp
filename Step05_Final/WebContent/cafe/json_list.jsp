<%@page import="org.json.JSONWriter"%>
<%@page import="test.cafe.dao.CafeDao"%>
<%@page import="test.cafe.dto.CafeDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	CafeDto dto=new CafeDto();
	dto.setStartRowNum(1);
	dto.setEndRowNum(10);
	List<CafeDto> list=CafeDao.getInstance().getList(dto);
	//List 안에 있는 데이터를 json 문자열로 변환하기 
	String result=JSONWriter.valueToString(list);
%>
<%=result%>