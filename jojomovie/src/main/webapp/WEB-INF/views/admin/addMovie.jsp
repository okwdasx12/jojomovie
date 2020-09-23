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
		<p>영화 등록</p>
		</div>
		<div class="tab-pane" id="update" align="center" style="margin-top: 60px;" >
			<form action="/admin/addMovie" enctype="multipart/form-data" name="checkAdd"   method="post" class="form-horizontal" name="updateFrm" style="display: inline-block;">
				<div class="form-group">
					<label for="movieName" class="col-xs-4 col-sm-3 control-label">영화제목</label>
					<div class="col-xs-8 col-sm-7">
						<input type="text" id="movieName" required class="form-control" name="movieName" style="margin-left: 0px;">
					</div>
				</div>
				<div class="form-group">
					<label  class="col-xs-4 col-sm-3 control-label">영화 사진</label>
					<div class="col-xs-8 col-sm-7">
						<input type="file" name="filename">
					</div>
				</div>
				<div class="form-group">
					<label for="director" class="col-xs-4 col-sm-3 control-label">감독</label>
					<div class="col-xs-8 col-sm-7">
						<input type="text" id="director" name="director" class="form-control" required  placeholder="감독 이름을 입력해주세요">
					</div>
				</div>
				<div class="form-group">
					<label for="cast" class="col-xs-4 col-sm-3 control-label">배우 </label>
					<div class="col-xs-8 col-sm-7">
						<input type="text" id="cast" required  class="form-control" name="cast">
					</div>
				</div>
				<div class="form-group">
					<label for="grade" class="col-xs-4 col-sm-3 control-label">등급</label>
					<div class="col-xs-8 col-sm-7">
						<select name="grade" id="grade"  required style="width: 245px; required height: 25px;">
							<option value="1">1</option>
							<option value="12">12</option>
							<option value="15">15</option>
							<option value="18">18</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="information" class="col-xs-4 col-sm-3 control-label">줄거리</label>
					<div class="col-xs-8 col-sm-7" id="information" style="display: flex;">
						<textarea rows="10" cols="50"  required id="information" maxlength="1000" style="width: 371px;" name="information"></textarea>
					</div>
				</div>
				<div class="form-group">
					<label for="genre" class="col-xs-4 col-sm-3 control-label">장르</label>
					<div class="col-xs-8 col-sm-7">
						<input type="text" id="genre"  required class="form-control" name="genre" >
					</div>
				</div>
				<div class="form-group">
					<label for="runtime" class="col-xs-4 col-sm-3 control-label">런타임</label>
					<div class="col-xs-8 col-sm-7">
						<input type="text" id="runtime" required class="form-control" name="runtime">
					</div>
				</div>
				<div class="form-group">
					<label for="startDate" class="col-xs-4 col-sm-3 control-label">시작일</label>
					<div class="col-xs-8 col-sm-7">
						<p> <input type="text" value="" required  name="startDate" id="sdate" style="width: 245px; height: 25px;"></p>
					</div>
				</div>
				<div class="form-group">
					<label for="endDate" class="col-xs-4 col-sm-3 control-label">종료일</label>
					<div class="col-xs-8 col-sm-7">
						<p> <input type="text" value="" required name="endDate" id="edate" style="width: 245px; height: 25px;"></p>
					</div>
				</div>
				<div class="form-group">
					<div class="col-xs-12 col-sm-12"
						style="text-align: center; margin-left: 82px;">
						<input type="button" onclick="location.href='/admin/adminPage'" value="돌아가기">
						<input type="submit" id="addmovie" value="등록하기">
						<input type="reset" value="초기화">
					</div>
				</div>
			</form>
		</div>


	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script type="text/javascript" src="/script/jquery-3.5.1.js"></script>
	<script type="text/javascript" src="/script/bootstrap.js"></script>
	<script type="text/javascript" src="/script/bootstrap-datepicker.js"></script>
	<script type="text/javascript" src="/script/bootstrap-datepicker.kr.js"></script>
	
	<script>
	<!--날짜 선택  -->
	var startDate = new Date('2020/01/01');
	var FromEndDate = new Date();
	var ToEndDate = new Date();

		$("#sdate").datepicker({
		    format: 'yyyy-mm-dd',
		    autoclose: true,
		}).on('changeDate', function (selected) {
		    var startDate = new Date(selected.date.valueOf());
		    $('#edate').datepicker('setStartDate', startDate);
		}).on('clearDate', function (selected) {
		    $('#edate').datepicker('setStartDate', null);
		});
		
		$("#edate").datepicker({
		    format: 'yyyy-mm-dd',
		    autoclose: true,
		}).on('changeDate', function (selected) {
		    var endDate = new Date(selected.date.valueOf());
		    $('#sdate').datepicker('setEndDate', endDate);
		}).on('clearDate', function (selected) {
		    $('#sdate').datepicker('setEndDate', null);
		});

	</script>
</body>
</html>
