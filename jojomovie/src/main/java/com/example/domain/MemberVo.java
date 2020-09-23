package com.example.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberVo implements Cloneable {
	private String userId;
	private String passwd;
	private String name;
	private String userEmail;
	private String birthday;
	private String userAddr;
	private String userZipCode;
	private String userFirstAddr;
	private String userSecondAddr;
	private String phone;
	private int point;
	private String grade;
	
	@Override
	protected Object clone() throws CloneNotSupportedException {
		// TODO Auto-generated method stub
		return super.clone();
	}
}




