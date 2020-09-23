package com.example.controller;

import java.io.File;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.domain.AttachVo;
import com.example.domain.MemberVo;
import com.example.domain.MovieVo;
import com.example.domain.PageDto;
import com.example.domain.PayVo;
import com.example.domain.ReserveVo;
import com.example.domain.SangyounggwanVo;
import com.example.domain.TheaterVo;
import com.example.domain.TimeVo;
import com.example.service.AdminService;
import com.example.service.SangyoungTimeService;
import com.example.service.SangyounggwanService;
import com.example.service.TheaterService;
import com.google.gson.Gson;

import lombok.extern.java.Log;

@Controller
@RequestMapping("/admin/*")
@Log
public class AdminController {

	@Autowired
	private AdminService adminService;

	@Autowired
	private TheaterService theaterService;

	@Autowired
	private SangyounggwanService sangyounggwanService;

	@Autowired
	private SangyoungTimeService sangyoungTimeService;

	@GetMapping("/adminPage")
	public String adminPage() {
		return "/admin/adminPage";
	}

	// 영화관 추가!
	@PostMapping("/addMovie")
	public String addMovie(HttpServletRequest request, @RequestParam("filename") List<MultipartFile> files,
			MovieVo movieVo) throws Exception {
		AttachVo attachVo = new AttachVo();

		// 일반 게시물 디비에서 넘 가져와서 파일 vo에 넘겨주기
		int movieId = adminService.getBoardMovieId();

		movieVo.setMovieId(movieId);
		attachVo.setMovieId(movieId);

		String movieName = movieVo.getMovieName();

		// 애플리케이션 내장객체
		ServletContext application = request.getServletContext();
		String path = application.getRealPath("/upload2");

		String strDate = this.getFoleder(); // 같은 컨트롤러 안에 getFoleder를 만들어줌.

		File dir = new File(path, strDate); // (path) -> /webapp/upload strDate로 만들어준거->/2020/06/16
		if (!dir.exists()) { // exists -> 폴더, 텍스트 종류 상관없이 존재하는지 여부를 알려줌.
			dir.mkdirs(); // dir이 존재하지 않는다면, 폴더를 생성해달라는 말. //mkdir 는 temp가 있어야 생성되지만, mkdirs는 temp까지도 생성해
							// 줌
		}

		// 첨부파일정보 담을 리스트 준비
		List<AttachVo> list = new ArrayList<>();

		for (MultipartFile multipartFile : files) { // file을 multipart형식으로 변환?
			if (multipartFile.isEmpty()) {
				continue;
			}

			String filename = multipartFile.getOriginalFilename(); // 파일명가져오기
			// 익스플로러는 파일이름에 경로가 포함되있으므로

			// 순수 파일이름만 부분문자열로 가져오기
			int index = filename.lastIndexOf("\\") + 1; // "\\"를 발견한 즉시 그 인덱스 값.

			filename = filename.substring(index); // index값에서 부터 잘라줘 이걸 기준으로 이후 값 다 가져오기

			String StrmovieName = movieId + ".jpg";
			// 업로드(생성)할 파일이름
			String uploadFilename = StrmovieName; // 앞에 랜덤 고유값 붙이고, 파일 네임에서 잘라온 파일 이름 붙이기

			// 생성할 파일정보 File 객체로 준비
			File saveFile = new File(dir, uploadFilename); // 부모 디렉토리를 파라미터로 인스턴스 생성(파일)

			multipartFile.transferTo(saveFile); // 임시업로드된 파일을 지정경로의 파일명으로 복사
			// 파일 데이터를 지정한 폴더로 저장

			// 파일정보 담기위한 AttachfileVo 객체 생성
			attachVo.setMovieId(movieId);
			attachVo.setMovieName(movieName);
			attachVo.setUploadpath(dir.getPath().replace("\\", "/"));

			attachVo.setUuid(StrmovieName);
			attachVo.setFilename(StrmovieName);

			list.add(attachVo);
		} // for

		adminService.insertBoardAndAttaches(movieVo, list);

		return "redirect:/admin/searchMovie";
	}

