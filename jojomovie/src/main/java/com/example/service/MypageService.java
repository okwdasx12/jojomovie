package com.example.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.MemberVo;
import com.example.domain.PayVo;
import com.example.domain.ReserveVo;
import com.example.mapper.MypageMapper;

import lombok.extern.java.Log;

@Log
@Service
@Transactional
public class MypageService {

	@Autowired
	private MypageMapper mypageMapper;

	public MemberVo myinfo(String userId) {
		MemberVo memberVo = mypageMapper.myinfo(userId);

		return memberVo;
	}

	public List<ReserveVo> myReserve(String userId, LocalDateTime ldt) {
		List<ReserveVo> list = mypageMapper.myReserve(userId, ldt);

		return list;
	}

	public List<ReserveVo> myReservePre(String userId, LocalDateTime ldt) {
		List<ReserveVo> list = mypageMapper.myReservePre(userId, ldt);

		return list;
	}

	public ReserveVo reserveInfo(int reserveNumber) {
		ReserveVo vo = mypageMapper.reserveInfo(reserveNumber);

		return vo;
	}

	public PayVo payInfo(String payId) {
		PayVo vo = mypageMapper.payInfo(payId);

		return vo;
	}

	public void update(MemberVo vo) {
		mypageMapper.update(vo);
	}

	public void delete(String userId) {
		mypageMapper.deleteById(userId);
	}

}
