<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 상세 내역</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/kts.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/header_test.css" type="text/css">
</head>
<body>
<div class="page-main">
	<div class="content-main">
	<jsp:include page="/WEB-INF/views/news/test_header.jsp"/>
	<jsp:include page="/WEB-INF/views/member/mypageheader.jsp"/>
	
	<h2>주문상세내역</h2>
	<hr size="1" noshade width="100%">
	
	<table>
 			<tr>
 				<th>도서명</th>
 				<th>수량</th>
 				<th>도서가격</th>
 				<th>합계</th>
 			</tr>
 			<c:forEach var="detail" items="${detailList}">
				<tr>
					<td>${detail.book_name}</td>
					<td class="align-center">
						<fmt:formatNumber value="${detail.order_quantity}"/>
					</td>
					<td class="align-center">
						<fmt:formatNumber value="${detail.book_price}"/>원
					</td>
					<td class="align-center">
						<fmt:formatNumber value="${detail.book_total}"/>원
					</td>
				</tr>
 			</c:forEach>
 			<tr>
 				<td colspan="3" class="align-right"><b>총구매금액</b></td>
 				<td class="align-center"><fmt:formatNumber value="${order.order_total}"/>원</td>
 			</tr>
 		</table>
 		
		<div id="receive_info">
			<ul>
				<li>
					<span>배송지정보</span>
					<div>
						<ul>
							<li><span id="displayName" class="info-span">${order.receive_name}</span></li>
							<li><span id="displayPhone" class="info-span">${order.receive_phone}</span></li>
							<li><span id="displayZipcode" class="info-span">${order.receive_zipcode}</span></li>
							<li><span id="displayAddress1" class="info-span">${order.receive_address1}</span> <span id="displayAddress2" class="info-span">${order.receive_address2}</span></li>

						</ul>
					</div>
				</li>
				<li>
					<label>배송요청사항</label> ${order.order_msg}
				</li>
				<li>
					<label>공동현관 출입방법</label>
					<c:if test="$">
					
					</c:if>
						<input type="radio" name="enter" value="passwd">공동현관 비밀번호
						<input type="radio" name="enter" value="free" checked>자유출입 가능
						<input type="text" name="enter_passwd" placeholder="정확한 공동현관 출입번호를 입력하세요">
				</li>
			</ul>
		</div>
				
	</div>
</div>
</body>
</html>