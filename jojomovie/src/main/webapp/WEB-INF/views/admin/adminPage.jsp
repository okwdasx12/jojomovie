<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<link href="/css/index.css" rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap"
	rel="stylesheet">
</head>

<body>
	<!--관리자 페이지 제목  -->
	<div class="container-fluid" id="page"
		style="background-color: #333333;">
		<h1>관리자 페이지</h1>
		<ul class="nav navbar-nav">
			<li class="active"><img alt="" src="/images/추가하기.png"><a href="#">관리자 추가하기</a></li>
			<li><img alt="" src="/images/나가기2.png"><a href="/">관리자모드 나가기</a></li>
		</ul>
	</div>
	
	<div class="container-fluid">
		<div class="jumbotron" id="jum"
			style="background-color: #485460; height: 737px; padding-top: 156px;">
			<div class="row3">
				<div class="box " style="margin: 10px;">
					<a href="/admin/addMovie"><button type="button" class="btn-row">영화등록</button></a>
				</div>
				<div class="box " style="margin: 10px;">
					<a href="/admin/searchMovie"><button type="button" class="btn-row">영화검색</button></a>
				</div>
				<div class="box " style="margin: 10px;">
					<a href="/admin/reserveList"><button type="button" class="btn-row">예매관리</button></a>
				</div>
				<div class="box " style="margin: 10px;">
					<a href="/admin/memberManage"><button type="button" class="btn-row">회원관리</button></a>
				</div>
			</div>
			<div class="row3">
				<div class="box" style="margin: 10px;">
					<a href="/admin/addTheater"><button type="button" class="btn-row">영화관추가</button></a>
				</div>
				<div class="box" style="margin: 10px;">
					<a href="/admin/addSangyounggwan"><button type="button" class="btn-row">상영관등록</button></a>
				</div>
				<div class="box" style="margin: 10px;">
					<a href="/admin/addMovieTime"><button type="button" class="btn-row">상영시간등록</button></a>
				</div>
				<div class="box" style="margin: 10px;">
					<a href="/admin/modify">
						<button type="button" class="btn-row">
							영화관 상영관<br>상영시간<br>수정및삭제
						</button>
					</a>
				</div>
			</div>
		</div>
	</div>

	<div class="container-fluid">
		<footer>
			<div class="owow">
				<div class="col-md-12" id="footer13">
					<p id="footerr">
						&copy; Untitled. All rights reserved. | Photos by Fotogrph | Design by 조조무비<img alt="d" src="/images/트위터.png">
						<img alt="d" src="/images/페이스북.png">
						<img alt="d" src="/images/인스타그램.png">
						<img alt="d" src="/images/안드로이드.png">
						<img alt="d" src="/images/애플.png">
					</p>
				</div>
			</div>
		</footer>

	</div>

</body>
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script type="text/javascript" src="/script/jquery-3.5.1.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script type="text/javascript" src="/script/bootstrap.js"></script>
</html>