	// 영화관 추가 페이지 링크
	@GetMapping("/addMovie")
	public String addMovie() {
		return "/admin/addMovie";
	}

	//////////////////////// 예매 상세 내역... 기간 별로 정렬시킨 후, 취소내역, 결제여부 버튼 클릭시 띄울 수 있게 +
	//////////////////////// 페이징
	//////////////////////// ////////////////////////////////////////////////////////////////

	@GetMapping("/reserveManage")
	public String reserveManage(Model model, @RequestParam(defaultValue = "") String ticketId) {

		ReserveVo reservVo = adminService.selectReserv(ticketId);

		List<PayVo> paylist = reservVo.getPayList();

		model.addAttribute("reserveVo", reservVo);
		model.addAttribute("paylist", paylist);

		return "/admin/reserveManage";
	}

	/////////////////// 전체 예매
	/////////////////// 페이징///////////////////////////////////////////////////////////////////////
	@GetMapping("/reserveList")
	public String reserveList(@RequestParam(defaultValue = "1") int pageNum,
			@RequestParam(defaultValue = "") String category, @RequestParam(defaultValue = "") String search,
			Model model) {
		// 전체 글 카운트
		int totalCount = adminService.getCountReserv(category, search); // 10개

		// 한 페이지 당 5개씩 띄우기
		int pageSize = 5;
		// 시작행 번호 limit 앞 부분 5, 10, 15
		// startRow = (1 - 1 ) * 5 // (2-1) * 5 = 5
		int startRow = (pageNum - 1) * pageSize;

		// 원하는 페이지 글 가져오기 총 갯수가 0을 넘어설시에
		List<ReserveVo> list = null;
		if (totalCount > 0) {
			list = adminService.Listreserv(startRow, pageSize, category, search);
		}

		// 페이지 관련 블록~ [1] [2] [3] 5개

		// 만약 11개 11 / 5 = 2 + 1 -> 총 블록 3개
		int pageCount = totalCount / pageSize;

		if (totalCount % pageSize > 0) {
			pageCount += 1;
		}

		// 5개를 보여줄거임 페이지블록
		int pageBlock = 5;

		// 페이지 블록 시작페이지
		int startPage = ((pageNum / pageBlock) - (pageNum % pageBlock == 0 ? 1 : 0)) * pageBlock + 1;
		// = (1 / 5) - (1 % 5 == 0 ? 1 : 0) * 5 + 1 = 1
		// = (2/ 5) - (2 % 5 == 0 ? 1 : 0) * 5 +1 = 1

		// 페이지 블록 끝페이지
		int endPage = startPage + pageBlock - 1;
		// 1 + 5 - 1 = 5;

		if (endPage > pageCount) {
			endPage = pageCount;
		}

		PageDto pageDto = new PageDto();
		pageDto.setTotalCount(totalCount);
		pageDto.setPageCount(pageCount);
		pageDto.setPageBlock(pageBlock);
		pageDto.setStartPage(startPage);
		pageDto.setEndPage(endPage);
		pageDto.setCategory(category);
		pageDto.setSearch(search);

		model.addAttribute("AllResv", list);
		model.addAttribute("pageDto", pageDto);
		model.addAttribute("pageNum", pageNum);

		return "/admin/reserveList";
	}

/////////		영화 검색 목록 페이징 		////////////////////////
///////////////////////////////////////////////////////////////////////
//	검색결과 목록 뽑아오깅~
	@GetMapping("/searchMovie")
	public String searchBoardList(@RequestParam(defaultValue = "1") int pageNum,
			@RequestParam(defaultValue = "") String category, @RequestParam(defaultValue = "") String search,
			Model model) {

		// 전체 글 카운트
		int totalCount = adminService.getTotalCount(category, search); // 10개

		// 한 페이지 당 5개씩 띄우기
		int pageSize = 5;
		// 시작행 번호 limit 앞 부분 5, 10, 15
		// startRow = (1 - 1 ) * 5 // (2-1) * 5 = 5
		int startRow = (pageNum - 1) * pageSize;

		// 원하는 페이지 글 가져오기 총 갯수가 0을 넘어설시에
		List<MovieVo> list = null;

		if (totalCount > 0) {
			list = adminService.getBoards(startRow, pageSize, category, search);
		}

		// 페이지 관련 블록~ [1] [2] [3] 5개

		// 만약 11개 11 / 5 = 2 + 1 -> 총 블록 3개
		int pageCount = totalCount / pageSize;

		if (totalCount % pageSize > 0) {
			pageCount += 1;
		}

		// 5개를 보여줄거임 페이지블록
		int pageBlock = 5;

		// 페이지 블록 시작페이지
		int startPage = ((pageNum / pageBlock) - (pageNum % pageBlock == 0 ? 1 : 0)) * pageBlock + 1;
		// = (1 / 5) - (1 % 5 == 0 ? 1 : 0) * 5 + 1 = 1
		// = (2/ 5) - (2 % 5 == 0 ? 1 : 0) * 5 +1 = 1

		// 페이지 블록 끝페이지
		int endPage = startPage + pageBlock - 1;
		// 1 + 5 - 1 = 5;

		if (endPage > pageCount) {
			endPage = pageCount;
		}

		PageDto pageDto = new PageDto();
		pageDto.setTotalCount(totalCount);
		pageDto.setPageCount(pageCount);
		pageDto.setPageBlock(pageBlock);
		pageDto.setStartPage(startPage);
		pageDto.setEndPage(endPage);
		pageDto.setCategory(category);
		pageDto.setSearch(search);

		model.addAttribute("movieList", list);
		model.addAttribute("pageDto", pageDto);
		model.addAttribute("pageNum", pageNum);

		return "/admin/searchMovie";
	}

//////////////////		회원관리 페이지 		////////////////////////////////
	@GetMapping("/memberManage")
	public String memberManage(@RequestParam(defaultValue = "1") int pageNum,
			@RequestParam(defaultValue = "") String category, @RequestParam(defaultValue = "") String search,
			Model model) {
		// 전체 글 카운트
		int totalCount = adminService.countAllMember(category, search); // 10개

		// 한 페이지 당 5개씩 띄우기
		int pageSize = 10;
		// 시작행 번호 limit 앞 부분 5, 10, 15
		// startRow = (1 - 1 ) * 5 // (2-1) * 5 = 5
		int startRow = (pageNum - 1) * pageSize;

		// 원하는 페이지 글 가져오기 총 갯수가 0을 넘어설시에
		List<MemberVo> list = null;
		if (totalCount > 0) {
			list = adminService.memberManage(startRow, pageSize, category, search);
		}

		// 페이지 관련 블록~ [1] [2] [3] 5개

		// 만약 11개 11 / 5 = 2 + 1 -> 총 블록 3개
		int pageCount = totalCount / pageSize;

		if (totalCount % pageSize > 0) {
			pageCount += 1;
		}

		// 5개를 보여줄거임 페이지블록
		int pageBlock = 5;

		// 페이지 블록 시작페이지
		int startPage = ((pageNum / pageBlock) - (pageNum % pageBlock == 0 ? 1 : 0)) * pageBlock + 1;
		// = (1 / 5) - (1 % 5 == 0 ? 1 : 0) * 5 + 1 = 1
		// = (2/ 5) - (2 % 5 == 0 ? 1 : 0) * 5 +1 = 1

		// 페이지 블록 끝페이지
		int endPage = startPage + pageBlock - 1;
		// 1 + 5 - 1 = 5;

		if (endPage > pageCount) {
			endPage = pageCount;
		}

		PageDto pageDto = new PageDto();
		pageDto.setTotalCount(totalCount);
		pageDto.setPageCount(pageCount);
		pageDto.setPageBlock(pageBlock);
		pageDto.setStartPage(startPage);
		pageDto.setEndPage(endPage);
		pageDto.setCategory(category);
		pageDto.setSearch(search);

		model.addAttribute("memList", list);
		model.addAttribute("pageDto", pageDto);
		model.addAttribute("pageNum", pageNum);

		return "/admin/memberManage";
	}

