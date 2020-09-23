package com.example.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.MovieVo;
import com.example.service.MovieService;

import lombok.extern.java.Log;

@Controller
@Log
public class HomeController {
	
	@Autowired
	MovieService movieService;

	@GetMapping("/")
	public String index(HttpSession session, Model model) {
		String userId = (String) session.getAttribute("userId");
		List<MovieVo> movieListLimitFive = movieService.getMovieLimitFive();
		List<MovieVo> currentMovieList = movieService.getCurrentMovie();
		
		for ( int i=0;i<movieListLimitFive.size();i++ ) {
			int movieIdFor = movieListLimitFive.get(i).getMovieId();
			
			int likeCheck = movieService.likeCheck(movieIdFor, userId);
			movieListLimitFive.get(i).setLikeCheck(likeCheck);
		}
		
		model.addAttribute("movieListLimitFive", movieListLimitFive);
		model.addAttribute("currentMovieList", currentMovieList);
		
		return "index"; // 디스패치방식 호출
	}
	
	@GetMapping("/likeCheck")
	@ResponseBody
	public Map<String, Integer> likeCheck(int movieId, HttpSession session) {
		String userId = (String) session.getAttribute("userId");
		
		int check = movieService.likeCheck(movieId, userId);
		
		if (check == 1) {
			movieService.pushLikeCancle(movieId, userId);
			movieService.deleteLikeCount(movieId);
		} else {
			movieService.pushLike(movieId, userId);
			movieService.updateLikeCount(movieId);
		}

		MovieVo vo = movieService.getMovieById(movieId);
		int likeCnt = vo.getLikeCnt();
		
		Map<String, Integer> map = new HashMap<>();
		map.put("check", check);
		map.put("likeCnt", likeCnt);
		
		return map;
	}

	@GetMapping("/admin")
	public String admin() {
		return "/admin";
	}
	
	@GetMapping("/chat/chat")
	public String chat() {
		return "/chat/chat";
	}
}
