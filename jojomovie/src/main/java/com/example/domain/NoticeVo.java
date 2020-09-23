package com.example.domain;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class NoticeVo {
	private List<AttachPosterVo> attachList;
	
	private int num;
	private String adminId;
	private String subject;
	private String content;
	private int readcount;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
	private LocalDateTime regDate;
	
	private String category;
}