	////////////////// 영화 수정 ////////////////////////////
	// 수정 폼
	@GetMapping("/ModifyMovie")
	public String ModifyMovie(String movieId, Model model) {
		MovieVo vo = adminService.ListGetOne(movieId);

		model.addAttribute("movieVo", vo);

		return "/admin/ModifyMovie";
	}

	@PostMapping("/ModifyMovie")
	public String ModifyMovie(MovieVo vo, int movieId, HttpServletRequest request,
			@RequestParam("filename") List<MultipartFile> files) throws Exception {

		vo.setMovieId(movieId);

		String movieName = vo.getMovieName();

		// 애플리케이션 내장객체
		ServletContext application = request.getServletContext();
		String path = application.getRealPath("/upload2");

		String strDate = this.getFoleder(); // 같은 컨트롤러 안에 getFoleder를 만들어줌.

		File dir = new File(path, strDate); // (path) -> /webapp/upload strDate로 만들어준거->/2020/06/16
		if (!dir.exists()) { // exists -> 폴더, 텍스트 종류 상관없이 존재하는지 여부를 알려줌.
			dir.mkdirs(); // dir이 존재하지 않는다면, 폴더를 생성해달라는 말. //mkdir 는 temp가 있어야 생성되지만, mkdirs는 temp까지도 생성해줌
		}

		// 첨부파일정보 담을 리스트 준비
		List<AttachVo> list = new ArrayList<>();

		for (MultipartFile multipartFile : files) { // file을 multipart형식으로 변환?
			if (multipartFile.isEmpty()) {
				continue;
			}

			String filename = multipartFile.getOriginalFilename(); // 파일명가져오기
			// 익스플로러는 파일이름에 경로가 포함되있으므로
			// 순수 파일이름만 부분문자열로 가져오기
			int index = filename.lastIndexOf("\\") + 1; // "\\"를 발견한 즉시 그 인덱스 값.

			filename = filename.substring(index); // index값에서 부터 잘라줘 이걸 기준으로 이후 값 다 가져오기

			String StrmovieName = movieId + ".jpg";
			// 업로드(생성)할 파일이름
			String uploadFilename = StrmovieName; // 앞에 랜덤 고유값 붙이고, 파일 네임에서 잘라온 파일 이름 붙이기

			// 생성할 파일정보 File 객체로 준비
			File saveFile = new File(dir, uploadFilename); // 부모 디렉토리를 파라미터로 인스턴스 생성(파일)

			multipartFile.transferTo(saveFile); // 임시업로드된 파일을 지정경로의 파일명으로 복사
			// 파일 데이터를 지정한 폴더로 저장

			// 파일정보 담기위한 AttachfileVo 객체 생성
			AttachVo attachVo = new AttachVo();
			attachVo.setMovieId(movieId);
			attachVo.setMovieName(movieName);
			attachVo.setUploadpath(dir.getPath().replace("\\", "/"));

			attachVo.setUuid(StrmovieName);
			attachVo.setFilename(StrmovieName);

			list.add(attachVo);
		} // for
		adminService.modifyBoardAndAttaches(vo, list);

		return "redirect:/admin/searchMovie";
	}

