<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<style>
.join {
	padding-top: 30px;
}
</style>
<head>
<body>

	<%-- top 영역  --%>
	<jsp:include page="/WEB-INF/views/include/top.jsp" />


	<div class="container" id="join">
		<div class="col-md-12">
			<h2>회원가입</h2>
			<div class="join">
				<div class="joinForm">
					<form class="form-horizontal" role="form" id="join" action="/member/join" method="post" name="frm" onsubmit="return validate()">
						<label style="margin-left: -14px;">아이디</label>
						<div class="form-group">
							<div class="input-group col-sm-4" id="iid">
								<span class="input-group-addon" id="iid2"> <span
									class="glyphicon glyphicon-user"> </span>
								</span> 
								<input type="text" name="userId" id="userId" class="form-control" placeholder="아이디를 입력하세요">
							</div>
							<button type="button" class="btn btn-in dup" onclick="winopen()">아이디중복확인</button>
						</div>
						<div class="form-group">
							<label>비밀번호</label>
							<div class="input-group col-sm-4 ">
								<span class="input-group-addon"> <span
									class="glyphicon glyphicon-lock"> </span>
								</span> 
								<input type="password" name="passwd" id="passwd" class="form-control" placeholder="비밀번호를 입력하세요">
							</div>
						</div>

						<div class="form-group">
							<label>비밀번호 확인</label>
							<div class="input-group col-sm-4">
								<span class="input-group-addon"> 
									<span class="glyphicon glyphicon-lock"></span>
								</span> 
								<input type="password" name="passwdCheck" id="passwdCheck" class="form-control" placeholder="비밀번호 확인">
							</div>
							<span id="passwdDupMessage"></span>
						</div>

						<div class="form-group">
							<label>성함</label>
							<div class="input-group col-sm-4">
								<span class="input-group-addon"> <span
									class="glyphicon glyphicon-user"> </span>
								</span> 
								<input type="text" name="name" id="name" class="form-control" placeholder="이름을 입력하세요.">
							</div>
						</div>

						<div class="form-group auth">
							<label class="emailCheck">이메일</label>
							<div class="createEmailSpan" id="createEmailSpan"></div>
							<div class="input-group col-sm-4">
								<span class="input-group-addon"> 
								 <span class="glyphicon glyphicon-user"></span>
								</span>
								<input type="email" name="userEmail" id="userEmail" class="form-control">
							</div>
							<button type="button" class="btn btn-in" id="emailBtn">인증번호전송</button>
						</div>
						
						<div class="form-group">
							<label>생년월일</label>
							<div class="input-group col-sm-4">
								<span class="input-group-addon"> 
									<span class="glyphicon glyphicon-user"></span>
								</span> 
								<input type="date" name="birthday" id="birthday" class="form-control" min="0" max="150">
							</div>
						</div>

						<div class="form-group">
							<label>주소</label>
							<div class="input-group col-sm-4">
								<input type="hidden" id="userAddr" name="userAddr">
								<input type="text" id="userZipCode" name="userZipCode" class="form-control" readonly="readonly">
								<button type="button" class="btn btn-in" onclick="execDaumPostcode()">우편번호 찾기</button>

								<input type="text" id="userFirstAddr" name="userFirstAddr" class="form-control" readonly="readonly"> 
								<input type="text" id="userSecondAddr" name="userSecondAddr" class="form-control" placeholder="상세주소를 입력하세요."> 
								<input type="text" id="userExtraAddr" name="userExtraAddr" class="form-control" placeholder="참고 항목" readonly="readonly">
							</div>
						</div>

						<div class="form-group">
							<label>휴대전화</label>
							<div class="input-group col-sm-4">
								<span class="input-group-addon"> <span
									class="glyphicon glyphicon-earphone"> </span>
								</span> 
							<input type="text" name="phone" id="phone" class="form-control" placeholder="휴대전화번호를 입력하세요.">
							</div>
						</div>
						<div class="form-group">
							<input type="hidden" name="point" id="point" value="1000">
							<input type="hidden" name="grade" id="grade" value="일반">
							<input type="hidden" name="userIdCheck" id="userIdCheck" value="">
							<input type="hidden" name="emailAuthCheck" id="emailAuthCheck" value="">
						</div>
						<div class="form-group">
							<div class="col-md-4 col-offset-md-8" id="reset">
								<input type="submit" class="btn btn-s" value="회원가입" onclick="sum()"> <input type="reset" class="btn btn-s" value="다시쓰기" class="cancel">
							</div>
						</div>
					</form>
				</div>
			</div>
			<!-- 로그인폼 -->
		</div>
	</div>

	<!-- container-fluid 끝  -->

	<%-- footer영역 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script type="text/javascript" src="/script/jquery-3.5.1.js"></script>
	<script type="text/javascript" src="/script/bootstrap.js"></script>
	<script src="/script/bootstrap-formhelpers.js"></script>
	<script type="text/javascript"></script>
	<script>
		// 비밀번호 일치 확인
		var passwd = document.getElementById('passwd');
		var passwd2 = document.getElementById('passwdCheck');
		var spanMessage = document.getElementById('passwdDupMessage');

		passwd2.onkeyup = function() {

			if (passwd.value != passwdCheck.value) {
				spanMessage.style.color = "red";
				spanMessage.innerHTML = '비밀번호가 일치하지 않습니다. 다시 확인해 주세요.';
			} else {
				spanMessage.style.color = "green";
				spanMessage.innerHTML = '비밀번호가 일치합니다.!!!';
			}
		};

		// 중복확인 버튼 클릭 시 새 창 오픈
		function winopen() {
			var dupId = document.frm.userId.value;

			if (dupId == '') {
				alert('아이디를 입력하세요');
				document.frm.userId.focus();
				return;
			}

			// 새창 열어서 jsp요청   window.open()
			open('/member/joinIdDupCheck?userId=' + dupId, 'dupCheck', 'width=400,height=200');
		}
	</script>

	<script>
		function validate() {

			var valUserId = document.getElementById("userId");
			var valPasswd = document.getElementById("passwd");
			var valPasswdCheck = document.getElementById("passwdCheck");
			var valName = document.getElementById("name");
			var valUserEmail = document.getElementById("userEmail");
			var valEmailAuth = document.getElementById("emailAuth")
			var valBirthday = document.getElementById("birthday");
			var valUserZipCode = document.getElementById("userZipCode");
			var valUserFirstAddr = document.getElementById("userFirstAddr");
			var valUserSecondAddr = document.getElementById("userSecondAddr");
			var valPhone = document.getElementById("phone");
			var valUserIdCheck = document.getElementById("userIdCheck");
			var valEmailAuthCheck = document.getElementById("emailAuthCheck")

			if ((valUserId.value) == "") {
				alert("아이디를 입력하지 않았습니다.");
				valUserId.focus();
				return false;
			} else if ((valPasswd.value) == "") {
				alert("비밀번호를 입력하지 않았습니다.");
				valPasswd.focus();
				return false;
			} else if ((valPasswdCheck.value) == "") {
				alert("비밀번호확인을 입력하지 않았습니다.");
				valPasswdCheck.focus();
				return false;
			} else if ((valName.value) == "") {
				alert("이름을 입력하지 않았습니다.");
				valName.focus();
				return false;
			} else if ((valUserEmail.value) == "") {
				alert("이메일을 입력하지 않았습니다.");
				valUserEmail.focus();
				return false;
			} else if ((valBirthday.value) == "") {
				alert("생년월일을 입력하지 않았습니다.");
				valBirthday.focus();
				return false;
			} else if ((valUserZipCode.value) == "") {
				alert("주소를 입력하지 않았습니다.");
				valUserZipCode.focus();
				return false;
			} else if ((valUserFirstAddr.value) == "") {
				alert("주소를 입력하지 않았습니다.");
				valUserFirstAddr.focus();
				return false;
			} else if ((valUserSecondAddr.value) == "") {
				alert("상세주소를 입력하지 않았습니다.");
				valUserSecondAddr.focus();
				return false;
			} else if ((valPhone.value) == "") {
				alert("전화번호를 입력하지 않았습니다.");
				valPhone.focus();
				return false;
			} else if ((valUserIdCheck.value) == "") {
				alert("아이디 중복을 확인해주세요");
				valUserId.focus();
				return false;
			} else if ((valEmailAuthCheck.value) == "") {
				alert("이메일 인증을 완료해주세요.");
				valUserEmail.focus();
				return false;
			} else if ((valPasswd.value) != (valPasswdCheck.value)) {
				alert("비밀번호가 일치하지않습니다.");
				valPasswd.focus();
				return false;

			} else {
				return true;
			}
		}
	</script>

	<!--이메일 합치기 -->
	<script>
		function sum() {
			var userFirstAddr = document.frm.userFirstAddr.value;
			var userSecondAddr = document.frm.userSecondAddr.value;
			var userAddr = userFirstAddr + ' ' + userSecondAddr;
			document.frm.userAddr.value = userAddr;
		}
	</script>

	<!-- 다음 API 주소  -->
	<script
		src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		function execDaumPostcode() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
							// 각 주소의 노출 규칙에 따라 주소를 조합한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var addr = ''; // 주소 변수
							var extraAddr = ''; // 참고항목 변수
	
							//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
							if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
								addr = data.roadAddress;
							} else { // 사용자가 지번 주소를 선택했을 경우(J)
								addr = data.jibunAddress;
							}
	
							// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
							if (data.userSelectedType === 'R') {
								// 법정동명이 있을 경우 추가한다. (법정리는 제외)
								// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
								if (data.bname !== ''
										&& /[동|로|가]$/g.test(data.bname)) {
									extraAddr += data.bname;
								}
								// 건물명이 있고, 공동주택일 경우 추가한다.
								if (data.buildingName !== ''
										&& data.apartment === 'Y') {
									extraAddr += (extraAddr !== '' ? ', '
											+ data.buildingName
											: data.buildingName);
								}
								// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
								if (extraAddr !== '') {
									extraAddr = ' (' + extraAddr + ')';
								}
								// 조합된 참고항목을 해당 필드에 넣는다.
								document.getElementById("userExtraAddr").value = extraAddr;
	
							} else {
								document.getElementById("userExtraAddr").value = '';
							}
	
							// 우편번호와 주소 정보를 해당 필드에 넣는다.
							document.getElementById('userZipCode').value = data.zonecode;
							document.getElementById("userFirstAddr").value = addr;
							// 커서를 상세주소 필드로 이동한다.
							document.getElementById("userSecondAddr").focus();
						}
					}).open();
			}
	</script>

	<script>
		var AuthNum;
		
		$('#emailBtn').on('click',function() {
			var userEmail = $('#userEmail').val();
			var emailBtn = document.getElementById('emailBtn');

			AuthNum = Math.floor(Math.random() * 1000000) + 100000;

			if (AuthNum > 1000000) {
				AuthNum = AuthNum - 100000;
			}

			if (userEmail == '') {
				alert('이메일을 입력하세요.');
				document.getElementById("userEmail").focus();
				return;
			}

			$.ajax({
				method : 'GET',
				url : '/member/joinEmailDupCheck',
				data : {
					userEmail : userEmail,
					AuthNum : AuthNum
				},
				success : function(data) {
					if (data == true) { // 중복값 있을경우
						alert("중복된 이메일입니다.");
					} else { // 중복값 없을경우
						$("#emailBtn").prop('disabled',
								true);
						$("#userEmail").prop(
								'readonly', true);
						$(".auth").append(
							"<br>"+ "<label class= 'control-label emailAuth labelEmailAuth' id='labelEmailAuth'>인증번호</label>"
								+ "<input type='text' id='emailAuth' name='emailAuth' class='form-control'>"
								+ "<button type='button' class='btn btn-in' id='emailAuthBtn'>인증</button>"
								+ "<span class='joinSpan' id='joinSpan'>남은 시간 :</span><span id='joinTime' class='joinTime'></span></span>");
						openTimer();
					}

				},
				error : function() {
					alert('이메일 인증 전송 실패...');
				}

			});

		}); //이메일 버튼 클릭 

		$('.auth').on('click','#emailAuthBtn',function() {
			var emailAuth = $('#emailAuth').val();

			$.ajax({
				method : 'GET',
				url : '/member/joinAuthEmailCheck',
				data : {
					emailAuth : emailAuth,
					AuthNum : AuthNum
				},
				success : function(data) {
					if (data == false) {

						alert("인증번호를 잘못 입력하셨습니다.");

					} else {

						alert("인증이 완료되었습니다.");
						$("#emailAuth").prop(
								'readonly', true);
						$("#emailAuthBtn").prop(
								'disabled', true);
						document
								.getElementById("createEmailSpan").style.color = "green";
						document
								.getElementById("createEmailSpan").innerHTML = "인증이 완료되었습니다.";
						document
								.getElementById("emailAuthCheck").value = "ok";
						closeTimer();

					}

				}

			});

		}); //이메일 인증 버튼
	</script>

	<script>
		function openTimer() {
			var time = 300;
			var min = "";
			var sec = "";

			var timer = setInterval(
			function() {
				min = parseInt(time / 60);
				sec = time % 60;

				var spanJoinTime = document.getElementById('joinTime');

				spanJoinTime.innerHTML = min + "분" + sec + "초";
				time--;

				if (time < 0) {
					clearInterval(timer);
					document.getElementById("createEmailSpan").style.color = "red";
					document.getElementById("createEmailSpan").innerHTML = "인증시간이 만료되었습니다.";
					$("#emailBtn").prop('disabled', false);
					$("#userEmail").prop('readonly', false);
					$("#emailAuth").remove();
					$("#emailAuthBtn").remove();
					$("#labelEmailAuth").remove();
					$("#joinSpan").remove();
					$("#joinTime").remove();
					$("#userEmail").focus();
				}
			}, 1000);
		}

		function closeTimer() {
			time = 0;
			$("#emailBtn").prop('disabled', true);
			$("#userEmail").prop('readonly', true);
			$("#emailAuth").remove();
			$("#emailAuthBtn").remove();
			$("#labelEmailAuth").remove();
			$("#joinSpan").remove();
			$("#joinTime").remove();

		}
	</script>

</body>
</html>
