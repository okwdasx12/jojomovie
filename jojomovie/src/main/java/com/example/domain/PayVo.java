package com.example.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class PayVo {
	
	private String payId;
	private String userId;
	private LocalDateTime payDate;
	private int howmany;
	private int point;
	private int usepoint;
	private int totalPrice;
	private int movieId;
	private String ticketId;
	private String movieName;
}
