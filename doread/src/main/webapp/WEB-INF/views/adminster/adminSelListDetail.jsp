<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ssh.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>

</head>
<body>
<jsp:include page="/WEB-INF/views/adminster/adminheader3.jsp"/>
<br><br>
<jsp:include page="/WEB-INF/views/adminster/adminheader.jsp"/>

<div class="page-main">
	<br>
	<h2>판매상세내역</h2>
		
	<hr size="1.5" width="80%" noshade="noshade">

	<div class="content-main">
	
		<c:if test="${!empty list}">
			<table>
				<tr>
					<th>상세번호</th>
					<th>책이름</th>
					<th>책가격</th>
					<th>수량</th> 
					<th>합계</th>
				</tr>
			<c:forEach var="i" items="${list}">
				<tr>
					<td>${i.order_num}</td>
					<td><a href="${pageContext.request.contextPath}/book/detail.do?book_num=${i.book_num}"><img width="200" height="270" src="${pageContext.request.contextPath}/upload/${i.book_image}"></a><br>${i.book_name}</td>
					<td>${i.book_price}</td>
					<td>${i.order_quantity}</td>
					<td> <fmt:formatNumber value="${i.book_total }"/>원</td>
				</tr>
				<tr>
					<td colspan="5"><hr size="1.5" width="80%" noshade="noshade"></td>
				</tr>
			</c:forEach>
			</table>
		</c:if>

	</div>
	
	<div class="align-center" style="margin:0 auto;">
	
		<ul class="align-left addressmm">
			<li>받는 사람 : ${order.receive_name }</li>
			<li>전화번호 : ${order.receive_phone }</li>
			<li>우편번호 : ${order.receive_zipcode }</li>
			<li>주소 : ${order.receive_address1 }  &nbsp;  ${order.receive_address2 }</li>
			<li>
			<span>배송상태 : </span>
				<c:if test="${order.order_status == 1}">결제완료</c:if>
				<c:if test="${order.order_status == 2}">배송시작</c:if>
				<c:if test="${order.order_status == 3}">배송중</c:if>
				<c:if test="${order.order_status == 4}">배송완료</c:if>
				<c:if test="${order.order_status == 5}"><span style="color:red;">주문 취소</span></c:if>
				<c:if test="${order.order_status != 5}">
			<input type="button" class="button2"  value="배송상태변경" id="delivery">
			
			
			<form id="deliform" class="hide" method="post">
			<select name="order_status" id="order_status" class="input-style"  >
					<option value="1" <c:if test="${order.order_status == 1}">selected</c:if>>배송대기</option>
					<option value="2" <c:if test="${order.order_status == 2}">selected</c:if>>배송준비중</option>
					<option value="3" <c:if test="${order.order_status == 3}">selected</c:if>>배송중</option>
					<option value="4"<c:if test="${order.order_status == 4}">selected</c:if>>배송완료</option>
					<option value="5" <c:if test="${order.order_status == 5}">selected</c:if>>주문취소</option>
			</select>
			
			<input type="submit" class="button2"  value="변경" id="upbtn">
			<input type="button" class="button2"  value="취소" id="delbtn">
			</form>
			</c:if>
			</li>
			<li>요청사항 : ${order.order_msg}</li>
		</ul>
		<form method="post" id="deliveryupdate" class="hide" >
			<input type="hidden" name="order_num" value="${order.order_num}" class="input-style input-check">
			<ul class="align-left" style="margin:0 auto;">
				<li><input type="text" id="receive_name" name="receive_name" value="${order.receive_name}" class="input-style input-check"></li>
				<li><input   type="text" id="receive_phone" name="receive_phone" value="${order.receive_phone}" class="input-style input-check"></li>
				<li><input type="text" id="receive_zipcode" name="receive_zipcode" value="${order.receive_zipcode}" class="input-style input-check"> <input type="button" class="hidden input-style" value="우편번호 찾기" onclick="execDaumPostcode()"></li>
				<li><input type="text" id="receive_address1" name="receive_address1" value="${order.receive_address1}" class="input-style input-check"></li>
				<li><input type="text" id="receive_address2" name="receive_address2" value="${order.receive_address2}" class="input-style"></li>
			</ul>
			<input type="submit" class="button2"  value="변경" id="up2btn">
			<input type="button" class="button2"  value="취소" id="del2btn">
		</form>
		<p>
		<br>
		<c:if test="${order.order_status == 1}">
			<input type="button" value="배송지 정보 수정" class="button2" id="addressbtn" >
		</c:if>
			<input type="button" value="목록" class="button2" onclick="location.href='${pageContext.request.contextPath}/order/adminList.do'">
		
		</div>
		<script type="text/javascript">
			$('#delivery').click(function(){
				if($('#deliform').hasClass('hide')){
					$('#deliform').removeClass('hide');
				}else{
					$('#deliform').addClass('hide');
				}
				
			});
			$('#delbtn').click(function(){
				if($('#deliform').hasClass('hide')){
					$('#deliform').removeClass('hide');
				}else{
					$('#deliform').addClass('hide');
				}
				
			});
			$('#deliform').submit(function(event){
					$.ajax({
						url:'updatestatus.do',
						data:{order_num:${order.order_num},status:$('#order_status').val()},
						type:'post',
						dataType:'json',
						success:function(param){
							if(param.result =='logout'){
								alert('관리자로 로그인 후 이용가능');
								
							}else if(param.result =='success'){
								alert('변경완료');
								$('#deliform').addClass('hide');
								location.href='detailOrder.do?order_num=${order.order_num}';
							}else if(param.result =='cancle'){
								alert('고객이 주문취소하였습니다.');
								
							}else{
								alert('변경오류');
							}
						},error:function(){
							alert('네트워크오류');
						}
						
					});
				
				
				event.preventDefault();
				
			});
			$('#addressbtn').click(function(){
				if($('.addressmm').hasClass('hide')){
					
				}else{
					$('.addressmm').addClass('hide');
					$('#deliveryupdate').removeClass('hide');
				}
			});
			$('#del2btn').click(function(){
				$('.addressmm').removeClass('hide');
				$('#deliveryupdate').addClass('hide');
				
			});
			
			$('#deliveryupdate').submit(function(event){
				const inputcheck = document.getElementsByClassName('input-check');
				for(let i=0; i<inputcheck.length; i++){
					if(inputcheck[i].value.trim()==''){
						alert("배송지 정보를 입력해주세요");
						return false;
					}
					if(items[i].id == 'receive_zipcode' && !/^[0-9]{5}$/.test(items[i].value)){
						alert('우편번호를 입력하세요 (숫자5자리)');
						items[i].value='';
						items[i].focus();
						return false;
						
					}
					
				}
				const address = $('#deliveryupdate').serialize();
				$.ajax({
					url:'updateadminaddress.do',
					data:address,
					type:'post',
					dataType:'json',
					success:function(param){
						if(param.result =='logout'){
							alert('관리자로 로그인 후 이용가능');
							
						}else if(param.result =='success'){
							alert('변경완료');
							$('.addressmm').removeClass('hide');
							$('#deliveryupdate').addClass('hide');
							location.href='detailOrder.do?order_num=${order.order_num}';
						}else{
							alert('변경오류');
						}
					},error:function(){
						alert('네트워크오류');
					}
					
				});
				event.preventDefault();
			})
		
		</script>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
