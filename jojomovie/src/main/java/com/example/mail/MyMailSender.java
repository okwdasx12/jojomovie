package com.example.mail;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

import com.example.domain.MemberVo;

@Component
public class MyMailSender {

	@Autowired
	private JavaMailSender mailSender;

	private static final String FROM_ADDRESS = "jojotest@naver.com";

	public void sendTextMail(MemberVo membervo) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setFrom(FROM_ADDRESS);
		message.setTo(membervo.getUserEmail());
		// string ...to --> 여러명 보낼 수 있음 // 배열... !전체공지!
		message.setSubject("[조조무비] 회원가입을 축하드립니다.");
		message.setText("조조무비를 가입해 주셔서 감사합니다.");

		mailSender.send(message);

	}

	public void sendAuthMail(String userEmail, String AuthNum) {

		SimpleMailMessage message = new SimpleMailMessage();
		message.setFrom(FROM_ADDRESS);
		message.setTo(userEmail);
		message.setSubject("[조조무비] 회원가입 인증 이메일입니다.");
		message.setText("인증번호는 [" + AuthNum + "] 입니다.");

		mailSender.send(message);
	}

	public void sendchangePasswdMail(String userEmail, String ranPasswdNum) {

		SimpleMailMessage message = new SimpleMailMessage();
		message.setFrom(FROM_ADDRESS);
		message.setTo(userEmail);
		message.setSubject("[조조무비] 임시 비밀번호 발급입니다.");
		message.setText("임시 비밀번호는 [" + ranPasswdNum + "] 입니다.");

		mailSender.send(message);

	}

}
