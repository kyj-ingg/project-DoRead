<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마일리지 내역 목록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/kts.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/header_test.css" type="text/css">
<script>

</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/member/mypageheader.jsp"/>
	<div class="content-main post-header">
		<h2>마일리지 내역 목록</h2>
		<hr size="1" noshade width="100%">
		<ul>
			<li>
				<span id="allpoint"> 총 마일리지 : ${allpoint}P </span>
			</li>
		</ul>
		<br><br>
		
		<c:if test="${count == 0}">
			<div class="result-display buylist-align-center">
				표시할 내역이 없습니다.
			</div>
		</c:if>
		
		<c:if test="${count != 0}">
			<table class="main-table">
				<tr class="main-tr">
					<th class="main-td">번호</th>
					<th class="main-td">구분</th>
					<th class="main-td">내용</th>
					<th class="main-td">마일리지</th>
					<th class="main-td">날짜</th>
					
				</tr>
				<c:forEach var="point" items="${list}">
					<c:if test="${point.p_point !=0 }">
						<tr class="mileage-list">
						
							
							<td class="main-td">${point.rownum}</td>
							<td class="main-td">
								<c:if test="${point.p_detail == 0}">도서구매적립</c:if>
								<c:if test="${point.p_detail == 1}">포인트사용</c:if>
								<c:if test="${point.p_detail == 2}">주문취소</c:if>
								<c:if test="${point.p_detail == 4}">포인트사용취소</c:if>
								<c:if test="${point.p_detail == 5}">이벤트 지급</c:if>
							</td>
							<td class="main-td">
								<c:if test="${point.p_detail != 5 && point.order_num != 0 }">
									<a href="${pageContext.request.contextPath}/order/orderDetail.do?order_num=${point.order_num}">${point.order_num}</a>
								</c:if>
							</td>	
							<td class="main-td">
								<c:set var="deletedStyle" value="text-decoration: line-through;" />
								
								<c:if test="${point.p_detail == 0}">+<fmt:formatNumber value="${point.p_point}"/></c:if>
								<c:if test="${point.p_detail == 1}">-<fmt:formatNumber value="${point.p_point}"/></c:if>
								<c:if test="${point.p_detail == 2}">
									<span style="text-decoration: line-through;">
										+<fmt:formatNumber value="${point.p_point}" />
									</span>
								</c:if>
								<c:if test="${point.p_detail == 4}">
									<span style="text-decoration: line-through;">
										-<fmt:formatNumber value="${point.p_point}" />
									</span>
								</c:if>
								<c:if test="${point.p_detail == 5}">+<fmt:formatNumber value="${point.p_point}"/></c:if>
							</td>
							<td class="main-td">${point.p_rdate}</td>
							
							
						</tr>
					</c:if>
				</c:forEach>		
			</table>
			<div style="text-align:center;">${page}</div>
			
		</c:if>
		
		
	</div>
	<br><br><br>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>