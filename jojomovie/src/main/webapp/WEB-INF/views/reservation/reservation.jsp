<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="javatime" uri="http://sargue.net/jsptags/time" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1 user-scalable=no">
<title>조조무비 - 예매</title>
<style>
	.background{
		margin-top: 20px;
		background-color: #2D2D2D;
		padding: 10px 13%;
	}
	.white{
		color: white;
	}
	.tit{
		padding : 20px 0 20px 0;
		background-color: #555555;
		border: 1px, solid, #E2E2E2;
		font-size: 22px;
		font-weight: bold;
		color: white;
	}
	.selectSize{
		width: 100%;
		height: 300px;
	}
	div.option option{
		text-align: center;
	}
	.btn-selectSeats{
		height:150px;
		padding: 30px;
		background:#555555;
		color: #FFFFFF;
		font-size:18px;
		display: flex;
		justify-content: space-around;
	}
	.vertical{
		font-size: 22px;
		margin: auto 0;
	}
	.font-white{
		color: white;
	}


</style>
</head>
<body>
<%-- top 영역  --%>
<jsp:include page="/WEB-INF/views/include/top.jsp" />

	<div class="container">
	<form action="/reservation/seat" method="get">
		<div class="row">
			<div class="col-md-3 tit"align="center">영화<br>
				<div align="center">
					<select multiple class="form-control movie" style="width: 100%; height: 300px;">
						<c:forEach var="movie" items="${ movieList }">
							<c:choose>
								<c:when test="${ movie.movieId eq MovieVo.movieId }">
									<option style="font-size: 20px;" selected value="${ movie.movieId }">${ movie.movieName }</option>
								</c:when>
								<c:otherwise>
									<option style="font-size: 20px;" value="${ movie.movieId }">${ movie.movieName }</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
			        </select> 
				</div>
			</div>
			<div class="col-md-3 tit"align="center">극장<br>
				<div align="center">
					<select multiple class="form-control theater" style="width: 100%; height: 300px;">
		          		<c:forEach var="theater" items="${ theaterList }">
							<option style="font-size: 20px;" value="${ theater.theaterName }">${ theater.theaterName }</option>
						</c:forEach>
			        </select> 
				</div>
			</div>
			<div class="col-md-3 tit"align="center" style="height: 374px;">날짜<br>
				<div class="option" align="center" >
					<select multiple class="form-control reserve-date date" style="width: 100%; height: 300px;">
						<c:forEach var="date" items="${ dateMap }" varStatus="vs">
							<option style="font-size: 20px;" value="${ date.value }">${ date.value }</option>
						</c:forEach>
			        </select> 
				</div>
			</div>
			<div class="col-md-3 tit"align="center">상영시간<br>
				<div class="option" align="center">
					<select multiple class="form-control sangyoungTime" id="sangyoungTime" style="width: 100%; height: 300px;">
			        </select> 
				</div>
			</div>
		</div>
		
		<div class="btn-selectSeats">
			<div class="vertical">
				<span class="font-white"> 영화 선택</span>
			</div>
			<div class="glyphicon glyphicon-chevron-right vertical">
			</div>
			<div class="vertical">
				<span class="font-white"> 극장 선택</span>
			</div>
			<div class="glyphicon glyphicon-chevron-right vertical">
			</div>
			<div class="vertical">
				<span class="font-white"> 날짜 및 상영시간<br>선택</span>
			</div>
			<div class="glyphicon glyphicon-chevron-right vertical">
			</div>
			<button style="width:100px; background-color: #555555;  border: 2px solid; border-radius: 10px;" class="glyphicon glyphicon-hand-up white btn-sub"><br><br>좌석선택</button>
		</div>
		<input id="timeNumHidden" type="hidden" name="timeNum">
	</form>
	</div>
	
<!-- 	<div class="background"> -->
		
<!-- 	</div> -->
	
	<%-- footer 영역  --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<script>
		var movieId;
		var theater;
		var date;
		var sangyoungTime;

		$('.btn-sub').on('click', function(){
			movieId=$('.movie option:selected').val();
			theater=$('.theater option:selected').val();
			date=$('.date option:selected').val();
			sangyoungTime=$('.sangyoungTime option:selected').val();
			
			if(movieId == '' ||movieId==null){
				alert("영화를 선택하세요");
				return false;
			} else if(theater == ''|| theater==null){
				alert("극장을 선택하세요");
				return false;
			} else if(date == '' || date==null){
				alert("날짜를 선택하세요");
				return false;
			} else if(sangyoungTime == '' || sangyoungTime==null){
				alert("상영시간을 선택하세요");
				return false;
			}
		});

		$('.movie option, .theater option, .date option').on('click', function(){
			movieId=$('.movie option:selected').val();
			theater=$('.theater option:selected').val();
			date=$('.date option:selected').val();
			
			if(movieId!=null && theater!=null&&date!=null){

				$.ajax({
					method:'GET',
					url:'/reservation/ajaxGetSangyoungTime',
					data:{movieId:movieId, theater:theater, date:date},
					success:function(data){
						if(data.sangyoungTimeList== 0){
							$('#sangyoungTime').html("<option value=''>상영 영화 없음</option>");
						}else{
							$('#sangyoungTime').find("option").remove();
							
							$(data.sangyoungTimeList).each(function(i){
								$('#sangyoungTime').append("<option style='font-size: 20px; ' class="+i+" value='"+data.sangyoungTimeList[i]+"'>"+data.sangyoungTimeList[i]+"</option>");	
							});
							$(data.sygIdList).each(function(i){
								$('.'+i).append("\t" + data.sygIdList[i]);	
							});
							$(data.remainSeatsList).each(function(i){
								$('.'+i).append("\t" + data.remainSeatsList[i]);
							});				
							$(data.seatsNumList).each(function(i){
								$('.'+i).append("/" + data.seatsNumList[i]);
							});
							$(data.timeNumList).each(function(i){
								//$('.'+i).append("<div style='display: none;'>"+data.timeNumList[i]+"</div>");
								$('.'+i).data('timenum', data.timeNumList[i]);
							});
							
							$('option').on('click', function(){
								$('#timeNumHidden').val($(this).data('timenum'));
							});
						}
					}
				});
			}
		});
	</script>
	
</body>
</html>
