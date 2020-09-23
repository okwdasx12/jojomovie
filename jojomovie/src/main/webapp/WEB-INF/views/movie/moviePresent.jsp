<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="javatime" uri="http://sargue.net/jsptags/time"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1 user-scalable=no">
<title>MoviePresentPage</title>
<link href="/css/main.css" rel="stylesheet">
<link href="/css/bootstrap.css" rel="stylesheet">
<link href="/css/front.css" rel="stylesheet" type="text/css" media="all">
<link href="/css/print.css" rel="stylesheet" type="text/css" media="print">
<link href="/css/iphone.css" rel="stylesheet" type="text/css" media="screen">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700&family=Black+Han+Sans&family=Do+Hyeon&family=Noto+Sans+KR:wght@300;500&display=swap" rel="stylesheet">
<script type="text/javascript" src="/script/jquery-1.6.1.min.js"></script>
<script type="text/javascript" src="/script/s3Slider.js"></script>

<style>

.title {
	text-align: center;
    font-family: 'Do Hyeon', sans-serif;
    padding-bottom: 20px;
    font-size: 30px;
    font-weight: bold;
}

.categoryBtn {
  -webkit-border-radius: 5;
  -moz-border-radius: 5;
  border-radius: 5px;
  color: #ffffff;
  font-size: 16px;
  background: #b4d9c1;
  padding: 5px 10px 5px 10px;
  text-decoration: none;
  border: solid #ffffff 0px;
  font-family: 'Nanum Gothic', sans-serif;
  font-weight: 400;
}

.categoryBtn:hover {
  background: #84a891;
  text-decoration: none;
}

.searchTop {
	padding: 5px 35px 15px 30px;
}

.frm2 {
	text-align: end;
}

.searchbtn {
  -webkit-border-radius: 5;
  -moz-border-radius: 5;
  border-radius: 5px;
  font-family: Arial;
  color: #3fa194;
  font-size: 15px;
  background: #ffffff;
  padding: 5px 10px 5px 10px;
  border: solid #158a78 1px;
  text-decoration: none;
}

.searchbtn:hover {
  background: #c9f0e9;
  text-decoration: none;
}

.input_box {
	height: 33px;
	border: 1px solid #158a78;
	border-radius: 5px;
}
.category {
	height: 33px;
	border: 1px solid #158a78;
	font-family: Arial;
    color: #3fa194;
    border-radius: 5px;
}

div.thumbnailBox {
    border: none;
    box-shadow: none;
}

.caption {
	text-align: center;
}

.movieName {
	font-family: 'Noto Sans KR', sans-serif;
    font-size: 20px;
    font-weight: 500;
}

.caption > ul {
	list-style : none;
}

.thumbnailBtns {
	padding-top: 10px;
}

#page_control {
	text-align: center;
	padding-bottom: 100px;
	font-size: 18px;
	text-decoration: none;
}

a:link, a:visited, a:hover {
	text-decoration: none !important
}

.thumbnailBtn {
  -webkit-border-radius: 5;
  -moz-border-radius: 5;
  border-radius: 5px;
  font-family: Arial;
  color: #3fa194;
  font-size: 15px;
  background: #ffffff;
  padding: 5px 10px 5px 10px;
  border: solid #3fa194 2px;
  text-decoration: none;
}

.thumbnailBtn:hover {
  background: #b4d9c1;
  text-decoration: none;
  cursor: pointer;
  color: #3fa194;
}


</style>

</head>

<body>

	<%-- top 영역  --%>
	<jsp:include page="/WEB-INF/views/include/top.jsp" />
	
	<div class="container">

		<h3 class="title">영화 게시판 [ 전체영화수: ${ moviepageDto.totalCount } ]</h3>

		<div class="searchTop">
			<div class="frm1">
				<form action="/movie/moviePresent" method="get">
					<button class="categoryBtn" type="submit" name="category" value="like">좋아요순</button>
					<button class="categoryBtn" type="submit" name="category" value="avgStar">관람객평점순</button>
				</form>
			</div>
			<div class="frm2">
				<form action="/movie/moviePresent" method="get">
					<select name="category" class="category">
						<option value="movieName" ${ moviepageDto.category eq 'movieName' ? 'selected' : '' }>영화제목</option>
						<option value="genre" ${ moviepageDto.category eq 'genre' ? 'selected' : '' }>장르</option>
						<option value="cast" ${ moviepageDto.category eq 'cast' ? 'selected' : '' }>배우</option>
					</select>
					<input type="text" name="search" value="${ moviepageDto.search }" class="input_box">
					<input type="submit" value="검색" class="searchbtn">
				</form>
			</div>
		</div> <!-- aaa -->

		<div class="row product">
			<c:choose>
				<c:when test="${ moviepageDto.totalCount gt 0 }">
					<c:forEach var="aboutmovie" items="${movieList }">
						<div class="col-sm-4">
							<div class="thumbnail thumbnailBox">
								<img src="/upload2/upposter/${aboutmovie.movieId}.jpg">
								<div class="caption">
									<span class="movieName">${aboutmovie.movieName}</span>
									<div class="thumbnailBtns">
										<a href="/movie/movieInfo?movieId=${ aboutmovie.movieId }" class="thumbnailBtn">자세히 보기</a>
										<c:if test="${ aboutmovie.relMovie eq '상영중' or aboutmovie.relMovie eq '상영임박'}">
											<a href="/reservation/?movieId=${aboutmovie.movieId }" class="thumbnailBtn">예매하기</a>
										</c:if>
									</div>	
								</div>
							</div>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<div class="emptyMovie">
						<div align="center" ><h1 ><img src="/images/검색없음.png"  ><br><br>조회된 영화 정보가 없습니다.<br></h1></div>
					</div>
				</c:otherwise>
			</c:choose>
		</div> <!-- row product -->

		<div id="page_control">
			<c:if test="${ moviepageDto.totalCount gt 0 }">
				<%-- [이전] --%>
				<c:if test="${ moviepageDto.startPage gt moviepageDto.pageBlock }">
					<a href="/movie/moviePresent?pageNum=${ moviepageDto.startPage - moviepageDto.pageBlock }&category=${ moviepageDto.category }&search=${ moviepageDto.search }">[이전]</a>
				</c:if>

				<%-- 페이지블록 내에서의 시작페이지부터 끝페이지까지 번호출력 --%>
				<c:forEach var="i" begin="${ moviepageDto.startPage }" end="${ moviepageDto.endPage }" step="1">
				<a href="/movie/moviePresent?pageNum=${ i }&category=${ moviepageDto.category }&search=${ moviepageDto.search }">
					<c:choose>
						<c:when test="${ i eq pageNum }">
							<span style="font-weight: bold; color:#3fa194;">[${ i }]</span>
						</c:when>
						<c:otherwise>
							<span style="color:#a1c2ad;">[${ i }]</span>
						</c:otherwise>
					</c:choose>
				</a>
				</c:forEach>

				<%-- [다음] --%>
				<c:if test="${ moviepageDto.endPage lt moviepageDto.pageCount }">
					<a href="/movie/moviePresent?pageNum=${ moviepageDto.startPage + moviepageDto.pageBlock }&category=${ moviepageDto.category }&search=${ moviepageDto.search }">[다음]</a>
				</c:if>
			</c:if>
		</div> <!-- page -->
	</div> <!-- container -->


	<%-- footer영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

	<script src="/js/jquery-3.5.1.js"></script>
	<script src="/js/bootstrap.js"></script>
</body>
</html>
