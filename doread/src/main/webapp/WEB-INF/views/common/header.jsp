<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- header 시작 -->
<div id="mini_nav">
	<ul>
		<c:if test="${empty user_num}">
		<li>
			<a href="${pageContext.request.contextPath}/member/registerUserForm.do">회원가입</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/member/loginForm.do">로그인</a>
		</li>
		</c:if>
		<c:if test="${!empty user_num}">
		<li class="menu-logout">
			[<span>${user_id}</span>]
			<a href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a>
		</li>
		</c:if>
		<c:if test="${!empty user_num && user_auth == 9}">
		<li>
			<a href="${pageContext.request.contextPath}/member/adminList.do">회원관리</a>
		</li>
		</c:if>
	</ul>
</div>
<div id="header-search">
	<h1 class="align-left">
		<a href="${pageContext.request.contextPath}/main/main.do">Do Read</a>
	</h1>
	<form id="search_form" action="list.do" method="get">
			<ul class="search">
				<li>
					<select name="keyfield">
						<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>제목</option>
						<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>아이디</option>
						<option value="3" <c:if test="${param.keyfield==3}">selected</c:if>>내용</option>
					</select>
				</li>
				<li>
					<input type="search" size="16" name="keyword" id="keyword" value="${param.keyword}">				
				</li>
				<li>
					<input type="submit" value="검색">
				</li>
			</ul>
	</form>
</div>
<div>
	<ul>
		<c:if test="${!empty user_num}">
		<li>
			<a href="${pageContext.request.contextPath}/member/myPage.do">MY페이지</a>
		</li>
		</c:if>
		<c:if test="${!empty user_num && !empty user_photo}">
		<li	class="menu-profile">
			<img src="${pageContext.request.contextPath}/upload/${user_photo}" width="25" height="25" class="my-photo">
		</li>
		</c:if>
		<c:if test="${!empty user_num && empty user_photo}">
		<li	class="menu-profile">
			<img src="${pageContext.request.contextPath}/images/face.png" width="25" height="25" class="my-photo">
		</li>
		</c:if>
	</ul>
</div>
<div id="main_nav">
	<ul>
		<li>
			<a href="${pageContext.request.contextPath}/board/list.do">책 카테고리</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/board/newsList.do">뉴스</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/board/eventList.do">이벤트</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/board/usedList.do">중고</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/board/list.do">게시판</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/board/QnAList.do">QnA</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/adminster/adminPage.do">관리자페이지</a>
		</li>
		
		
	</ul>
</div>
<!-- header 끝 -->








