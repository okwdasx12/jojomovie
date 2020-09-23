package com.example.controller;

import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.domain.InquireVo;
import com.example.domain.MemberVo;
import com.example.domain.PageDto;
import com.example.service.InquireService;
import com.example.service.MemberService;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping("/inquire/*")
public class InquireController {
	
	@Autowired
	private InquireService inquireService;
	
	@Autowired
	private MemberService memberService;

	@GetMapping("")
	public String inquire(
			@RequestParam(defaultValue = "1") int pageNum,			
			@RequestParam(defaultValue = "") String category,
			@RequestParam(defaultValue = "") String search,
			Model model,
			HttpSession session) {
		// 세션에서 아이디 값 가져오기
		String userId = (String) session.getAttribute("userId");
		
		// =================== 한페이지에 해당하는 글목록 구하기 작업 ===================
		
		// 한 페이지에 가져올 글 갯수
		int pageSize = 10;
		
		// 시작행 인덱스번호 구하기(수식)
		int startRow = (pageNum - 1) * pageSize;
		
		// 회원등급 가져오기
		MemberVo vo = memberService.getMemberById(userId);
		String grade = vo.getGrade();
		
		// 변수 선언
		int total = 0;
		int ing = 0;
		int fin = 0;
		int totalCount = 0;
		List<InquireVo> list = null;
		
		// 문의 글 갯수
		total = inquireService.getInquireTotalCount(userId, grade);
		ing = inquireService.getInquireIngCount(userId, grade);
		fin = inquireService.getInquireFinCount(userId, grade);
		
		// 전체 글 갯수 (문의 + 답변)
		totalCount = inquireService.getTotalCount(category, search, userId, grade);
		
		// 원하는 페이지의 글을 가져오는 메소드
		if (totalCount > 0) {
			list = inquireService.getInquires(startRow, pageSize, category, search, userId, grade);
		}
		
		// =================== 페이지 블록 관련정보 구하기 작업 ===================
	
		// 총 페이지 수 구하기
		/*int pageCount = (totalCount / pageSize) + (totalCount % pageSize == 0 ? 0 : 1);*/ // 삼항연산자 활용가능
		int pageCount = (totalCount / pageSize);
		if (totalCount % pageSize > 0) {
			pageCount += 1;
		}
		
		// 화면에 보여줄 페이지 번호의 갯수 설정
		int pageBlock = 10;
		
		// 페이지블록의 시작페이지 구하기!
		int startPage = ((pageNum / pageBlock) - (pageNum % pageBlock == 0 ? 1 : 0 )) * pageBlock + 1;
		
		// 페이지블록의 끝페이지
		int endPage = startPage + pageBlock - 1;
		if (endPage > pageCount) { // 글 없는 페이지 번호 안주기 
			endPage = pageCount;
		}
		
		PageDto pageDto = new PageDto();
		pageDto.setTotalCount(totalCount);
		pageDto.setTotal(total);
		pageDto.setIng(ing);
		pageDto.setFin(fin);
		pageDto.setPageCount(pageCount);
		pageDto.setPageBlock(pageBlock);
		pageDto.setStartPage(startPage);
		pageDto.setEndPage(endPage);
		pageDto.setCategory(category);
		pageDto.setSearch(search);
		
		// 뷰(jsp)에서 사용할 데이터를 model 객체에 저장해놓으면
		// 스프링 프론트컨트롤러가  request 영역객체로 옮겨줌
		model.addAttribute("inquireList", list);
		model.addAttribute("pageDto", pageDto);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("grade", vo.getGrade());
		
		return "board/inquire";
	} // list()
	
	@GetMapping("/content")
	public String content(int num, 
			@ModelAttribute("pageNum") String pageNum, 
			Model model,
			HttpSession session) {
		// 글 한 개 가져오기
		InquireVo inquireVo = inquireService.getInquireByNum(num);
		
		// 내용에서 엔터키 줄바꿈 \r\n -> <br> 바꾸기
		String content = "";
		if (inquireVo.getContent() != null) {
			content = inquireVo.getContent().replace("\r\n", "<br>");
			inquireVo.setContent(content);
		}
		
		String userId = (String) session.getAttribute("userId");
		MemberVo memberVo = memberService.getMemberById(userId);
		
		model.addAttribute("inquireVo", inquireVo);
		model.addAttribute("grade", memberVo.getGrade());
		
		return "board/inquireContent";
	}
	
	@GetMapping("/write")
	public String write() {
		return "board/inquireWrite";
	}
	
	@PostMapping("/write")
	public String write(InquireVo inquireVo, HttpServletRequest request) {
		// ip주소  작성일자 값 저장
		inquireVo.setIp(request.getRemoteAddr());
		inquireVo.setRegDate(LocalDateTime.now());
		
		// 주글 한개 등록
		inquireService.insertInquire(inquireVo);
		
		return "redirect:/inquire/";
	}
	
	@GetMapping("/modify")
	public String modify(int num, 
			@ModelAttribute("pageNum") String pageNum, 
			Model model) {
		InquireVo inquireVo = inquireService.getInquireByNum(num);
		
		// 내용에서 엔터키 줄바꿈 \r\n -> <br> 바꾸기
		String content = "";
		if (inquireVo.getContent() != null) {
			content = inquireVo.getContent().replace("\r\n", "<br>");
			inquireVo.setContent(content);
		}
				
		model.addAttribute("inquireVo", inquireVo);
		
		return "board/inquireModify";
	}
	
	@PostMapping("/modify")
	public String modify(
			InquireVo inquireVo, 
			HttpServletRequest request,
			int num, 
			@ModelAttribute("pageNum") String pageNum,
			Model model) {
		// ip주소  작성일자 값 저장
		inquireVo.setIp(request.getRemoteAddr());
		inquireVo.setRegDate(LocalDateTime.now());
		
		inquireService.updateInquire(inquireVo);
		
		return "redirect:/inquire/content?num="+inquireVo.getNum()+"&pageNum="+pageNum;
	}
	
	@GetMapping("/reply")
	public String reply(int num, 
			@ModelAttribute("pageNum") String pageNum, 
			Model model) {
		InquireVo inquireVo = inquireService.getInquireByNum(num);
		
		// 내용에서 엔터키 줄바꿈 \r\n -> <br> 바꾸기
		String content = "";
		if (inquireVo.getContent() != null) {
			content = inquireVo.getContent().replace("\r\n", "<br>");
			inquireVo.setContent(content);
		}
				
		model.addAttribute("inquireVo", inquireVo);
		
		return "board/inquireReply";
	}
	
	@PostMapping("/reply")
	public String reply(int num, InquireVo inquireVo, HttpServletRequest request) {
		// ip주소  작성일자 값 저장
		inquireVo.setIp(request.getRemoteAddr());
		inquireVo.setRegDate(LocalDateTime.now());
		inquireVo.setReRef(num);
		
		inquireService.replyInquire(inquireVo);
		
		return "redirect:/inquire/inquire";
	}
	
	@GetMapping("/delete")
	public String delete(int num) {
		inquireService.deleteInquire(num);
		
		return "redirect:/inquire/";
	}
}
