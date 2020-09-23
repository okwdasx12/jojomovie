package com.example.mail;

import java.io.File;
import java.io.IOException;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

public class MailHandler {
	
	private JavaMailSender mailSender;
	
	private MimeMessage message;
	
	private MimeMessageHelper messageHelper;
	
	// 생성자
	public MailHandler(JavaMailSender mailSender) throws MessagingException {
		this.mailSender = mailSender;
		
		message = mailSender.createMimeMessage();
		messageHelper = new MimeMessageHelper(message, true, "utf-8");
	}

	// 보내는 사람 이메일 주소  //메세지객체를 잡고 있는 헬퍼사용 
	public void setFrom(String fromEmailAddr) throws MessagingException{
		messageHelper.setFrom(fromEmailAddr);
	}
	
	// 받는 사람 이메일 주소 
	public void setTo(String toEmailAddr) throws MessagingException {
		messageHelper.setTo(toEmailAddr); 
	}
	
	// 메일 제목
	public void setSubject(String subject) throws MessagingException {
		messageHelper.setSubject(subject);
	}
	
	// 메일 내용
	public void setText(String text, boolean useHtml) throws MessagingException {
		messageHelper.setText(text, useHtml); // true이면 html문서임을 알려줌 
	}

	// 첨부 파일
	public void setAttach(String displayFileName, String pathToattachment) throws MessagingException, IOException { // displayname : 사용자에게 보여질 파일 이름 
		File file = new ClassPathResource(pathToattachment).getFile();
		
		messageHelper.addAttachment(displayFileName, file);
	}

	// 이미지 삽입
	public void setInline(String contentId, String pathToInline)throws MessagingException, IOException {
		File file = new ClassPathResource(pathToInline).getFile();
		
		messageHelper.addInline(contentId, file);
	}
	
	// 발송
	public void send() { 
		mailSender.send(message);
		
	}
}
