package com.example.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.MemberVo;
import com.example.domain.MovieVo;
import com.example.domain.PayVo;
import com.example.domain.ReserveDto;
import com.example.domain.ReserveVo;
import com.example.domain.SangyounggwanVo;
import com.example.domain.TheaterVo;
import com.example.mapper.ReservationMapper;

import lombok.extern.java.Log;

@Service
@Transactional
@Log
public class ReservationService {

	@Autowired
	private ReservationMapper reservationMapper;

	public List<MovieVo> movieRel() {
		List<MovieVo> list = reservationMapper.movieRel();
		
		return list;
	}

	public List<TheaterVo> theaterRel() {
		List<TheaterVo> list = reservationMapper.theaterRel();

		return list;
	}

	public String dateAdd(LocalDate ld, int num) {
		String str = reservationMapper.dateAdd(ld, num);

		return str;
	}

	public List<ReserveDto> getSangyoungTime(int movieId, String theater, LocalDate date) {
		List<ReserveDto> list = reservationMapper.getSangyoungTime(movieId, theater, date);
		
		return list;
	}

	public SangyounggwanVo getRowCul(String sygId) {
		SangyounggwanVo vo = reservationMapper.getRowCul(sygId);
		
		return vo;
	}

	public void insertReservation(ReserveVo reserveVo) {
		reservationMapper.insertReservation(reserveVo);
	}

	public void insertPay(PayVo payVo) {
		reservationMapper.insertPay(payVo);
	}

	public String getReserveSeatsByTimeNum(int timeNum) {
		String strSeats = reservationMapper.getReserveSeatsByTimeNum(timeNum);
		
		return strSeats;
	}

	public void updateReserveSeats(int timeNum, String strSeats) {
		reservationMapper.updateReserveSeats(timeNum, strSeats);
	}

	public MemberVo findUserPoint(String userId) {
		MemberVo memberVo = reservationMapper.findUserPoint(userId);
		
		return memberVo;
	}

	public boolean maxPoint(String userId, String useP) {
		boolean maxP = false;

		MemberVo vo = reservationMapper.findUserPoint(userId);
		int max = vo.getPoint();

		int use = Integer.parseInt(useP);

		if (max < use) {
			maxP = true;
		} else {
			maxP = false; // 돈써도됨
		}

		return maxP;
	}

	public void updateUserPoint(int usepoint, String userId, int point) {
		reservationMapper.updateUserPoint(usepoint, point, userId);
	}
}
