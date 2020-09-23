<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="javatime" uri="http://sargue.net/jsptags/time" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1 user-scalable=no">
<title>조조무비 - 1:1문의</title>
<link href="/css/bootstrap.css" rel="stylesheet">
<link href="/css/bootstrap-theme.css" rel="stylesheet">
</head>
<body>
<%-- top 영역  --%>
<jsp:include page="/WEB-INF/views/include/top.jsp" />
	<div class="container">
		<div class="form-group table-responsive">
			<table class="table table-striped">
				<c:if test="${ inquireVo.reLev eq '0' }">
					<tr>
						<th scope="col">문의 번호</th>
						<td>${ inquireVo.num }</td>
					</tr>
					<tr>
						<th scope="col">문의 작성자</th>
						<td>${ inquireVo.userId }</td>
					</tr>
					<tr>
						<th scope="col">문의 작성일</th>
						<td><javatime:format value="${ inquireVo.regDate }" pattern="yyyy.MM.dd HH:mm"/></td>
					</tr>
					<tr>
						<th scope="col">문의 제목</th>
						<td>${ inquireVo.subject }</td>
					</tr>
					<tr>
						<th scope="col">문의 내용</th>
						<td>${ inquireVo.content }</td>
					</tr>
				</c:if>
				<c:if test="${ inquireVo.reLev eq '1' }">
					<tr>
						<th scope="col">답변 작성일</th>
						<td><javatime:format value="${ inquireVo.regDate }" pattern="yyyy.MM.dd HH:mm"/></td>
					</tr>
					<tr>
						<th scope="col">문의 제목</th>
						<td>${ inquireVo.subject }</td>
					</tr>
					<tr>
						<th scope="col">답변 내용</th>
						<td>${ inquireVo.content }</td>
					</tr>
				</c:if>
			</table>
			
			<div id="inquireContentBtns" align="right">
				<c:if test="${ inquireVo.reComp eq '0' }">
					<button type="button" class="btn" onclick="location.href='/inquire/modify?num=${ inquireVo.num }&pageNum=${ pageNum }'">문의 수정</button>
					<button type="button" class="btn" id="delBtn">문의 삭제</button>
				</c:if>
				<c:if test="${ grade eq '관리자' }">
					<c:if test="${ inquireVo.reComp eq '0' }">
						<button type="button" class="btn" onclick="location.href='/inquire/reply?num=${ inquireVo.num }&pageNum=${ pageNum }'">답변 쓰기</button>
					</c:if>
				</c:if>
				<button type="button" class="btn" onclick="location.href='/inquire/list?pageNum=${ pageNum }'">목록보기</button>
			</div>	
		</div>
	</div>
	
	<%-- footer 영역  --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	
	<script>
		$('button#delBtn').on('click', function () {
			var result = confirm('${ inquireVo.num }번 문의를 정말 삭제하시겠습니까?');
			if (result) {
				location.href = '/inquire/delete?num=${ inquireVo.num }';
			}
		});
	</script>
	
</body>
</html>