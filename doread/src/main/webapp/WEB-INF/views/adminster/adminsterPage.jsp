<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ssh.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script type="text/javascript">
	window.onload = function(){
		const inputcheck = document.getElementsByClassName('inputcheck');
		
	};

</script>
</head>
<body>
<div class="page-main">
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/adminster/adminheader.jsp"/>
<form action="bookcreate.do" method="post" id="bookcreate_form" enctype="multipart/form-data" >
	<h2>책 등록</h2>
	<hr size="1.5" width="100%" noshade="noshade">
	<ul>
		<li><label for="book_name">책 이름</label>
			<input type="text" name="book_name" class="inputcheck input-style" id="book_name" maxlength="30" >
		</li>
		<li><label for="author">책 저자</label>
			<input type="text" name="author" class="inputcheck input-style "  id="author" maxlength="10">
		</li>
		<li><label for="publisher">출판사</label>
			<input type="text" name="publisher" class="inputcheck input-style " id="publisher" maxlength="10">
		</li>
		<li><label for="publish_date">출판일</label>
			<input type="text" name="publish_date" class="inputcheck input-style " id="publish_date" maxlength="10">
		</li>
		<li><label for="price">가격</label>
			<input type="number" name="price" class="inputcheck input-style " id="price" maxlength="8">
		</li>
		<li><label for="stock">재고</label>
			<input type="number" name="stock" class="inputcheck input-style" id="stock" maxlength="8">
		</li>
		<li><label for="book_category">책카테고리</label>
			<select name="book_category" id="book_category" class="inputcheck input-style">
				<option value="1">소설</option>
				<option value="2">시/에세이</option>
				<option value="3">인문</option>
				<option value="4">정치/사회</option>
				<option value="5">과학/공학</option>
				<option value="6">IT/프로그래밍</option>
				<option value="7">자기계발</option>
				<option value="8">외국어</option>
				<option value="9">수험서/취업</option>
				<option value="10">만화</option>
				<option value="11">취미/스포츠</option>
			</select>
		</li>
		<li>
			<label for="book_img">책 이미지</label>
			<input type="file" id="book_img" name="book_img" class="inputcheck input-style " accept="image/gif,image/png,image/jpeg">
			
		</li>
	</ul>
	<div class="align-center">
	<input type="submit" value="등록" class="button2">
	<input type="button" value="메인" class="button2" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
	</div>
</form>
</div>
</body>
</html>