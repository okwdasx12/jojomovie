<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="javatime" uri="http://sargue.net/jsptags/time"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1 user-scalable=no">
<title>Insert title here</title>
<style>
	.center{
		text-align: center;
	}
</style>
</head>
<body>
	<!--관리자 페이지 제목  -->
	<%-- top 영역  --%>
	<jsp:include page="/WEB-INF/views/include/adminTop.jsp" />

	<div class="container-fluid bg-color">
		<hr>
			<p class="active-tab">
				<strong>Active Tab</strong>: <span></span>
			</p>
			<p class="previous-tab">
				<strong>Previous Tab</strong>: <span></span>
			</p>
		<hr>

		<ul id="myTab" class="nav nav-tabs">
			<li id="theater" class="${tabNum eq 1 ? 'active' : ''}">
				<a href="#home" data-toggle="tab">영화관</a>
			</li>
			<li id="sangyounggwan" class="${tabNum eq 2 ? 'active' : ''}">
				<a href="#tab1" data-toggle="tab">상영관</a>
			</li>
			<li id="sangyoungTime" class="${tabNum eq 3 ? 'active' : ''}">
				<a href="#tab2" data-toggle="tab">상영 시간</a>
			</li>
		</ul>
		<div class="tab-content">
			<div class="tab-pane fade ${tabNum eq 1 ? 'in active' : ''}" id="home">
			     <h3>영화관 수정 및 삭제</h3>
			     <table class="table table-bordered">
					<thead>
						<tr>
							<th class="center"> 극장 코드 </th>
							<th class="center"> 극장 이름 </th>
							<th class="center"> 극장 주소 </th>
							<th class="center"> 극장 번호 </th>
							<th class="center"> 수정 OR 삭제 </th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${ pageDto.totalCountTh gt 0 }">
								<c:forEach var="theaterVo" items="${ theaterList }">
									<tr class="tr">
										<td class="theaterId">${ theaterVo.theaterId }</td>
										<td>${ theaterVo.theaterName }</td>
										<td>${ theaterVo.address }</td>
										<td>${ theaterVo.number }</td>
										<td class="center">
											<button class="black" onclick="location.href='/admin/modifyTheater?theaterId=${ theaterVo.theaterId }'">수정</button>
											<button class="black deleteTheater">삭제</button>
										</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="5" align="center"><div><h1 ><img src="/images/검색없음.png"  ><br><br>조회된 정보가 없습니다.<br></h1></div></td>
								</tr>
							</c:otherwise>
						</c:choose>  
					</tbody>
				 </table>
				 
				 <div id="page_control" align="center">
					<c:if test="${pageDto.totalCountTh gt 0}">
						<ul class="pagination">
							<%-- [이전] --%>
							<c:if test="${pageDto.startPageTh gt pageDto.pageBlock }">
								<li><a class="black"  href="/admin/modify?pageNumTh=${pageDto.startPageTh - pageDto.pageBlock}&category=${pageDto.category}&searchTh=${pageDto.searchTh}&tabNum=1"><span class="glyphicon glyphicon-chevron-left"></span></a></li>
							</c:if>	
							
							<c:forEach var="i" begin="${pageDto.startPageTh}" end="${pageDto.endPageTh}" step="1">
								<li>
									<a href="/admin/modify?pageNumTh=${i}&category=${pageDto.category}&searchTh=${pageDto.searchTh}&tabNum=1">
										<c:choose>
											<c:when test="${pageNumTh eq i}">
												<span style="font-weight: bold; color: red;">${i}</span>
											</c:when>
											<c:otherwise>
												${i}
											</c:otherwise>
										</c:choose>
									</a>
								</li>
							</c:forEach>
							
							<%-- [다음] --%>
							<c:if test="${ pageDto.endPageTh lt pageDto.pageCountTh }">
								<li><a href="/admin/modify?pageNumTh=${ pageDto.startPageTh + pageDto.pageBlock }&category=${pageDto.category}&searchTh=${pageDto.searchTh}&tabNum=1"><span class="glyphicon glyphicon-chevron-right"></span></a></li>
							</c:if>	
						</ul>	
					</c:if>
				</div>

				<div id="table_search" class="black margin-bottom" align="right">
					<form action="/admin/modify?category=${pageDto.category}&searchTh=${pageDto.searchTh}" style="text-align: center;" method="get">
						<select name="category" style="height:33px;">
							<option value="theater_name" ${pageDto.category eq 'theater_name' ? selected : ''}>영화관이름</option>
						</select> 
						<input type="text" name="searchTh" value="${pageDto.searchTh}" style="height:33px;"	class="input_box"> 
						<input type="hidden" name="pageNumSyg" value="1"> 
						<input type="hidden" name="tabNum" value="1">
						<input type="submit" style="margin-bottom: 2px;" value="검색" class="btn btn-primary">
					</form>
				</div>
			</div>
			
		 	<div class="tab-pane fade ${tabNum eq 2 ? 'in active' : ''}" id="tab1">
				<h3>상영관 수정 및 삭제</h3>
				<table class="table table-bordered">
					<thead>
						<tr>
							<th class="center"> 상영관 번호 </th>
							<th class="center"> 극장 코드 </th>
							<th class="center"> 극장 이름 </th>
							<th class="center"> 총 좌석 수 </th>
							<th class="center"> 세로 좌석 수 </th>
							<th class="center"> 가로 좌석 수 </th>
							<th class="center">수정 OR 삭제</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${ pageDto.totalCountSyg gt 0 }">
								<c:forEach var="sangyounggwanVo" items="${ sangyounggwanList }">
									<tr class="tr">
										<td class="sygId">${ sangyounggwanVo.sygId }</td>
										<td>${ sangyounggwanVo.theaterId }</td>
										<td>${ sangyounggwanVo.theaterName }</td>
										<td class="center">${ sangyounggwanVo.seatsNum }</td>
										<td class="center">${ sangyounggwanVo.row }</td>
										<td class="center">${ sangyounggwanVo.cul }</td>
										<td class="center">
											<button class="black" onclick="location.href='/admin/modifySangyounggwan?sygId=${ sangyounggwanVo.sygId }'">수정</button>
											<button class="black deleteSangyounggwan" >삭제</button>
										</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="8" align="center"><div><h1 ><img src="/images/검색없음.png"  ><br><br>조회된 정보가 없습니다.<br></h1></div></td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table> 
				 
				<div id="page_control" align="center">
					<c:if test="${pageDto.totalCountSyg gt 0}">
						<ul class="pagination">
								<%-- [이전] --%>
							<c:if test="${pageDto.startPageSyg gt pageDto.pageBlock }">
								<li><a href="/admin/modify?pageNumSyg=${pageDto.startPageSyg - pageDto.pageBlock}&category=${pageDto.category}&searchSyg=${pageDto.searchSyg}&tabNum=2"><span class="glyphicon glyphicon-chevron-left"></span></a></li>
							</c:if>	
							
							<c:forEach var="i" begin="${pageDto.startPageSyg}" end="${pageDto.endPageSyg}" step="1">
								<li>
									<a href="/admin/modify?pageNumSyg=${i}&category=${pageDto.category}&searchSyg=${pageDto.searchSyg}&tabNum=2">
										<c:choose>
											<c:when test="${pageNumSyg eq i}">
												<span style="font-weight: bold; color: red;">${i}</span>
											</c:when>
											<c:otherwise>
												${i }
											</c:otherwise>
										</c:choose>
									</a>
								</li>
							</c:forEach>
							
							<%-- [다음] --%>
							<c:if test="${ pageDto.endPageSyg lt pageDto.pageCountSyg }">
								<li><a href="/admin/modify?pageNumSyg=${ pageDto.startPageSyg + pageDto.pageBlock }&category=${pageDto.category}&searchSyg=${pageDto.searchSyg}&tabNum=2"><span class="glyphicon glyphicon-chevron-right"></span></a></li>
							</c:if>
						</ul>		
					</c:if>
				</div>
				 
				<div id="table_search" class="black margin-bottom" align="right">
					<form action="/admin/modify?category=${pageDto.category}&searchSyg=${pageDto.searchSyg}" style="text-align: center;" method="get">
						<select name="category" style="height: 33px;">
							<option value="syg_id" ${pageDto.category eq 'syg_id' ? selected : ''}>상영관</option>
						</select> 
						<input type="text" name="searchSyg" value="${pageDto.searchSyg}" style="height: 33px;" class="input_box">
						<input type="hidden" name="pageNumSyg" value="1">
						<input type="hidden" name="tabNum" value="2">
						<input type="submit" style="margin-bottom: 2px;" value="검색" class="btn btn-primary">
					</form>
				</div>
 
				
			</div>
			
			<div class="tab-pane fade ${tabNum eq 3 ? 'in active' : ''}" id="tab2">
				<h3>상영시간 수정 및 삭제</h3>
				<table class="table table-bordered">
					<thead>
						<tr>
						   <th class="center"> 상영 시간 </th>
						   <th class="center"> 극장 이름 </th>
						   <th class="center"> 상영관 번호 </th>
						   <th class="center"> 영화 제목 </th>
						   <th class="center"> 수정 OR 삭제 </th>
						</tr>
					</thead>
					<tbody>
						<c:choose>	
							<c:when test="${ pageDto.totalCountSyt gt 0 }">
								<c:forEach var="timeVo" items="${ timeList }">
								<tr class="tr">
									<td class="sangyoungTime center" data-time="${ timeVo.sangyoungTime }">
										<javatime:format value="${ timeVo.sangyoungTime }" pattern="MM월 dd일  HH:mm"/>
									</td>
									<td>${ timeVo.theaterName }</td>
									<td class="sygId">${ timeVo.sygId }</td>
									<td>${ timeVo.movieName }</td>
									<td class="center">
										<button class="black" onclick="location.href='/admin/modifyMovieTime?timeNum=${ timeVo.timeNum }'">수정</button>
										<button class="black deleteSangyoungTime" >삭제</button>
									</td>
								</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="5" align="center"><div><h1 ><img src="/images/검색없음.png"  ><br><br>조회된 정보가 없습니다.<br></h1></div></td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table> 
			
				<div id="page_control" align="center">
					<c:if test="${pageDto.totalCountSyt gt 0}">
						<ul class="pagination">
							<%-- [이전] --%>
							<c:if test="${pageDto.startPageSyt gt pageDto.pageBlock }">
								<li><a href="/admin/modify?pageNumSyt=${pageDto.startPageSyt - pageDto.pageBlock}&category=${pageDto.category}&searchSyt=${pageDto.searchSyt}&tabNum=3"><span class="glyphicon glyphicon-chevron-left"></span></a></li>
							</c:if>	
						
							<c:forEach var="i" begin="${pageDto.startPageSyt}" end="${pageDto.endPageSyt}" step="1">
								<li>
									<a href="/admin/modify?pageNumSyt=${i}&category=${pageDto.category}&searchSyt=${pageDto.searchSyt}&tabNum=3">
									<c:choose>
										<c:when test="${pageNumSyt eq i}">
											<span style="font-weight: bold; color: red;">${i}</span>
										</c:when>
										<c:otherwise>
											${ i }
										</c:otherwise>
									</c:choose>
									</a>
								</li>
							</c:forEach>
						
							<%-- [다음] --%>
							<c:if test="${ pageDto.endPageSyt lt pageDto.pageCountSyt }">
								<li><a href="/admin/modify?pageNumSyt=${ pageDto.startPageSyt + pageDto.pageBlock }&category=${pageDto.category}&searchSyt=${pageDto.searchSyt}&tabNum=3"><span class="glyphicon glyphicon-chevron-right"></span></a></li>
							</c:if>	
						</ul>	
					</c:if>
				</div>
			
				<div id="table_search" class="black margin-bottom" align="right">
					<form action="/admin/modify?category=${pageDto.category}&searchSyt=${pageDto.searchSyt}" method="get" style="text-align: center;">
						<select name="category" style="height: 33px;">
							<option value="theater_name" ${pageDto.category eq 'theater_name' ? 'selected' : ''}>영화관이름 </option>
							<option value="syg_id" ${pageDto.category eq 'syg_id' ? 'selected' : ''}>상영관 </option>
							<option value="movie_name" ${pageDto.category eq 'movie_name' ? 'selected' : ''}>영화제목 </option>
						</select>
						 <input type="text" name="searchSyt" style="height: 33px;" value="${pageDto.searchSyt}" class="input_box"> 
						 <input type="hidden" name="pageNumSyg" value="1"> 
						 <input type="hidden" name="tabNum" value="3"> 
						 <input type="submit" style="margin-bottom: 2px;" value="검색" class="btn btn-primary">
					</form>
				</div> 
			</div>
		</div>
	</div>
	