	////////////////// 영화 삭제 /////////////
	@GetMapping("/DeleteMovie")
	public String DeleteMovie(@RequestParam(defaultValue = "") String movieId,
			@RequestParam(defaultValue = "") String movieIdCheck) {

		String movieCheck = movieIdCheck.replaceAll(" ", "");
		String movie = movieId.replaceAll(" ", "");

		int movieIdNum = Integer.parseInt(movieId);

		if (movie.equals(movieCheck)) {
			adminService.DeleteMovie(movieId, movieIdCheck);
			adminService.deleteAttach(movieIdNum);
		}

		return "redirect:/admin/searchMovie";
	}

	//////////////// 회원 수정 //////////////////
	@GetMapping("/modifyMember")
	public String getOne(@RequestParam(defaultValue = "") String userId, Model model) {
		MemberVo vo = adminService.getOne(userId);

		model.addAttribute("memberVo", vo);

		return "/admin/modifyMember";
	}

	@PostMapping("/modifyMember")
	public String updateMember(MemberVo vo) {
		adminService.updateMember(vo);

		return "redirect:/admin/memberManage";
	}

	// 예매 내역 가져오기
	@GetMapping("/updateReserve")
	public String ReserVgetByOne(@RequestParam(defaultValue = "") int reserveNumber, Model model) {
		ReserveVo vo = adminService.ReserVgetByOne(reserveNumber);

		model.addAttribute("rvList", vo);

		return "/admin/modifyReservManage";
	}

