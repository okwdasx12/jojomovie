package com.example.domain;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;


@Data
public class TimeVo {
	private Integer timeNum;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
	private LocalDateTime sangyoungTime;
	
	private String theaterName;
	private String sygId;
	private String movieName;
	private int movieId;
	private String reserveSeats;
}
