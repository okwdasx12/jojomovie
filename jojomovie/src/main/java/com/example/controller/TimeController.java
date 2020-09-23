package com.example.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.datetime.joda.LocalDateParser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.MovieVo;
import com.example.domain.TimeVo;
import com.example.service.MovieService;
import com.example.service.SangyoungTimeService;

import lombok.extern.java.Log;

@Controller
@Log
public class TimeController {
	@Autowired
	private SangyoungTimeService sangyoungTimeService;
	
	@Autowired
	private MovieService movieService;
	
	@PostMapping("/ajaxAddTime")
	@ResponseBody
	public Map<String, Object> makeTime(TimeVo timeVo) {
		MovieVo movieVo = movieService.getMovieById(timeVo.getMovieId());
		timeVo.setMovieName(movieVo.getMovieName());
		
		sangyoungTimeService.insert(timeVo);
		TimeVo Vo = sangyoungTimeService.getNumByTimeSyg(timeVo.getSangyoungTime(), timeVo.getSygId());
		String sygTime =  Vo.getSangyoungTime().format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm"));
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("Vo", Vo);
		map.put("sygTime", sygTime);
		
		return map;
	}
	
	@DeleteMapping("/ajaxDelTime")
	@ResponseBody
	public int delTime(String str, String str2) {
		
		LocalDateTime ldtStr = LocalDateTime.parse(str);
		
		int num = sangyoungTimeService.getIdByTimeAndSyg(ldtStr, str2);
		
		sangyoungTimeService.del(ldtStr, str2);
		
		return num;
	}
	
	@GetMapping("/ajaxSelectSygByTheaterName")
	@ResponseBody
	public List<String> getSygByTheaterName(String changeTheaterName){
		List<String> list = sangyoungTimeService.getSygByTheaterName(changeTheaterName);
		
		return list;
	}
}
