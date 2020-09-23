package com.example.domain;

import lombok.Data;

@Data
public class PageDto {
	  private String category;
	  private String search;
	
	  private int totalCountTh;
	  private int totalCountSyg;
	  private int totalCountSyt;
	  
	  private int pageCountTh;
	  private int pageCountSyg;
	  private int pageCountSyt;
	  
	  private int startPageTh;
	  private int startPageSyg;
	  private int startPageSyt;
	  
	  private int endPageTh;
	  private int endPageSyg;
	  private int endPageSyt;
	  
	  private String searchTh;
	  private String searchSyg;
	  private String searchSyt;

	  private int total;
	  private int ing;
	  private int fin;
	
	  private int totalCount;
	  private int pageCount;
	  private int startPage;
	  private int endPage;
	  private int pageBlock;
}
