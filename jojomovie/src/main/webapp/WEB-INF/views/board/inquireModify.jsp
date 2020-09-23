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
		<div class="col-sm-offset-1 col-sm-10" align="center">
			<form action="/inquire/modify" method="post" class="form-horizontal" name="inquireFrm">
				<input type="hidden" name="num" value="${ inquireVo.num }">
				<div class="form-group">
					<label for="userId" class="col-xs-4 col-sm-3 control-label">문의 작성자</label>
					<div class="col-xs-8 col-sm-7">
						<input type="text" id="userId" class="form-control" name="userId" readonly value="${ sessionScope.userId }">
					</div>
				</div>
				<div class="form-group">
					<label for="subject" class="col-xs-4 col-sm-3 control-label">문의 제목</label>
					<div class="col-xs-8 col-sm-7">
						<input type="text" id="sub" class="form-control" name="subject" value="${ inquireVo.subject }">
					</div>
				</div>
				<div class="form-group">
					<label for="content" class="col-xs-4 col-sm-3 control-label">문의 내용</label>
					<div class="col-xs-8 col-sm-7">
						<textarea id="content" class="form-control" name="content" rows="13" cols="40">${ inquireVo.content }</textarea>
					</div>
				</div>
				<br>
				<div id="inquireModifyBtns" align="right">
					<button type="submit" class="btn">수정하기</button>
					<button type="reset" class="btn">다시쓰기</button>
					<button type="button" class="btn" onclick="location.href='/inquire/content?num=${ inquireVo.num }&pageNum=${ pageNum }'">목록보기</button>
				</div>
			</form>
		</div>
	</div>
	<br>
	
	<%-- footer 영역  --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	
</body>
</html>