	// 예약 수정
	@PostMapping("/deleteReserve")
	public String updateReserve(PayVo payVo, ReserveVo reserveVo, MemberVo memberVo, int point, String userId) {
		TimeVo timeVo = adminService.getAllReserveSeats(reserveVo.getSygId(), reserveVo.getSangyoungTime());

		String[] arrayStr = timeVo.getReserveSeats().split(",");

		String stst = "";
		String str = reserveVo.getSeat();
		String[] arrayDelStr = str.split(",");

		List<String> list = new ArrayList<>();

		for (int j = 0; j < arrayStr.length; j++) {
			list.add(arrayStr[j]);

		}
		for (int i = 0; i < arrayDelStr.length; i++) {
			list.remove(arrayDelStr[i]);

		}
		for (int i = 0; i < list.size(); i++) {
			if (i != list.size() - 1) {
				stst += list.get(i) + ",";
			} else {
				stst += list.get(i);
			}
		}

		memberVo = adminService.getBymemberPoint(userId);

		int orignPoint = memberVo.getPoint();
		int memPoint = payVo.getPoint(); // 결제시 적립포인트
		int returnPoint = payVo.getUsepoint();// 쓴 포인트
		int minusPoint = orignPoint + returnPoint - memPoint;

		adminService.timeSetUpdate(stst, reserveVo.getSygId(), reserveVo.getSangyoungTime());
		adminService.memberPointUpgrade(minusPoint, userId);
		adminService.deletePay(payVo.getPayId());
		adminService.deleteReserve(reserveVo.getReserveNumber());

		return "redirect:/admin/reserveList";
	}

	/////////////////////////////////// ajax poster delete
	@DeleteMapping(value = "/admin/{movieId}")
	@ResponseBody
	public void deletePoster(@PathVariable("movieId") int movieId) {
		adminService.getDeleteMovieId(movieId);
	}

	private String getFoleder() {
		String strDate = "upposter";

		return strDate;
	} //

	// 삭제
	@PostMapping("/deleteMember")
	public String deleteMember(@RequestParam(defaultValue = "") List<String> userlist) {
		adminService.deleteMemberByCheck(userlist);

		return "redirect:/admin/memberManage";
	}

	// chart
	@GetMapping("/chartTest")
	public String chartTest(@RequestParam(defaultValue = "") String searchMovie, Model model) {
		if (searchMovie != null) {
			MovieVo vo = adminService.chartSelect(searchMovie);
			model.addAttribute("Chartget", vo);

		}

		return "/admin/chartTest";
	}

