package com.example.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.domain.AttachPosterVo;
import com.example.domain.NoticeVo;
import com.example.domain.PageDto;
import com.example.service.NoticeService;
import com.example.service.NoticeboardService;

import lombok.extern.java.Log;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@RequestMapping("/notice/*")
@Log
public class NoticeController {

	@Autowired
	private NoticeService noticeService;

	@Autowired
	private NoticeboardService noticeboardService;

	@GetMapping("/noticeFormWrite")
	public String noticeFormWrite() {
		return "/notice/noticeForm";
	}

	private String getFoleder() {
		LocalDateTime dateTime = LocalDateTime.now(); // 오늘날짜 객체준비
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
		String strDate = dateTime.format(formatter); // 2020/06/16

		return strDate;
	} // getFoleder()

	@PostMapping("/noticeFormWrite")
	public String noticeFormWrite(HttpServletRequest request, @RequestParam("filename") List<MultipartFile> files,
			NoticeVo noticeVo) throws Exception {
		int num = noticeService.getBoardNum();

		// 일반 게시물 디비에서 넘 가져와서 파일 vo에 넘겨주기
		noticeVo.setNum(num);

		// 날짜 입력한 시간
		noticeVo.setRegDate(LocalDateTime.now());

		// 애플리케이션 내장객체
		ServletContext application = request.getServletContext();
		String path = application.getRealPath("/upload");

		String strDate = this.getFoleder(); // 같은 컨트롤러 안에 getFoleder를 만들어줌.

		File dir = new File(path, strDate); // (path) -> /webapp/upload strDate로 만들어준거->/2020/06/16
		if (!dir.exists()) { // exists -> 폴더, 텍스트 종류 상관없이 존재하는지 여부를 알려줌.
			dir.mkdirs(); // dir이 존재하지 않는다면, 폴더를 생성해달라는 말. //mkdir 는 temp가 있어야 생성되지만, mkdirs는 temp까지도 생성해줌
		}

		// 첨부파일정보 담을 리스트 준비
		List<AttachPosterVo> attachList = new ArrayList<>();

		for (MultipartFile multipartFile : files) { // file을 multipart형식으로 변환?
			if (multipartFile.isEmpty()) {
				continue;
			}

			String filename = multipartFile.getOriginalFilename(); // 파일명가져오기
			// 익스플로러는 파일이름에 경로가 포함되있으므로
			// 순수 파일이름만 부분문자열로 가져오기
			int index = filename.lastIndexOf("\\") + 1; // "\\"를 발견한 즉시 그 인덱스 값.

			filename = filename.substring(index); // index값에서 부터 잘라줘 이걸 기준으로 이후 값 다 가져오기

			// 파일명 중복 피하기 위해 파일이름 앞에 uuid 문자열 붙이기
			UUID uuid = UUID.randomUUID();
			String strUuid = uuid.toString();

			// 업로드(생성)할 파일이름
			String uploadFilename = strUuid + "_" + filename; // 앞에 랜덤 고유값 붙이고, 파일 네임에서 잘라온 파일 이름 붙이기

			// 생성할 파일정보 File 객체로 준비
			File saveFile = new File(dir, uploadFilename); // 부모 디렉토리를 파라미터로 인스턴스 생성(파일)

			multipartFile.transferTo(saveFile); // 임시업로드된 파일을 지정경로의 파일명으로 복사
			// 파일 데이터를 지정한 폴더로 저장

			// 파일정보 담기위한 AttachfileVo 객체 생성
			AttachPosterVo attachVo = new AttachPosterVo();

			// 게시판 글번호 설정
			attachVo.setBno(noticeVo.getNum()); // bno = num 일치시키기
			// 업로드 경로 설정. 경로에서 백슬래시문자는 슬래시로 모두 변환해서 설정.
			attachVo.setUploadpath(dir.getPath().replace("\\", "/"));
			attachVo.setUuid(strUuid);
			attachVo.setFilename(filename);

			// 파일명 확장자가 이미지면 "I", 아니면 "O"
			if (isImageType(saveFile)) {
				// 섬네일 이미지 생성하기********************************
				File thumbnailFile = new File(dir, "s_" + uploadFilename);

				try (FileOutputStream fos = new FileOutputStream(thumbnailFile)) {
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), fos, 800, 800);
				}
				// *********************************
				attachVo.setImage("I");
			} else {
				attachVo.setImage("O");
			}

