<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1 user-scalable=no">
<title>조조무비</title>

<style>
	div.col-sm-2.text-center{
		color: white;
	}

</style>

</head>

<body>
	<%-- top 영역  --%>
	<jsp:include page="/WEB-INF/views/include/adminTop.jsp" />
	    
		<div class="col-md-12" id="mmm">
			<p>회원 수정</p>
		</div>
		<div class="tab-pane" id="update" align="center" style="margin-top: 60px;">
			<form action="/admin/modifyMember" name="frm" method="post" class="form-horizontal" name="updateFrm"style="display: inline-block;">
				<div class="form-group">
					<label for="userId" class="col-xs-4 col-sm-3 control-label">아이디</label>
					<div class="col-xs-8 col-sm-7">
						<input type="text" id="userId" name="userId" readonly value="${memberVo.userId}" class="form-control">
					</div>
				</div>
				<div class="form-group">
					<label for="passwd" class="col-xs-4 col-sm-3 control-label">비밀번호 </label>
					<div class="col-xs-8 col-sm-7">
						<input type="text" id="passwd" class="form-control" name="passwd" value="${memberVo.passwd}">
					</div>
				</div>
				<div class="form-group">
					<label for="name" class="col-xs-4 col-sm-3 control-label">이름 </label>
					<div class="col-xs-8 col-sm-7">
						<input type="text" id="name" class="form-control" name="name" value="${memberVo.name}">
					</div>
				</div>
				<div class="form-group">
					<label for="birthday" class="col-xs-4 col-sm-3 control-label">생일</label>
					<div class="col-xs-8 col-sm-7">
						<input type="date" id="birthday" class="form-control" name="birthday" value="${memberVo.birthday}"  min="1900-01-01" max="2030-12-31">
					</div>
				</div>
				<div class="form-group">
					<label for="address" class="col-xs-4 col-sm-3 control-label">회원 주소</label>
					<div class="col-xs-8 col-sm-7">
					   <input readonly type="text"  value="${memberVo.userAddr}" class="form-control">
					</div>
				</div>
				<div class="form-group">
					<label for="userAddr" class="col-xs-4 col-sm-3 control-label">주소 변경</label>
					<div class="col-xs-8 col-sm-7">
					   <input type="hidden" id="userAddr" name="userAddr"> 
					   <input type="text" id="userZipCode" name="userZipCode" class="form-control" readonly="readonly">
					</div>
				</div>
				<div class="form-group">
					<label for="userAddr" class="col-xs-4 col-sm-3 control-label"></label>
					<div class="col-xs-8 col-sm-7">
					  <button id="clickaddr" type="button" class="btn btn-in" onclick="execDaumPostcode()">우편번호 찾기</button>
					</div>
				</div>
				<div class="form-group">
					<label for="userAddr" class="col-xs-4 col-sm-3 control-label"></label>
					<div class="col-xs-8 col-sm-7">
					  <input type="text" id="userFirstAddr" name="userFirstAddr" class="form-control col-sm-3" readonly="readonly">
					</div>
				</div>
				<div class="form-group">
					<label for="userAddr" class="col-xs-4 col-sm-3 control-label"></label>
					<div class="col-xs-8 col-sm-7">
					   <input type="text" id="userSecondAddr" name="userSecondAddr" class="form-control col-sm-3" placeholder="상세주소를 입력하세요.">
					</div>
				</div>
				<div class="form-group">
					<label for="userAddr" class="col-xs-4 col-sm-3 control-label"></label>
					<div class="col-xs-8 col-sm-7">
					  <input type="text" id="userExtraAddr" name="userExtraAddr" class="form-control col-sm-3" placeholder="참고 항목">
					</div>
				</div>
				<div class="form-group">
					<label for="phone" class="col-xs-4 col-sm-3 control-label"> 전화번호 </label>
					<div class="col-xs-8 col-sm-7">
						<input name="phone" type="tel"  value="${memberVo.phone}" class="form-control">
					</div>
				</div>
				<div class="form-group">
					<label for="point" class="col-xs-4 col-sm-3 control-label"> 포인트 </label>
					<div class="col-xs-8 col-sm-7">
						<input name="point" type="text"  value="${memberVo.point}" class="form-control">
					</div>
				</div>
				<div class="form-group">
					<label for="grade" class="col-xs-4 col-sm-3 control-label"> 등급 </label>
					<div class="col-xs-8 col-sm-7">
						<input class="col-sm-4" name="grade" type="text"  value="${memberVo.grade}"  class="form-control">
					</div>
				</div>
				<div class="form-group">
					<div class="col-xs-12 col-sm-12"
						style="text-align: center; margin-left: 82px;">
						<button class="col-sm-4" type="reset">되돌리기</button>
						<button class="col-sm-4" type="submit" onclick="sum()">수정하기</button>
					</div>
				</div>
			</form>
		</div>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script type="text/javascript" src="/script/jquery-3.5.1.js"></script>
<script type="text/javascript" src="/script/bootstrap.js"></script>
<script type="text/javascript"></script>

	<!-- 다음 API 주소  -->
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	function sum() {
		var userFirstAddr = document.frm.userFirstAddr.value;
		var userSecondAddr = document.frm.userSecondAddr.value;
		var userAddr = userFirstAddr + ' ' + userSecondAddr;
		document.frm.userAddr.value = userAddr;
	}

	
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
</body>
</html>