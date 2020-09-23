package com.example.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.domain.CommentVo;
import com.example.domain.MovieVo;
import com.example.domain.PageDto;
import com.example.service.CommentService;
import com.example.service.MovieService;

import lombok.extern.java.Log;

@Log
@RequestMapping("/movie/*")
@Controller
public class MovieController {

	@Autowired
	private MovieService movieService;
	@Autowired
	private CommentService commentService;

	@GetMapping("/moviePresent")
	public String moviePresentList(@RequestParam(defaultValue = "1") int pageNum, @RequestParam(defaultValue = "likeCnt") String category,
			@RequestParam(defaultValue = "") String search, Model model) {

		// 전체 글 갯수
		int totalCount = movieService.getMovieTotalcount(category, search);
		
		// 한 페이지에 15개씩 가져오기
		int pageSize = 6;
		
		// 시작행 인덱스번호 구하기(수식)
		int startRow = (pageNum - 1) * pageSize;

		// 원하는 페이지의 글을 가져오는 메소드
		List<MovieVo> list = null;
		if (totalCount > 0) {
			list = movieService.getMovieBoards(startRow, pageSize, category, search);
		}
		int pageCount = totalCount / pageSize;
		if (totalCount % pageSize > 0) {
			pageCount += 1;
		}
		
		// 화면에 보여줄 페이지번호의 갯수 설정
		int pageBlock = 10;
		
		// 페이지 블록의 시작페이지
		int startPage = ((pageNum / pageBlock) - (pageNum % pageBlock == 0 ? 1 : 0)) * pageBlock + 1;
		
		// 페이지 블록의 끝페이지
		int endPage = startPage + pageBlock - 1;
		if (endPage > pageCount) {
			endPage = pageCount;
		}
		
		// 페이지블록 관련 정보를 CmtPageDTO에 저장(Map 컬렉션 사용 가능)
		PageDto pageDto = new PageDto();
		pageDto.setTotalCount(totalCount);
		pageDto.setPageCount(pageCount);
		pageDto.setPageBlock(pageBlock);
		pageDto.setStartPage(startPage);
		pageDto.setEndPage(endPage);
		pageDto.setCategory(category);
		pageDto.setSearch(search);
		

		model.addAttribute("movieList", list);
		model.addAttribute("moviepageDto", pageDto);
		model.addAttribute("pageNum", pageNum);

		return "/movie/moviePresent";
	} // moviePresentList()
	
	@GetMapping("/movieInfo")
	public String movieInfo(@RequestParam(defaultValue = "1") int pageNum,
			@RequestParam(defaultValue = "") String category,
			@RequestParam(defaultValue = "") String search,
			@RequestParam(defaultValue = "1") int movieId,
			Model model) {
		
		// 전체 글 갯수
		int totalCount = commentService.getTotalcount(category, search, movieId);
		
		// 한 페이지에 10개씩 가져오기
		int pageSize = 10;
		
		// 시작행 인덱스번호 구하기(수식)
		int startRow = (pageNum-1) * pageSize;
					
		// 원하는 페이지의 글을 가져오는 메소드
		List<CommentVo> list = null;
		if (totalCount > 0) {
			list = commentService.getBoards(startRow, pageSize, category, search, movieId);	
		}
		
		MovieVo movieVo = movieService.getBoardsByMovieId(movieId);
		
		int pageCount = totalCount / pageSize;
		if (totalCount % pageSize > 0) {
			pageCount += 1;
		}
		
		// 화면에 보여줄 페이지번호의 갯수 설정
		int pageBlock = 3;
	
		// 페이지 블록의 시작페이지
		int startPage = ((pageNum / pageBlock) - (pageNum % pageBlock == 0 ? 1 : 0)) * pageBlock + 1;
		
		// 페이지 블록의 끝페이지
		int endPage = startPage + pageBlock - 1;
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
	
		// 별점평균 구하기
		float cmtCountByMovie = commentService.cmtCountByMovie(movieId);
		float totalStarByMovie = commentService.totalStarByMovie(movieId);
		float staravg = totalStarByMovie/cmtCountByMovie;
		
		model.addAttribute("staravg", staravg);
		model.addAttribute("commentList", list);
		model.addAttribute("cmtPageDto", pageDto);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("movieVo", movieVo);
		
		return "/movie/movieInfo";
	}  // movieInfo()

