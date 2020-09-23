package com.example.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class ReserveDto {

	private LocalDateTime sangyoungTime;
	private int seatsNum;
	private String reserveSeats;
	private String sygId;
	private int timeNum;
}
