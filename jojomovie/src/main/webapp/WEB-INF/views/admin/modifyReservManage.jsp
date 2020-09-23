<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	div.col-sm-2.text-center {
		color: white;
	}
</style>
</head>

<body>
	<!--관리자 페이지 제목  -->
	<div class="container" style="background-color: #1e272e">
		<h1 style="color: white;">관리자 페이지</h1>
		<ul class="nav navbar-nav">
			<li class="active">
				<a href="#">
					<span class="glyphicon glyphicon-plus"> 관리자 추가하기</span>
				</a>
			</li>
			<li><a href="#"><span class="glyphicon glyphicon-log-out">
						관리자 모드 나가기</span></a></li>
			<li>
				<a href="/admin/adminPage">
					<spanclass="glyphicon glyphicon-log-out"> 메인 관리자 모드로 돌아가기!</span>
				</a>
			</li>
		</ul>
	</div>

	<div class="container" style="background-color: #485460;">
		<div class="jumbotron" style="background-color: #485460;">
			<h3 class="text-center" style="color: white;">
				<strong>** 회원 예매 정보 수정 **</strong>
			</h3>
			<!-- INPUT -->
			<form action="/admin/updateReserve" name="inputValue" method="post">
				<div class="row">
					<div class="col-sm-2" style="margin: 10px;"></div>
					<div class="col-sm-2 text-center" style="margin: 10px;"> 회원 ID</div>
					<div class="col-sm-3 text-center" style="margin: 10px;">
						<input type="text" name="userId" value="${rvList.userId}" readonly>
					</div>
					<div class="col-sm-3" style="margin: 10px;"></div>
				</div>
				<div class="row">
					<div class="col-sm-2" style="margin: 10px;"></div>
					<div class="col-sm-2 text-center" style="margin: 10px;">예매번호</div>
					<div class="col-sm-3 text-center" style="margin: 10px;">
						<input type="text" name="reservNumber" value="${rvList.reservNumber}" readonly>
					</div>
					<div class="col-sm-2" style="margin: 10px;"></div>
				</div>
				<div class="row">
					<div class="col-sm-2" style="margin: 10px;"></div>
					<div class="col-sm-2 text-center" style="margin: 10px;">티켓번호</div>
					<div class="col-sm-3 text-center" style="margin: 10px;">
						<input type="text" name="ticketId" value="${rvList.ticketId}" readonly> 
						 <strong style="color: white;">영화 이름 </strong>
						 <input type="text" name="movieName" value="${rvList.movieName}" readonly>
					</div>
					<div class="col-sm-2" style="margin: 10px;"></div>
				</div>
				<div class="row">
					<div class="col-sm-2" style="margin: 10px;"></div>
					<div class="col-sm-2 text-center" style="margin: 10px;">좌석</div>
					<div class="col-sm-3 text-center" style="margin: 10px;">
						<input type="text" name="seat" value="${rvList.seat}" readonly>
					</div>
					<div class="col-sm-3" style="margin: 10px;"></div>
				</div>
				<div class="row">
					<div class="col-sm-2" style="margin: 10px;"></div>
					<div class="col-sm-2 text-center" style="margin: 10px;">결제여부</div>
					<div class="col-sm-3 text-center" style="margin: 10px;">
						<input type="text" value="${rvList.tf}" name="tf"  id="changeReserv" readonly>
					</div>
					<div class="col-sm-2" style="margin: 10px;"></div>
				</div>
				<div class="row">
					<div class="col-sm-6"></div>
						<div class="col-sm-3">
							<c:choose>
								<c:when test="${rvList.tf eq 't'}">
										<button type="button" id="changeBtn" onclick="btbTest()" style="padding: 10px; background-color: #a9bcc4">
											결제 취소
										</button>
								</c:when>
								<c:otherwise></c:otherwise>
							</c:choose>
						</div>
					<div class="col-sm-3"></div>
				</div>
			</form>
		</div>
	</div>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script type="text/javascript" src="/script/jquery-3.5.1.js"></script>
	<script type="text/javascript" src="/script/bootstrap.js"></script>
	<script type="text/javascript"></script>
	
	
	<script>
		function btbTest(){
			var checkDC = confirm("취소하겠습니까????");
			
			if(checkDC == true){
				$('input[name=tf]').val('c');
				document.inputValue.submit();
				alert("취소완료");
			}else{
				alert("취소실패");
				
			}
		}
	</script>
</body>
</html>