<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
.row{
		font-weight: bold;
	}

	div#t1{
		background-color: #ffffff; 
		text-align: center;
		border: solid 1px;
	}
	
	div#t1-scroll{
		background-color: #ffffff; 
		text-align: center;
		border: solid 1px;
		overflow: scroll;
	}
	
	select{
		 height: 26px;
		 width: 100%;
	 }
	
	input#writeT{
		 height: 35px;
		 width: 100%;
		 padding: 0px;
	}

</style>

</head>

<body>
	<div class="container">
		<div class="container" style="background-color:#1e272e">
		<h1 style="color: white;">관리자 페이지</h1>
		<ul class="nav navbar-nav">
	      <li class="active"><a href="#"><span class="glyphicon glyphicon-plus"> 관리자 추가하기</span></a></li>
	      <li><a href="#"><span class="glyphicon glyphicon-log-out"> 관리자 모드 나가기</span></a></li>
	    </ul>
	</div>
	
	<form action="/notice/noticeFormWrite" method="post" enctype="multipart/form-data" name="frm">
	<input type="hidden" value="admin" name="adminId">
	
	<div class="container" style="padding: 0px;">
		<div class="jumbotron text-center" >
			<div class="text-center" style="margin: 20px;">
				<h2><strong>공지사항</strong></h2>
			</div>
				<div class="row">
					<div class="col-sm-1"></div>
					<select class="col-sm-2 text-center" name="category">
						<option value="categoryNotice">공지사항</option>
						<option value="categoryEvent">이벤트 / 소식</option>
					</select>
					<input type="text" name="subject" required   placeholder="제목을 입력해주세요!" class="col-sm-8">
				</div>
			<div class="row">
				<div class="col-sm-1"></div>
				<textarea class="col-sm-10" id="t1-scroll" name="content"  required  placeholder="내용을 적어주세요"  style="height: 500px; padding: 30px;"></textarea>		
			</div>
			
			<button type="button" onclick="add()">파일추가</button>
			<div class="listadd">
				<ul id="list">
					<li style="list-style: none;"><input type="file" name="filename">
						<button type="button" onclick="remove()">파일지우기</button>
					</li>
				</ul>
			</div>
			
			<div class="row">
				<div class="col-sm-4"></div>
				<div class="col-sm-5">
					<button type="reset" style="margin-top: 10px; background-color: #ffa550;">초기화</button>
					<button style="margin-top: 10px; background-color: #ffa550;" onclick="location.href='/notice/noticeBoardList'">목록으로</button>
					<button type="submit" style="margin-top: 10px; background-color: #ffa550;">등록하기</button>
				</div>
			</div>
		</div>
	</div>
</form>
</div>

<script>

	var str = '<ul id="list"><li style="list-style: none;"><input type="file" name="filename"><button type="button" onclick="remove()">파일지우기</button></li></ul>';
	var count = 1;
	function add(){
		if(count < 5){
				$('.listadd').append(str);	
				count++;
		}else{
			alert('5개 이상 추가 불가합니다.');
		}
	}
	
	function remove(){
		$('#list').remove();
		count--;
	}

</script>


	<script type="text/javascript" src="/script/jquery-3.5.1.js"></script>
	<script type="text/javascript" src="/script/bootstrap.js"></script>
	<script type="text/javascript"></script>
</body>
</html>