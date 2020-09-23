package com.example.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.MemberVo;
import com.example.domain.PageDto;
import com.example.domain.PayVo;
import com.example.domain.ReserveVo;
import com.example.domain.TimeVo;
import com.example.service.AdminService;
import com.example.service.InquireService;
import com.example.service.MemberService;
import com.example.service.MypageService;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping("/mypage/*")
public class MypageController {
	
	@Autowired
	private MypageService mypageService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private InquireService inquireService;
	
	@Autowired
	private AdminService adminService;
	
	// 마이페이지
	@GetMapping("")
	public String mypage(
			Model model,
			HttpSession session) {
		String userId = (String) session.getAttribute("userId");
		MemberVo memberVo = mypageService.myinfo(userId);
		String grade = memberVo.getGrade();
		LocalDateTime ldt = LocalDateTime.now();
		
		List<ReserveVo> myReserveList = mypageService.myReserve(userId, ldt);
		List<ReserveVo> myReservePreList = mypageService.myReservePre(userId, ldt);

		int total = inquireService.getInquireTotalCount(userId, grade);
		int ing = inquireService.getInquireIngCount(userId, grade);
		int fin = inquireService.getInquireFinCount(userId, grade);
		
		PageDto pageDto = new PageDto();
		pageDto.setTotal(total);
		pageDto.setIng(ing);
		pageDto.setFin(fin);
		
		model.addAttribute("memberVo", memberVo);
		model.addAttribute("pageDto", pageDto);
		model.addAttribute("reserveList", myReserveList);
		model.addAttribute("reservePreList", myReservePreList);
		
		return "mypage/mypage";
	}
	
	// 예매 내역
	@GetMapping("/reserveInfo")
	@ResponseBody
	public Map<String, Object> reserveInfo(int reserveNumber) {
		ReserveVo reserveVo = mypageService.reserveInfo(reserveNumber);
		PayVo payVo = mypageService.payInfo(reserveVo.getPayId());
		
		LocalDateTime ldt = reserveVo.getSangyoungTime();
		LocalDate ldtDate = LocalDate.from(ldt);
		String ldtTime = ldt.format(DateTimeFormatter.ofPattern("HH:SS"));
		
		Map<String, Object> map = new HashMap<>();
		map.put("movieName", reserveVo.getMovieName());
		map.put("teatherName", reserveVo.getTheaterName());
		map.put("sygId", reserveVo.getSygId());
		map.put("sangyoungDate", ldtDate);
		map.put("sangyoungTime", ldtTime);
		map.put("seat", reserveVo.getSeat());
		map.put("usePoint", payVo.getUsepoint());
		map.put("totalPrice", payVo.getTotalPrice());
		map.put("payId", payVo.getPayId());
		
		return map;
	}
	
	//예매 취소
	@PostMapping("/delReserve")
	public String delReserve(int reserveNumber, PayVo payVo, ReserveVo reserveVo, HttpSession session) {
		String userId = (String) session.getAttribute("userId");
		
		reserveVo = mypageService.reserveInfo(reserveNumber);
		payVo = mypageService.payInfo(reserveVo.getPayId());
		TimeVo timeVo = adminService.getAllReserveSeats(reserveVo.getSygId(), reserveVo.getSangyoungTime());
		
		String[] arrayStr = timeVo.getReserveSeats().split(",");
		
		String stst="";
		String str = reserveVo.getSeat();
		String[] arrayDelStr = str.split(",");
		
		List<String> list = new ArrayList<>();
		for(int j = 0; j<arrayStr.length;j++) {
			list.add(arrayStr[j]);
		}
		for(int i = 0;i<arrayDelStr.length;i++) {
			list.remove(arrayDelStr[i]);
		}
		for(int i=0;i<list.size();i++) {
			if(i!=list.size()-1) {
				stst+=list.get(i) + ",";
			}else {
				stst+=list.get(i);
			}
		}
		
		MemberVo memberVo = memberService.getMemberById(userId);
		
		int userPoint = memberVo.getPoint();
		int point = payVo.getPoint();
		int usePoint = payVo.getUsepoint();
		int returnPoint = userPoint - point + usePoint;
		
		adminService.timeSetUpdate(stst, reserveVo.getSygId(), reserveVo.getSangyoungTime());
		adminService.memberPointUpgrade(returnPoint, userId);
		adminService.deletePay(payVo.getPayId());
		adminService.deleteReserve(reserveVo.getReserveNumber());

		return "redirect:/mypage/";
	}
	
	// 회원 정보 수정
	@PostMapping("update")
	public ResponseEntity<String> update(MemberVo vo) {
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "text/html; charset=UTF-8");
		
		StringBuilder sb = new StringBuilder(); // String 형태도 가능
		sb.append("<script>");
		sb.append("alert('회원 정보 수정 됨');");
		sb.append("location.href='/mypage/';");
		sb.append("</script>");
		
		mypageService.update(vo);
		
		return new ResponseEntity<String>(sb.toString(), headers, HttpStatus.OK);
	}
	
	// 회원 탈퇴
	@PostMapping("delete")
	public ResponseEntity<String> delete(String userId, String deletePasswd, 
			HttpSession session,
			HttpServletRequest request,
			HttpServletResponse response) {
		userId = (String) session.getAttribute("userId");
		
		// -1: 아이디 없음, 0: 비밀번호 틀림, 1: 아이디 비밀번호 일치
		int check = memberService.userCheck(userId, deletePasswd);
		// 실패시
		if (check == 0) {
			String message ="비밀번호 틀림";
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type", "text/html; charset=UTF-8");
			
			StringBuilder sb = new StringBuilder();
			sb.append("<script>");
			sb.append("alert('"+ message +"');");
			sb.append("history.back();");
			sb.append("</script>");
			
			return new ResponseEntity<String>(sb.toString(), headers, HttpStatus.OK);
		}
		
		session.invalidate();
		
		// 로그인 상태유지용 쿠키가 존재하면 삭제
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				 if (cookie.getName().equals("userId")) {
					 cookie.setMaxAge(0); // 유효기간 0 설정
					 cookie.setPath("/"); // 경로 설정
					 response.addCookie(cookie); // 클라이언트로 응답 보냄
				 }
			}
		}
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "text/html; charset=UTF-8");
		
		StringBuilder sb = new StringBuilder(); // String 형태도 가능
		sb.append("<script>");
		sb.append("alert('회원 탈퇴 됨');");
		sb.append("location.href='/';");
		sb.append("</script>");
		
		mypageService.delete(userId);
		
		return new ResponseEntity<String>(sb.toString(), headers, HttpStatus.OK);
	}
}