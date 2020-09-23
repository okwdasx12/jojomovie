package com.example.domain;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class ReserveVo {
	private List<PayVo> payList;
	
	private String reserveNumber;
	private String userId;
	private int movieId;
	private String theaterName;
	private String seat;
	private LocalDateTime reserveDate;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
	private LocalDateTime sangyoungTime;
	
	private String tf;
	private String payId;
	private String ticketId;
	private String sygId;
	private String movieName;
}
