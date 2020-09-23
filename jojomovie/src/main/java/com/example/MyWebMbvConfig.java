package com.example;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.example.interceptor.MemberLoginCheckInterceptor;
import com.example.interceptor.MemberStayLoggedInInterceptor;

@Configuration // 컴포넌트계열,  이 클래스를 스프링의 설정으로? 스프링 생성할 때 자동 등록 
public class MyWebMbvConfig implements WebMvcConfigurer {

	// 컨트롤러 인터셉터 
	@Autowired // 이필드에 선언함  자동주입  이 클래스가 spring bean이여야 함 // 컴포넌트쓰면 스프링빈 됨
	private MemberLoginCheckInterceptor memberLoginCheckInterceptor;
	@Autowired
	private MemberStayLoggedInInterceptor memberStayLoggedInInterceptor;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		
		InterceptorRegistration reg = registry.addInterceptor(memberLoginCheckInterceptor);
		reg.addPathPatterns("/mypage/*").addPathPatterns("/inquire/*").addPathPatterns("/reservation/*").addPathPatterns("/admin/*"); // 파일인것에만 기능 적용
		
		registry.addInterceptor(memberStayLoggedInInterceptor)
		.addPathPatterns("/*");
		
	}



	
}
