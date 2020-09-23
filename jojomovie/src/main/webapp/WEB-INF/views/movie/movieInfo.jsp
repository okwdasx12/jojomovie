<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="javatime" uri="http://sargue.net/jsptags/time"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1 user-scalable=no">
<title>MovieInfoPage</title>
<link href="/css/main.css" rel="stylesheet">
<link href="/css/bootstrap.css" rel="stylesheet">
<link href="/css/rateit.css" rel="stylesheet">
<link href="/css/rateit.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700&family=Black+Han+Sans&family=Do+Hyeon&family=Noto+Sans+KR:wght@300;500&display=swap" rel="stylesheet">

<style>

.title {
	text-align: center;
    font-family: 'Do Hyeon', sans-serif;
    padding-bottom: 20px;
    font-size: 30px;
    font-weight: bold;
}

.movieInfo {
	margin-bottom:15px;
}

.movieScore1, .movieScore2, .movieContent1, .movieContent2, .movieContent3 {
	padding-bottom: 10px;
	font-family: 'Noto Sans KR', sans-serif;
	font-size: large;
	font-weight: 500;
	
}

.movieName {
	margin-top: 10px;
	margin-bottom: 20px;
	font-size: 30px;
	
}

.movieStory {
	padding: 50px 150px 200px 150px;
	line-height: 4rem;
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 400;
	font-size: large;
	
}

.starR1{
    background: url("/images/star.png") no-repeat -52px 0;
    background-size: auto 100%;
    width: 15px;
    height: 30px;
    float:left;
    text-indent: -9999px;
    cursor: pointer;
}
.starR2{
    background: url("/images/star.png") no-repeat right 0;
    background-size: auto 100%;
    width: 15px;
    height: 30px;
    float:left;
    text-indent: -9999px;
    cursor: pointer;
}
.starR1.on{background-position:0 0;}
.starR2.on{background-position:-15px 0;}

.cmtTitle {
	text-align: center;
    font-family: 'Do Hyeon', sans-serif;
    font-size: 35px;
    font-weight: 700;
}

.movieScore {
	margin-top: 20px;
	margin-bottom: 30px;
	text-align: center;
	font-family: 'Do Hyeon', sans-serif;
	font-size: 20px;
}

.reviewBox {
	height: 90px;
	margin-bottom: 60px;
	border: 1px solid #ccc;
	box-sizing: border-box;
}
.starRev {
	float: left;
	width: 30%;
	height:88px;
	background: #F8F8F8;
	text-align: center;
	border-right: 1px solid #ccc;
}

.reviewWriteBox {
	float: left;
	width: 50%;
}

.cmtWriteBtn {
	float: left;
	width: 20%;
	height : 90px;
	border: none;
	margin: -1px -1px 0 0 ;
	background : #666;
	color: #fff;
	font-size: 15px;
}

.reviewBtn {
	float: right;
	background: #ffffff;
	background-color:#ffffff;
	border-radius:10px;
	border:1px solid #ffffff;
	display:inline-block;
	cursor:pointer;
	color:#ccc;
	font-size:13px;
	text-decoration:none;
}

.reviewBtn:hover {
	color:#b8b812;
	text-decoration:none;
}


#cmtContent {
	height: 88px;
	border: none;
	width: 100%;
    line-height: 1.5;
    box-sizing: border-box;
    padding: 13px 18px;
    resize: none;
    font-size: 14px;
    -webkit-border-radius: 4px;
}

ul {
	list-style: none;
}

.reviewContentList {
	padding-left:0;
}

.reviewContentList > li:first-child {
	border-color: #ccc;
}

.reviewContentList > li {
	position: relative;
    padding: 20px 0 15px 70px;
    border-top: 1px solid #eee;
    font-family: 'Noto Sans KR', sans-serif;
    
	
}

.reviewContentList > li .reviewImg {
	display: block;
    position: absolute;
    top: 15px;
    left: 10px;
    overflow: hidden;
    width: 42px;
    height: 42px;
    border-radius: 50%;
}

.reviewContentList > li .reviewImg img {
	width: 100%;
	border-radius: 50%;
}

.reviewContentList .topInfo {
	margin-bottom:15px;
}

.reviewContentList .topInfo .nameInfo {
	position: relative;
	padding-right: 5px;
    font-size: 14px;
	color: darkgray;
	vertical-align: middle;
}

.reviewContentList .topInfo .scoreInfo {
	font-size: 14px;
    margin-right: 11px;
    display: inline-block;
    vertical-align: middle;
}

.reviewContentList .reviewInfo {
	margin-bottom: 11px;
    font-size: 15px;

}

