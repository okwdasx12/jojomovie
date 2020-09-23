<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	body{
		color: white;
	}

	.seat{
		margin: 233px -85px -227px 0;
	}
	
	button{
		color: black;
	}
</style>

</head>
<body>
	<%-- top 영역  --%>
	<jsp:include page="/WEB-INF/views/include/adminTop.jsp" />
	<div class="col-md-12" id="mmm4">
		<p>상영관 수정</p>
	</div>
	<div class="container">
		<form action="modifySangyounggwan" method="post" class="form-horizontal frm" role="form" name="frm" style="margin: 0 auto;">
			<div class="form-group">
				<label for="TheaterId" class="col-md-5 control-label">영화관ID</label>
				<div class="col-md-7">
					<input id="TheaterId" name="TheaterId" type="text" class="form-control"  value="${ sangyounggwanVo.theaterId }">
				</div>
			</div>
			<div class="form-group">
				<div class="btn-group" style="width: 100%">
					<label for="TheaterName" class="col-md-5 control-label">영화관 선택</label>
					<div class="col-md-7">
					<input id="TheaterName" name="TheaterName" type="text" class="form-control"  value="${ sangyounggwanVo.theaterName }">
				</div>
				</div>
			</div>
			<div class="form-group">
				<label for="newSygId" class="col-md-5 control-label">상영관 번호</label>
				<div class="col-md-7">
					<input id="newSygId" name="newSygId" type="text" class="form-control" value="${ sangyounggwanVo.sygId }">
					<input id="sygId" name="sygId" type="hidden" class="form-control" value="${ sangyounggwanVo.sygId }">
					<c:forEach var="sangyounggwanVoList" items="${ sangyounggwanVoList }" varStatus="vs">
						<input type="hidden" class="${ vs.count }" value="${ sangyounggwanVoList.sygId }">
					</c:forEach>
				</div>
			</div>
			
			<div class="col-md-12">
				<div class="btn-group" style="width: 100%; margin-left: -6px;">
					<label for="row" class="col-md-5 control-label">행</label>
					<div id="row" class="col-md-7 bfh-selectbox" data-name="row">
	       				 <div data-value="${ sangyounggwanVo.row }" class="row">${ sangyounggwanVo.row }</div>
					</div>
					<label for="cul" class="col-md-5 control-label">열</label>
					<div id="cul" class="col-md-7 bfh-selectbox" data-name="cul">
						<div data-value="${ sangyounggwanVo.cul }" class="cul">${ sangyounggwanVo.cul }</div>
					</div>
				</div>
			</div>
			<div class="col-md-12"
				style="text-align: center; margin-left: 42px; margin-top: 48px; margin-bottom: -41px;">
				<input type="button" class="form-control btn-mary3 make-seats" value="좌석표 생성하기">
			</div>
			<div class="seat" align="center"></div>
			<div>
				<div class="col-md-12"
				style="text-align: center; margin-left: 42px; margin-top: 48px; margin-bottom: -41px;">
					<input type="submit" class="form-control btn-mary4 dup-check"  value="수정하기" id="btnAdd">
				</div>
			</div>
		</form>
	</div>



<script type="text/javascript" src="/script/jquery-3.5.1.js"></script>
<script type="text/javascript" src="/script/bootstrap.js"></script>
<script type="text/javascript" src="/script/bootstrap-formhelpers.js"></script>
<script>
	$('.dup-check').on('click', function () {

		var theaterName = $('.theaterName').val();
		var theaterId = $('.theaterId').val();
		var sygId = $('#sygId').val();
		var row = $('#row').val();
		var cul = $('#cul').val();
		
		if(theaterId == ''){
			alert("영화관 코드를 입력하세요");
			return false;
		} else if(theaterName == ''){
			alert("영화관 이름 입력하세요");
			return false;
		} else if(sygId == ''){
			alert("상영관 번호를 입력하세요");
			return false;
		} else if(row == ''){
			alert("행을 선택하세요");
			return false;
		} else if(cul == ''){
			alert("열을 선택하세요");
			return false;
		}
		
		for(var i = 1; i<=${ totalNum }; i++){
			var text = $('.'+i).val();
			if(text != null){
				if($('#newSygId').val() == text){
					if($('#newSygId').val() == sygId){
						return true;
					}else{
						alert('이미 사용중인 상영관 입니다.');
						return false;
					}
				}
			}
		}

	});
	
	$('.make-seats').on('click',function(){
		var row = $('input[name="row"]').val();
		var cul = $('input[name="cul"]').val();

		var str ="";
		var cnt= 1;
		var seat="";
		var hang = 'A';

		if (row == '') {
			alert("행을 선택하세요");
			return false;
		} else if (cul == '') {
			alert("열을 선택하세요");
			return false;
		}
		
		for(var i = 1; i<=row;i++) {
			
			for(var j = 1; j<=cul;j++) {
				str += "<button style='width:40px; margin-bottom:1px;'>"+hang+j+"</button> \t";
				seat=hang+""+ j;
				cnt ++;
			}
			str += "<br>";
			var charCode = hang.charCodeAt(0);
			charCode++;
			hang = String.fromCharCode(charCode);
		}
		$('.seat').html(str);
	});

</script>
</body>
</html>