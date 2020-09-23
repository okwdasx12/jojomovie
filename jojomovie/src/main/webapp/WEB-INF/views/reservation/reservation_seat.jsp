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
<title>조조무비 - 예매</title>
<style>
.background {
	margin-top: 20px;
	background-color: #2D2D2D;
	padding: 10px 13%;
}
.white {
	color: white;
}
.tit {
	padding: 20px 0 20px 0;
	background-color: #555555;
	border: 1px, solid, #E2E2E2;
	font-size: 22px;
	font-weight: bold;
	color: white;
}
.res-seat {
	background-color: #FFFFFF;
	color: #000000;
}
button{
	border:1px solid black;
	border-radius:5px;
	margin-bottom: 20px;	 	
}
button.clicked{
	background:"#2F2F2F";
	color:"white";
}
.priceDiv{
	padding: 30px;
	background:#555555;
	color: #FFFFFF;
	font-size:18px;
	display: flex;
	justify-content: space-around;
}
.modal-body input {
	border: none;
}
.box{
display: flex;
justify-content: flex-end;
font-size: 15px;

}
.boxWhite{
width: 18px;
height: 18px;
background-color: #EFEFEF;
}
.boxRed{
width: 18px;
height: 18px;
background-color: #A61212;
}
.boxBlack{
width: 18px;
height: 18px;
background-color: black;
}
</style>
</head>
<body>
	<%-- top 영역  --%>
	<jsp:include page="/WEB-INF/views/include/top.jsp" />

	<div class="container">
		<div class="row">
			<div class="col-md-12 tit" align="center">
				좌석 선택<br>
				<div class="box">
					<div class="boxWhite"></div><span>&nbsp; 선택가능 좌석&nbsp;</span>
					<div class="boxRed"></div><span>&nbsp; 선택 불가능&nbsp;</span>
					<div class="boxBlack"></div><span>&nbsp;선택한 좌석&nbsp;</span>
				</div>
				<div style="margin: 30px 0 ;">
					<label for="adult">성인</label>
					<select id="adult" class="form-control">
					  <option class="adult" value="0">성인</option>
			          <option class="adult" value="1">1</option>
			          <option class="adult" value="2">2</option>
			          <option class="adult" value="3">3</option>
			          <option class="adult" value="4">4</option>
			          <option class="adult" value="5">5</option>
			        </select>
					<label for="teen">청소년</label>
					<select id="teen" class="form-control">
					  <option class="teen" value="0">청소년</option>
			          <option class="teen" value="1">1</option>
			          <option class="teen" value="2">2</option>
			          <option class="teen" value="3">3</option>
			          <option class="teen" value="4">4</option>
			          <option class="teen" value="5">5</option>
			        </select>
				</div>		
				
				<div align="center" class="col-md-12 res-seat">
					<div>screen</div>
					<div id="seatDiv" align="center">
