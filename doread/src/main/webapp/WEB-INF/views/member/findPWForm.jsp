<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${checkID_msg == 'IDNotFound'}">
<script type="text/javascript">
	alert('입력하신 아이디를 찾을 수 없습니다.');
	history.go(-1);
</script>
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/kbm.css" type="text/css">

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
$(function(){
	let pwChecked = 0;
	$('#passwd_checkmessage').hide();
	
	
	$('#findPW_form #passwd').keyup(function(){
		pwChecked = 0;
		$('#passwd_checkmessage').hide();
	});
	
	$('#findPW_form #cpasswd').keyup(function(){
		pwChecked = 0;
		$('#passwd_checkmessage').hide();
	});
	
	
	$('#findPW_form #cpasswd').keyup(function(){
		if($('#passwd').val() == $('#cpasswd').val()){
			pwChecked = 1;
			$('#passwd_checkmessage').show();
		}
	});
	
	$('#findPW_form #passwd').keyup(function(){
		if($('#passwd').val() == $('#cpasswd').val()){
			pwChecked = 1;
			$('#passwd_checkmessage').show();
		}
	});
	
	$('#findPW_form').submit(function(event){
		const items = document.querySelectorAll('.input-check');
		for(let i=0;i<items.length;i++){
			if(items[i].value.trim() == ''){
				const label = document.querySelector('label[for="' +items[i].id+ '"]');
				alert(label.textContent + ' 필수 입력')
				items[i].value == '';
				items[i].focus();
				return false;
			}
			if(items[i].id == 'phone' && !/^01(0|1|[6-9])[0-9]{3,4}[0-9]{4}$/.test($('#phone').val())){
				alert('전화번호를 양식에 맞게 입력하세요');
				$('#id').focus();
				return false;
			}
			
			if(items[i].id == 'passwd' && !/^(?!((?:[A-Za-z]+)|(?:[~!@#$%^&*()_+=]+)|(?:[0-9]+))$)[A-Za-z\d~!@#$%^&*()_+=]{8,12}$/.test($('#passwd').val())){
				alert('비밀번호는 영문,숫자,특수문자 조합(8~12자)으로 입력하세요');
				$('#passwd').focus();
				return false;
			}
			
			if(items[i].id == 'cpasswd' && pwChecked == 0){
				alert('비밀번호를 다시 입력하세요');
				$('#cpasswd').focus();
				return false;
			}
			
		}
	});
});
</script>
</head>
<body>
<div class="page-main">
	<div class="content-main">
	<jsp:include page="/WEB-INF/views/member/loginheader.jsp"/>
	<div class="find-menu">
		<div class="find-h">
			<h4><a href="findIDForm.do">아이디 찾기</a></h4>
			<h2><a href="findPWNoIDForm.do">비밀번호 찾기</a></h2>
		</div>
	</div>
	<hr size="1" noshade width="800">
	<div class="find-menu2">
		<h3>비밀번호 재설정</h3>
		<span>비밀번호를 변경해주세요</span>
	</div>
	<div class="findPW-main">
		<form id="findPW_form" action="findPW.do" method="post" class="register-member">
			<input type="hidden" name="num" value="${num}">
			<input type="hidden" name="id" value="${id}">
			<ul>
				<li class="ID-setted">
					아이디 : <span>${id}</span>
				</li>
				<li>
					<label for="phone">전화번호</label>
					<input type="text" name="phone" id="phone" maxlength="15" class="input-check" placeholder="숫자만 입력">
				</li>
				<li>
					<label for="passwd">새 비밀번호</label>
					<input type="password" name="passwd" id="passwd" maxlength="12" class="input-check" placeholder="영문,숫자,특수문자 조합(8~12자)">
				</li>
				<li>
					<label for="cpasswd">새 비밀번호 확인</label>
					<input type="password" name="cpasswd" id="cpasswd" maxlength="12" class="input-check">
					<span id="passwd_checkmessage">비밀번호 일치</span>
				</li>
			</ul>
			<div class="findPW-button">
				<input type="submit" value="확인">
			</div>
		</form>
		<hr size="1" noshade width="800">
	</div>
	</div>
</div>
</body>
</html>