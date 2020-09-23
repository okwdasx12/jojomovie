<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="javatime" uri="http://sargue.net/jsptags/time" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1 user-scalable=no">
<title>조조무비</title>

<link href="/css/bootstrap.css" rel="stylesheet">
<link href="/css/bootstrap-theme.css" rel="stylesheet">
<link href="/css/admin.css" rel="stylesheet">

<style>
	td#table_t{
		text-align: center;
		font-weight: bold;
	}
</style>
</head>
<body>
	<!--관리자 페이지 제목  -->
	<div class="container" style="background-color:#1e272e">
		<h1 style="color: white;">관리자 페이지</h1>
		<ul class="nav navbar-nav">
	      <li class="active"><a href="#"><span class="glyphicon glyphicon-plus"> 관리자 추가하기</span></a></li>
	      <li><a href="#"><span class="glyphicon glyphicon-log-out"> 관리자 모드 나가기</span></a></li>
	      <li><a href="/admin/adminPage"><span class="glyphicon glyphicon-log-out"> 메인 관리자 모드로 돌아가기!</span></a></li>
	    </ul>
	</div>
	<div class="container" style="margin-top: 100px;">
		<h1> 예매 내역 </h1>
			<div style="margin:10px;">
				<table class="table">
				    <thead>
				      <tr>
				        <th class="text-center">아이디</th>
				        <th class="text-center">예매번호</th>
				        <th class="text-center">결제번호</th>
				        <th class="text-center">영화 이름</th>
				        <th class="text-center">영화관</th>
				        <th class="text-center">상영관</th>
				        <th class="text-center">예약 좌석</th>
				        <th class="text-center">상영시간</th>
				        <th class="text-center">예매 금액</th>
				        <th class="text-center">적립 포인트</th>
				        <th class="text-center">예매 날짜</th>
				        <th class="text-center">예매 취소</th>
				      </tr>
				    </thead>
			    <c:forEach var="paylist" items="${paylist}">
				    <tbody>
				      <tr>
				        <td id="table_t">${reserveVo.userId}</td>
				        <td>${reserveVo.reserveNumber}</td>
				        <td>${reserveVo.ticketId}</td>
				        <td>${reserveVo.movieName}</td>
				        <td>${reserveVo.theaterName}</td>
				        <td><strong>${reserveVo.sygId} 관</strong></td>
				        <td>${reserveVo.seat}</td>
				        <td><javatime:format value="${reserveVo.sangyoungTime}" pattern="yyyy.MM.dd HH시mm분"/></td>
			     		<td>${paylist.totalPrice}</td>
			     		<td>${paylist.point}</td>
				     	<td><javatime:format value="${reserveVo.reserveDate}" pattern="yyyy.MM.dd HH시mm분"/></td>
				        <td colspan="2">  
			        	<form action="/admin/deleteReserve" name="checkD" method="post">
							<input type="hidden" value="${reserveVo.reserveNumber}" name="reserveNumber">
							<input type="hidden" value="${reserveVo.payId}" name="payId">
							<input type="hidden" value="${reserveVo.seat }" name="seat">
							<input type="hidden" value="${reserveVo.sygId }" name="sygId">
							<input type="hidden" value="${reserveVo.sangyoungTime }" name="sangyoungTime">
							<input type="hidden" value="${paylist.point}" name="point">
							<input type="hidden" value="${paylist.usepoint}" name="usepoint">
							<input type="hidden" value="${reserveVo.userId}" name="userId">
							<button type="button" onclick="deleteReserve()"style="padding: 10px; background-color: #a9bcc4">예매취소</button>
						</form>
				        </td>
				      </tr>
				    </tbody>
			    </c:forEach>
		 	</table>
		</div>
   	</div> 
		
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script type="text/javascript" src="/script/jquery-3.5.1.js"></script>
	<script type="text/javascript" src="/script/bootstrap.js"></script>
	<script type="text/javascript"></script>
	
	<script>
		function deleteReserve(){
			var check = confirm('삭제하시겠습니까');

			if(check == true){
				alert('삭제완료');
				checkD.submit();
			}else{
				alert('삭제 취소');
			}
		}
	</script>
</body>
</html>