<!-- 						스크린 버튼 -->
					</div>
				</div>
			</div>
		</div>
		<div class="priceDiv">
			<div>
				<div>극장&nbsp;&nbsp;:&nbsp;&nbsp;${ timeVo.sygId }</div>
				<div>영화&nbsp;&nbsp;:&nbsp;&nbsp;${ timeVo.movieName }</div>
				<div>일시&nbsp;&nbsp;:&nbsp;&nbsp;<javatime:format value="${ timeVo.sangyoungTime }" pattern="MM월 dd일 HH:mm"/></div>
				<div>인원&nbsp;&nbsp;:&nbsp;&nbsp;<span id="adNum" class="white"></span>&nbsp;&nbsp;<span id="teNum" class="white"></span></div>
			</div>
			<div>
				<div id="adultPrice"></div>
				<div id="teenPrice"></div>
				<div id="totalPrice"></div>
			</div>
			<div>
				<button
					style="width: 100px; height: 100px; background-color: #555555; border: 2px solid; border-radius: 10px;"
					class="glyphicon glyphicon-hand-up white reservation" type="button"
					data-toggle="modal" data-target="#reservationModal">
					<br>
					<br>예매하기
				</button>
			</div>
		</div>
	</div>
	<!-- 	<div class="background"> -->
	<!-- 모달  -->
   <form action="/reservation/doreserve" name ="test1" method="post">
	   <div class="modal fade" id="reservationModal" tabindex="-1" role="dialog"
	      aria-labelledby="myModalLabel">
	      <div class="modal-dialog" role="document">
	         <div class="modal-content">
	            <div class="modal-header" style="background-color: black;">
	               <button type="button" class="close" data-dismiss="modal"
	                  aria-label="Close">
	                  <span aria-hidden="true">×</span>
	               </button>
	               <h4 class="modal-title text-center" id="myModalLabel" style="color: white;">예매 확인</h4>
	            </div>
	            
	            <div class="modal-body">
					<div class="row">
					   <div class="col-sm-3 col-xs-1"></div>
					   <div class="col-sm-3 col-xs-4">영화명</div>
					   <div class="col-sm-6 col-xs-5" ><input type="text" name="movieName" value="${ timeVo.movieName }" readonly></div>
					</div>
					<div class="row">
					   <div class="col-sm-3 col-xs-1"></div>
					   <div class="col-sm-3 col-xs-4">지점</div>
					   <div class="col-sm-6 col-xs-5"><input type="text"  name="theaterName" value="${ timeVo.theaterName }" readonly></div>
					</div>
					<div class="row">
					   <div class="col-sm-3 col-xs-1"></div>
					   <div class="col-sm-3 col-xs-4">상영관</div>
					   <div class="col-sm-6 col-xs-5"><input type="text" name="sygId" value="${ timeVo.sygId }" readonly></div>
					</div>
					  <input type="hidden" name="sangyoungTime" value="${ timeVo.sangyoungTime }"/>
					<div class="row">
					   <div class="col-sm-3 col-xs-1"></div>
					   <div class="col-sm-3 col-xs-4">상영일</div>
					   <div class="col-sm-6 col-xs-5"><input type="text" value="<javatime:format value="${ timeVo.sangyoungTime }" pattern="yyyy.MM.dd"/>" readonly></div>
					</div>
					<div class="row">
					   <div class="col-sm-3 col-xs-1"></div>
					   <div class="col-sm-3 col-xs-4">상영시간</div>
					   <div class="col-sm-6 col-xs-5"><input type="text" value="<javatime:format value="${ timeVo.sangyoungTime }" pattern="HH:mm"/>" readonly></div>
					</div>
					<div class="row">
					   <div class="col-sm-3 col-xs-1"></div>
					   <div class="col-sm-3 col-xs-4">예약자 수</div>
					   <div class="col-sm-5 col-xs-5"><input type="text" id="reservCountModal" value="" readonly></div>
					</div>
					<div class="row">
					   <div class="col-sm-3 col-xs-1"></div>
					   <div class="col-sm-3 col-xs-4">좌석</div>
					   <div class="col-sm-6 col-xs-5"><input type="text" name="seat" id="seats" value="F10" style="border: none;" readonly></div>
					</div>
					<hr>
					<div class="row">
						<div align="center">결제 금액</div>
						<br>
					</div>
					<div class="row">
						<div class="col-sm-3 col-xs-1"></div>
						<div class="col-sm-3 col-xs-4">성인</div>
						<div class="col-sm-1 col-xs-1">:</div>
						<div class="col-sm-5 col-xs-5"><input type="text" id="adultPriceModal" name="adultPrice" style="border: none;" readonly></div>
					</div>
					<div class="row">
						<div class="col-sm-3 col-xs-1"></div>
						<div class="col-sm-3 col-xs-4">청소년</div>
						<div class="col-sm-1 col-xs-1">:</div>
						<div class="col-sm-5 col-xs-5"><input type="text" id="teenPriceModal" name="teenPrice" style="border: none;" readonly></div>
					</div>
					<div class="row">
						<div class="col-sm-3 col-xs-1"></div>
						<div class="col-sm-3 col-xs-4"><button type="button" id="btn-point">포인트확인</button></div>
						<div class="col-sm-1 col-xs-1">:</div>
						<div class="col-sm-5 col-xs-5"><span id="viewPoint"></span></div>
					</div>
					<div class="row">
						<input type="hidden" name="userId" value="${sessionScope.userId }" id="useruser">
						<div class="col-sm-3 col-xs-1"></div>
						<div class="col-sm-3 col-xs-5">포인트 사용</div>
						<div class="col-sm-1 col-xs-1">:</div>
						<div class="col-sm-5 col-xs-5"><input type="number" name="usepoint" id="userusepoint" value=0><span id="maxPoint"></span></div>
					</div>
					<div class="row">
						<div class="col-sm-3 col-xs-1"></div>
						<div class="col-sm-3 col-xs-4">총 금액</div>
						<div class="col-sm-1 col-xs-1">:</div>
						<div class="col-sm-5 col-xs-5"><input type="text" id="totalPriceModal" name="totalPrice" style="border: none;" readonly></div>
					</div>
	            </div>
	            <div class="modal-footer">
					<input type="hidden" name="movieId" value="${ timeVo.movieId }">
					<input type="hidden" name="timeNum" value="${ timeVo.timeNum }">
					<input type="hidden" name="point" value="" id="postPoint">
					<button type="submit" class="btn btn-primary btn-sub">결제하기</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
	            </div>
	         
	         </div>
	      </div>
	   </div>
	</form>
	
	<%-- footer 영역  --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

	<script>
		$(document).ready(function() {
			var index = ${index};
			var seatsList = ${seatsList};

			var row = ${ rowcul.row};
			var cul = ${ rowcul.cul};
			var hang='A';
			var str='';
			var seat="";
			var cnt= 1;
			for(var i = 1; i<=row;i++) {
				
				for(var j = 1; j<=cul;j++) {
					seat=hang+""+ j;
					if( seatsList.includes(seat) ){
						str += "<button style='width:50px; margin-bottom:20px; background-color:#A61212; cursor:not-allowed' class='btnId' id='"+hang+j+"' value='"+hang+j+"' disabled>"+hang+j+"</button> \t";
					}else{
						str += "<button style='width:50px; margin-bottom:20px;' class='btnId' id='"+hang+j+"' value='"+hang+j+"'>"+hang+j+"</button> \t";
					}
					
					cnt ++;
				}
				str += "<br>";
				var charCode = hang.charCodeAt(0);
				charCode++;
				hang = String.fromCharCode(charCode);
			}
			$('#seatDiv').html(str);
			
		});
	</script>
	<script>
		var adult;
		var teen;
		var cnt = document.getElementsByClassName('clicked').length;
		var reserveCount;
		var totalPrice=0;
		var adultPrice=0;
		var teenPrice=0;
		
		$('#seatDiv').on('click', '.btnId', function(){
			adult= parseInt($('#adult option:selected').val());
			teen = parseInt($('#teen option:selected').val());
			reserveCount = adult + teen;
			
			if( $(this).hasClass('clicked') ) {
				$(this).css({background:"#EFEFEF", color:"black"});
				$(this).removeClass('clicked');
				
				cnt--;
			} else {
				if(reserveCount<=cnt){
					alert('선택가능한 좌석은 '+reserveCount+'석 입니다.');
					return false;
				}
				$(this).addClass('clicked');
				$(this).css({background:"#2F2F2F", color:"white"});
				cnt ++;
			}
// 			$(this).attr('class', )
		});
		
		$('#adult, #teen').on('change', function(){
			adult = parseInt($('#adult option:selected').val());
			teen = parseInt($('#teen option:selected').val());
			reserveConut = adult + teen;

			if (reserveConut < cnt) {
				alert('선택된 좌석이 더 많습니다.');
				$('.clicked').css({background:"#EFEFEF", color:"black"});
				$('.clicked').removeClass('clicked');
				cnt = 0;
				return false;
			}
			
			$('#adNum').html("성인 : " + adult);
			$('#teNum').html("청소년 : " + teen);
			
			adultPrice = adult*10000;
			teenPrice = teen*7000;
			totalPrice=adultPrice + teenPrice;
			
			$('#adultPrice').html("성　인 : " + adultPrice+"원" );
			$('#teenPrice').html("청소년 : " + teenPrice +"원");
			$('#totalPrice').html("총금액 : " + totalPrice +"원");

			$('#reservCountModal').val(reserveConut);
			$('#adultPriceModal').val(adultPrice);
			$('#teenPriceModal').val(teenPrice);
			$('#totalPriceModal').val(totalPrice);
		});

		$('.reservation').on('click', function(){
			var a = document.getElementsByClassName('clicked');
			var str ='';
			adult = parseInt($('#adult option:selected').val());
			teen = parseInt($('#teen option:selected').val());
			reserveConut = adult + teen;
	       
			if ( reserveConut == 0 || reserveConut != cnt ) {
				alert('좌석을 선택하세요.');
				return false;
			} 
			
			for(var i = 0; i<a.length;i++){
			   if(i != a.length-1){
			      str += a[i].value+",";
			   } else{
			      str += a[i].value;
			   }
			}
			$('#seats').val(str);
	    });
	</script>
	
	<!--여기서 부터 붙여주세요~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  -->
	<script>
	var userId = document.getElementById('useruser').value;

	$("#btn-point").on("click", function() {
		$.ajax({
			type: 'GET',
			url : '/reservation/search/' + userId ,
			success : function(result){
				$('#viewPoint').html(result);
			}, 
			error : function(){
				alert("적립된 포인트가 없습니다.");
			}
		});
	});


	$('input[name="usepoint"]').keyup(function(event){

		var useP = $(this).val();
		var userId = document.getElementById('useruser').value;
			
		$.ajax({
			url : '/reservation/usePoint',
			data : {useP : useP , userId : userId },
			success : function (data){
				showMaxPoint(data);
			},
			error : function(){
				alert('데이터 오류');
			}

		});
	});

	function showMaxPoint(data) {
		if (data.whymax) {
				alert('사용 가능 포인트를 초과하셨습니다!');
				 document.getElementById('userusepoint').value = 0;
				 totalPrice=adultPrice + teenPrice;
				 $('#totalPriceModal').val(totalPrice);
		} 
	}

	var tenmoney = 0;
	var usepoint = 0;
	$('#userusepoint').keyup(function(){
		usepoint = $(this).val();
		var maxTotalPrice = adultPrice + teenPrice;
		
			if(usepoint <= maxTotalPrice ){
						tenmoney= usepoint % 10;
						totalPrice = adultPrice + teenPrice - usepoint;
						var postPoint = Math.ceil(totalPrice/10);
				      $('#postPoint').val(postPoint);
				      $('#totalPriceModal').val(totalPrice);
			}else{
				alert('총 금액을 초과하실 수 없습니다.');
				$('#userusepoint').val(0);
				
				 $('#totalPriceModal').val(maxTotalPrice);
				return;
			}
	});

	var submitAction = function(e){
		e.preventDefault();
		e.stopPropagation();
	}

	
	var changeTen = 0;
	
	$('.btn-sub').on('click', function(){

		if(usepoint == 0 || tenmoney == 0){
			totalPrice = adultPrice+teenPrice-usepoint;
			var postPoint = Math.ceil(totalPrice/10);
			$('#postPoint').val(postPoint);
		}else{


			var checkChange = confirm('포인트는 10원 단위까지만 사용가능합니다. 사용에 동의하시면 확인을, 재입력하시려면 취소를 눌러주세요');
			if(checkChange == true){
				usepoint = $('#userusepoint').val();
				changeTen = usepoint - tenmoney;
				$('#userusepoint').val(changeTen);
				test1.submit();
			}else{
				return false;				
			}
		}
	});
	</script>
</body>
</html>