.reviewContentList .btnInfo {
    font-size: 11px;
    color: #666;
}

.starRevTop {
	margin-top: 15px;
}

.starRevBtm {
	margin-left: 100px;
	margin-top: 10px;
}

.gradeImg{
	width: 65px;
    height: 65px;
    margin-right: 10px;
}

span.movieLabel {
    font-size: 60%;
    margin-left: 10px;
    font-weight: 500;
    padding: 8px 8px 8px 8px;
}

span.movieTitle {
 font-family: 'Black Han Sans', sans-serif;
 font-size: 40px;
 
}

.tiketingBtn {
  -webkit-border-radius: 10;
  -moz-border-radius: 10;
  border-radius: 10px;
  font-family: Arial;
  color: #ffffff;
  font-size: 20px;
  background: #798F8C;
  padding: 10px 20px 10px 20px;
  text-decoration: none;
  display: inline-block;
  margin-top: 20px;
}

.tiketingBtn:hover {
  background: #56706c;
  text-decoration: none; 
  color: #ffffff;
  cursor: pointer;
  
}

.movieDetail {
	padding-top: 15px;
	padding-bottom: 15px;
}

.starImg {
	width: 20px;
	height: 20px;
}

.emptyIdBox {
	text-align: center;
    margin-top: 30px;
    color: red;
    font-size: 15px;
    font-family: 'Noto Sans KR', sans-serif; 
}

.reviewListTop {
	font-size: 15px;
    font-family: 'Noto Sans KR', sans-serif;
}

.cmtNum {
	vertical-align: middle;
}

.btmInfo {
	font-size: 11px;
    color: darkgray;
}

.img1 {
	width: 20px; 
	height: 20px;
}
</style>

</head>

