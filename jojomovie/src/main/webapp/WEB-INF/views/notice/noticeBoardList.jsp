<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<style>
button {
	background-color: #ffb8b8;
	border-radius: 5px;
}
</style>

</head>

<body>

<jsp:include page="/WEB-INF/views/include/top.jsp" />

	<div class="container"
		style="margin-top: 40px;">
		<h3 class="text-center">전체 글 목록</h3>
		<h5>총 글 수 : ${pageDto.totalCount } </h5>

		<table class="table text-center" >
			<thead>
				<tr>
					<th class="text-center">알림</th>
					<th class="text-center">번호</th>
					<th class="text-center">제목</th>
					<th class="text-center">작성자</th>
					<th class="text-center">작성일</th>
					<th class="text-center">조회수</th>
				</tr>
			</thead>
			<c:choose>
				<c:when test="${pageDto.totalCount gt 0 }">
					<c:forEach var="noticeList" items="${noticeList}">
						<tbody>
							<tr>
								<td>
									<c:choose>
										<c:when test="${noticeList.category eq 'categoryEvent'}">
											이벤트
										</c:when>
										<c:otherwise>
											공지사항
										</c:otherwise>
									</c:choose>
								</td>
								
								<td>${noticeList.num }</td>
								<!--따로 반복문 돌려서 숫자 정렬  -->
								<td><a href="/notice/noticeBoardView?num=${noticeList.num }&pageNum=${ pageNum }">${noticeList.subject }</a></td>
								<td>${noticeList.adminId }</td>
								<td><javatime:format value="${ noticeList.regDate }" pattern="yyyy.MM.dd"/></td>
								<td>${noticeList.readcount }</td>
							</tr>
							<tr>
						</tbody>
					</c:forEach>
		    	</c:when>
					<c:otherwise>
						<tr>
							<td colspan="6"><div align="center" ><h1 ><img src="/images/검색없음.png"  ><br><br>조회된 정보가 없습니다.<br></h1></div></td>
						</tr>
					</c:otherwise>
			</c:choose>
		</table>
		
		<c:choose>
			<c:when test="${not empty sessionScope.userId && sessionScope.grade eq '관리자'}"> 
				<button type="button" onclick="location.href='/notice/noticeFormWrite?adminId=admin'">글쓰기</button>
			</c:when>	
			<c:otherwise>
			</c:otherwise>
		</c:choose>



		<!-- 검색 -->
		<form action="/notice/noticeBoardList" method="get">
			<div class="row">
				<div class="col-sm-3" style="margin: 10px;"></div>
				<div class="col-sm-6 text-center" style="margin: 10px;">
					<select name="category">
						<option value="categoryEvent" ${ pageDto.category eq 'categoryEvent' ? 'selected' : '' }>이벤트 / 소식</option>
						<option value="categoryNotice"${ pageDto.category eq 'categoryNotice' ? 'selected' : '' }>공지</option>
					</select> <input type="text" name="search" placeholder="검색어를 입력해주세요">
					<button type="submit" style="margin-left: 5px; height: 50px;">검색</button>
				</div>
				<div class="col-sm-3" style="margin: 10px;"></div>
			</div>
		</form>


		<!-- page -->
		<div class="text-center">
			<c:if test="${pageDto.totalCount gt 0 }">
				<ul class="pagination">
					<!--이전  -->
					<c:if test="${ pageDto.startPage gt pageDto.pageBlock }">
						<li><a
							href="/admin/searchMovie?pageNum=${ pageDto.startPage - pageDto.pageBlock }&category=${ pageDto.category }&search=${ pageDto.search }"><span
								class="glyphicon glyphicon-chevron-left"></span></a></li>
					</c:if>
					<%-- 페이지블록 내에서의 시작페이지부터 끝페이지까지 번호출력 --%>
					<c:forEach var="i" begin="${ pageDto.startPage }"
						end="${ pageDto.endPage }" step="1">
						<li><a
							href="/notice/noticeBoardList?pageNum=${ i }&category=${ pageDto.category }&search=${ pageDto.search }">
								<c:choose>
									<c:when test="${ i eq pageNum }">
										<span style="font-weight: bold; color: red;">${ i }</span>
									</c:when>
									<c:otherwise>
									${ i }
					</c:otherwise>
								</c:choose>
						</a></li>
					</c:forEach>
					<%-- [다음] --%>
					<c:if test="${ pageDto.endPage < pageDto.pageCount }">
						<li><a
							href="/notice/noticeBoardList?pageNum=${ pageDto.startPage + pageDto.pageBlock }&category=${ pageDto.category }&search=${ pageDto.search }"><span
								class="glyphicon glyphicon-chevron-right"></span></a></li>
					</c:if>
				</ul>
			</c:if>
		</div>
	</div>
		
	<%-- footer영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script type="text/javascript" src="/script/jquery-3.5.1.js"></script>
	<script type="text/javascript" src="/script/bootstrap.js"></script>
	<script type="text/javascript"></script>
</body>
</html>