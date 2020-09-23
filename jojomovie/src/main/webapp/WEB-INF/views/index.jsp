<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1 user-scalable=no">
<title>조조무비</title>
<link href="/css/bootstrap.css" rel="stylesheet">
<link href="/css/bootstrap-theme.css" rel="stylesheet">
<link href="/css/index.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
</head>
<style>
</style>

<body>
<div id="topMenu"></div>
<jsp:include page="/WEB-INF/views/include/top.jsp" />
	<div class='container-fluid embed-container' id="topMenu">
		<iframe  title="YouTube video player" class="youtube-player" type="text/html"  width="560" height="315" src="//www.youtube.com/embed/-01Lmk0RKDI"></iframe>
	</div>

	<div class="chat">
		<div class="col-md-offset-10 col-md-2" id="chat">
			<c:if test="${ userId == null }">
				<img alt="d" src="/images/채팅.png"><a href="javascript:loginPopup()" class="chat-button" data-toggle="tooltip" data-placement="top" title="로그인 후 이용가능합니다." role="button">자유채팅</a>
			</c:if>
			<c:if test="${ userId != null }">
				<img alt="d" src="/images/채팅.png"><a href="javascript:popup()" class="chat-button" role="button">자유채팅</a>
			</c:if>
		</div>
	</div>

	<div class="container">
		<div class="now-movie">
			<div class="col-md-9">
				<h4>현재상영작</h4>
			</div>
			<div class="col-md-3" id="plus">
				<a href="/movie/moviePresent">더 많은 영화보기<img alt="d" src="/images/플러스.png"></a>
			</div>
		</div>
	</div>
	<div class="container"
		style="background-color: ghostwhite; margin-bottom: 120px;">
		<div class="movies">
			<div id="carousel-example-generic" class="carousel slide">
				<!-- Carousel items -->
				<div class="carousel-inner">
					<div class="item active">
						<div class="row">
							<c:forEach begin="0" end="3" items="${ currentMovieList }" var="movie">
								<div class="col-md-3 col-sm-6">
									<img src="/upload2/upposter/${movie.movieId}.jpg" alt="First slide" class="img-responsive center-block">
									<div class="caption">
										<h3>${movie.movieName}</h3>
										<p>
											<c:if test="${ userId == null }">
												<a href="/member/login" class="btn btn-primary"
													data-toggle="tooltip" data-placement="top"
													title="로그인 후 이용가능합니다." role="button">예매</a>
											</c:if>
											<c:if test="${ userId != null }">
												<a href="/reservation/?movieId=${movie.movieId }" class="btn btn-primary" role="button">예매</a>
											</c:if>
										</p>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
					<div class="item">
						<div class="row">
							<c:forEach begin="4" end="7" items="${ currentMovieList }" var="movie">
								<div class="col-md-3 col-sm-6">
									<img src="/upload2/upposter/${movie.movieId}.jpg" alt="Second slide" class="img-responsive center-block">
									<div class="caption">
										<h3>${movie.movieName}</h3>
										<p>
											<c:if test="${ userId == null }">
												<a href="/member/login" class="btn btn-primary"
													data-toggle="tooltip" data-placement="top"
													title="로그인 후 이용가능합니다." role="button">예매</a>
											</c:if>
											<c:if test="${ userId != null }">
												<a href="/reservation/" class="btn btn-primary" role="button">예매</a>
											</c:if>
										</p>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
				<!-- Controls -->
				<a class="left carousel-control" href="#carousel-example-generic"
					data-slide="prev"> <!-- <span class="icon-prev"></span> --> <img
					src="/images/왼쪽.png" class="control">
				</a> <a class="right carousel-control" href="#carousel-example-generic"
					data-slide="next"> <!--  <span class="icon-next"></span> --> <img
					src="/images/오른쪽.png" class="control">
				</a>
			</div>
		</div>
	</div>


	<div class="hot">
		<div class="container">
			<h4>HOT!한 개봉</h4>
		</div>
	</div>

	<div class="hot-movie">
		<div class="row">
			<div class="col-sm-offset-3 col-sm-3">
				<div id="myCarousel" class="carousel slide">
					<!-- Carousel items -->
					<div class="carousel-inner">
						<c:forEach begin="0" end="0" var="movie" items="${currentMovieList}">
							<div class="item active">
								<img src="/upload2/upposter/${ movie.movieId }.jpg" alt="${ movie.movieId }" class="img-responsive center-block">
							</div>
						</c:forEach>
						<c:forEach begin="1" end="4" var="movie" items="${currentMovieList}">
							<div class="item">
								<img src="/upload2/upposter/${ movie.movieId }.jpg" alt="${ movie.movieId }" class="img-responsive center-block">
							</div>
						</c:forEach>
					</div>
					<!-- Controls buttons -->
					<div class="img-responsive center-block" id="sllidee" align="center">
						<c:forEach begin="0" end="4" var="movie" items="${currentMovieList}" varStatus="vs">
							<c:if test="${vs.index eq 0 }">
								<input type="button" class="btn slide-one" value="1">
							</c:if>
							<c:if test="${vs.index eq 1 }">
								<input type="button" class="btn slide-two" value="2">
							</c:if>
							<c:if test="${vs.index eq 2 }">
								<input type="button" class="btn slide-three" value="3">
							</c:if>
							<c:if test="${vs.index eq 3 }">
								<input type="button" class="btn slide-four" value="4">
							</c:if>
							<c:if test="${vs.index eq 4 }">
								<input type="button" class="btn slide-five" value="5">
							</c:if>
						</c:forEach>
					</div>
				</div>
			</div>
			<div class="col-xs-offset-1 col-xs-5 col-sm-offset-1 col-sm-5">
				<div class="hot5">
					<div class="back">
						<h2>
							<img alt="d" src="/images/팝콘.png" id="pop">HOT한!!! 영화의 최신 평점
						</h2>
					</div>
					<c:forEach begin="0" end="4" items="${currentMovieList}" var="movie">
						<c:if test="${movie.avgStar ne '0.0'}">
							<p>${movie.movieName}&nbsp;<img alt="d" src="/images/화살표.png" id="right-arrow">&nbsp;
								<fmt:formatNumber value="${ movie.avgStar }" pattern=".00"/>
							</p>
						</c:if>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
	<div class="tab-content">
		<div class="container">
			<div class="hot2" id="c">
				<h4>이달의 기대작</h4>
			</div>
		</div>
		<div class="container-fluid">
			<div class="hot2-movie">
				<div class="col-md-12" id="hot3">
					<p>기대되는 영화 순위</p>
				</div>
				<div class="col-md-12">
					<div class="hot3" id="myTab">
						<a href="#1" class="btn btn-tap" data-toggle="tab">1</a> 
						<a href="#2" class="btn btn-tap" data-toggle="tab">2</a> 
						<a href="#3" class="btn btn-tap" data-toggle="tab">3</a> 
						<a href="#4" class="btn btn-tap" data-toggle="tab">4</a> 
						<a href="#5" class="btn btn-tap" data-toggle="tab">5</a>
					</div>
					<div class="tab-content" id="john">
						<c:forEach var="movie" items="${ movieListLimitFive }" varStatus="status">
							<div class="tab-pane" id="${ status.index + 1}">
								<div class="col-md-12" style="padding-top: 24px;">
									<div class="col-md-offset-3 col-md-3">
										<div class="snip1283">
											<img src="/upload2/upposter/${movie.movieId}.jpg" alt="포스터" class="img-responsive center-block">
											<figure>
												<figcaption>
													<h3>${ movie.movieName }</h3>
													<p>${ movie.information }</p>
												</figcaption>
											</figure>
										</div>
									</div>
	
									<div class="col-md-offset-1 col-md-5" style="padding-top: 40px;">
										<div class="hot4">
											<p>${ movie.movieName }</p>
										</div>
										<div class="col-md-12" id="like2">
	
											<p>감독:&nbsp${ movie.director }</p>
											<p>배우:&nbsp${ movie.cast }</p>
											<p>장르:&nbsp${ movie.genre}&nbsp/&nbsp기본:&nbsp${movie.grade}이상,&nbsp${ movie.runtime }</p>
											<div>
												<c:if test="${ userId == null }">
													<button class="likeBtn2" name="likeBtn" id="ddd" onclick="needLogin()">
														<img alt="d" src="/images/빈하트.png"> <span>${ movie.likeCnt }</span>
													</button>
												</c:if>
												<c:if test="${ userId != null }">
													<c:if test="true">
														<input type="hidden" value="${ movie.movieId }">
														<button class="likeBtn" name="${ movie.movieName }" id="${ movie.movieId }">
															<c:if test="${ movie.likeCheck == 1 }">
																<img alt="d" src="/images/찬하트.png" class="img1">
															</c:if>
															<c:if test="${ movie.likeCheck == 0 }">
																<img alt="d" src="/images/빈하트.png" class="img1">
															</c:if>
															<span id="span">${ movie.likeCnt }</span>
														</button>
													</c:if>
												</c:if>
											</div>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			<div class="top">
				<div class="col-md-offset-11 col-md-1" style="text-align: end;">
				<a href="#topMenu"><img src="/images/위로.png" title="위로가기"></a>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	
	<script>
		$('.carousel').carousel()

		$('#myTab a:first').tab('show')
	</script>
	<script>
		// Cycles the carousel to a particular frame 
		$(".slide-one").click(function() {
			$("#myCarousel").carousel(0);
		});
		$(".slide-two").click(function() {
			$("#myCarousel").carousel(1);
		});
		$(".slide-three").click(function() {
			$("#myCarousel").carousel(2);
		});
		$(".slide-four").click(function() {
			$("#myCarousel").carousel(3);
		});
		$(".slide-five").click(function() {
			$("#myCarousel").carousel(4);
		});
	</script>
	<script>
		var userId = '${ userId }';
		var likeBtn = $('button.likeBtn');
		var check = '${ check }';

		function needLogin() {
			alert('해당 기능은 로그인 후에 이용하실수 있습니다.');
		}
	
		$('button.likeBtn').on('click', function () {
			var movieId = $(this).parent().find($('input')).val();
			var button = $(this);
			var span = $(this).html();
			var str = '';
			var btn = $(this);
			
			$.ajax({
				url: '/likeCheck',
				method: 'GET',
				data: {movieId : movieId},
				success: function (map) {
					btn.empty();
					
					if (map.check == 1) {
						str += '<img alt="d" src="/images/빈하트.png" class="img1">'
						str += ' <span>' + map.likeCnt + '</span>'
						button.html(str);
					} else {
						str += '<img alt="d" src="/images/찬하트.png" class="img1">'
						str += ' <span>' + map.likeCnt + '</span>'
						button.html(str);
					}
				}
			});
		});
	</script>
	 <script>
        function popup(){
            var url = '/chat/chat';
            var name = "popup test";
            var option = "width = 510, height = 770, top = 100, left = 900"
            window.open(url, name, option);
        }

        function loginPopup() {
			alert('해당 기능은 로그인 후에 이용하실수 있습니다.');
			location.href="member/login";
		}
    </script>
	
</body>
</html>





