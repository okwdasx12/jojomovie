<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="javatime" uri="http://sargue.net/jsptags/time"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1 user-scalable=no">
<title>조조무비 - 1:1문의</title>
<style>
</style>
</head>
<body>
	<%-- top 영역  --%>
	<jsp:include page="/WEB-INF/views/include/top.jsp" />

	<div class="container" id="con">
		<div class="col-md-5" id="iq" style="text-align: start;">
			<img alt="" src="/images/일대일문의.png"><a>1:1 문의</a>
		</div>
		<div class="form-group table-responsive">
			<table class="table">
				<thead>
					<tr>
						<th>작성한 문의</th>
						<th>진행 중인 문의</th>
						<th>진행 완료 문의</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>${ pageDto.total }</td>
						<td>${ pageDto.ing }</td>
						<td>${ pageDto.fin }</td>
					</tr>
				</tbody>
			</table>
		</div>

		<br> <br>
		<div class="col-md-12" id="quire-btn">
			<input type="button" value="문의 작성하기" class="btn-w" 
				onclick="location.href='/inquire/write?pageNum=${ pageNum }'">
		</div>
		<div class="tab-pane" id="inquireTable">
			<div class="form-group table-responsive">
				<table class="table table-striped">
					<tr>
						<th scope="col" class="">문의 번호</th>
						<c:if test="${ grade eq '관리자' }">
							<th scope="col" class="">아이디</th>
						</c:if>
						<th scope="col" class="">문의 제목</th>
						<th scope="col" class="">작성 날짜</th>
					</tr>
					<c:choose>
						<c:when test="${ pageDto.totalCount gt 0 }">
							<c:forEach var="inquire" items="${ inquireList }">
								<tr id="trPointer"
									onclick="location.href='/inquire/content?num=${ inquire.num }&pageNum=${ pageNum }'">
									<td><c:if test="${ inquire.reLev eq 0 }">
											${ inquire.num }
										</c:if></td>
									<c:if test="${ grade eq '관리자' }">
										<c:if test="${ inquire.reLev eq 0 }">
											<td scope="col" class="">${ inquire.userId }</td>
										</c:if>
										<c:if test="${ inquire.reLev ne 0 }">
											<td scope="col" class=""></td>
										</c:if>
									</c:if>
									<td><c:if test="${ inquire.reLev gt 0 }">
											<img src="/images/board/level.gif"
												width="${ inquire.reLev * 10 }" height="13px">
											<img src="/images/board/re.gif" height="13px">
										</c:if> ${ inquire.subject }</td>
									<td><javatime:format value="${ inquire.regDate }"
											pattern="yyyy.MM.dd HH:mm" /></td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="4"><div align="center" ><h1 ><img src="/images/검색없음.png"  ><br><br>조회된 문의 정보가 없습니다.<br></h1></div></td>
							</tr>
						</c:otherwise>
					</c:choose>
				</table>

				<div class="page_control" align="center">
					<c:if test="${ pageDto.total gt 0 }">
						<!-- [이전 10페이지] -->
						<c:if test="${ pageDto.startPage gt pageDto.pageBlock }">
							<a
								href="/inquire/?pageNum=${ pageDto.startPage - pageDto.pageBlock }&category=${ pageDto.category }&search=${ pageDto.search }">[이전]</a>
						</c:if>
						<!-- 페이지 1 ~ 끝 페이지 -->
						<c:forEach var="i" begin="${ pageDto.startPage }"
							end="${ pageDto.endPage }" step="1">
							<a
								href="/inquire/?pageNum=${ i }&category=${pageDto.category}&search=${pageDto.search}">
								<c:choose>
									<c:when test="${ i eq pageNum }">
										<span style="font-weight: bold; color: red;">[${ i }]</span>
									</c:when>
									<c:otherwise>
									[${ i }]
								</c:otherwise>
								</c:choose>
							</a>
						</c:forEach>
						<!-- [다음 10페이지] -->
						<c:if test="${ pageDto.endPage lt pageDto.pageCount }">
							<a
								href="/inquire/?pageNum=${ pageDto.endPage + pageDto.pageBlock }&category=${ pageDto.category }&search=${ pageDto.search }">[다음]</a>
						</c:if>
					</c:if>
				</div>

				<br> <br>

				<div class="table_search" id="ts">
					<form action="/inquire/" method="get">
						<div class="col-md-12"
							style="text-align: center; margin-top: 96px;">
							<select name="category" class="form-a">
								<option value="subject"
									${ pageDto.category eq 'subject' ? 'selected' : ''}>문의
									제목</option>
								<option value="content"
									${ pageDto.category eq 'content' ? 'selected' : ''}>문의
									내용</option>
								<option value="regDate"
									${ pageDto.category eq 'regDate' ? 'selected' : ''}>문의
									작성일</option>
								<c:if test="${ grade eq '관리자' }">
									<option value="userId"
										${ pageDto.category eq 'userId' ? 'selected' : ''}>문의
										작성자</option>
								</c:if>
							</select> <input type="text" name="search" value="${ pageDto.search }"
								class="form-b"> <input type="submit" value="검색"
								class="btn-c">
						</div>
					</form>
					<br>
				</div>
				<br> <br>
			</div>
		</div>
	</div>

	<%-- footer 영역  --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />


</body>
</html>