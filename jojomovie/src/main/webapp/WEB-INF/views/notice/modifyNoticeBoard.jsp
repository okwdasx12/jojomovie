<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="javatime" uri="http://sargue.net/jsptags/time"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1 user-scalable=no">
<title>조조무비</title>

<link href="/css/bootstrap.css" rel="stylesheet">
<link href="/css/bootstrap-theme.css" rel="stylesheet">

<style>
	.row {
		font-weight: bold;
	}
	
	div#t1 {
		background-color: #ffffff;
		padding: 5px;
		text-align: center;
		border: solid 1px;
	}
	
	div#t1-scroll {
		background-color: #ffffff;
		padding: 5px;
		text-align: center;
		border: solid 1px;
		overflow: scroll;
	}
</style>

</head>

<body>
	<div class="container">
		<div class="container" style="background-color: #1e272e">
			<h1 style="color: white;">관리자 페이지</h1>
			<ul class="nav navbar-nav">
				<li class="active"><a href="#"><span
						class="glyphicon glyphicon-plus"> 관리자 추가하기</span></a></li>
				<li><a href="#"><span class="glyphicon glyphicon-log-out">
							관리자 모드 나가기</span></a></li>
			</ul>
		</div>

		<form action="/notice/updateNotice" method="post" enctype="multipart/form-data" name="frm">
			<div class="container" style="padding: 0px;">
				<div class="jumbotron text-center">
					<div class="text-center" style="margin: 20px;">
						<h2>
							<strong>공지사항</strong>
						</h2>
					</div>
					<div class="row">
						<div class="col-sm-1"></div>
						<div class="col-sm-2" id="t1">글 제목</div>
						<div class="col-sm-8" id="t1">
							<input type="text" value="${noticeVo.subject }" name="subject">
						</div>
					</div>
					<div class="row">
						<div class="col-sm-1"></div>
						<div class="col-sm-2" id="t1">작성일</div>
						<div class="col-sm-3" id="t1">
							<javatime:format value="${ noticeVo.regDate }" pattern="yyyy.MM.dd" />
						</div>
						<div class="col-sm-2" id="t1">조회수</div>
						<div class="col-sm-3" id="t1">${noticeVo.readcount } </div>
					</div>
					<div class="row">
						<div class="col-sm-1"></div>
						<div class="col-sm-10" id="t1">글내용</div>
					</div>

					<div class="row">
						<div class="col-sm-1"></div>
						<div class="col-sm-10" id="t1-scroll"
							style="height: 500px; padding: 30px;">
							<textarea class="col-sm-10" id="t1-scroll" name="content"
								required style="height: 500px; padding: 30px;">
								${noticeVo.content }
							</textarea>
						</div>
					</div>
					
		<div class="row" id="removeImage">
				<c:if test="${ not empty attachList }">
						<%-- ${ not empty boardVo.attachList } --%>
						<c:forEach var="attach" items="${ attachList }">
							<c:choose>
								<c:when test="${ attach.image eq 'I' }">

									<c:set var="beginIndex"
										value="${ fn:indexOf(attach.uploadpath, 'upload') }" />
									<c:set var="length"
										value="${ fn:length(attach.uploadpath) }" />
									<c:set var="path"
										value="${ fn:substring(attach.uploadpath, beginIndex, length) }" />
								
								<div class="${attach.uuid } col-sm-3">	
									<input type="radio" name="uuid" id="uuname"  value="${ attach.uuid }">
										<a href="/${ path }/${ attach.uuid }_${ attach.filename }" id="uupath"> 
												${attach.filename}
										</a>
								</div>	
								</c:when>
								<c:otherwise>
									<div class="${attach.uuid } col-sm-3">
										<input type="radio" name="uuid" id="uuname" value="${ attach.uuid }">
											<a href="/notice/download?uuid=${ attach.uuid }" id="uupath">
												${attach.filename} </a>
											<br>
									</div>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:if>
			</div>
			
			<input type="hidden" value="${countFile}" readonly id="getCount">
			<div class="row" id="delBtnF">
				<button class="text-center" style="margin: 10px;" type="button" onclick="deleteSelectUuid()">선택파일 삭제</button>
			</div>
			<button type="button" onclick="add()">파일추가</button>
			<div class="listadd">
				<ul id="list" style="display: none;">
					<li style="list-style: none;"><input type="file" name="filename">
					<button type="button" onclick="remove()">파일지우기</button>
					</li>
				</ul>
			</div>
			<div class="row">
				<div class="col-sm-2"></div>
				<div class="col-sm-8">
					<input type="hidden" name="num" value="${ noticeVo.num}">
					<!--수정하기  -->
					<input type="button" onclick="submitModify()" value="수정하기" style="background-color: salmon;">
					
					<input type="reset" value="초기화">

					<button style="margin-top: 10px; background-color: #ffa550;"
						onclick="location.href='/notice/noticeBoardList?pageNum=${pageNum}&num=${noticeVo.num}'">목록으로</button>
				</div>
				</div>
			</div>
		</div>
	</form>
</div>

	<script>
		function submitModify(){
			var con = confirm("수정하시겠습니까?");
			if(con){
				frm.submit();
			}else{
				return;
			}
		}

//RADIO 체크 여부 확인 후 삭제하는 걸로. CONFIRM창 띄우기		 
		function deleteSelectUuid(){
			if($("input:radio[name='uuid']").is(":checked") == true){

				var count = 0;
				count = $('#getCount').val();
				count = parseInt(count, 10);
					
				count = count - 1;
 			    $('#getCount').val(count);
				
				var selectfile = $('#uuname').val(); //uuid가져오기

					$.ajax({
							method: 'DELETE',
							url: '/notice/' + selectfile,
							success: function (result) {
								$('.'+result).remove();
							},
							error: function () {
								alert("실패");
							}
						});
				}else{
					alert('삭제할 파일을 선택해주세요');
				}
			}

		
		var str = '<ul id="list"><li style="list-style: none;"><input type="file" name="filename"><button type="button" onclick="remove()">파일지우기</button></li></ul>';

		function add(){
			var count = 0;
			count = $('#getCount').val();
			count = parseInt(count, 10);

				if(count < 5){
					//	alert(typeof(count));
			 			$('.listadd').append(str);	

			 			count = count + 1;
			 			 $('#getCount').val(count);
			 			 
					}else{
						$('#list').hide();
						alert('5개 이상 추가 불가합니다.');
				}
				
			}
		function remove(){
			var count = 0;
			count = $('#getCount').val();
			count = parseInt(count, 10);
			
			$('#list').remove();

			count = count - 1;
			 $('#getCount').val(count);
		}
		
	</script>

	<script type="text/javascript" src="/script/jquery-3.5.1.js"></script>
	<script type="text/javascript" src="/script/bootstrap.js"></script>
	<script type="text/javascript"></script>
</body>
</html>