			attachList.add(attachVo);
		} // for

		noticeService.insertBoardAndAttaches(noticeVo, attachList);

		return "redirect:/notice/noticeBoardList";
	}

	private boolean isImageType(File saveFile) throws IOException {
		boolean isImageType = false;

		String str = saveFile.getPath();

		// 확장자명 구하기
		String ext = str.substring(str.lastIndexOf(".") + 1);
		if (ext.equalsIgnoreCase("png") || ext.equalsIgnoreCase("gif") || ext.equalsIgnoreCase("jpg")
				|| ext.equalsIgnoreCase("jpeg")) {
			isImageType = true;
		} else {
			isImageType = false;
		}

		// MIME 타입 정보 확인하기 (MIME 타입 정보가 없으면 null을 리턴함)
		String contentType = Files.probeContentType(saveFile.toPath());
		if (contentType != null) {
			isImageType = contentType.startsWith("image");
		} else {
			isImageType = false;
		}

		return isImageType;
	} // isImageType()

	//////////////////////////////////////////////
	///////////////////////////////////////////
	// 관리자 공지 게시판.................

	// 검색 목록
	@GetMapping("/noticeBoardList")
	public String noticeBoard(@RequestParam(defaultValue = "1") int pageNum,
			@RequestParam(defaultValue = "") String category, @RequestParam(defaultValue = "") String search,
			Model model) {

		// 전체 글 카운트
		int totalCount = noticeboardService.countAllNotice(category, search); // 10개

		// 한 페이지 당 5개씩 띄우기
		int pageSize = 10;
		// 시작행 번호 limit 앞 부분 5, 10, 15
		// startRow = (1 - 1 ) * 5 // (2-1) * 5 = 5
		int startRow = (pageNum - 1) * pageSize;

		// 원하는 페이지 글 가져오기 총 갯수가 0을 넘어설시에
		List<NoticeVo> list = null;
		if (totalCount > 0) {
			list = noticeboardService.noticeBoardGetAll(startRow, pageSize, category, search);
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

		model.addAttribute("noticeList", list);
		model.addAttribute("pageDto", pageDto);
		model.addAttribute("pageNum", pageNum);

		return "/notice/noticeBoardList";
	}

	///////////////////////
	@GetMapping("/noticeBoardView")
	public Object fileContent(int num, @ModelAttribute("pageNum") String pageNum, Model model, HttpSession session) {
		// 조회수 1증가
		noticeboardService.updateReadcount(num);
		
		// 글 한개 가져오기
		NoticeVo vo = noticeboardService.getBoardAndAttachfilesByNum(num);
		
		// 첨부파일 리스트 가져오기
		List<AttachPosterVo> attachList = vo.getAttachList();

		// 내용에서 엔터키 줄바꿈 \r\n -> <br> 바꾸기
		String content = "";
		if (vo.getContent() != null) {
			content = vo.getContent().replace("\r\n", "<br>");
			vo.setContent(content);
		}

		// jsp화면(뷰) 만들때 필요한 데이터를 Model 타입 객체에 저장
		model.addAttribute("noticeVo", vo);
		model.addAttribute("attachList", attachList);

		return "/notice/noticeBoardView";
	}

	@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	public ResponseEntity<Resource> download(String uuid) throws Exception {
		// uuid에 해당하는 레코드 한개 가져오기
		AttachPosterVo attachVo = noticeService.getAttachfileByUuid(uuid);
		
		// 다운로드할 파일 객체 준비
		String filename = attachVo.getUuid() + "_" + attachVo.getFilename();
		File file = new File(attachVo.getUploadpath(), filename);

		Resource resource = new FileSystemResource(file);

		if (!resource.exists()) {
			return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
		}

		String resFilename = resource.getFilename();

		// 다운로드할 파일이름에서 UUID 제거하기
		int beginIndex = resFilename.indexOf("_") + 1;
		String originalFilename = resFilename.substring(beginIndex);

		// 다운로드 파일명의 문자셋을 utf-8에서 iso-8859-1로 변환
		String downloadFilename = new String(originalFilename.getBytes("utf-8"), "iso-8859-1");

		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Disposition", "attachment; filename=" + downloadFilename);

		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	} // download()

	@GetMapping("/noticeDelete")
	public String noticeDelete(int num, String pageNum, Model model) {
		noticeboardService.noticeDelete(num, pageNum);
		noticeboardService.noticeDeleteUuid(num);

		return "redirect:/notice/noticeBoardList";
	}

	@GetMapping("/noticeModify")
	public String noticeModify(int num, @ModelAttribute("pageNum") String pageNum, Model model, HttpSession session) {
		// 글 한개 가져오기
		NoticeVo vo = noticeboardService.getBoardAndAttachfilesByNum(num);
		// 첨부파일 리스트 가져오기
		List<AttachPosterVo> attachList = vo.getAttachList();

		int countFile = noticeService.getNum(num);

		// 내용에서 엔터키 줄바꿈 \r\n -> <br> 바꾸기
		String content = "";
		if (vo.getContent() != null) {
			content = vo.getContent().replace("\r\n", "<br>");
			vo.setContent(content);
		}

		// jsp화면(뷰) 만들때 필요한 데이터를 Model 타입 객체에 저장
		model.addAttribute("noticeVo", vo);
		model.addAttribute("attachList", attachList);
		model.addAttribute("countFile", countFile);

		return "/notice/modifyNoticeBoard";
	}

	@PostMapping("/updateNotice")
	public String updateNotice(NoticeVo vo, int num, HttpServletRequest request,
			@RequestParam("filename") List<MultipartFile> files) throws Exception {
		vo.setNum(num);

		// 애플리케이션 내장객체
		ServletContext application = request.getServletContext();
		String path = application.getRealPath("/upload");

		String strDate = this.getFoleder();

		File dir = new File(path, strDate);
		if (!dir.exists()) {
			dir.mkdirs();
		}

		// 첨부파일정보 담을 리스트 준비
		List<AttachPosterVo> attachList = new ArrayList<>();

		for (MultipartFile multipartFile : files) {
			if (multipartFile.isEmpty()) {
				continue;
			}

			String filename = multipartFile.getOriginalFilename();
			// 익스플로러는 파일이름에 경로가 포함되있으므로
			// 순수 파일이름만 부분문자열로 가져오기
			int index = filename.lastIndexOf("\\") + 1;
			filename = filename.substring(index);

			// 파일명 중복 피하기 위해 파일이름 앞에 uuid 문자열 붙이기
			UUID uuid = UUID.randomUUID();
			String strUuid = uuid.toString();

			// 업로드(생성)할 파일이름
			String uploadFilename = strUuid + "_" + filename;

			// 생성할 파일정보 File 객체로 준비
			File saveFile = new File(dir, uploadFilename);

			multipartFile.transferTo(saveFile); // 임시업로드된 파일을 지정경로의 파일명으로 복사

			// 파일정보 담기위한 AttachfileVo 객체 생성
			AttachPosterVo attachVo = new AttachPosterVo();
			// 게시판 글번호 설정
			attachVo.setBno(vo.getNum());
			// 업로드 경로 설정. 경로에서 백슬래시문자는 슬래시로 모두 변환해서 설정.
			attachVo.setUploadpath(dir.getPath().replace("\\", "/"));

			attachVo.setUuid(strUuid);
			attachVo.setFilename(filename);

			// 파일명 확장자가 이미지면 "I", 아니면 "O"
			if (isImageType(saveFile)) {
	            // 섬네일 이미지 생성하기********************************
	            File thumbnailFile = new File(dir, "s_" + uploadFilename);

	            try (FileOutputStream fos = new FileOutputStream(thumbnailFile)) {
	               Thumbnailator.createThumbnail(multipartFile.getInputStream(), fos, 800, 800);
	            }
	            // *********************************
	            attachVo.setImage("I");
	         } else {
	            attachVo.setImage("O");
	         }

			attachList.add(attachVo);
		} // for

		noticeService.modifyBoardAndAttaches(vo, attachList);
		noticeboardService.updateNotice(vo);

		return "redirect:/notice/noticeBoardList";
	}

	@DeleteMapping(value = "/notice/{selectfile}")
	@ResponseBody
	public String deleteUuid(@PathVariable("selectfile") String selectfile) {
		AttachPosterVo vo = noticeService.uuSelectNum(selectfile);

		String uu = vo.getUuid();

		noticeService.delete(selectfile);

		return uu;
	}
}
