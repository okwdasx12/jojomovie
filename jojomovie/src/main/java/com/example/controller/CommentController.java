package com.example.controller;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.domain.CommentVo;
import com.example.service.CommentService;

import lombok.extern.java.Log;

@Log
@RequestMapping("/comment/*")
@Controller
public class CommentController {
	
	@Autowired
	private CommentService commentService;

	@ResponseBody
	@PostMapping("/cmtWrite")
	public Map<String, Object> cmtWrite(CommentVo commentVo, Model model) {
		commentVo.setCmtRegDate(LocalDateTime.now());
		String userId = commentVo.getUserId();
		
		int movieId = (Integer)commentVo.getMovieId();
		boolean result = false;
		boolean isCmtDup = commentService.isCmtDuplicated(userId);
		
		if (isCmtDup == true) { // 중복값 있을 경우
			result = true;
		} else { // 코멘트 작성
			commentService.insert(commentVo);
			result = false;
		}
		
		float cmtCountByMovie = commentService.cmtCountByMovie(commentVo.getMovieId());
		float totalStarByMovie = commentService.totalStarByMovie(commentVo.getMovieId());
		float staravg = totalStarByMovie/cmtCountByMovie;

		model.addAttribute("staravg", staravg);
		model.addAttribute("result", result);
		
		Map<String, Object> map = new HashMap<>();
		map.put("staravg", staravg);
		map.put("result", result);
		map.put("movieId", movieId);
		
		return map;
	} // cmtWrite()
	
	@ResponseBody
	@PostMapping("/cmtDelete")
	public int cmtDelete(String cmtNumber) {
		CommentVo commentVo = commentService.cmtNumberSelect(cmtNumber);
		int cmtNum = commentVo.getCmtNumber();
			
		commentService.deleteBycmtNumber(cmtNumber);
		
		return cmtNum;
	} // cmtDelete()
	
	
	@PostMapping(value = "/modify", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> modify(@RequestBody CommentVo commentVo) {
		int count = commentService.updateCmt(commentVo);
		ResponseEntity<String> entity = null;
		
		if (count > 0) {
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} else {
			entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	} // modify()
}