<%--다음 우편번호 api 시작 --%>
		 	<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
		<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
		</div>
		
		<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script>
		    // 우편번호 찾기 화면을 넣을 element
		    var element_layer = document.getElementById('layer');
		
		    function closeDaumPostcode() {
		        // iframe을 넣은 element를 안보이게 한다.
		        element_layer.style.display = 'none';
		    }
		
		    function execDaumPostcode() {
		        new daum.Postcode({
		            oncomplete: function(data) {
		                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
		
		                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
		                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		                var addr = ''; // 주소 변수
		                var extraAddr = ''; // 참고항목 변수
		
		                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		                    addr = data.roadAddress;
		                } else { // 사용자가 지번 주소를 선택했을 경우(J)
		                    addr = data.jibunAddress;
		                }
		
		                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
		                if(data.userSelectedType === 'R'){
		                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                        extraAddr += data.bname;
		                    }
		                    // 건물명이 있고, 공동주택일 경우 추가한다.
		                    if(data.buildingName !== '' && data.apartment === 'Y'){
		                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                    }
		                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		                    if(extraAddr !== ''){
		                        extraAddr = ' (' + extraAddr + ')';
		                    }
		                    //(주의)address1에 참고항목이 보여지도록 수정
		                    // 조합된 참고항목을 해당 필드에 넣는다.
		                    //(수정) document.getElementById("address2").value = extraAddr;
		                
		                } 
		                //(수정) else {
		                //(수정)    document.getElementById("address2").value = '';
		                //(수정) }
		
		                // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                document.getElementById('receive_zipcode').value = data.zonecode;
		                //(수정) + extraAddr를 추가해서 address1에 참고항목이 보여지도록 수정
		                document.getElementById("receive_address1").value = addr + extraAddr;
		                // 커서를 상세주소 필드로 이동한다.
		                document.getElementById("receive_address2").focus();
		
		                // iframe을 넣은 element를 안보이게 한다.
		                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
		                element_layer.style.display = 'none';
		            },
		            width : '100%',
		            height : '100%',
		            maxSuggestItems : 5
		        }).embed(element_layer);
		
		        // iframe을 넣은 element를 보이게 한다.
		        element_layer.style.display = 'block';
		
		        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
		        initLayerPosition();
		    }
		
		    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
		    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
		    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
		    function initLayerPosition(){
		        var width = 300; //우편번호서비스가 들어갈 element의 width
		        var height = 400; //우편번호서비스가 들어갈 element의 height
		        var borderWidth = 5; //샘플에서 사용하는 border의 두께
		
		        // 위에서 선언한 값들을 실제 element에 넣는다.
		        element_layer.style.width = width + 'px';
		        element_layer.style.height = height + 'px';
		        element_layer.style.border = borderWidth + 'px solid';
		        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
		        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
		        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
		    }
		</script>
</body>
</html>