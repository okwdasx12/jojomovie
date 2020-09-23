<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="javatime" uri="http://sargue.net/jsptags/time"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1 user-scalable=no">
<title>조조무비 - 마이페이지</title>
<link href="/css/bootstrap.css" rel="stylesheet">
<link href="/css/bootstrap-theme.css" rel="stylesheet">
</head>
<style>
.modal-body input {
	border: none;
}
#myModalLabel {
	color: white;
}
</style>
<body>
	<%-- top 영역  --%>
	<jsp:include page="/WEB-INF/views/include/top.jsp" />

	<div class="container" id="my">
		<div class="col-md-5" id="my2">
			<img alt="" src="/images/멤버.png"><a>마이 페이지</a>
		</div>
		<div class="container table-responsive" align="center">
			<table class="table mypage-table">
				<thead>
					<tr>
						<th>포인트</th>
						<th>대기 중 예매</th>
						<th>지난 예매</th>
						<th>등급</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>${ memberVo.point }</td>
						<td>${ reserveList.size() }</td>
						<td>${ reservePreList.size() }</td>
						<td>${ memberVo.grade }</td>
					</tr>
				</tbody>
			</table>
		</div>
		<br>

		<div class="container row wrap-mycon" id="myTab">
			<div class="mycon col-xs-6 col-sm-3" align="center">
				<a href="#reservation" data-toggle="tab" onclick="first()">예매 내역</a>
			</div>
			<div class="mycon col-xs-6 col-sm-3" align="center">
				<a href="#inquire" data-toggle="tab">1:1 문의</a>
			</div>
			<div class="mycon col-xs-6 col-sm-3" align="center">
				<a href="#update" data-toggle="tab">개인정보 수정</a>
			</div>
			<div class="mycon col-xs-6 col-sm-3" align="center">
				<a href="#delete" data-toggle="tab">회원 탈퇴</a>
			</div>
		</div>

		<br>

		<div class="tab-content col-sm-offset-1 col-sm-10" align="center">
			<div class="tab-pane" id="reservation">
				<div class="form-group table-responsive">
					<h3>관람 대기 예매 내역</h3>
					<table class="table mypage-table table-striped">
						<thead>
							<tr>
								<th>영화제목</th>
								<th>영화관</th>
								<th>상영관</th>
								<th>좌석</th>
								<th>상영일</th>
								<th>결제 여부</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${ reserveList.size() gt 0 }">
								<c:forEach var="reserve" items="${ reserveList }">
									<tr>
										<td>${ reserve.movieName }</td>
										<td>${ reserve.theaterName }</td>
										<td>${ reserve.sygId }</td>
										<td>${ reserve.seat }</td>
										<td>
											<javatime:format value="${ reserve.sangyoungTime }" pattern="yyyy.MM.dd / HH:mm"/>
										</td>
										<td>
											<c:if test="${ reserve.tf eq 't' }">
												결제 완료
											</c:if>
											<c:if test="${ reserve.tf eq 'f' }">
												미 결제
											</c:if>
										</td>
										<td>
											<button type="button" class="btn reserve-info" data-num="${ reserve.reserveNumber }" data-toggle="modal" data-target="#reservationModal">상세 정보</button>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${ reserveList.size() eq 0 }">
								<tr>
									<td colspan="7">예매 내역이 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>

					<h3>지난 예매 내역</h3>
					<table class="table mypage-table table-striped">
						<thead>
							<tr>
								<th>영화제목</th>
								<th>영화관</th>
								<th>상영관</th>
								<th>좌석</th>
								<th>상영일</th>
								<th>결제 여부</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${ reservePreList.size() gt 0 }">
								<c:forEach var="reservePre" items="${ reservePreList }">
									<tr>
										<td>${ reservePre.movieName }</td>
										<td>${ reservePre.theaterName }</td>
										<td>${ reservePre.sygId }</td>
										<td>${ reservePre.seat }</td>
										<td>
											<javatime:format value="${ reservePre.sangyoungTime }" pattern="yyyy.MM.dd / HH:mm"/>
										</td>
										<td>
											<c:if test="${ reservePre.tf eq 't' }">
												결제 완료
											</c:if>
											<c:if test="${ reservePre.tf eq 'f' }">
												미 결제
											</c:if>
										</td>
										<td>
											<button type="button" class="btn reserve-info" data-num="${ reservePre.reserveNumber }" data-toggle="modal" data-target="#reservationModal">상세 정보</button>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${ reservePreList.size() eq 0 }">
								<tr>
									<td colspan="7">지난 예매 내역이 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
					<button type="button" class="btn btn-inquire" onclick="location.href='/reservation/'">예매 하러가기</button>
				</div>
			</div>

			<div class="tab-pane" id="inquire">
				<div class="form-group table-responsive">
					<h3>문의 내역</h3>
					<table class="table mypage-table">
						<thead>
							<tr>
								<th>작성한 문의</th>
								<th>진행 중인 문의</th>
								<th>진행 완료 문의</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>${ pageDto.total }</td>
								<td>${ pageDto.ing }</td>
								<td>${ pageDto.fin }</td>
							</tr>
						</tbody>
					</table>
					<button type="button" class="btn btn-inquire" onclick="location.href='/inquire/'">1:1 문의 하러가기</button>
				</div>
			</div>

			<br> <br>

			<div class="tab-pane" id="update" align="center">
				<form action="/mypage/update" method="post" id="updateFrm"
					class="form-horizontal" name="updateFrm" onsubmit="return check();"
					style="display: inline-block;">
					<div class="form-group">
						<label for="userId" class="col-xs-4 col-sm-3 control-label">아이디</label>
						<div class="col-xs-8 col-sm-7">
							<input type="text" id="userId" class="form-control" name="userId" readonly value="${ sessionScope.userId }" style="margin-left: 0px;">
						</div>
					</div>

					<div class="form-group">
						<label for="updatePasswd" class="col-xs-4 col-sm-3 control-label">비밀번호</label>
						<div class="col-xs-8 col-sm-7">
							<input type="password" id="passwd" name="passwd" class="form-control" placeholder="비밀번호를 입력하세요">
						</div>
					</div>

					<div class="form-group">
						<label for="updatePasswd2" class="col-xs-4 col-sm-3 control-label"
							style="padding-left: 0px;">비밀번호 확인</label>
						<div class="col-xs-8 col-sm-7">
							<input type="password" id="passwd2" name="passwd2" class="form-control" placeholder="비밀번호를 한 번 더 입력하세요">
						</div>
					</div>

					<div class="form-group">
						<span id="passwdDupMessage"></span>
					</div>

					<div class="form-group">
						<label for="name" class="col-xs-4 col-sm-3 control-label">이
							름</label>
						<div class="col-xs-8 col-sm-7">
							<input type="text" id="name" class="form-control" name="name" value="${ memberVo.name }">
						</div>
					</div>

					<div class="form-group">
						<label for="birthday" class="col-xs-4 col-sm-3 control-label">생년월일</label>
						<div class="col-xs-8 col-sm-7">
							<input type="date" id="birthday" class="form-control" name="birthday" value="${ memberVo.birthday }">
						</div>
					</div>

					<div class="form-group">
						<label for="userEmail" class="col-xs-4 col-sm-3 control-label">이메일</label>
						<div class="col-xs-8 col-sm-7" id="email" style="display: flex;">
							<input type="email" id="userEmail" class="form-control" name="userEmail" value="${ memberVo.userEmail }">
							<button type="button" class="btn btn-default" onclick="emailCheck()" style="height: 34px;">이메일인증</button>
						</div>
					</div>
					<div class="form-group">
						<label for="userAddr" class="col-xs-4 col-sm-3 control-label">주소</label>
						<div class="col-xs-8 col-sm-7">
							<input type="text" id="userAddr" class="form-control" name="userAddr" value="${ memberVo.userAddr }">
						</div>
					</div>

					<div class="form-group">
						<label for="phone" class="col-xs-4 col-sm-3 control-label">연락처</label>
						<div class="col-xs-8 col-sm-7">
							<input type="text" id="phone" class="form-control" name="phone" value="${ memberVo.phone }">
						</div>
					</div>


					<div class="form-group">
						<div class="col-xs-12 col-sm-12" style="text-align: end; margin-top: 26px;">
							<button type="submit" class="btn btn-default">회원 정보 수정</button>
						</div>
					</div>
				</form>
			</div>

			<br> <br>

			<div class="tab-pane" id="delete" align="center">
				<form action="/mypage/delete" method="post" id="deleteFrm" class="form-horizontal" name="deleteFrm" onsubmit="return delCheck()">
					<div class="form-group" style="display: inline-block;">
						<label for="deletePasswd" class="col-xs-4 col-sm-3 control-label">비밀번호</label>
						<div class="col-xs-8 col-sm-7" align="center">
							<input id="deletePasswd" name="deletePasswd" type="password" class="form-control" placeholder="비밀번호를 입력하세요">
						</div>
					</div>
					<div class="form-group">
						<div class="col-md-9 col-offset-md-3 col-sm-7" style="text-align: end;">
							<button type="submit" class="btn btn-default">회원 탈퇴</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- 모달  -->
	<form action="/mypage/delReserve" name ="test1" method="post">
		<div class="modal fade" id="reservationModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header" style="background-color: black;">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">×</span>
						</button>
						<h4 class="modal-title text-center" id="myModalLabel" >예매 확인</h4>
					</div>
					<div class="modal-body">
						<div class="row">
							<div class="col-sm-3 col-sm-offset-3 col-xs-offset-1 col-xs-4">영화명</div>
							<div class="col-sm-6 col-xs-5" class="modal-div" id="modalMovieNameDiv"></div>
						</div>
						<div class="row">
							<div class="col-sm-3 col-sm-offset-3 col-xs-offset-1 col-xs-4">지점</div>
							<div class="col-sm-6 col-xs-5" class="modal-div" id="modalTeatherNameDiv"></div>
						</div>
						<div class="row">
							<div class="col-sm-3 col-sm-offset-3 col-xs-offset-1 col-xs-4">상영관</div>
							<div class="col-sm-6 col-xs-5" class="modal-div" id="modalSygIdDiv"></div>
						</div>
						<input type="hidden" name="sangyoungTime" value="" />
						<div class="row">
							<div class="col-sm-3 col-sm-offset-3 col-xs-offset-1 col-xs-4">상영일</div>
							<div class="col-sm-6 col-xs-5" class="modal-div" id="modalSangyoungDateDiv"></div>
						</div>
						<div class="row">
							<div class="col-sm-3 col-sm-offset-3 col-xs-offset-1 col-xs-4">상영시간</div>
							<div class="col-sm-6 col-xs-5" class="modal-div" id="modalSangyoungTimeDiv"></div>
						</div>
						<div class="row">
							<div class="col-sm-3 col-sm-offset-3 col-xs-offset-1 col-xs-4">좌석</div>
							<div class="col-sm-6 col-xs-5" class="modal-div" id="modalSeatDiv"></div>
						</div>
						<hr>
						<div class="row">
							<h4 class="modal-title text-center">결제 금액</h4>
							<br>
						</div>
						<div class="row">
							<div class="col-sm-3 col-sm-offset-3 col-xs-offset-1 col-xs-5">사용 포인트</div>
							<div class="col-sm-1 col-xs-1">:</div>
							<div class="col-sm-5 col-xs-5" class="modal-div" id="modalUsePointDiv"></div>
						</div>
						<div class="row">
							<div class="col-sm-3 col-sm-offset-3 col-xs-offset-1 col-xs-5">총 결제 금액</div>
							<div class="col-sm-1 col-xs-1">:</div>
							<div class="col-sm-5 col-xs-5" class="modal-div" id="modalTotalPriceDiv"></div>
						</div>
					</div>
					<div class="modal-footer">
						<input type="hidden" name="reserveNumber" id="modalReserveNumberHidden" value="">
						<input type="hidden" name="payId" id="modalPayIdHidden" value="">
						<button type="submit" class="btn btn-primary btn-sub">예매 취소</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
					</div>
				</div>
			</div>
		</div>
	</form>

	<%-- footer 영역  --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

	<script>
		// 비밀번호 확인
		var passwd = document.getElementById('passwd');
		var passwd2 = document.getElementById('passwd2');
		var delPasswd = document.getElementById('deletePasswd');
		
		$('input[name="passwd"]').keyup(
			function(event) {
				if (passwd.value == "") {
					$('span#passwdDupMessage').html('패스워드를 입력하세요.').css('color', 'red');
				} else if (passwd.value != passwd2.value) {
					$('span#passwdDupMessage').html('패스워드 불일치..').css('color', 'red');
				} else {
					$('span#passwdDupMessage').html('패스워드 일치함!!').css('color', 'green');
				}
			});
		$('input[name="passwd2"]').keyup(
			function(event) {
				if (passwd.value != passwd2.value) {
					$('span#passwdDupMessage').html('패스워드 불일치..').css('color', 'red');
				} else {
					$('span#passwdDupMessage').html('패스워드 일치함!!').css('color', 'green');
				}
			});

		// .tap-pane영역 active 관련 버튼 클릭 이벤트
		$('div.mycon a').on('click', function() {
			$(this).closest('div.wrap-mycon').find('a').removeClass('btn-d');
			$(this).addClass('btn-d');
		});

		// 예매 정보 모달 창 띄우기
		$('button.reserve-info').on('click', function() {
			var reserveNumber = $(this).data("num");
			$.ajax({
				method :'GET',
				url :'/mypage/reserveInfo',
				data : {reserveNumber:reserveNumber},
				success : function(data){
					$('#modalMovieNameDiv').html(data.movieName);
					$('#modalTeatherNameDiv').html(data.teatherName);
					$('#modalSygIdDiv').html(data.sygId);
					$('#modalSangyoungDateDiv').html(data.sangyoungDate);
					$('#modalSangyoungTimeDiv').html(data.sangyoungTime);
					$('#modalSeatDiv').html(data.seat);
					$('#modalUsePointDiv').html(data.usePoint);
					$('#modalTotalPriceDiv').html(data.totalPrice);
					$('#modalReserveNumberHidden').val(reserveNumber);
					$('#modalPayIdHidden').val(data.payId);
				}
			});
		})
		
		// 회원 정보 수정 유효성 검사
		function check() {
			if (passwd.value == '') {
				alert('비밀번호를 입력하세요.');
				passwd.focus();
				return false;
			} else if (passwd2.value != passwd.value) {
				alert('비밀번호를 확인해주세요.');
				passwd2.focus();
				return false;
			} else if (updateFrm.name.value == '') {
				alert('이름을 입력하세요.');
				updateFrm.name.focus();
				return false;
			} else if (updateFrm.birthday.value == '') {
				alert('생년월일을 입력하세요.');
				updateFrm.birthday.focus();
				return false;
			} else if (updateFrm.email.value == '') {
				alert('이메일을 입력하세요.');
				updateFrm.email.focus();
				return false;
			} else if (updateFrm.userAddr.value == '') {
				alert('주소를 입력하세요.');
				updateFrm.userAddr.focus();
				return false;
			} else if (updateFrm.phone.value == '') {
				alert('연락처를 입력하세요.');
				updateFrm.phone.focus();
				return false;
			} else {
				var isUpdate = confirm('입력하신 내용으로 수정 하시겠습니까?');
				if (!isUpdate) {
					return false;
				} else {
					return true;
				}
			}
		}

		// 탈퇴 확인하기
		function delCheck() {
			var password = '${memberVo.passwd}';
			
			if ( delPasswd.value == '') {
				alert('비밀번호를 입력하세요.');
				delPasswd.focus();
				return false;
			} else if ( delPasswd.value != password) {
				alert('비밀번호를 확인해주세요.');
				delPasswd.focus();
				return false;
			}
			
			var isDel = confirm('탈퇴 하시겠습니까?');
	
			if (!isDel) {
				return false;
			} else {
				return true;
			}
		}

		// #myTab 첫 화면 띄우기
		$('#myTab a:first').tab('show')
	</script>
</body>
</html>
