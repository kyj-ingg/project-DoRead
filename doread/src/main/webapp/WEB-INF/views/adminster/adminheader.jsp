<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ssh.css" type="text/css">
 
<div id="adminpage" style="z-index:1;">
	<a class="photo_btn"><img  class="photo_btn" id="penimage" src="${pageContext.request.contextPath}/images/pencil_1361912.png"  width="30" height="30"></a>
	<div class="adminnav" style="z-index:1;">
	<ul >
		<li id="myphoto" style="z-index:1;">
			<c:if test="${empty user_photo}">
				<img src="${pageContext.request.contextPath}/images/face.png" 
						                   width="100" height="100" class="my-photo">
			</c:if>
			<c:if test="${!empty user_photo}">
				<img src="${pageContext.request.contextPath}/upload/${user_photo}"
					                   width="100" height="100" class="my-photo" id="my" >
			</c:if>
			
				<div id="photo_choice" style="display:none; position:absolute; z-index:999 !important; background:white;">
					<input type="file" id="photo" accept="image/gif,image/png,image/jpeg" class="input-style"> 
					<input type="button" class="button2" value="전송" id="photo_submit"> 
					<input type="button"   class="button2" value="취소" id="photo_reset">
				</div>
			
		</li>
		<li style="padding-top:40px; font-size:19pt; text-align:left;color:white;">
			<b>관리자<br>페이지입니다.</b>
		</li>
		<li>
			<div class="subul">
			<ul >
				<li><label>도서관리</label></li>
				<li><a href="${pageContext.request.contextPath}/adminster/adminPage.do">-책등록</a></li>
				<li><a href="${pageContext.request.contextPath}/book/adminBookList.do">-도서 정보 변경</a></li>
			</ul>
			</div>
		</li>
		<li>
			<div class="subul">
			<ul>
				<li><label>회원관리</label></li>
				<li><a href="${pageContext.request.contextPath}/adminster/userList.do">-전체회원</a></li>
				<li><a href="${pageContext.request.contextPath}/adminster/userList2.do">-정지회원</a></li>
			</ul>
			</div>
		</li>
		<li >
			<div class="subul">
			<ul >
				<li><label>판매</label></li>
				<li><a href="${pageContext.request.contextPath}/order/adminList.do">-판매내역</a></li>
				<li><a href="${pageContext.request.contextPath}/qna/qnaList.do">-문의내역</a></li>
			
			</ul>
			</div>
		</li>
		<li>
			<div class="subul">
			<ul style="font-size:12px;" >
				<li><label>신고내역관리</label></li>
				<li><a href="${pageContext.request.contextPath}/adminster/ulist.do">-신고게시글/댓글</a>
				<li><a href="${pageContext.request.contextPath}/adminster/ulimitlist.do">-정지게시글/댓글</a>
			</ul>
			</div>
		</li>
	</ul>
	</div>
</div>