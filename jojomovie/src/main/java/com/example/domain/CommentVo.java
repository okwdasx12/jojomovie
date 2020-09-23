package com.example.domain;

import java.time.LocalDateTime;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor

public class CommentVo {
	private int cmtNumber;
	private String userId;
	private int cmtStar;
	private String cmtContent;
	private int movieId;
	private String movieName;
	private LocalDateTime cmtRegDate;
}
