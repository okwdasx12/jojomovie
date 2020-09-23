package com.example.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.domain.ChartDto;
import com.example.service.ChartTestService;

import lombok.extern.java.Log;

@RestController // 이 클래스의 모든 메소드의 리턴값이 JSON 또는 XML 응답으로 동작함 
@RequestMapping("/chartTest/*")
@Log
public class ChartTestController {
	
	@Autowired
	ChartTestService chartTestService;

	@GetMapping(value = "/chartTest/{now}")
	public Map<String, List> movieDataGet(@PathVariable("now") String now, Model model){
		
		Map<String, List> map = new HashMap<>(); // { a:[], b:[], c:[] }
		
		List<String> movieNameList = new ArrayList<>();  // []
		List<Integer> likeCntList = new ArrayList<>();  // []
		List<Integer> scoreList = new ArrayList<>(); // []
		List<ChartDto> movieList = null;
		
		movieList = chartTestService.movieGet(now);
		
		for (ChartDto chartDto : movieList) {
			String movieName = chartDto.getMovieName();
			int likeCnt = chartDto.getLikeCnt();
			int score = chartDto.getScore();
			
			movieNameList.add(movieName);
			likeCntList.add(likeCnt);
			scoreList.add(score * 10);
		}
		
		map.put("movieNameList", movieNameList);
		map.put("likeCntList", likeCntList);
		map.put("scoreList", scoreList);
		
		return map;
	}//get()
}	
