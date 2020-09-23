<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
td#table_t{
	text-align: center;
	font-weight: bold;
}
</style>
</head>

<body>
	<%-- top 영역  --%>
	<jsp:include page="/WEB-INF/views/include/adminTop.jsp" />
	<div class="col-md-12" id="mmm2">
		<p>예매 관리</p>
	</div>
	  <!-- 검색 -->
		<form action="/admin/reserveList" method="get">
			<div class="row">
				<div class="col-sm-3" style="margin:10px;"></div>
		        <div class="col-sm-6 text-center" style="margin:10px;">
		        	<select name="category" style="height: 32px;">
		        		<option value="userId" ${ pageDto.category eq 'userId' ? 'selected' : '' }>회원아이디</option>
		        		<option value="theaterName" ${ pageDto.category eq 'theaterName' ? 'selected' : '' }>영화관</option>
		        		<option value="movieName" ${ pageDto.category eq 'movieName' ? 'selected' : '' }>영화이름</option>
		        	</select>
		        	<input type="text" name="search"  value="${ pageDto.search }" placeholder="검색어를 입력해주세요" style="height: 32px;">
		        	<button type="submit" style="height: 32px;">검색</button></div>
		    	<div class="col-sm-3" style="margin:10px;"></div>
			</div>
		</form>
<!--AllResv  -->
	<div class="container" style="margin-top: 100px;">
		<div style="margin:10px;">
			<table class="table">
			    <thead>
			      <tr>
			        <th class="text-center">아이디</th>
			        <th class="text-center">예매번호</th>
			        <th class="text-center">결제번호</th>
			        <th class="text-center">영화 이름</th>
			        <th class="text-center">영화관</th>
	              	<th class="text-center">예매 결제 여부</th>
			      </tr>
			    </thead>
			    <c:choose>
				  	<c:when test = "${pageDto.totalCount gt 0 }">
				  		<c:forEach var="AllResv" items="${AllResv}">
						    <tbody>
						    <!--검색결과  -->
						      <tr>
						        <td class="text-center" id="table_t">${AllResv.userId}</td>
						        <td class="text-center">${AllResv.reserveNumber}</td>
						        <td class="text-center" >${AllResv.ticketId}</td>
						        <td class="text-center">${AllResv.movieName}</td>
						        <td class="text-center"> ${AllResv.theaterName}</td>
						        <td class="text-center">  
									<button id="openModify" onclick="location.href='/admin/reserveManage?ticketId=${AllResv.ticketId}'">상세 보기</button>
						        </td>
						      </tr>
						    </tbody>
					    </c:forEach>
		   		   </c:when>
			   		 <c:otherwise>
		   		 		<tr>
							<td colspan="6"><div align="center" ><h1 ><img src="/images/검색없음.png"  ><br><br>조회된 예매 정보가 없습니다.<br></h1></div></td>
						</tr>
			   		  </c:otherwise>
   	 		 </c:choose>
		 	</table>
		</div>
	</div>

		      <!-- page -->
	    <div class="text-center">
	   	<c:if test="${pageDto.totalCount gt 0 }">
	    	<ul class="pagination">
		    	<!--이전  -->
	    		<c:if test="${ pageDto.startPage gt pageDto.pageBlock }">
					<li><a href="/admin/reserveList?pageNum=${ pageDto.startPage - pageDto.pageBlock }&category=${ pageDto.category }&search=${ pageDto.search }"><span class="glyphicon glyphicon-chevron-left"></span></a></li>
				</c:if>
		    	<%-- 페이지블록 내에서의 시작페이지부터 끝페이지까지 번호출력 --%>
				<c:forEach var="i" begin="${ pageDto.startPage }" end="${ pageDto.endPage }" step="1">
				<li>
					<a href="/admin/reserveList?pageNum=${ i }&category=${ pageDto.category }&search=${ pageDto.search }">
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
					<li><a href="/admin/reserveList?pageNum=${ pageDto.startPage + pageDto.pageBlock }&category=${ pageDto.category }&search=${ pageDto.search }"><span class="glyphicon glyphicon-chevron-right"></span></a></li>
				</c:if>
			</ul>
			</c:if>
		</div>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script type="text/javascript" src="/script/jquery-3.5.1.js"></script>
	<script type="text/javascript" src="/script/bootstrap.js"></script>
	<script type="text/javascript"></script>
</body>
</html>