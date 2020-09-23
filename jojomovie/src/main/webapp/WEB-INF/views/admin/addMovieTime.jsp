<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1 user-scalable=no">
<title>조조무비</title>

<link href="/css/bootstrap.css" rel="stylesheet">
<link href="/css/bootstrap-theme.css" rel="stylesheet">
<link href="/css/bootstrap-formhelpers.css" rel="stylesheet">
<link href="/css/admin.css" rel="stylesheet">

<style>
body {
	color: white;
}

div.col-sm-2.text-center {
	color: white;
}
</style>

</head>

<body>
	<!--관리자 페이지 제목  -->
	<%-- top 영역  --%>
	<jsp:include page="/WEB-INF/views/include/adminTop.jsp" />

	<div class="col-md-12" id="mmm5">
		<p>상영시간 등록</p>
	</div>
	<div class="container">
		<form class="form-horizontal" role="form">
			<div class="form-group">
				<div class="btn-group" style="width: 100%">
					<label for="Name" class="col-xs-2 col-lg-2 control-label">영화관
						선택</label>
					<div class="col-xs-10 col-lg-10 theaterName">
						<select name="theaterName" id="theaterName" class="form-control" style="width: 470px; height: 37px;">
							<option>영화관 선택</option>
							<c:forEach var="theaterVo" items="${ theaterVoList }">
								<option value="${ theaterVo.theaterName }">${ theaterVo.theaterName }</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="btn-group" style="width: 100%">
					<label for="Name" class="col-xs-2 col-lg-2 control-label">상영관
						선택</label>

					<div class="col-xs-10 col-lg-10 sygId">
						<select name="sygId" id="sygId" class="form-control" style="width: 470px; height: 37px;">

						</select>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="btn-group" style="width: 100%">
					<label for="Name" class="col-xs-2 col-lg-2 control-label">영화 선택</label>

					<div class="col-xs-10 col-lg-10 movieName">
						<select name="movieId" id="movieId" class="form-control" style="width: 470px; height: 37px;">
							<option>영화 선택</option>
							<c:forEach var="movieVo" items="${ movieVoList }">
								<option value="${ movieVo.movieId }">${ movieVo.movieName }</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="btn-group" style="width: 100%">
					<label for="Name" class="col-xs-2 col-lg-2 control-label">상영시간
						선택</label> <input type="datetime-local"
						style="margin-left: 15px; width: 805px; height: 37px;" class="form-control time">

				</div>
				<div class=" col-xs-offset-9 col-xs-3 col-lg-offset-9 col-lg-3"
					style="margin-top: 30px; margin-bottom: 50px;">
					<input type="button" class="form-control btn-primary btn-add" id="btn-add"
						value="추가하기">
				</div>
				<div class="sangyoungTime">
					<c:forEach var="timeVo" items="${ timeVoList }" varStatus="vs">
						<input type="hidden" class="${ timeVo.timeNum }"
							value="${ timeVo.sangyoungTime }">
						<input type="hidden" id="${ timeVo.timeNum }"
							value="${ timeVo.sygId }">
					</c:forEach>
				</div>
			</div>
		</form>
	</div>

	<script type="text/javascript" src="/script/jquery-3.5.1.js"></script>
	<script type="text/javascript" src="/script/bootstrap.js"></script>
	<script type="text/javascript"></script>
	<script type="text/javascript" src="/script/bootstrap-formhelpers.js"></script>
	<script>
		var timeNum;
		var theaterName;
		var sygId;
		var movieId;
		var date;
		var hour;
		var min;
		$('.btn-add').on('click',function() {
			theaterName = $('#theaterName').val();
			sygId = $('#sygId').val();
			movieId = $('#movieId').val();
			sangyoungTime = $('.time').val();

			if (theaterName == ''|| theaterName=='영화관 선택') {
				alert("영화관 이름을 입력하세요");
				return false;
			} else if (sygId == '' || sygId=='상영관 선택') {
				alert("상영관 번호를 입력하세요");
				return false;
			} else if (movieId == '' || movieId=='영화 선택') {
				alert("영화 제목을 입력하세요");
				return false;
			} else if (sangyoungTime == '') {
				alert("상영 시간을 선택하세요");
				return false;
			}

			for (var i = 1; i <= ${ totalNum +300}; i++) {
				var syt = $('.' + i).val();
				var syg = $('#' + i).val();
				if (syt != null) {

					if (sangyoungTime == syt && syg == sygId) {
						alert('중복되는 상영 시간 입니다.');
						return false;

					}
				}
			}

		$.ajax({
				method : 'POST',
				url : '/ajaxAddTime',
				data : {theaterName : theaterName,sygId : sygId,movieId : movieId,sangyoungTime : sangyoungTime},
				success : function(data) {
					alert("'"+data.Vo.movieName + "' 이(가) 추가되었습니다.");
					$('.sangyoungTime').append('<input type="hidden" class="'+ data.Vo.timeNum +'" value="'+ data.sygTime +'">')
					$('.sangyoungTime').append('<input type="hidden" id="'+ data.Vo.timeNum +'" value="'+ data.Vo.sygId +'">')
					$('.sangyoungTime').append('<div class="show-box"><span>'+ sygId+ '</span><span>'+ sangyoungTime
											+ "</span>  <span>"+ data.Vo.movieName+ "</span><input type='button' style='color:black' data-id='"+sangyoungTime+"' class='btn-del' value='등록 취소'/></div>\t");
				}
			});
		});

		// 동적 이벤트 연결
		$('.sangyoungTime').on('click', '.btn-del', function() {
			var clicked= $(this);
			var str = $(this).prev().prev().html();
			var str2 = $(this).prev().prev().prev().html();

			$.ajax({
				method : 'DELETE',
				url : '/ajaxDelTime',
				data : {str : str,str2 : str2},
				success : function(data) {
					$('.' + data).remove();
					$('#' + data).remove();
					clicked.closest('div.show-box').remove();
					alert('삭제성공');
				}
			});
		});
	</script>
	<script>
		$('.theaterName').on('change',function() {
			var changeTheaterName = $("#theaterName option:selected").val();
			$.ajax({
				method : 'GET',
				url : '/ajaxSelectSygByTheaterName',
				data : {changeTheaterName : changeTheaterName},
				success : function(data) {
					if (data.length == 0) {
						$('#sygId').find("option").remove();
						$('#sygId').append("<option value=''>상영관 없음</option>");
					} else {
						$('#sygId').find("option").remove();
						$(data).each(function(i) {
							$('#sygId').append("<option value='"+data[i]+"'>"+ data[i]+ "</option>");
						});
					}

				}
			});
		});
	</script>
</body>
</html>