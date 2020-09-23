package com.example.domain;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor   /*인자 안받는거*/
@AllArgsConstructor  /*인자 받는거*/
public class MovieVo {
	private int movieId;
	private String movieName;
	private String director;
	private String cast;
	private int grade;
	private String information;
	private int score;
	private int likeCnt;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate startDate;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate endDate;

	private String genre;
	private String runtime;

	private String relMovie;
	private float avgStar;
	
	private int likeCheck;
}