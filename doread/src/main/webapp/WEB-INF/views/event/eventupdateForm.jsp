<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 글쓰기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/kbm.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/header_test.css" type="text/css">
<script type="text/javascript">
	window.onload = function(){
		const inputcheck = document.getElementsByClassName('inputcheck');
		const form = document.getElementById('event_form');
		
		form.onsubmit = function(){
			for(let i=0; i<inputcheck.length; i++){
			const label = document.querySelector('label[for="'+inputcheck[i].id+'"]');
			
			if(inputcheck[i].value.trim()==''){
				alert(label.textContent+' 필수 입력');
				inputcheck[i].value='';
				inputcheck[i].focus();
				return false;
				
			}
			if(inputcheck[i].id=='e_deadline'){
				if(!/^[2-9][0-9]{3}[-][0-9]{2}[-][0-9]{2}$/.test(inputcheck[i].value)){
					alert('이벤트 종료일은 2024-05-26 형식으로 입력하세요');
					inputcheck[i].focus();
					return false;
					
				}
				
			}
		
			}
		}
		
	};

</script>
</head>

<body>
<jsp:include page="/WEB-INF/views/news/test_header.jsp"/>
<div class="page-main">
<div class="eventvar">
	<h1>EVENT 글수정</h1>
</div>
<div>
<form action="eventupdate.do" method="post" id="event_form" enctype="multipart/form-data" >
	<div>
	<input type="hidden" name="e_num" value="${event.e_num}">
	<ul>
		<li><label for="e_title">이벤트 제목</label>
			<input type="text" name="e_title" class="inputcheck input-style" id="e_title" maxlength="30"  value="${event.e_title}">
		</li>
		<li><label for="e_item">이벤트 상품</label>
			<input type="text" name="e_item" class="inputcheck input-style "  id="e_item" maxlength="10" value="${event.e_item}">
		</li>
		
		<li><label for="e_deadline">이벤트종료일(발표일)</label>
			<input type="text" name="e_deadline" class="inputcheck input-style " id="e_deadline" maxlength="10" value="${event.e_deadline}">
		</li>
		<li><label for="e_content">이벤트 내용</label>
			<textarea class="inputcheck input-style" style="height:150px"  id="e_content" name="e_content">${event.e_content}</textarea>
		</li>
		
		<li>
			<label for="e_image">이벤트 이미지</label>
			<input type="file" id="e_image" name="e_image" class="input-style " accept="image/gif,image/png,image/jpeg">
			
		</li>
	</ul>
	</div>
	<div class="align-center">
	<input type="submit" value="수정" class="btn2">
	<input type="button" value="이벤트목록" class="btn2" onclick="location.href='${pageContext.request.contextPath}/event/eventmain.do'">
	
	</div>
	
</form>
			
				
		
			
</div>
	
</div>
</body>
</html>

