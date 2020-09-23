package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.TheaterVo;
import com.example.mapper.TheaterMapper;

@Service
@Transactional
public class TheaterService {
	@Autowired
	private TheaterMapper theaterMapper;

	public void insert(TheaterVo theaterVo) {
		theaterMapper.insert(theaterVo);
	}

	public void update(TheaterVo theaterVo) {
		theaterMapper.update(theaterVo);
	}

	public void searchSygId(String strBefore, String strAfter) {
		theaterMapper.searchSygId(strBefore, strAfter);
	}

	public void searchSygTimeInSygId(String strBefore, String strAfter) {
		theaterMapper.searchSygTimeInSygId(strBefore, strAfter);
	}
	
	public void updateDif(String afterTheaterName, String beforeTheaterName) {
	      theaterMapper.updateDif(afterTheaterName, beforeTheaterName);
	   }

	public void del(String theaterId) {
		theaterMapper.del(theaterId);
	}
	
	public int getTotalCount() {
		int count = theaterMapper.getTotalCount();

		return count;
	}

	public int getTotalCountTh(String category, String search) {
		int count = theaterMapper.getTotalCountTh(category, search);

		return count;
	}

	public TheaterVo getTheaterById(String theaterId) {
		TheaterVo vo = theaterMapper.getTheaterById(theaterId);

		return vo;
	}

	public List<TheaterVo> getTheater() {
		List<TheaterVo> theaterVoList = theaterMapper.getTheater();

		return theaterVoList;
	}

	public List<TheaterVo> getTheaters(int startRowTh, int pageSize, String category, String search) {
		List<TheaterVo> theaterList = theaterMapper.getTheaters(startRowTh, pageSize, category, search);

		return theaterList;
	}

}
