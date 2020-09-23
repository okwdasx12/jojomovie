package com.example.domain;

import lombok.Data;

@Data
public class AttachVo {
	private String uuid;
	private String filename;
	private String uploadpath;
	private String image;
	private int movieId;
	private String movieName;
}