	//////////////////////// 관리자2////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////
	@GetMapping("/addTheater")
	public String addTheater(Model model) {
		List<TheaterVo> theaterVoList = theaterService.getTheater();
		int totalNum = theaterService.getTotalCount();
		
		model.addAttribute("theaterVoList", theaterVoList);
		model.addAttribute("totalNum", totalNum);
		
		return "/admin/addTheater";
	}

	@PostMapping("/addTheater")
	public String addTheater(TheaterVo theaterVo) {
		theaterService.insert(theaterVo);

		return "redirect:/admin/adminPage";
	}

	@GetMapping("/addSangyounggwan")
	public String addSangyounggwan(Model model) {
		List<TheaterVo> theaterVoList = theaterService.getTheater();
		List<SangyounggwanVo> sangyounggwanVoList = sangyounggwanService.getSangyounggwan();
		int totalNum = sangyounggwanService.getTotalCount();
		
		
		model.addAttribute("theaterVoList", theaterVoList);
		model.addAttribute("sangyounggwanVoList", sangyounggwanVoList);
		model.addAttribute("totalNum", totalNum);

		return "/admin/addSangyounggwan";
	}

	@PostMapping("/addSangyounggwan")
	public String addSangyounggwan(SangyounggwanVo sangyounggwanVo) {
		int seats = sangyounggwanVo.getCul() * sangyounggwanVo.getRow();

		sangyounggwanVo.setSeatsNum(seats);
		sangyounggwanService.insert(sangyounggwanVo);

		return "redirect:/admin/addSangyounggwan";
	}

	@GetMapping("/modifyReservManage")
	public String modifyReservManage() {

		return "/admin/modifyReservManage";
	}

	@GetMapping("/addMovieTime")
    public String addMovieTime(Model model) {
       // 리턴타입이 void면 메소드 이름을 jsp경로로 사용하여 실행
       List<MovieVo> movieVoList = sangyoungTimeService.getSangyoungMovie();
       List<TheaterVo> theaterVoList = theaterService.getTheater();
       List<SangyounggwanVo> sangyounggwanVoList = sangyounggwanService.getSangyounggwan();
       List<TimeVo> timeVoList = sangyoungTimeService.getSangyounggwanTime();
       int totalNum = sangyoungTimeService.getTotalCount();
       
       
       model.addAttribute("movieVoList", movieVoList);
       model.addAttribute("theaterVoList", theaterVoList);
       model.addAttribute("sangyounggwanVoList", sangyounggwanVoList);
       model.addAttribute("timeVoList", timeVoList);
       model.addAttribute("totalNum", totalNum);
       
       return "/admin/addMovieTime";
    }

