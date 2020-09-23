<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1 user-scalable=no">
<title>조조무비</title>
<link href="/css/bootstrap.css" rel="stylesheet">
<link href="/css/bootstrap-theme.css" rel="stylesheet">
<link href="/css/bootstrap-formhelpers.css" rel="stylesheet">
<link href="/css/admin.css" rel="stylesheet">

<style>
	body{
	color: white;
	}
	div.col-sm-2.text-center{
		color: white;
	}
	
</style>

</head>

<body>
	<%-- top 영역  --%>
	<jsp:include page="/WEB-INF/views/include/adminTop.jsp" />

	<div class="col-md-12" id="mmm5">
		<p>상영시간 수정</p>
	</div>
	<div class="container">
		<form action="/admin/modifyMovieTime" method="post" class="form-horizontal" role="form">
			<div class="form-group">
				<div class="btn-group" style="width: 100%">
					<label for="theaterName" class="col-xs-2 col-lg-2 control-label">영화관 선택</label>
					<div class="col-xs-10 col-lg-10">
						<input id="theaterName" name="theaterName" type="text" class="form-control aaaa" value="${ timeVo.theaterName }" readonly>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="btn-group" style="width: 100%">
					<label for="sygId" class="col-xs-2 col-lg-2 control-label">상영관 선택</label>
					<div class="col-xs-10 col-lg-10">
						<select name="sygId" id="sygId" class="form-control" style="width: 470px; height: 37px;">
							<option value="${ timeVo.sygId }" selected hidden>${ timeVo.sygId }</option>
						</select>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="btn-group" style="width: 100%">
					<label for="movieName" class="col-xs-2 col-lg-2 control-label">영화 선택</label>
					<div class="col-xs-10 col-lg-10 movieName">
						<select name="" id="movieId" class="form-control" style="width: 470px; height: 37px;" >
							<option value="${ timeVo.movieId }" selected hidden>${ timeVo.movieName }</option>
							<c:forEach var="movieVo" items="${ movieVoList }">
								<option value="${ movieVo.movieId }">${ movieVo.movieName }</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="btn-group" style="width: 100%">
					<label for="Name" class="col-xs-2 col-lg-2 control-label">상영시간 선택</label>
					<input type="datetime-local" style="margin-left: 15px; width: 805px; height: 37px;"
					 class="form-control time" name="SangyoungTime" 
					value="${ timeVo.sangyoungTime }" >
					<c:forEach var="timeVo" items="${ timeVoList }" varStatus="vs">
						<input type="hidden" class="${ timeVo.timeNum }" value="${ timeVo.sangyoungTime }">
						<input type="hidden" id="${ timeVo.timeNum }" value="${ timeVo.sygId }">
					</c:forEach>
				</div>
				<div class=" col-xs-offset-9 col-xs-3 col-lg-offset-9 col-lg-3"style="margin-top: 30px; margin-bottom: 50px;">
					<input type="submit" class="form-control btn-primary dup-check" value="수정하기">
				</div>
				<div class="sangyoungTime">
					<input type="hidden" name="timeNum" value="${ timeVo.timeNum }">
					<input type="hidden" name="movieId" id="movieIdHidden" value="">
					<input type="hidden" name="movieName" id="movieNameHidden" value="">
				</div>
			</div>
		</form>
	</div>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script type="text/javascript" src="/script/jquery-3.5.1.js"></script>
	<script type="text/javascript" src="/script/bootstrap.js"></script>
	<script type="text/javascript" src="/script/bootstrap-formhelpers.js"></script>
	<script>
		var theaterName;
		var sygId;
		var movieId;
		var sangyoungTime;

		$(document).ready(function () {
			var changeTheaterName = '${ timeVo.theaterName }';
			$.ajax({
				method: 'GET',
				url: '/ajaxSelectSygByTheaterName',
				data:{changeTheaterName: changeTheaterName},
				success:function(data){
					if(data.length == 0){
						$('#sygId').append("<option value=''>상영관 없음</option>");
					}else{
						$('#sygId').find("option").remove();
						$('#sygId').append("<option value='${ timeVo.sygId }' selected hidden>${ timeVo.sygId }</option>")
						$(data).each(function(i){
							$('#sygId').append("<option value='"+data[i]+"'>"+data[i]+"</option>");	
						});				
					}
				}
			});
		});
		
		$('.dup-check').on('click', function () {
			theaterName = $('#theaterName').val();
			sygId = $('#sygId').val();
			movieId = $('#movieId').val();
			movieName = $('#movieId option:selected').text();
			sangyoungTime=$('.time').val();

			$('#movieNameHidden').val(movieName);
			$('#movieIdHidden').val(movieId);

			if(theaterName == ''){
				alert("영화관 이름을 입력하세요");
				return false;
			} else if(sygId == ''){
				alert("상영관 번호를 입력하세요");
				return false;
			} else if(movieId == ''){
				alert("영화 제목을 입력하세요");
				return false;
			} else if(sangyoungTime == ''){
				alert("상영 시간을 선택하세요");
				return false;
			}
			
			for(var i = 1; i<=${ totalNum }; i++){
				var syt = $('.'+i).val();
				var syg = $('#'+i).val();
				if(syt != null){
					if ( ${timeVo.timeNum} == i ) {
						continue;
					} 
					
					if (sangyoungTime == syt && syg == sygId){
						alert("선택하신 시간과 겹치는 영화 시간이 있습니다.");
						
						return false;
					}
				}
			}
		});

	</script>
	
</body>
</html>