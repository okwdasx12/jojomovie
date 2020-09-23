<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
@media screen and (max-width: 767px) {
	.row.content {
		height: auto;
	}
	
	image {
		width: 50%; 
		height: 80%; 
	}
	
}

	button#del-btn {
    margin: 0;
    padding: 2px;
    background-color: aliceblue;
    margin-left: 53px;
    font-family: 'Nanum Gothic', sans-serif;
    font-weight: bolder;
}
    button#modi-btn{
    margin: 0;
    padding: 2px;
    background-color: aliceblue;
    margin-left: 53px;
    font-family: 'Nanum Gothic', sans-serif;
    font-weight: bolder;
    }

</style>
</head>

<body>
	<%-- top 영역  --%>
	<jsp:include page="/WEB-INF/views/include/adminTop.jsp" />
	<div class="col-md-12" id="mmm2">
		<p>영화 검색</p>
	</div>
	<h4 class="text-center" id="hh4">전체 글 수 :
		${requestScope.pageDto.totalCount}</h4>
	<!-- 검색 -->
	<form action="/admin/searchMovie" method="get">
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-sm-6 text-center" style="margin-bottom: 40px;">
				<select name="category" style="height: 32px;">
					<option value="movieName" ${ pageDto.category eq 'movieName' ? 'selected' : '' }>영화명</option>
					<option value="director" ${ pageDto.category eq 'director' ? 'selected' : '' }>감독명</option>
					<option value="grade" ${ pageDto.category eq 'grade' ? 'selected' : '' }>등급</option>
					<option value="gerne" ${ pageDto.category eq 'gerne' ? 'selected' : '' }>장르</option>
				</select> 
					<input type="text" name="search" style="height: 32px;" value="${ pageDto.search }" placeholder="검색어를 입력해주세요">
				<button type="submit" style="height: 32px;">검색</button>
			</div>
			<div class="col-sm-3" style="margin: 10px;"></div>
		</div>
	</form>

	<div class="container">
		<c:choose>
			<c:when test="${pageDto.totalCount gt 0 }">
				<c:forEach var="movie" items="${movieList}">
					<img alt="${movie.movieName}" src="/upload2/upposter/${movie.movieId}.jpg" class="col-sm-3 text-center" style="margin-bottom: 10px;">
					<div class="container-fluid">
						<div class="col-sm-9">
							<h2>${movie.movieName }</h2>
							<h5>
								<span class="glyphicon glyphicon-user"></span> ${movie.director }
							</h5>
							<h5>
								<span class="label label-danger">
									<c:choose>
										<c:when test="${movie.grade == 1}">
											전체관람가
										</c:when>
										<c:otherwise>
											${movie.grade }세 관람가
										</c:otherwise>
									</c:choose>
								</span> 
									<span class="label label-primary"> ${movie.cast }</span>
							</h5>
							<br>
							<h5><span class="glyphicon glyphicon-barcode"></span>장르  ${movie.genre }</h5>
							<h5><span class="glyphicon glyphicon-time"></span>런타임  ${movie.runtime }</h5>
							<h5><span class="glyphicon glyphicon-comment"></span>평점  ${movie.score }</h5>
							<h5><span class="glyphicon glyphicon-thumbs-up"></span>좋아요 ${movie.likeCnt }</h5>
							<h5><span class="glyphicon glyphicon-time"></span>상영일 ${movie.startDate }</h5>
							<h5><span class="glyphicon glyphicon-time"></span>종료일  ${movie.endDate }</h5>

							<p><Strong>${movie.information }</Strong></p>
							<br> <br>
							<h4>
								<small>
								 <c:set var="relMovie" value="${movie.relMovie }" />
									<c:choose>
										<c:when test="${relMovie == '상영예정'}">
											<th class="text-center" style="width: 100px;" colspan="2">
												<img alt="상영예정" src="/images/상영예정.png" style="max-width: 80px; max-height: 25px; vertical-align: bottom;">
											</th>
										</c:when>
										<c:when test="${relMovie == '상영종료'}">
											<th class="text-center" style="width: 100px;" colspan="2">
												<img alt="상영종료" src="/images/상영종료.png" style="max-width: 80px; max-height: 25px; vertical-align: bottom;">
											</th>
										</c:when>
										<c:when test="${relMovie == '상영중'}">
											<th class="text-center" style="width: 100px;" colspan="2">
												<img alt="상영중" src="/images/상영중.png"style="max-width: 80px; max-height: 25px; vertical-align: bottom;">
											</th>
										</c:when>
										<c:when test="${relMovie == '상영임박'}">
											<th class="text-center" style="width: 100px;" colspan="2">
												<img alt="상영임박" src="/images/상영임박.png"style="max-width: 80px; max-height: 25px; vertical-align: bottom;">
											</th>
										</c:when>
										<c:otherwise>
											<th class="text-center" style="width: 100px;" colspan="2">
												<img alt="데이터없음" src="/images/데이터 없음.png"style="max-width: 80px; max-height: 25px; vertical-align: bottom;">
											</th>
										</c:otherwise>
									</c:choose>
								</small>
								<button data-toggle="modal" data-title="data" class="deleteBtn" id="del-btn" data-target="#checkPasswd"  data-id="${movie.movieId }">삭제</button>
								<button type="submit" class="text-center" id="modi-btn" onclick="location.href='/admin/ModifyMovie?movieId=${movie.movieId }&pageNum=${ pageNum }'"> 수정하기</button>
							</h4>
							<hr>
						</div>
					</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td colspan="5">영화 없음</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</div>
	
	
	 <!-- page -->
    <div class="text-center">
	   	<c:if test="${pageDto.totalCount gt 0 }">
	    	<ul class="pagination">
		    	<!--이전  -->
	    		<c:if test="${ pageDto.startPage gt pageDto.pageBlock }">
					<li><a href="/admin/searchMovie?pageNum=${ pageDto.startPage - pageDto.pageBlock }&category=${ pageDto.category }&search=${ pageDto.search }"><span class="glyphicon glyphicon-chevron-left"></span></a></li>
				</c:if>
		    	<%-- 페이지블록 내에서의 시작페이지부터 끝페이지까지 번호출력 --%>
				<c:forEach var="i" begin="${ pageDto.startPage }" end="${ pageDto.endPage }" step="1">
				<li>
					<a href="/admin/searchMovie?pageNum=${ i }&category=${ pageDto.category }&search=${ pageDto.search }">
					<c:choose>
						<c:when test="${ i eq pageNum }">
							<span style="font-weight: bold; color: red;">${ i }</span>
						</c:when>
						<c:otherwise>
							${ i }
						</c:otherwise>
					</c:choose>
					</a>
				</li>
				</c:forEach>
				<%-- [다음] --%>
				<c:if test="${ pageDto.endPage < pageDto.pageCount }">
					<li>
						<a href="/admin/searchMovie?pageNum=${ pageDto.startPage + pageDto.pageBlock }&category=${ pageDto.category }&search=${ pageDto.search }"><span class="glyphicon glyphicon-chevron-right"></span></a>	
					</li>
				</c:if>
			</ul>
		</c:if>
	</div>
	
	
	<!-- 모달창 -->
   
   <div class="modal fade" id="checkPasswd" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="movieCheck">실수 방지를 위해 아래의 숫자를 따라적어주세요.</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form action="/admin/DeleteMovie"   name="checkD"   method="get">
					<div class="modal-body">
						<input type="text" readonly  id="movieId" name="movieId" value=""  style="border: none; text-align: center;" > 를 따라 적어주세요
					</div>
					<div class="modal-body2">
						<input type="text" name="movieIdCheck" id="checkWrite" style="margin-left: 14px;">
					</div>					
					<div class="modal-footer">
					<button type="button" onclick="deleteMovie()" class="btn btn-primary " id="deleteMBNT">삭제</button>
					<button type="button" class="btn btn-secondary" id="closeMBNT" data-dismiss="modal">닫기</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script type="text/javascript" src="/script/jquery-3.5.1.js"></script>
	<script type="text/javascript" src="/script/bootstrap.js"></script>
	<script type="text/javascript"></script>
	
	<script>
	$(document).on("click", ".deleteBtn", function () {
		var listMovieId = $(this).data('id');
		$(".modal-body #movieId").val(listMovieId);
		});
		
		function deleteMovie(){
		var writeCheck = $('#checkWrite').val();
		var orign = $('#movieId').val();

		if(writeCheck != null && writeCheck != ''){
			var checkDC = confirm("정말로~ 정말로! 삭제하겠습니까????");
			if(checkDC == true && writeCheck == orign){
					checkD.submit();
					alert("삭제완료");
				}else{
					alert("값이 없거나 일치하지 않습니다.");
				}
			}
		}
		
		$('#closeMBNT').on("click", function(){
			alert("취소 완료");
		});
	</script>
</body>
</html>