	@GetMapping("/modify")
	public String modifyTheater(@RequestParam(defaultValue = "1") int pageNumTh,
			@RequestParam(defaultValue = "1") int pageNumSyg, @RequestParam(defaultValue = "1") int pageNumSyt,
			@RequestParam(defaultValue = "") String category, @RequestParam(defaultValue = "") String searchTh,
			@RequestParam(defaultValue = "") String searchSyg, @RequestParam(defaultValue = "") String searchSyt,
			@RequestParam(defaultValue = "1") String tabNum, Model model) {

		int totalCountTh = theaterService.getTotalCountTh(category, searchTh);
		int totalCountSyg = sangyounggwanService.getTotalCountSyg(category, searchSyg);
		int totalCountSyt = sangyoungTimeService.getTotalCountSyt(category, searchSyt);

		// 한 페이지에 15개씩 가져오기
		int pageSize = 5;
		// 시작행 인덱스번호 구하기(수식)
		int startRowTh = (pageNumTh - 1) * pageSize;
		int startRowSyg = (pageNumSyg - 1) * pageSize;
		int startRowSyt = (pageNumSyt - 1) * pageSize;

		List<TheaterVo> theaterList = null;
		if (totalCountTh > 0) {
			theaterList = theaterService.getTheaters(startRowTh, pageSize, category, searchTh);
		}
		List<SangyounggwanVo> sangyounggwanList = null;
		if (totalCountSyg > 0) {
			sangyounggwanList = sangyounggwanService.getSangyounggwans(startRowSyg, pageSize, category, searchSyg);
		}
		List<TimeVo> timeList = null;
		if (totalCountSyt > 0) {
			timeList = sangyoungTimeService.getSangyounggwanTimes(startRowSyt, pageSize, category, searchSyt);
		}

		List<TheaterVo> theaterVoList = theaterService.getTheater();
		List<SangyounggwanVo> sangyounggwanVoList = sangyounggwanService.getSangyounggwan();
		List<TimeVo> timeVoList = sangyoungTimeService.getSangyounggwanTime();

		int pageCountTh = totalCountTh / pageSize;
		int pageCountSyg = totalCountSyg / pageSize;
		int pageCountSyt = totalCountSyt / pageSize;

		if (totalCountTh % pageSize > 0) {
			pageCountTh += 1;
		}
		if (totalCountSyg % pageSize > 0) {
			pageCountSyg += 1;
		}
		if (totalCountSyt % pageSize > 0) {
			pageCountSyt += 1;
		}

		int pageBlock = 5;

		int startPageTh = ((pageNumTh / pageBlock) - (pageNumTh % pageBlock == 0 ? 1 : 0)) * pageBlock + 1;
		int startPageSyg = ((pageNumSyg / pageBlock) - (pageNumSyg % pageBlock == 0 ? 1 : 0)) * pageBlock + 1;
		int startPageSyt = ((pageNumSyt / pageBlock) - (pageNumSyt % pageBlock == 0 ? 1 : 0)) * pageBlock + 1;

		int endPageTh = startPageTh + pageBlock - 1;
		if (endPageTh > pageCountTh) {
			endPageTh = pageCountTh;
		}
		int endPageSyg = startPageSyg + pageBlock - 1;
		if (endPageSyg > pageCountSyg) {
			endPageSyg = pageCountSyg;
		}
		int endPageSyt = startPageSyt + pageBlock - 1;
		if (endPageSyt > pageCountSyt) {
			endPageSyt = pageCountSyt;
		}

		PageDto pageDto = new PageDto();
		pageDto.setTotalCountTh(totalCountTh);
		pageDto.setTotalCountSyg(totalCountSyg);
		pageDto.setTotalCountSyt(totalCountSyt);

		pageDto.setPageCountTh(pageCountTh);
		pageDto.setPageCountSyg(pageCountSyg);
		pageDto.setPageCountSyt(pageCountSyt);

		pageDto.setPageBlock(pageBlock);

		pageDto.setStartPageTh(startPageTh);
		pageDto.setStartPageSyg(startPageSyg);
		pageDto.setStartPageSyt(startPageSyt);

		pageDto.setEndPageTh(endPageTh);
		pageDto.setEndPageSyg(endPageSyg);
		pageDto.setEndPageSyt(endPageSyt);

		pageDto.setCategory(category);
		pageDto.setSearchTh(searchTh);
		pageDto.setSearchSyg(searchSyg);
		pageDto.setSearchSyt(searchSyt);

		model.addAttribute("theaterVoList", theaterVoList);
		model.addAttribute("sangyounggwanVoList", sangyounggwanVoList);
		model.addAttribute("timeVoList", timeVoList);

		model.addAttribute("theaterList", theaterList);
		model.addAttribute("sangyounggwanList", sangyounggwanList);
		model.addAttribute("timeList", timeList);

		model.addAttribute("pageDto", pageDto);

		model.addAttribute("pageNumTh", pageNumTh);
		model.addAttribute("pageNumSyg", pageNumSyg);
		model.addAttribute("pageNumSyt", pageNumSyt);
		model.addAttribute("tabNum", tabNum);

		return "admin/modify";
	}

