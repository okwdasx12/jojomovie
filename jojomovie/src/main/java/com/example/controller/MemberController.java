package com.example.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.MemberVo;
import com.example.mail.MyMailSender;
import com.example.service.MemberService;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MyMailSender mailSender;

	//@RequestMapping(value = "/join", method = RequestMethod.GET)
	@GetMapping("/join")
	public void join() {
		//return "member/join";  // 메소드 리턴타입이 String일때
	}
	
	@ResponseBody
	@RequestMapping("/joinEmailDupCheck")
	public boolean joinEmailDupCheck(String userEmail, String AuthNum) {
		boolean result = false;
		
		boolean isEmailDup = memberService.isEmailDuplicated(userEmail);
		
		if (isEmailDup == true) { // 중복값 있을 경우 
			result = true;
		} else {  // 중복값 없을경우
			mailSender.sendAuthMail(userEmail, AuthNum);
			
			result = false;
		}
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/joinAuthEmailCheck")
	public boolean joinAuthEmailCheck(String emailAuth, String AuthNum) {
		boolean authCheck = false;
		
		if(!emailAuth.equals(AuthNum)) {
			 authCheck = false;
		} else {
			 authCheck = true;
		}
	
		return authCheck;
	}
	
	@PostMapping("/join")
	public String join(MemberVo memberVo) {
		// 회원가입처리
		memberService.insert(memberVo);
		
		//회원가입 메일전송
		mailSender.sendTextMail(memberVo);
		
		return "redirect:/member/login";
	}
	
	@RequestMapping("/joinIdDupCheck")
	public String joinIdDupCheck(String userId, Model model) {  
		// 호출할 때 매개변수 확인해서 값 찾음 
		log.info("userId : " + userId );
		
		// 아이디 중복여부 값 구하기
		boolean isIdDup = memberService.isIdDuplicated(userId);
		
		// model 타입 객체에 뷰(JSP)에서 사용할 데이터를 저장하기(싣기)
		model.addAttribute("isIdDup", isIdDup);
		model.addAttribute("userId",userId);
		
		return "member/join_IDCheck";
	}
	
	@GetMapping("/login")
	public void login() {}
	
	@ResponseBody
	@RequestMapping("/findId")
	public String findId(String userName, String userPhone) {
		String userId = memberService.findId(userName, userPhone);
		
		return userId;
	}
	
	@ResponseBody
	@RequestMapping("/findPasswd")
	public boolean findPasswd(String userId, String userEmail, String ranPasswdNum) {
		boolean result = false;
		
		boolean isIdEmailCheck = memberService.isIdEmailCheck(userId, userEmail);
		
		if(isIdEmailCheck == false) { // 아이디 이메일 없을 경우 
			result = false;
		} else { // 아이디 이메일 해당 값 있을 경우 
			// 비밀번호 바꾸기 
			memberService.changePasswd(userId, ranPasswdNum);
			// 이메일 전송
			mailSender.sendchangePasswdMail(userEmail, ranPasswdNum);
			
			return true;
		}
		return result;
	}
	
	@PostMapping("/login")
	public ResponseEntity<String> login(String userId, String passwd, 
			@RequestParam(defaultValue = "false") boolean keepLogin,
			HttpSession session,
			HttpServletResponse response) {
			
		if("".equals(userId)) {
			
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type", "text/html; charset=UTF-8");
			
			StringBuilder sb = new StringBuilder();
			sb.append("<script>");
			sb.append("alert('아이디를 입력하세요.');");
			sb.append("history.back();");
			sb.append("</script>");
			
			return new ResponseEntity<String>(sb.toString(), headers, HttpStatus.OK);
		}
		
		if("".equals(passwd)) {
			
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type", "text/html; charset=UTF-8");
			
			StringBuilder sb = new StringBuilder();
			sb.append("<script>");
			sb.append("alert('비밀번호를 입력하세요.');");
			sb.append("history.back();");
			sb.append("</script>");
			
			return new ResponseEntity<String>(sb.toString(), headers, HttpStatus.OK);
		}
			
		// -1: 아이디 없음, 0: 비밀번호 틀림, 1: 아이디 비밀번호 일치
		int check = memberService.userCheck(userId, passwd);
		
		// 로그인 실패시
		if(check != 1) {
			String message = "";
			if (check == 0) {
				message ="비밀번호 틀림";
				} else if (check == -1) {
					message = "아이디없음";
				}
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type", "text/html; charset=UTF-8");
			
			StringBuilder sb = new StringBuilder();
			sb.append("<script>");
			sb.append("alert('"+ message +"');");
			sb.append("history.back();");
			sb.append("</script>");
			
			return new ResponseEntity<String>(sb.toString(), headers, HttpStatus.OK);
		}
		
		// 로그인 성공시 
		// 세션에 아이디 저장(로그인 인증)
		session.setAttribute("userId", userId);
		MemberVo vo = memberService.getMemberById(userId);
		String grade = vo.getGrade();
		
		session.setAttribute("grade", grade);
		
		// 로그인 상태유지 원하면 쿠키 생성 후 응답주기
		if (keepLogin) { // keepLogin == true
			Cookie idCookie = new Cookie("userId", userId);
			idCookie.setMaxAge(60*10); // (초단위 설정) 10분
			idCookie.setPath("/"); // 쿠키경로설정
			response.addCookie(idCookie); // 응답객체에 추가
		}
		// return "redirect:/";
		HttpHeaders headers = new HttpHeaders();
		headers.add("Location", "/"); // redirect 경로 위치 지정 
		// 리다이렉트일 경우 HttpStatus.FOUND 지정해야함
		return new ResponseEntity<>(headers, HttpStatus.FOUND); //새로운 경로 찾음
 	} // login
	
	@GetMapping("/logout")
	public ResponseEntity<String> logout(HttpSession session,
			HttpServletRequest request,
			HttpServletResponse response) {
		//세션값 초기화
		session.invalidate();
		
		// 로그인 상태유지용 쿠키가 존재하면 삭제
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("userId")) {
					cookie.setMaxAge(0); // 유효기간 0 설정
					cookie.setPath("/"); // 경로 설정
					response.addCookie(cookie);
				}
			}
		}
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "text/html; charset=UTF-8");
		
		StringBuilder sb = new StringBuilder();
		sb.append("<script>");
		sb.append("alert('로그아웃됨');");
		sb.append("location.href = '/';");
		sb.append("</script>");
		
		return new ResponseEntity<String>(sb.toString(), headers, HttpStatus.OK);
		
	} // logout
}
