<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ssh.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ysw.css" type="text/css">

</head>
<body>

<jsp:include page="/WEB-INF/views/adminster/adheader2.jsp"/>
<jsp:include page="/WEB-INF/views/adminster/adminheader.jsp"/>
<div class="page-main">

	<h2>회원 관리</h2>
	
	<hr size="1.5" width="80%" noshade="noshade">
	
	<div class="content-main">
	<table>
		<c:if test="${!empty member}">
			<tr>
			<th>회원번호</th>
			<th>회원이름</th>
			<th>회원아이디</th>
			<th>회원등급</th> 
			<th>회원전화번호</th>
			<th>회원이메일</th>
			<th>회원가입일</th>
			</tr>
		<c:forEach var="i" items="${member}">
			
			<tr>
			<td>${i.mem_num}</td>
			<td>${i.mem_name}</td>
			<td>${i.mem_id }</td>
			<td> <a href="detailUser.do?mem_num=${i.mem_num}">${i.mem_auth}</a></td>
			<td>${i.mem_email}</td>
			<td>${i.mem_email}</td>
			<td>${i.mem_rdate}</td>
			</tr>
		</c:forEach>
		</c:if>
	</table>
	</div>
	<div class="align-center">

	<input type="button" value="메인" class="button2" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
	</div>
	


</div>
</body>
</html>