	@GetMapping("/modifyTheater")
	public String modifyTheater(String theaterId, Model model) {
		TheaterVo theaterVo = theaterService.getTheaterById(theaterId);
		int totalNum = theaterService.getTotalCount();
		
		model.addAttribute("theaterVo", theaterVo);
		model.addAttribute("totalNum", totalNum);
		
		return "/admin/modifyTheater";
	}

	@PostMapping("/modifyTheater")
    public String modifyTheater(TheaterVo theaterVo) {
       TheaterVo Vo = theaterService.getTheaterById(theaterVo.getTheaterId());
       String beforeTheaterName=Vo.getTheaterName();
       String afterTheaterName=theaterVo.getTheaterName();
       
       String[] strBf = beforeTheaterName.split(" ");
       String[] strAf = afterTheaterName.split(" ");
       
       theaterService.searchSygId(strBf[1], strAf[1]);
       theaterService.searchSygTimeInSygId(strBf[1], strAf[1]);
       
       
       theaterService.updateDif(afterTheaterName, beforeTheaterName);
       
       theaterService.update(theaterVo);
       
       return "redirect:/admin/modify";
    }

	@ResponseBody
	@DeleteMapping("/deleteTheater")
	public void deleteTheater(String theaterId) {
		theaterService.del(theaterId);
	}

	@GetMapping("/modifySangyounggwan")
	public String modifySangyounggwan(SangyounggwanVo sangyounggwanVo, String sygId, Model model) {
		sangyounggwanVo = sangyounggwanService.getSangyounggwanById(sygId);
		List<SangyounggwanVo> sangyounggwanVoList = sangyounggwanService.getSangyounggwan();
		int totalNum = sangyounggwanService.getTotalCount();
		
		model.addAttribute("sangyounggwanVo", sangyounggwanVo);
		model.addAttribute("sangyounggwanVoList", sangyounggwanVoList);
		model.addAttribute("totalNum", totalNum);
		
		return "/admin/modifySangyounggwan";
	}

	@PostMapping("/modifySangyounggwan")
	public String modifySangyounggwan(SangyounggwanVo sangyounggwanVo) {
		int seats = sangyounggwanVo.getCul() * sangyounggwanVo.getRow();
		sangyounggwanVo.setSeatsNum(seats);
		
		String beforeSygId = sangyounggwanVo.getSygId();
		String afterSygId = sangyounggwanVo.getNewSygId();
		
		String[] strBf = beforeSygId.split(" ");
		String[] strAf = afterSygId.split(" ");
		
		sangyounggwanService.updateDif(strBf[1], strAf[1]);
		sangyounggwanService.update(sangyounggwanVo);
		
		return "redirect:/admin/modify";
	}

	@ResponseBody
	@DeleteMapping("/deleteSangyounggwan")
	public void deleteSangyounggwan(String sygId) {
		sangyounggwanService.del(sygId);
	}

	@GetMapping("/modifyMovieTime")
	public String modifyMovieTime(TimeVo timeVo, Model model) {
		timeVo = sangyoungTimeService.getTimeNumByNum(timeVo.getTimeNum());
		List<TimeVo> timeVoList = sangyoungTimeService.getSangyounggwanTime();
		List<MovieVo> movieVoList = adminService.getMovie();
		int totalNum = sangyoungTimeService.getTotalCount();
		
		model.addAttribute("timeVo", timeVo);
		model.addAttribute("timeVoList", timeVoList);
		model.addAttribute("movieVoList", movieVoList);
		model.addAttribute("totalNum", totalNum);
		
		return "/admin/modifyMovieTime";
	}

	@PostMapping("/modifyMovieTime")
	public String modifyMovieTime(TimeVo timeVo) {
		sangyoungTimeService.update(timeVo);

		return "redirect:/admin/modify";
	}

	@GetMapping("/ajaxSelectTherterNameByTheaterId")
	@ResponseBody
	public String getTheaterNameByTheaterId(String changeTheaterId) {
		String theaterName = sangyounggwanService.getTheaterNameByTheaterId(changeTheaterId);
		
		return theaterName;
	}
}
