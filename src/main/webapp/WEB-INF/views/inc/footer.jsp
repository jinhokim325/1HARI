<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
</div>

<!--bottom 시작 -->
<footer class="footer text-center" style="margin-left:5%;">
	
	<div>All Rights Reserved by Matrix-admin. Designed and Developed by 1HARI</div>
</footer>
<!--bottom 끝-->

<!-- jsTree -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>

<!-- websocket sockjs -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.min.js"></script>

<script>
	$(document).ready(function() {
		connect();
// 		var Notification = window.Notification || window.mozNotification || window.webkitNotification;

// 		 Notification.requestPermission(function (permission) {
// 			console.log(permission);
// 	    });
		// notifications 알림 권한확인 
// 		if (window.Notification) {
// 	        Notification.requestPermission(); //사용자 권한을 받아오는 함수
// 	    }
	})
	
	var wsocket;
	//웹소켓 연결
	function connect() {
		wsocket =new WebSocket("ws://192.168.6.10:8090/1HARI/sign.hari"); 

		wsocket.onopen = onOpen;
		wsocket.onmessage = onMessage;
		wsocket.onclose = onClose;
	}

	function onOpen(evt) {
		console.log("websocket 연결");
	}

	function onClose(evt) {
		console.log("websocket 연결해제");
	}
	
	//로그아웃에서 호출할 함수 (연결해제)
	function disconnect() {
		wsocket.close();
	}

	//websocket 에서 전송된 메시지 받는 함수
	function onMessage(evt) {
		var data = evt.data;
		appendMessage(data);
	}
	
	//websocket에 메시지 전달(기안시, 결재시 호출할 함수)
	function send(draftEmp,empSign,signCode) {
		wsocket.send(draftEmp + "," + empSign + "," + signCode);
	}

	//websocket에서 전송된 메시지 뿌려주는 함수
	function appendMessage(msg) {
		toastr.info(msg, '전자결재 알림', {timeOut: 5000});
 		//signNotify(msg);
	}

	//notifications : http 적용불가
    function signNotify(msg) {
        //알림 권한이 없으면 경고창
        if (Notification.permission !== 'granted') {
            swal("warning", "notification is disabled", "warning")
        }else {
            var instance = new Notification('Notification title', {
                icon: '${pageContext.request.contextPath}/resources/hari/assets/images/favicon.png',
                body: msg,
            });

            instance.onclick = function () {
                location.href='${pageContext.request.contextPath}/1hariSign/signHome.hari';
            };
        }
    }
</script>