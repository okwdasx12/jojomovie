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

	button.member_info{
		background-color: white;
	}

</style>

</head>

<body>
	<%-- top 영역  --%>
	<jsp:include page="/WEB-INF/views/include/adminTop.jsp" />
	
	<div class="col-md-12" id="mmm2">
		<p>회원 관리</p>
		</div>
	<!-- 검색 -->
		<form action="/admin/memberManage" method="get">
			<div class="row">
				<div class="col-sm-3" style="margin:10px;"></div>
		        <div class="col-sm-6 text-center" style="margin:10px;">
		        	<select name="category" style="height: 32px;">
		        		<option value="userId" ${ pageDto.category eq 'userId' ? 'selected' : '' }>ID</option>
		        		<option value="grade" ${ pageDto.category eq 'grade' ? 'selected' : '' }>등급</option>
		        		<option value="point" ${ pageDto.category eq 'point' ? 'selected' : '' }>포인트</option>
		        	</select>
		        	<input type="text" name="search" placeholder="검색어를 입력해주세요" style="height: 32px;">
		        	<button type="submit" style="height: 32px;">검색</button>
	        	</div>
		    	<div class="col-sm-3" style="margin:10px;"></div>
			</div>
		</form>
	
	<div class="container" style = margin-top: 40px;">
		<h3 class="text-center" id="all-member">전체 회원</h3>
		<h5 id="all-member2">총 회원 수 <span class="glyphicon glyphicon-user"></span> : ${requestScope.pageDto.totalCount}</h5>
		<input type="button" id="del-con" onclick="check_check()" value="삭제">
			
			<form action="/admin/deleteMember" name="frmB" method="post">    
				<table class="table text-center">
				    <thead>
				      <tr>
				      	<th>체크박스</th>
				        <th class="text-center">아이디</th>
				        <th class="text-center">비밀번호</th>
				        <th class="text-center">이름</th>
				        <th class="text-center">생일</th>
				        <th class="text-center">주소</th>
				        <th class="text-center">전화번호</th>
				        <th class="text-center">포인트</th>
				        <th class="text-center">등급</th>
				        <th class="text-center">수정</th>
				      </tr>
				    </thead>
				<c:choose>
				  	<c:when test = "${pageDto.totalCount gt 0}">
				  		<c:forEach var="memList" items="${memList}">
						    <tbody>
						    	<c:choose>
						    		<c:when test="${memList.userId != 'admin'}">
									      <tr>
									      	<td><input type="checkbox" name="userlist" value="${memList.userId }"> </td>
											<td><a>${memList.userId}</a></td>
											<td>${memList.passwd}</td>
											<td>${memList.name}</td>
											<td>${memList.birthday}</td>
											<td>${memList.userAddr}</td>
											<td>${memList.phone}</td>
											<td>${memList.point}</td>
											<td>${memList.grade}</td>
											<td>
												<button type="button" id="click" onclick="location.href='/admin/modifyMember?userId=${memList.userId}'" class="btnmody" id="btnmodify">수정하기</button>
									      	</td>
									      </tr>
						      		</c:when>
						      	</c:choose>
						    </tbody>
				    	</c:forEach>
				    </c:when>
				   <c:otherwise>
						<tr>
							<td colspan="10"><div align="center" ><h1 ><img src="/images/검색없음.png"  ><br><br>조회된 회원 정보가 없습니다.<br></h1></div></td>
						</tr>	    
				    </c:otherwise>
			    </c:choose>
				</table>
		    </form>
		    
		 	      <!-- page -->
		    <div class="text-center">
	   			<c:if test="${pageDto.totalCount gt 0 }">
	   				<ul class="pagination">
		    		<!--이전  -->
	    				<c:if test="${ pageDto.startPage gt pageDto.pageBlock }">
							<li><a href="/admin/memberManage?pageNum=${ pageDto.startPage - pageDto.pageBlock }&category=${ pageDto.category }&search=${ pageDto.search }"><span class="glyphicon glyphicon-chevron-left"></span></a></li>
						</c:if>
		    			<%-- 페이지블록 내에서의 시작페이지부터 끝페이지까지 번호출력 --%>
					<c:forEach var="i" begin="${ pageDto.startPage }" end="${ pageDto.endPage }" step="1">
						<li>
							<a href="/admin/memberManage?pageNum=${ i }&category=${ pageDto.category }&search=${ pageDto.search }">
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
						<li><a href="/admin/memberManage?pageNum=${ pageDto.startPage + pageDto.pageBlock }&category=${ pageDto.category }&search=${ pageDto.search }"><span class="glyphicon glyphicon-chevron-right"></span></a></li>
					</c:if>
				</ul>
			</c:if>
		</div>
	</div>
	 	
	<script>
	
	function sum() {
		var userFirstAddr = document.frm.userFirstAddr.value;
		var userSecondAddr = document.frm.userSecondAddr.value;
		var userAddr = userFirstAddr + ' ' + userSecondAddr;
		document.frm.userAddr.value = userAddr;
	}

	function check_check(){
		if($("input:checkbox[name=userlist]").is(":checked") == true){
				if(confirm('삭제하시겠습니까?')){
					document.frmB.submit();
					alert("삭제완료");
				}else{
					$("input:checkbox[name=userlist]").prop("checked", false);
					alert("취소");
				}
		}else{
			alert('삭제할 회원을 선택해주세요');
		}
	}
			
	</script>	 	


	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script type="text/javascript" src="/script/jquery-3.5.1.js"></script>
	<script type="text/javascript" src="/script/bootstrap.js"></script>
	<script type="text/javascript"></script>
</body>
</html> 