<body>

	<%-- top 영역  --%>
	<jsp:include page="/WEB-INF/views/include/top.jsp" />

	<div class="container">
	
		<h3 class="title">영화 상세보기</h3>
		<div class="row">
			<div class="movieImg col-md-4">
				<img class="img-responsive center-block" src="/upload2/upposter/${movieVo.movieId}.jpg">
			</div>

			<div class="movieInfo col-md-8">
				<div class="movieName movieInfo">
					<img class="gradeImg" src="/images/grade${movieVo.grade}.png">
					<span class="movieTitle">${ movieVo.movieName }</span>
						<c:choose>
					 		<c:when test="${movieVo.relMovie eq '상영중' }">
								<span class="label label-success movieLabel"> ${movieVo.relMovie} </span>
					 		</c:when>
					 		<c:when test="${movieVo.relMovie eq '상영예정' }">
								<span class="label label-info movieLabel"> ${movieVo.relMovie} </span>
					 		</c:when>
					 		<c:when test="${movieVo.relMovie eq '상영임박' }">
								<span class="label label-warning movieLabel"> ${movieVo.relMovie} </span>
					 		</c:when>
					 		<c:otherwise>
					 			<span class="label label-danger movieLabel"> ${movieVo.relMovie} </span>
					 		</c:otherwise>
					 	</c:choose>			
				</div> <!-- moviename -->
				<div class="movieDetail">
					<div class="movieScore1">
						<button class="likeBtn" name="${ movieVo.movieName }" id="${ movieVo.movieId }" style="padding:0"> 
							<c:if test="${ movieVo.likeCheck == 1 }">
								<img alt="d" src="/images/찬하트.png" class="img1">
							</c:if>
							<c:if test="${ movieVo.likeCheck == 0 }">
								<img alt="d" src="/images/빈하트.png" class="img1">
							</c:if>
							<span id="span">${ movieVo.likeCnt }</span>
						</button>
					</div>
					<div class="movieScore2">
						관람객평점 : 
						<fmt:formatNumber value="${ staravg }" pattern=".00"/>
					</div>
					<div class="movieContent1">
						감독 : ${movieVo.director} 
					</div>
					<div class="movieContent2">
						배우 : ${movieVo.cast} 
					</div>
					<div class="movieContent3">
						장르 : ${movieVo.genre} |	${movieVo.startDate}개봉 |${movieVo.runtime}
					</div>
				</div>
				<c:if test="${ movieVo.relMovie eq '상영중' or movieVo.relMovie eq '상영임박' }">
					<div><a style="color: white;" href="/reservation/?movieId=${movieVo.movieId }" class="tiketingBtn" >예매</a></div>
				</c:if> 
			</div>
		</div> <!-- row -->
		
		<div class="row movieStory">
			${ movieVo.information }
		</div>
		
		<div class="cmt">
		<h4 class="cmtTitle">평점 및 관람평 </h4>
			<div class="movieScore">
				<em>총 평점</em>
				<img class="starImg" src="/images/starImg.jpg">
				<span><fmt:formatNumber value="${ staravg }" pattern=".00"/> </span>
				<span> / 10</span>
			</div>	
				<div class="reviewBox" id="reviewBox">
					<c:choose>
						<c:when test="${ not empty userId }">
							<%-- ${ not empty sessionScope.userId } --%>
							<form id="cmtWrite" name="cmtWrite" class="cmtWrite">
								<input id="cmtStar" class="cmtStar"  name="cmtStar" value="10" type="hidden">
								<input type="hidden" id="userId" name="userId" value="${ userId }">
								<input type="hidden" id="movieId" name="movieId" value="${ movieVo.movieId }">
								<input type="hidden" id="movieName" name="movieName" value="${ movieVo.movieName }">
								<div class="starRev">
									<div class="starRevTop">
										<span class="score1">10</span>점
									</div>
									<div class="starRevBtm">
										<span class="starR1 on">1</span>
										<span class="starR2 on">2</span>
										<span class="starR1 on">3</span>
										<span class="starR2 on">4</span>
										<span class="starR1 on">5</span>
										<span class="starR2 on">6</span>
										<span class="starR1 on">7</span>
										<span class="starR2 on">8</span>
										<span class="starR1 on">9</span>
										<span class="starR2 on">10</span>
									</div>
								</div>
								<div class="reviewWriteBox">
								<textarea id="cmtContent" name="cmtContent" placeholder="평점 및 영화 관람평을 작성해주세요."></textarea>
								</div>
								<button id="cmtWriteBtn" class="cmtWriteBtn" type="submit">관람평 작성</button>
							</form>
							</c:when>
						<c:otherwise>
							<div class="emptyIdBox">로그인 후 이용 가능합니다.</div>
						</c:otherwise>
					</c:choose>
				</div> <!-- reviwBox -->				
				
				<div class="reviewList">
					<div class="reviewListTop">
						총 [${cmtPageDto.totalCount }] 건 
					</div>
					<ul class="reviewContentList"></ul>
					<ul class="reviewContentList">
						<c:choose>
							<c:when test="${ cmtPageDto.totalCount gt 0 }">
								<c:forEach var="comment" items="${ commentList }">
									<li>
										<span class="reviewImg">
											<c:choose>
												<c:when test="${comment.cmtStar ge 9 }">
													<img src="/images/reviewImg9.png">
												</c:when>
												<c:when test="${comment.cmtStar ge 7 }">
													<img src="/images/reviewImg7.png">
												</c:when>
												<c:when test="${comment.cmtStar ge 5 }">
													<img src="/images/reviewImg5.png">
												</c:when>
												<c:when test="${comment.cmtStar ge 3 }">
													<img src="/images/reviewImg3.png">
												</c:when>
												<c:when test="${comment.cmtStar ge 1 }">
													<img src="/images/reviewImg1.png">
												</c:when>
											</c:choose>
										</span>
										<div class="topInfo">
											<span class="nameInfo">${ comment.userId }</span>
											<span class="scoreInfo">
												<img class="starImg" src="/images/starImg.jpg">
												<strong class="cmtNum"> ${ comment.cmtStar } </strong>
											</span>
											<c:if test="${ not empty userId and userId eq comment.userId }">
												<button id="cmtDelete" class="cmtDelete reviewBtn" value="${ comment.cmtNumber }">삭제</button>
												<button id="cmtModify" class="cmtModify reviewBtn" value="${ comment.cmtNumber }">수정</button>
												<input type="hidden" id="inputModalCmtStar" class="inputModalCmtStar" value="${ comment.cmtStar }">
											</c:if>
										</div>
										<div class="reviewInfo">
											${ comment.cmtContent }
										</div>
										<div class="btmInfo">
											<javatime:format value="${ comment.cmtRegDate }" pattern="yyyy.MM.dd" />
										</div>
									</li>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<ul class="reviewContentList">
									<li> 작성된 댓글이 없습니다.</li>
								</ul>
							</c:otherwise>
						</c:choose>		
					</ul>	
				</div>
			</div> <!-- cmt -->
		
		<div id="page_control" style="text-align : center !important;">
			<c:if test="${ cmtPageDto.totalCount gt 0 }">
				<%-- [이전] --%>
				<c:if test="${ cmtPageDto.startPage gt cmtPageDto.pageBlock }">
					<a href="/movie/movieInfo?movieId=${ movieVo.movieId }&pageNum=${ cmtPageDto.startPage - cmtPageDto.pageBlock }&category=${ cmtPageDto.category }">[이전]</a>
				</c:if>
				
				<%-- 페이지블록 내에서의 시작페이지부터 끝페이지까지 번호출력 --%>
				<c:forEach var="i" begin="${ cmtPageDto.startPage }" end="${ cmtPageDto.endPage }" step="1">
					<a href="/movie/movieInfo?movieId=${ movieVo.movieId }&pageNum=${ i }&category=${ cmtPageDto.category }">
					<c:choose>
						<c:when test="${ i eq pageNum }">
							<span style="font-weight: bold; color: red;">[${ i }]</span>
						</c:when>
						<c:otherwise>
							[${ i }]
						</c:otherwise>
					</c:choose>
					</a>
				</c:forEach>
				
				<%-- [다음] --%>
				<c:if test="${ cmtPageDto.endPage lt cmtPageDto.pageCount }">
					<a href="/movie/movieInfo?movieId=${ movieVo.movieId }&pageNum=${ cmtPageDto.startPage + cmtPageDto.pageBlock }&category=${ cmtPageDto.category }">[다음]</a>
				</c:if>
			</c:if>
		</div>
	</div>
	<!-- 컨테이너 -->

	</body>
	<!-- Modal -->
	<div class="modal fade" id="myModal" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">댓글 모달창</h4>
	      </div>
	      <div class="modal-body">
		      <div class="form-group">
					<label for="reply">댓글 내용</label> 
					<input type="text" class="form-control" placeholder="댓글 내용" name="reply" id="reply">
			  </div>
		      <div class="form-group">
					<label for="replyer">댓글 작성자</label> 
					<input type="text" class="form-control" placeholder="댓글 작성자" name="replyer" id="replyer" readonly>
			  </div>
			  <div class="form-group">
					<label for="modalCmtNumber">댓글 번호</label> 
					<input type="text" class="form-control" placeholder="댓글 번호" name="modalCmtNumber" id="modalCmtNumber" readonly>
			  </div>
			  <div class="form-group">
					<label for="modalCmtStar">별점 </label> 
					<input type="text" class="form-control" placeholder="" name="modalCmtStar" id="modalCmtStar" value="">
					<div class="starRev2">
						<div class="starRevTop">
							<span class="score2" id="modalCmtStar"></span>점
						</div>
						<div class="starRevBtm">
							<span class="star starR1 s1">1</span>
							<span class="star starR2 s2">2</span>
							<span class="star starR1 s3">3</span>
							<span class="star starR2 s4">4</span>
							<span class="star starR1 s5">5</span>
							<span class="star starR2 s6">6</span>
							<span class="star starR1 s7">7</span>
							<span class="star starR2 s8">8</span>
							<span class="star starR1 s9">9</span>
							<span class="star starR2 s10">10</span>
						</div>
					</div>
			 </div>
			  <div class="form-group">
					<label for="regDate">댓글 작성일자</label> 
					<input type="text" class="form-control" placeholder="댓글 작성일자" name="regDate" id="regDate">
			  </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-warning" id="btnModalModify">수정</button>
	        <button type="button" class="btn btn-danger" id="btnModalRemove">삭제</button>
	        <button type="button" class="btn btn-primary" id="btnModalRegister">등록</button>
	        <button type="button" class="btn btn-default" data-dismiss="modal" id="btnModalClose">닫기</button>
	      </div>
	    </div> <!-- 모달 콘텐츠 -->
	  </div> <!-- 모달 다이얼로그 -->
	</div> <!-- 모달 전체 윈도우 -->


	<script type="text/javascript" src="/script/jquery-3.5.1.js"></script>
	<script src="/script/bootstrap.js"></script>
	<script>
	   $('.starRev span').click(function(){
		      $(this).parent().children('span').removeClass('on');
		      $(this).addClass('on').prevAll('span').addClass('on');
		      var score = $(this).html();
		      $(".score1").html(score);
		      document.cmtWrite.cmtStar.value = score;
		      // 값 전송
		      $('input.cmtStar').val(score);
		   });

		   $('.cmtWriteBtn').on('click', function(){
		      
		      var cmtContent = document.getElementById("cmtContent");

		      if (cmtContent.value =="") {
		         alert("댓글을 입력해주세요.")
		         cmtContent.focus();
		         return false;
		         } 
		      
		      var params = $('#cmtWrite').serialize(); // serialize() : 입력된 모든Element(을)를 문자열의 데이터에 serialize 한다.

		      var str = params + '&movieId=' + movieId;
		      
		      $.ajax({
		         method: 'POST',
		         url: '/comment/cmtWrite',
		         data: str,
		         success: function (data) {
		            var result = data.result;
		            var staravg = data.staravg;
		            var movieId = data.movieId;
		            if(result == true) {
		               alert("ID당 1회 입력 가능합니다.");
		               location.href=location.href;
		            } else {
		               alert("게시글 등록 완료");
		               location.href=location.href;
		            }
		         }
		      });
		   }); 

		   $('#cmtDelete').on('click', function() {
		      var cmtNumber = $(this).attr("value");

		      $.ajax({
		         method : 'post',
		         url : '/comment/cmtDelete',
		         data : {
		            cmtNumber : cmtNumber
		         },
		         success : function(data) {
		            alert(data + '번이 삭제되었습니다.');
		            location.href=location.href;
		         }
		      });
		   });
		   
		   // 이벤트 연결용

		   // 모달창 화면요소를 미리 변수로 저장
		   var cmtUserId = $('#userId').val();
		   var PostCmtNumber = $('#cmtModify').val();
		   var inputModalCmtStar = parseInt($('#inputModalCmtStar').val()); // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
		   
		   var modal = $('.modal');
		   var modalTitle = $('#myModalLabel');
		   var modalInputReply = modal.find('input[name="reply"]');
		   var modalInputReplyer = modal.find('input[name="replyer"]');
		   var modalInputCmtNumber = modal.find('input[name="modalCmtNumber"]');
		   var modalInputRegDate = modal.find('input[name="regDate"]');
		   var modalInputCmtStar = modal.find('input[name="modalCmtStar"]'); // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //

		   var btnModalRegister = $('#btnModalRegister');
		   var btnModalRemove = $('#btnModalRemove');
		   var btnModalModify = $('#btnModalModify');
		      
		   // 댓글등록 버튼 클릭했을때
		   $('#cmtModify').on('click', function (event) {

		      for(var i=1; i<= inputModalCmtStar; i++){      // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
		         $(".s"+i+"").addClass(' on');
		         }

		      // 이벤트 전파 막기
		      event.stopPropagation();

		      modalTitle.html('게시판 수정'); // 모달창 제목 설정

		      //별점 
		      $(".score2").html(inputModalCmtStar); // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
		      
		      modal.find('input').val('');
		      modalInputReplyer.val(cmtUserId); // 댓글은 로그인 전용이므로 댓글 작성자를 로그인 아이디로 설정
		      modalInputCmtNumber.val(PostCmtNumber);
		      modalInputCmtStar.val(inputModalCmtStar);  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //

		      modalInputRegDate.closest('div').hide(); // 댓글 작성일자 영역 숨기기
		      modalInputCmtStar.closest('input').hide();
		      modal.find('button[id != "btnModalClose"]').hide(); // 닫기버튼을 제외한 모든버튼 숨기기   

		      btnModalRegister.show(); // 등록버튼 보이기
		      
		      modal.modal('show'); // 'show'모달창 띄우기, 'hide'모달창 숨기기

		      //return false; // 기본기능방지, 이벤트전파막기 모두 수행
		   
		      $('.starRev2 span').click(function(){    // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ //
		         $(this).parent().children('span').removeClass('on');
		         $(this).addClass('on').prevAll('span').addClass('on');
		         var score2 = $(this).html();
		         
		         $(".score2").html(score2);
		         document.cmtWrite.cmtStar.value = score2;
		         modalInputCmtStar.val(score2);
		      });
		   });

		   // 모달창의 댓글등록 버튼을 클릭했을때
		   btnModalRegister.on('click', function () {
		         if (modalInputReply.val() == ""){
		            alert('내용을 입력해주세요')
		            modalInputReply.focus();
		            return false;
		         }
		      
		       var reply = {
		         cmtContent: modalInputReply.val(), // 내용
		         userId: modalInputReplyer.val(), // 작성자
		         cmtNumber: modalInputCmtNumber.val(), // 댓글번호
		         cmtStar : modalInputCmtStar.val() // 별점
		      };

		      var str = JSON.stringify(reply);

		      $.ajax({
		         method: 'POST',
		         url: '/comment/modify',
		         data: str,
		         contentType: 'application/json; charset=utf-8',
		         success: function (result) {
		            alert(result);

		            modal.find('input').val('');
		            modal.modal('hide');

		            pageNum = 1;
		            location.href=location.href;
		         },
		         error: function () {
		            alert('댓글등록 에러발생...');
		         }
		      }); 
		   });
	</script>
</html>
