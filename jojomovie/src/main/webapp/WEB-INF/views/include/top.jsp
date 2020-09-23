<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1 user-scalable=no">
<title>조조무비</title>
<link href="/css/bootstrap.css" rel="stylesheet">
<link href="/css/bootstrap-theme.css" rel="stylesheet">
<link href="/css/index.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">

</head>
	<div class="container-fluid">
		<div class="login">
			<c:choose>
				<c:when test="${not empty sessionScope.userId && sessionScope.grade eq '관리자'}"> 
				 관리자로 로그인하셨습니다.
				<a href="/member/logout">로그아웃</a>
				<a href="/admin/adminPage">관리자페이지</a>
				</c:when>		
			
				<c:when test="${not empty sessionScope.userId}">
				${ sessionScope.userId } 님 환영합니다!
        			<a href="/member/logout">로그아웃</a>
					<a href="/mypage/mypage"> 마이페이지</a>
				
				</c:when>
				
				<c:otherwise>
					<a href="/member/login">로그인</a>
	        	 / <a href="/member/join">회원가입</a>
				</c:otherwise>
			</c:choose>
		</div>

		<div class="col-md-9 col-md-offset-3">
			<div class="col-md-12">
				<img alt="d" src="/images/영화아이콘.png">
			</div>
		</div>


		<div class="row">
			<div class="col-md-5">
				<a id="subject" href="/">조조무비</a>
			</div>
		<div class="searchTop">
			<div class="frm3">
				<form action="/movie/moviePresent" method="get" name="searchAll" onsubmit="return needText()">
					<select name="category" class="selectt">
						<option value="all" ${ moviepageDto.category eq 'all' ? 'selected' : '' }>통합검색</option>
					</select>
					<input type="text" name="search" value="${ moviepageDto.search }" id="inputt">
					<input type="submit" value="검색" class="s-btn">
				</form>
			</div>
		</div> <!-- aaa -->
		</div>
		<nav class="navbar navbar-inverse">
			<div class="navbar-header">
				<a class="navbar-brand" href="/">홈</a>
				<!--네비게이션 제목 -->
			</div>

			<div>
				<ul class="nav navbar-nav">
					<li><a href="/movie/currentMovie">현재상영작</a></li>
					<li><a href="/movie/comingMovie">상영예정작</a></li>
					<li><a href="/movie/moviePresent">영화</a></li>
					<li><a href="/reservation/">예매</a></li>
					<li><a href="/inquire/">문의</a></li>
					<li><a href="/notice/noticeBoardList">공지</a></li>
				</ul>
			</div>
		</nav>
	</div>
	

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script type="text/javascript" src="/script/jquery-3.5.1.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script type="text/javascript" src="/script/bootstrap.js"></script>
	<script>
	function needText() {

		  if(searchAll.inputt.value == "") {

		    alert("검색할 단어를 입력해 주세요.");

		    searchAll.inputt.focus();

		    return false;

		  }
	}
	</script>