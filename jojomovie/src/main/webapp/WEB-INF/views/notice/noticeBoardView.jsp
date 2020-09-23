<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="javatime" uri="http://sargue.net/jsptags/time"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1 user-scalable=no">
<title>조조무비</title>

<link href="/css/bootstrap.css" rel="stylesheet">
<link href="/css/bootstrap-theme.css" rel="stylesheet">
<%-- top 영역  --%>
	<jsp:include page="/WEB-INF/views/include/top.jsp" />

<style>
	.row {
		font-weight: bold;
	}
	
	div#t1 {
		background-color: #ffffff;
		padding: 5px;
		text-align: center;
		border: solid 1px;
	}
	
	div#t1-scroll {
		background-color: #ffffff;
		padding: 5px;
		text-align: center;
		border: solid 1px;
		overflow: scroll;
	}
</style>

</head>

<body>
		<div class="container" style="padding: 0px;">
			<div class="jumbotron text-center" style="background-color: #ffffff;">
				<div class="text-center" style="margin: 20px;">
					<h2>
						<strong>공지사항</strong>
					</h2>
				</div>
				<div class="row">
					<div class="col-sm-1"></div>
					<div class="col-sm-2" id="t1">글 제목</div>
					<div class="col-sm-8" id="t1">${noticeVo.subject }</div>
				</div>
				<div class="row">
					<div class="col-sm-1"></div>
					<div class="col-sm-2" id="t1">작성일</div>
					<div class="col-sm-3" id="t1">
					  <javatime:format value="${ noticeVo.regDate }" pattern="yyyy.MM.dd" />
					</div>
					<div class="col-sm-2" id="t1">조회수</div>
					<div class="col-sm-3" id="t1">${noticeVo.readcount }</div>
				</div>
				<div class="row">
					<div class="col-sm-1"></div>
					<div class="col-sm-10" id="t1">글내용</div>
				</div>

				<div class="row">
					<div class="col-sm-1"></div>
					<div class="col-sm-10" id="t1-scroll"
						style="height: 800px; padding: 30px;">${noticeVo.content }
						<div class="row">
					<c:if test="${ not empty attachList }">
						<%-- ${ not empty boardVo.attachList } --%>
						<c:forEach var="attach" items="${ attachList }">

							<c:choose>
								<c:when test="${ attach.image eq 'I' }">

									<c:set var="beginIndex"
										value="${ fn:indexOf(attach.uploadpath, 'upload') }" />
									<c:set var="length" value="${ fn:length(attach.uploadpath) }" />
									<c:set var="path"
										value="${ fn:substring(attach.uploadpath, beginIndex, length) }" />

									<a href="/${ path }/${ attach.uuid }_${ attach.filename }">
										<img src="/${ path }/s_${ attach.uuid }_${ attach.filename }">
									</a>
									<br>
								</c:when>
								<c:otherwise>
									<a href="/notice/download?uuid=${ attach.uuid }"> ${ attach.filename }
									</a>
									<br>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:if>
				</div>
			</div>
		</div>
	</div>
		
		<c:choose>
				<c:when test="${not empty sessionScope.userId && sessionScope.grade eq '관리자'}"> 
				
					<div class="row">
						<div class="col-sm-4"></div>
						<div class="col-sm-4">
							<!-- 삭제하기  -->
							<button type="button" onclick="deleteCheck()" style="margin-top: 10px; background-color: #ffa550;" id="deleteBtn">
							<!--location.href='/notice/noticeDelete?num=${ noticeVo.num }&pageNum=${pageNum }  -->
								삭제하기
							</button>		
							<!--수정하기  -->
							<button style="margin-top: 10px; background-color: #ffa550;"
								onclick="location.href='/notice/noticeModify?num=${ noticeVo.num }&pageNum=${pageNum }'">
								수정하기
							</button>				
							<button style="margin-top: 10px; background-color: #ffa550;"
								onclick="location.href='/notice/noticeBoardList?pageNum=${pageNum}&num=${Nvo.num}'">목록으로</button>
						</div>
					</div>
				</c:when>	
			<c:otherwise>
			</c:otherwise>
		</c:choose>
	</div>

	

	<script>
		function deleteCheck(){
		  var okCheck =  confirm("제목 : ${noticeVo.subject }, 이 글을 삭제하시겠습니까?");
		  if(okCheck){
			  location.href="/notice/noticeDelete?num=${ noticeVo.num }&pageNum=${pageNum }";
		  }else{
			  return;
		  }
		}			
	</script>
	



	<%-- footer영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	
	
	<script type="text/javascript" src="/script/jquery-3.5.1.js"></script>
	<script type="text/javascript" src="/script/bootstrap.js"></script>
	<script type="text/javascript"></script>
</body>
</html>