	@GetMapping("/currentMovie")
	public String currentMovieList(@RequestParam(defaultValue = "1") int pageNum,
			@RequestParam(defaultValue = "startDate") String category, 
			@RequestParam(defaultValue = "") String search, 
			Model model) {

		// 전체 영화갯수
		int totalCount = movieService.getCurrentTotalMovieCount(category, search);

		// 한 페이지에 6개씩 
		int pageSize = 6;

		// 시작행 인덱스번호 구하기
		int startRow = (pageNum - 1) * pageSize;

		// 원하는 페이지의 글을 가져오는 메소드
		List<MovieVo> list = null;
		if (totalCount > 0) {
			list = movieService.getCurrentMovies(startRow, pageSize, category, search);
		}

		// 총 페이지 수 구하기 
		int pageCount = totalCount / pageSize;
		if (totalCount % pageSize > 0) {
			pageCount += 1;
		}

		// 화면에 보여줄 페이지번호의 갯수설정 
		int pageBlock = 5;

		// 페이지 블록의 시작페이지
		int startPage = ((pageNum / pageBlock) - (pageNum % pageBlock == 0 ? 1 : 0)) * pageBlock + 1;
		// 페이지 블록의 끝페이지
		int endPage = startPage + pageBlock - 1;
		if (endPage > pageCount) {
			endPage = pageCount;
		}

		// 페이지블록 관련 정보를 PageDTO에 저장( Map 컬렉션 )
		PageDto pageDto = new PageDto();
		pageDto.setTotalCount(totalCount);
		pageDto.setPageCount(pageCount);
		pageDto.setPageBlock(pageBlock);
		pageDto.setStartPage(startPage);
		pageDto.setEndPage(endPage);
		pageDto.setCategory(category);
		pageDto.setSearch(search);

		model.addAttribute("movieList", list);
		model.addAttribute("moviePageDto", pageDto);
		model.addAttribute("pageNum", pageNum);
		
		return "movie/currentMovie";
	}

	@GetMapping("/comingMovie")
	public String comingMovieList(@RequestParam(defaultValue = "1") int pageNum,
			@RequestParam(defaultValue = "startDate") String category, 
			@RequestParam(defaultValue = "") String search, Model model) {
		// 전체 영화갯수
		int totalCount = movieService.getComingTotalMovieCount(category, search);

		// 한 페이지에 6개씩 
		int pageSize = 6;

		// 시작행 인덱스번호 구하기
		int startRow = (pageNum - 1) * pageSize;

		// 원하는 페이지의 글을 가져오는 메소드
		List<MovieVo> list = null;
		if (totalCount > 0) {
			list = movieService.getComingMovies(startRow, pageSize, category, search);
		}

		// 총 페이지 수 구하기 
		int pageCount = totalCount / pageSize;
		if (totalCount % pageSize > 0) {
			pageCount += 1;
		}

		// 화면에 보여줄 페이지번호의 갯수설정 
		int pageBlock = 5;

		// 페이지 블록의 시작페이지
		int startPage = ((pageNum / pageBlock) - (pageNum % pageBlock == 0 ? 1 : 0)) * pageBlock + 1;
		
		// 페이지 블록의 끝페이지
		int endPage = startPage + pageBlock - 1;
		if (endPage > pageCount) {
			endPage = pageCount;
		}

		// 페이지블록 관련 정보를 PageDTO에 저장( Map 컬렉션 )
		PageDto pageDto = new PageDto();
		pageDto.setTotalCount(totalCount);
		pageDto.setPageCount(pageCount);
		pageDto.setPageBlock(pageBlock);
		pageDto.setStartPage(startPage);
		pageDto.setEndPage(endPage);
		pageDto.setCategory(category);
		pageDto.setSearch(search);

		model.addAttribute("movieList", list);
		model.addAttribute("moviePageDto", pageDto);
		model.addAttribute("pageNum", pageNum);

		return "movie/comingMovie";
	} // comingMovieList()
}