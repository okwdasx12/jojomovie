package com.example;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import com.example.websocket.SocketHandler;

@Configuration
@EnableWebSocket // 웹소켓 서버 기능 활성화하기
public class MyWebSocketConfig implements WebSocketConfigurer {
	
	@Autowired
	private SocketHandler webSocketHandler;

	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(webSocketHandler, "/chating")
				.addInterceptors(new HttpSessionHandshakeInterceptor()) 
				// HttpSession에 있는 attributes 값들을 WebSocketSession으로 복사해줌!
				.setAllowedOrigins("*");
		
		
	}
	

}
