<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1 user-scalable=no">
<title>Insert title here</title>
<link href="/css/bootstrap.css" rel="stylesheet">
<link href="/css/bootstrap-formhelpers.css" rel="stylesheet">
<link href="/css/bootstrap-theme.css" rel="stylesheet">
<link href="/css/admin.css" rel="stylesheet">
<style>
body {
	color: white;
}

.seat {
	margin: 233px -85px -227px 0;
}

button {
	color: black;
}
</style>

</head>
<body>
	<%-- top 영역  --%>
	<jsp:include page="/WEB-INF/views/include/adminTop.jsp" />

	<div class="col-md-12" id="mmm4">
		<p>상영관 등록</p>
	</div>

	<div class="container">
		<form action="/admin/addSangyounggwan" method="post"
			class="form-horizontal frm" role="form" name="frm"
			style="margin: 0 auto;">
			<div class="form-group">
				<div class="btn-group" style="width: 100%">
					<label for="theaterId" class="col-md-5 control-label">영화관ID</label>

					<div class="col-md-7 theaterId">
						<select name="theaterId" id="theaterId" class="form-control"
							style="height: 37px; margin-left: 6px;">
							<option>영화관 선택</option>
							<c:forEach var="theaterVo" items="${ theaterVoList }">
								<option value="${ theaterVo.theaterId }">${ theaterVo.theaterId }</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="btn-group" style="width: 100%">
					<label for="theaterName" class="col-md-5 control-label">영화관 선택</label>
					<div class="col-md-7 theaterName">
						<select name="theaterName" id="theaterName" class="form-control"style="height: 37px; margin-left: 6px;">
						</select>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label for="sygId" class="col-md-5 control-label">상영관 번호</label>
				<div class="col-md-7">
					<input id="sygId" name="sygId" type="text" style="height: 37px; margin-left: 6px;" class="form-control" placeholder="ex) 서면점 1관, 사상점 2관 ..">
				</div>
			</div>
			<div class="col-md-12">
				<div class="btn-group" style="width: 100%">
					<label for="row" class="col-md-5 control-label">행</label>
					<div id="row" class="col-md-7 bfh-selectbox" data-name="row">
						<div data-value="1" class="row">1</div>
						<div data-value="2" class="row">2</div>
						<div data-value="3" class="row">3</div>
						<div data-value="4" class="row">4</div>
						<div data-value="5" class="row">5</div>
					</div>
					<label for="cul" class="col-md-5 control-label">열</label>
					<div id="cul" class="col-md-7 bfh-selectbox" data-name="cul">
						<div data-value="1" class="cul">1</div>
						<div data-value="2" class="cul">2</div>
						<div data-value="3" class="cul">3</div>
						<div data-value="4" class="cul">4</div>
						<div data-value="5" class="cul">5</div>
						<div data-value="6" class="cul">6</div>
						<div data-value="7" class="cul">7</div>
						<div data-value="8" class="cul">8</div>
					</div>
				</div>
			</div>
			<div class="col-md-12"
				style="text-align: center; margin-left: 42px; margin-top: 48px; margin-bottom: -41px;">
				<input type="button" class="form-control btn-mary make-seat" value="좌석표 생성하기">
			</div>
			<div class="seat" align="center"></div>
			<div>
				<div class="col-md-12"
				style="text-align: center; margin-left: 42px; margin-top: 48px;" style="margin-bottom: 50px;">
					<input type="submit" class="form-control btn-mary2" value="추가하기" id="btnAdd">
				</div>
			</div>
			<c:forEach var="sangyounggwanVo" items="${ sangyounggwanVoList }" varStatus="vs">
				<input type="hidden" class="${ vs.count }" value="${ sangyounggwanVo.sygId }">
			</c:forEach>
		</form>
	</div>



	<script type="text/javascript" src="/script/jquery-3.5.1.js"></script>
	<script type="text/javascript" src="/script/bootstrap.js"></script>
	<script type="text/javascript" src="/script/bootstrap-formhelpers.js"></script>
	<script>
		var seatData;

		$('#btnAdd').on('click', function() {
			var theaterId = $('#theaterId').val();
			var theaterName = $('#theaterName').val();
			var sygId = $('#sygId').val();
			var row = $('#row').val();
			var cul = $('#cul').val();

			if (theaterId == '') {
				alert("영화관 코드를 입력하세요");
				return false;
			} else if (theaterName == '') {
				alert("영화관 이름 입력하세요");
				return false;
			} else if (sygId == '') {
				alert("상영관 번호를 입력하세요");
				return false;
			} else if (row == '') {
				alert("행을 선택하세요");
				return false;
			} else if (cul == '') {
				alert("열을 선택하세요");
				return false;
			}

			for (var i = 1; i <= ${ totalNum+100 }; i++) {
				var text = $('.' + i).val();
				if (text != null) {
					if ($('#sygId').val() == text) {
						console.log(text);
						alert('이미 사용중인 상영관 입니다.');
						return false;
					}
				} else {
					var sygId = $('#sygId').val();
					console.log(sygId);
					alert(sygId + '이 추가되었습니다.');
					return true;
				}
			}
		});

		$('.make-seat').on('click', function() {
			var row = $('input[name="row"]').val();
			var cul = $('input[name="cul"]').val();

			var str = "";
			var cnt = 1;
			var seat = "";
			var hang = 'A';

			if (row == '') {
				alert("행을 선택하세요");
				return false;
			} else if (cul == '') {
				alert("열을 선택하세요");
				return false;
			}

			for (var i = 1; i <= row; i++) {

				for (var j = 1; j <= cul; j++) {
					
					str += "<button style='width:40px; margin-bottom:1px;'>"+hang+j+"</button> \t";
					seat = hang + "" + j;
					cnt++;
				}
				str += "<br>";
				var charCode = hang.charCodeAt(0);
				charCode++;
				hang = String.fromCharCode(charCode);
			}
			$('.seat').html(str);
		});

		$('.theaterId').on('change', function() {
			var changeTheaterId = $("#theaterId option:selected").val();
			console.log(changeTheaterId);
			$.ajax({
				method : 'GET',
				url : '/admin/ajaxSelectTherterNameByTheaterId',
				data : {changeTheaterId : changeTheaterId},
				success : function(data) {
					if (data.length == 0 || data == null) {
						$('#theaterName').find("option").remove();
						$('#theaterName').append("<option value=''>선택</option>");
					} else {
						$('#theaterName').find("option").remove();
						$('#theaterName').append("<option value='"+data+"'>"+ data+ "</option>");
					}
				}
			});
		});
	</script>
</body>
</html>