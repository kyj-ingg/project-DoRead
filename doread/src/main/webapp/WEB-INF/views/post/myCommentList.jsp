<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 내역</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/kts.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/header_test.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
</head>
<body>
<div class="page-main">
		<jsp:include page="/WEB-INF/views/member/mypageheader.jsp" />
	<div class="content-main">
		<div class="post-header">
			<h2>내가 쓴 댓글</h2>
			<hr size="1" noshade width="100%">
			<div class="alertfont" style="font-size:10pxt; color:#d4d2d2;">***게시글/댓글당 신고 누적횟수가 5회이상이면 정지게시글/댓글이되며, 정지게시글/댓글이 5개이상이면 회원 정지가 될 수 있습니다.</div>
		</div>
		<h4>스토리 게시판 댓글</h4>
		<c:if test="${scount == 0}">
			<div class="result-display buylist-align-center">
				내역이 없습니다.
			</div>
		</c:if>
		<c:if test="${scount> 0}">
		<table class="content-main main-table">
			<tr class="main-tr">
				<th class="main-td">댓글 번호</th>
				<th class="main-td">내용</th>
				<th class="main-td">작성일</th>
			</tr>
			<c:forEach var="SCommentList" items="${SCommentList}">
			<input type="hidden" name="s_num" id="s_num" value="${SCommentList.s_num}">
			<tr>
				<td class="main-td">${SCommentList.sc_num}</td>
				<td class="main-td"><a href="${pageContext.request.contextPath}/story/storyDetail.do?s_num=${SCommentList.s_num}" class="comment-content">${SCommentList.sc_content}</a></td>
				<td class="main-td">${SCommentList.sc_rdate}</td>
			</tr>
			</c:forEach>	
		</table>
			<div style="text-align:center;">
				${spage}
			</div>
		</c:if>
			<hr size="1" noshade width="100%">
		<h4>중고 게시판 댓글</h4>
		<c:if test="${ucount == 0}">
			<div class="result-display buylist-align-center">
				내역이 없습니다.
			</div>
		</c:if>
		<c:if test="${ucount > 0}">
		<table class="main-table">
			<tr class="main-tr">
				<th class="main-td">댓글 번호</th>
				<th class="main-td">내용</th>
				<th class="main-td">작성일</th>
			</tr>
			<c:forEach var="UBCList" items="${UBCList}">
			<input type="hidden" name="u_num" id="u_num" value="${UBCList.u_num}">
			<tr>
				<td class="main-td">${UBCList.uc_num}</td>
				<td class="main-td"><a href="${pageContext.request.contextPath}/used/usedDetail.do?u_num=${UBCList.u_num}" class="comment-content">${UBCList.uc_content}</a></td>
				<td class="main-td">${UBCList.uc_rdate}</td>
			</tr>
			</c:forEach>	
		</table>
		<div style="text-align:center;">
				${upage}	
		</div>
		</c:if>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>