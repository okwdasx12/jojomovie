package com.example.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor   /*인자 안받는거*/
@AllArgsConstructor  /*인자 받는거*/

public class LikeVo {
	private int likeNo;
	private String userId;
	private int movieId;
}