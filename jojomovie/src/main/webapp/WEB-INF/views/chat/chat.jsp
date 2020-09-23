<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko-kr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>부트스트랩 채팅화면</title>
<link href="/css/bootstrap.css" rel="stylesheet">
<link href="/css/index.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
</head>
<body>

<div id="cchat" class="container">
		<h1>조조무비</h1>
		<img alt="" src="/images/자유채팅.png"><a>익명채팅방</a>
		<div id="chating" class="chating"></div>
		
		<div id="yourName">
				<span>${ sessionScope.userId }님 채팅에 참여하시겠습니까?</span>
				<table class="inputTable">
				<tr>
					<th>닉네임 입력</th>
					<th><input type="text" name="userName" id="userName"></th>
					<th><button onkeyup="enterkey();" onclick="chatName()" id="startBtn">등록</button></th>
				</tr>
			</table>
		</div>
		<div id="yourMsg">
			<table class="inputTable">
				<tr>
					<th><input id="chatting" type="text" placeholder="보내실 메시지를 입력하세요."></th>
					<th><button onclick="send()" id="sendBtn">보내기</button></th>
				</tr>
			</table>
			<div>
				<button id="btnQuit" class="btn btn-danger">채팅방 나가기</button>
			</div>
		</div>
	</div>


	<script src="/script/jquery-3.5.1.js"></script>
	<script src="/script/bootstrap.js"></script>
	<script type="text/javascript">
	var ws;

	function wsOpen(){
		ws = new WebSocket('ws://' + location.host + '/chating');
		wsEvt();
	}
		
	function wsEvt() {
		
		ws.onmessage = function(data) {
			var msg = data.data;
			if(msg != null && msg.trim() != ''){
				$("#chating").append("<p>" + msg + "</p>");
			}
		}

		document.addEventListener("keypress", function(e){
			if(e.keyCode == 13){ //enter press
				send();
			}
		});
	}

	function chatName(){
		var userName = $("#userName").val();
		
		if(userName == null || userName.trim() == ""){
			alert("닉네임을 입력해주세요.");
			$("#userName").focus();
		}else{
			wsOpen();
			$("#yourName").hide();
			$("#yourMsg").show();
		}
	}

	function send() {
		var uN = $("#userName").val();
		var msg = $("#chatting").val();

		if(msg == null || msg.trim() == ""){
			alert("내용을 입력해주세요.");
			$("#chatting").focus();
		}else{
			ws.send(uN+" : "+msg);
			$('#chatting').val("");
		}
	}

    $('#btnQuit').on('click', function() {
        ws.close();
        alert('채팅이 종료됩니다.');
        window.close(); 
    });

    document.onkeydown = function(e) {
        var event = window.event || e;
        if (event.keyCode == 116) {
        //   alert("실행할 수 없는 명령입니다.");
           return false;
        }
     }
	</script>
</body>
</html>




