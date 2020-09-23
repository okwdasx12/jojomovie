<%@page import="java.io.Console"%>
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
	div.col-sm-2.text-center{
		color: white;
	}
	
	img#poster{
		width: 80px;
		height: 80px;
	}
</style>

</head>

<body>
<%-- top 영역  --%>
	<jsp:include page="/WEB-INF/views/include/adminTop.jsp" />
	
	<div class="col-md-12" id="mmm6">
		<p>영화 수정</p>
	</div>
	 <form action="/admin/ModifyMovie" method="post" enctype="multipart/form-data" >
		<div class="container">
			<div class="jumbotron" style="background-color: white; height: 700px;">
				<input type="hidden" value="${movieVo.movieId}" name="movieId">
				<div class="row">
					<div class="col-sm-2" style="margin:10px;"></div>
			        <div class="col-sm-2 text-center" id="white">영화 제목 </div>
			        <div class="col-sm-3 text-center" style="margin:10px;">
			        	<input type="text" id="black" name="movieName" value="${movieVo.movieName}">
		        	</div>
			    	<div class="col-sm-3" style="margin:10px;"></div>
			    </div>
			    <div class="row">
					<div class="col-sm-2" style="margin:10px;"></div>
			        <div class="col-sm-2 text-center" id="white">올린 파일 </div>
			        <div class="col-sm-3 text-center" id="showImg" style="margin:10px;">
			        	<input type="radio" name="movieId" id="movieId" value="${movieVo.movieId }">
			        	<img alt="${movieVo.movieId }" src="/upload2/upposter/${movieVo.movieId }.jpg" id="poster">
			        	<div class="col-sm-3" style="margin:10px;"><button type="button" onclick="remove()">X</button></div>
		        	</div>
	        	</div>
			     <div class="row">
					<div class="col-sm-2" style="margin:10px;"></div>
			        <div class="col-sm-2 text-center" id="white">파일 </div>
			        <div class="col-sm-3 text-center" style="margin:10px;">
			        	<input type="file" name="filename">
		        	</div>
			    </div>
			    
			    <div class="row">
					<div class="col-sm-2" style="margin:10px;"></div>
			        <div class="col-sm-2 text-center" id="white">감독</div>
			        <div class="col-sm-3 text-center" style="margin:10px;">
			        	<input type="text" id="black" name="director" value="${movieVo.director}">
		        	</div>
			    	<div class="col-sm-3" style="margin:10px;"></div>
			    </div>
			    <div class="row">
					<div class="col-sm-2" style="margin:10px;"></div>
			        <div class="col-sm-2 text-center" id="white">배우</div>
			        <div class="col-sm-3 text-center" style="margin:10px;">
			        	<input type="text" id="black" name="cast"  value="${movieVo.cast}">
		        	</div>
			    	<div class="col-sm-3" style="margin:10px;"></div>
			    </div>
			    <div class="row">
					<div class="col-sm-2" style="margin:10px;"></div>
			        <div class="col-sm-2 text-center" id="white">등급 (수정 전 : ${movieVo.grade})</div>
			        <div class="col-sm-3 text-center" style="margin:10px;">
						<select name="grade" id="black">
							<option value="12">12</option>
							<option value="15">15</option>
							<option value="18">18</option>
						</select>
		        	</div>
			    	<div class="col-sm-3" style="margin:10px;"></div>
			    </div>
			    <div class="row">
					<div class="col-sm-2" style="margin:10px;"></div>
			        <div class="col-sm-2 text-center"  id="white">줄거리</div>
			        <div class="col-sm-3 text-center" style="margin:10px;">
			        	<textarea rows="10" cols="50" maxlength="1000" style="" name="information"  >${movieVo.information}</textarea>  
		        	 </div>
			    	<div class="col-sm-3" style="margin:10px;"></div>
			    </div>
			    <div class="row">
					<div class="col-sm-2" style="margin:10px;"></div>
			        <div class="col-sm-2 text-center" id="white">장르</div>
			        <div class="col-sm-3 text-center" style="margin:10px;">
			        	<input type="text" id="black" name="genre"  value="${movieVo.genre}">
		        	 </div>
			    	<div class="col-sm-3" style="margin:10px;"></div>
			    </div>
			    <div class="row">
					<div class="col-sm-2" style="margin:10px;"></div>
			        <div class="col-sm-2 text-center" id="white">런타임</div>
			        <div class="col-sm-3 text-center" style="margin:10px;">
			        	<input type="text" id="black" name="runtime" value="${movieVo.runtime}">
		        	</div>
			    	<div class="col-sm-3" style="margin:10px;"></div>
			    </div>
		       <div class="row">
					<div class="col-sm-2" style="margin:10px;"></div>
			        <div class="col-sm-2 text-center" id="white">시작일</div>
			    	<div class="col-sm-3" style="margin:10px;">
				    	<p><input type="date" id="black" value="${movieVo.startDate}" min="2000-01-01" name="startDate"></p>
	     			</div>
			    </div>
			     <div class="row">
					<div class="col-sm-2" style="margin:10px;"></div>
			        <div class="col-sm-2 text-center" id="white">마감일</div>
			    	<div class="col-sm-3" style="margin:10px;">
				    	<p><input type="date" id="black" value="${movieVo.endDate}" min="2000-01-01"  name="endDate"></p>
	     			</div>
			    </div>
			    </div>
			    <div class="col-md-12" id="tom" style="text-align: center;">
			        	<button type="submit" id="modifyBtn2" > 수정하기 </button>
			       		<input type="reset" id="modifyBtn2" value="취소">
			    </div>
			</div>
		</form>



	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script type="text/javascript" src="/script/jquery-3.5.1.js"></script>
	<script type="text/javascript" src="/script/bootstrap.js"></script>
	<script type="text/javascript"></script>

	<script>
		$('#modifyBtn').on("click", function(){
			alert("수정이 완료되었습니다.");
			location.href='/admin/ModifyMovie';
		});

		var movieId  = 0;

		function remove(){
			if($("input:radio[name='movieId']").is(":checked") == true){
				
				movieId = $('#movieId').val(); //movieId가져오기

					$.ajax({
							method: 'DELETE',
							url: '/admin/' + movieId,
							success: function (result) {
								alert('삭제완료');
								$('#showImg').remove();
							},
							error: function () {
								alert("실패");
							}
						});
				}else{
					alert('삭제할 파일을 선택해주세요');
				}
			}	
	</script>

</body>
</html>