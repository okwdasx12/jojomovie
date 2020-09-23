<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/css/bootstrap.css" rel="stylesheet">
<link href="/css/bootstrap-theme.css" rel="stylesheet">
<link href="/css/admin.css" rel="stylesheet">
<link rel="shortcut icon" href="#">
</head>
<body>
	
	
	<button type="button" value="상영중" id="nowMovie">상영중</button>	


	<canvas id="myChart"></canvas>	<!--차트  -->
	
	<script type="text/javascript" src="/script/jquery-3.5.1.js"></script>
	<script type="text/javascript" src="/script/bootstrap.js"></script>
	<script type="text/javascript"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script> <!-- 차트! -->
		
	<script>

	var now = $('#nowMovie').attr('value');	 // 상영중
	var end = $('#endMovie').attr('value');	// 상영종료
	var future = $('#futureMovie').attr('value');//상영예정


	var arrayLike= new Array();
	var arrayScore= new Array();

	
	$('#nowMovie').click(function() {
		$.ajax({
			type: 'GET',
			url : '/chartTest/' + now ,
			success : function(result){
				console.log(result);

				drawChart(result.movieNameList, result.likeCntList, result.scoreList);
				
			}, //success
			error : function(){
				alert("데이터 값이 넘어가지지 않았습니다.");
			}
		});

	});


	function drawChart(movieNames, likeCnts, scores) {
		var ctx = document.getElementById('myChart').getContext('2d');
		var myChart = new Chart(ctx, {
		    type: 'bar',
		    data: {
		        labels: movieNames,
		        datasets: [{
		            label: '좋아요',
		            data: likeCnts,
		            backgroundColor:'rgba(54, 162, 235, 0.2)',
		            borderColor: 'rgba(54, 162, 235, 1)',
		            borderWidth: 1
		        },
		        {
		            label: '평점',
		            data: scores,
		            backgroundColor: 'rgba(255, 206, 86, 0.2)',
		            borderColor: 'rgba(255, 206, 86, 1)',
		            borderWidth: 1
		        }]
		    },
		    options: {
		        scales: {
		            yAxes: [{
		                ticks: {
		                    beginAtZero: true
		                }
		            }]
		        }
		    }
		});

	} // drawChart

	</script>

	

</body>
</html>