<script type="text/javascript" src="/script/jquery-3.5.1.js"></script>
<script type="text/javascript" src="/script/bootstrap.js"></script>
<script>
	$('.deleteTheater').on('click', function() {
		var theaterId = $(this).closest('.tr').find('.theaterId').html();
		var tr = $(this).closest('.tr');

		var yn = confirm(theaterId + "을 삭제하시겠습니까?")
		if (yn) {
			$.ajax({
				method : 'DELETE',
				url : '/admin/deleteTheater',
				data : {theaterId : theaterId},
				success : function() {
					tr.remove();
				}
			});
		} else {
			return false;
		}
	});

	$('.deleteSangyounggwan').on('click', function() {
		var sygId = $(this).closest('.tr').find('.sygId').html();
		var tr = $(this).closest('.tr');

		var yn = confirm(sygId + "을 삭제하시겠습니까?")
		if (yn) {
			$.ajax({
				method : 'DELETE',
				url : '/admin/deleteSangyounggwan',
				data : {sygId : sygId},
				success : function() {
					tr.remove();
				}
			});
		} else {
			return false;
		}
	});

	$('.deleteSangyoungTime').on('click', function() {
// 		var str = $(this).closest('.tr').find('.sangyoungTime').html();
		var str = $(this).closest('.tr').find('.sangyoungTime').data('time');
		var str2 = $(this).closest('.tr').find('.sygId').html();
		var tr = $(this).closest('.tr');

		var yn = confirm(str + "을 삭제하시겠습니까?")
		if (yn) {
			$.ajax({
				method : 'DELETE',
				url : '/ajaxDelTime',
				data : {str : str, str2 : str2},
				success : function() {
					tr.remove();
				}
			});
		} else {
			return false;
		}
	});

	$('a[data-toggle="tab"]').on('shown.bs.tab', function(e) {
		// 현재 활성화 된 탭 이름 가져오기 
		var activeTab = $(e.target).text();
		// 이전 탭 이름 가져오기 
		var previousTab = $(e.relatedTarget).text();
		$(".active-tab span").html(activeTab); // 현재 활성화 탭 이름 표시 
		$(".previous-tab span").html(previousTab); // 이전 탭 이름 표시 
	});
</script>
</body>
</html>