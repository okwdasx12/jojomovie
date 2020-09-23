<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="javatime" uri="http://sargue.net/jsptags/time"%>
<!DOCTYPE html>
<html>
<head>
<title> 상영예정작 </title>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700&family=Black+Han+Sans&family=Do+Hyeon&family=Noto+Sans+KR:wght@300;500&display=swap" rel="stylesheet">
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
	
		<h3 class="title"> 상영 예정작 [ 상영예정작 수 : ${moviePageDto.totalCount}] </h3>
		
		<div class="searchTop">	
			<div class="frm1">
				<form action="/movie/comingMovie" method="get">
					<button class="categoryBtn" type="submit" name="category" value="date">개봉일순</button>
					<button class="categoryBtn" type="submit" name="category" value="like">좋아요순</button>
					<button class="categoryBtn" type="submit" name="category" value="score">평점순</button>
				</form>
			</div>
			<div class="frm2">
				<form action="/movie/comingMovie" method="get">
					<select name="category" class="category">
						<option value="movieName" ${ moviepageDto.category eq 'movieName' ? 'selected' : '' }>영화제목</option>
					</select>
					 <input type="text" name="search" value="${ moviepageDto.search }"	class="input_box">
					 <input type="submit" value="검색" class="searchbtn">
				</form>
			</div>
		</div> <!-- aaa -->
	
		<div class="row product">
			<c:choose>
				<c:when test="${ moviePageDto.totalCount gt 0 }">
					<c:forEach var="movie" items="${movieList }">
						<div class="col-sm-4">
							<div class="thumbnail thumbnailBox">
								<img src="/upload2/upposter/${movie.movieId}.jpg">
								<div class="caption">
									<span class="movieName">${movie.movieName}</span>
									<div class="thumbnailBtns">
										<a href="/movie/movieInfo?movieId=${ movie.movieId }" class="thumbnailBtn">자세히 보기</a>
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
		</div>

		<div id="page_control">
			<c:if test="${ moviePageDto.totalCount gt 0 }">
				<%-- [이전] --%>
				<c:if test="${ moviePageDto.startPage gt moviePageDto.pageBlock }">
					<a href="/movie/comingMovie?pageNum=${ moviePageDto.startPage - moviePageDto.pageBlock }&category=${ pageDto.category }">[이전]</a>
				</c:if>
			
				<%-- 페이지블록 내에서의 시작페이지부터 끝페이지까지 번호출력 --%>
				<c:forEach var="i" begin="${ moviePageDto.startPage }" end="${ moviePageDto.endPage }" step="1">
					<a href="/movie/comingMovie?pageNum=${ i }&category=${ moviePageDto.category }">
						<c:choose>
							<c:when test="${ i eq pageNum }">
								<span style="font-weight: bold; color: #3fa194;">[${ i }]</span>
							</c:when>
							<c:otherwise>
								<span style="color:#a1c2ad;">[${ i }]</span>
							</c:otherwise>
						</c:choose>
					</a>
				</c:forEach>
				<%-- [다음] --%>
				<c:if test="${ moviePageDto.endPage lt moviePageDto.pageCount }">
					<a href="/movie/comingMovie?pageNum=${ moviePageDto.startPage + moviePageDto.pageBlock }&category=${ pageDto.category }">[다음]</a>
				</c:if>
			</c:if>
		</div>
	</div> <!-- container -->

	<%-- footer영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script type="text/javascript" src="/script/jquery-3.5.1.js"></script>
	<script type="text/javascript" src="/script/bootstrap.js"></script>

</body>
</html>
