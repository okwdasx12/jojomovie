package com.example.domain;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor // 기본생성자
@AllArgsConstructor // 전체인자를 받는 생성자
public class InquireVo {
	
	private Integer num;
	private String userId;
	private String subject;
	private String content;
	private String ip;
	private LocalDateTime regDate;
	private Integer reRef;
	private Integer reLev;
	private Integer reComp;
}
