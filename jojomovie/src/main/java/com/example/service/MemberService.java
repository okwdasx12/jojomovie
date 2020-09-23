package com.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.MemberVo;
import com.example.mapper.MemberMapper;

import lombok.extern.java.Log;

@Log
@Service
@Transactional // 모든 메소드 각각이 한개의 트랜잭션 단위로 수행됨 // 자동 커밋,롤백
public class MemberService {

	@Autowired
	private MemberMapper memberMapper;

	public void insert(MemberVo vo) {
		memberMapper.insert(vo);
	}

	public MemberVo getMemberById(String userId) {
		MemberVo vo = memberMapper.getMemberById(userId);

		return vo;
	}

	public boolean isIdDuplicated(String userId) {
		boolean isIdDup = false;

		int count = memberMapper.countMemberById(userId);

		if (count == 1) {
			isIdDup = true; // 아이디중복
		} else { // count == 0
			isIdDup = false; // 아이디중복아님
		}

		return isIdDup;
	}

	public int userCheck(String userId, String passwd) {
		int check = -1; // -1: 아이디 없음, 0: 비밀번호 틀림, 1: 아이디 비밀번호 일치

		String dbPasswd = memberMapper.getPasswdById(userId);

		if (dbPasswd != null) {
			if (dbPasswd.equals(passwd)) {
				check = 1;
			} else {
				check = 0;
			}
		} else { // dbPasswd == null
			check = -1;
		}

		return check;
	}

	public boolean isEmailDuplicated(String userEmail) {
		boolean isEmailDup = false;

		int emailCount = memberMapper.countMemberByuserEmail(userEmail);
		if (emailCount == 1) {
			isEmailDup = true; // 이메일 중복
		} else { // emailCount == 0
			isEmailDup = false;
		}

		return isEmailDup;
	}

	public String findId(String userName, String userPhone) {
		String userId = memberMapper.findIdByuserNamePhone(userName, userPhone);

		return userId;
	}

	public boolean isIdEmailCheck(String userId, String userEmail) {

		boolean isIdEmailCheck = false;

		int IdEmailCount = memberMapper.countMemberByuserIdEmail(userId, userEmail);

		if (IdEmailCount == 1) { // 해당값 있으면
			isIdEmailCheck = true;
		} else {
			isIdEmailCheck = false;
		}

		return isIdEmailCheck;
	}

	public void changePasswd(String userId, String ranPasswdNum) {
		memberMapper.changePasswd(userId, ranPasswdNum);
	}

}
