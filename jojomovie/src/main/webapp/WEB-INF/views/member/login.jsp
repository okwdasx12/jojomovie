<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<body>

	<%-- top 영역  --%>
	<jsp:include page="/WEB-INF/views/include/top.jsp" />

	<div class="container-fluid" id="login">

		<!-- 로그인 -->
		<div class ="loginForm" align="center">
		<h2>로그인</h2><div class="s"></div>
		<form action="/member/login" method="post" id="join" name="frm"  >
			<div class="form-group">
				<label for="id"> 아이디 </label> 
				<input type="text" id="userId" name="userId" class="form-control">
			</div>
			<div class="form-group">
				<label for="password"> 비밀번호 </label> 
				<input type="password" id="passwd"name="passwd"  class="form-control">
			</div>
			<div class="form-group">
				<input type="checkbox" name="keepLogin" value="true" id="keepLogin">
				<label for="keepLogin"> 로그인 상태 유지 </label>
			</div>
			<div class="form-group">
				<button type="submit" class="btn log" class="submit">로그인</button>
			</div>
			<div class="form-group" id="find">
				<a href="#findIdModal" data-toggle="modal"> 아이디 찾기/ </a>
				<a href="#findPasswdModal" data-toggle="modal"> 비밀번호 찾기/ </a> 
				<a href="/member/join"> 회원가입</a>
			</div>
			<div class="ss2"></div>
		</form>
		</div>
	</div>
	<!-- container-fluid 끝  -->

	<!-- 아이디찾기 모달 -->
	<div class="modal fade" id="findIdModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="findIdModalLabel">아이디 찾기</h4>
				</div>
				<div class="modal-body findId">
					<form role="form">
						<div class="form-group">
							<label>이름</label>
						    <input type="text" id="findName" class="form-control" placeholder="이름을 입력하세요.">
						</div>
						<div class="form-group">
							<label>휴대전화</label>
						    <input type="text" id="findPhone" class="form-control" placeholder="전화번호를 입력하세요.">
						</div>
						<button type="button" id="findIdBtn" class="btn btn-default" data-dismiss="modal">아이디 찾기</button>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</div>
			<!-- 모달 콘텐츠 -->
		</div>
		<!-- 모달 다이얼로그 -->
	</div>
	<!-- 모달 전체 윈도우 -->
	
	<!-- 비밀번호찾기 모달 -->
	<div class="modal fade" id="findPasswdModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="findPasswdModalLabel">비밀번호 찾기</h4>
				</div>
				<div class="modal-body findPasswd">
					<form role="form">
						<div class="form-group">
							<label>아이디</label>
						    <input type="text" id="findId" class="form-control" placeholder="아이디를 입력하세요.">
						</div>
						<div class="form-group">
							<label>이메일</label>
						    <input type="text" id="findEmail" class="form-control" placeholder="이메일을 입력하세요.">
						</div>
						<button type="button" id="findPasswdBtn" class="btn btn-default" data-dismiss="modal">비밀번호 찾기</button>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</div>
			<!-- 모달 콘텐츠 -->
		</div>
		<!-- 모달 다이얼로그 -->
	</div>
	<!-- 모달 전체 윈도우 -->


	<%-- footer영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script type="text/javascript" src="/script/jquery-3.5.1.js"></script>
	<script type="text/javascript" src="/script/bootstrap.js"></script>
	<script>

	<!--아이디 찾기 -->
	$('.findId').on('click','#findIdBtn', function(){ 
		var userName = $('#findName').val();
		var userPhone = $('#findPhone').val();

		if (userName == '') {
			alert('이름을 입력하세요.');
			document.getElementById("findName").focus();
			return false;
			}
		if (userPhone == '') {
			alert('전화번호를 입력하세요.');
			document.getElementById("findPhone").focus();
			return false;
			}

		$.ajax({
			method:'GET',
			url: '/member/findId',
			data: {userName : userName, userPhone : userPhone},
			success: function(data) {

 				if(data == '') {

				 alert('일치하는 정보가 없습니다.');

				 return true;
				 	 
				}else{ 
				 alert('회원님의 아이디는 ' + data + '입니다.');
				 document.getElementById("userId").value = data;
				 document.getElementById("passwd").focus();
				} 
			}, 
				error : function() {
					alert('아이디 찾기 실패...');
				}
			});
		});// 아이디 찾기 버튼
	
		$('#findIdModal').on('hidden.bs.modal', function (e){
			$(".modal-body input").val("");
			});
		</script>
		<script>
		<!--비밀번호 찾기 -->
		
		$('.findPasswd').on('click','#findPasswdBtn', function(){ 
			var userId = $('#findId').val();
			var userEmail = $('#findEmail').val();

			var ranPasswdNum = Math.floor(Math.random() * 1000000)+100000;
			
			if(ranPasswdNum > 1000000){
				ranPasswdNum = ranPasswdNum - 100000;
			}

			if (userId == '') {
				alert('아이디를 입력하세요.');
				document.getElementById("findId").focus();
				return false;
				}
			
			if (userEmail == '') {
				alert('이메일을 입력하세요.');
				document.getElementById("findEmail").focus();
				return false;
				}

			$.ajax({
				method:'GET',
				url: '/member/findPasswd',
				data: {userId : userId, userEmail : userEmail, ranPasswdNum:ranPasswdNum},
				success: function(data) {
	 				if(data == false) {
					 alert('일치하는 정보가 없습니다.');
					} else { 
					 alert('해당 이메일로 임시번호를 발급했습니다. 메일을 확인해주세요.');
						} 
					}, 
					error : function() {
						alert('아이디 찾기 실패...');
						}
				});
		}); // 비밀번호찾기 버튼 

		$('#findPasswdModal').on('hidden.bs.modal', function (e){
         	$(".modal-body input").val("");
         });
	</script>
</body>
</html>
