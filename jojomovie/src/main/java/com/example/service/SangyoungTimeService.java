package com.example.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.MovieVo;
import com.example.domain.TimeVo;
import com.example.mapper.SangyoungTimeMapper;

import lombok.extern.java.Log;

@Log
@Service
@Transactional
public class SangyoungTimeService {
	@Autowired
	private SangyoungTimeMapper sangyoungTimeMapper;

	public void insert(TimeVo timeVo) {
		int num = sangyoungTimeMapper.getTimeNum();
		
		timeVo.setTimeNum(num);
		
		sangyoungTimeMapper.insert(timeVo);
	}

	public void update(TimeVo timeVo) {
		sangyoungTimeMapper.update(timeVo);
	}

	public void del(LocalDateTime str, String str2) {
		sangyoungTimeMapper.del(str, str2);
	}

	public int getTotalCountSyt(String category, String search) {
		int count = sangyoungTimeMapper.getTotalCountSyt(category, search);
		
		return count;
	}
	
	public int getTotalCount() {
		int count = sangyoungTimeMapper.getTotalCount();

		return count;
	}

	public TimeVo getTimeNumByNum(int num) {
		TimeVo timeVo = sangyoungTimeMapper.getTimeNumByNum(num);
		
		return timeVo;
	}

	public TimeVo getNumByTimeSyg(LocalDateTime str, String str2) {
		TimeVo timeVo = sangyoungTimeMapper.getNumByTimeSyg(str, str2);
		
		return timeVo;
	}

	public List<TimeVo> getSangyounggwanTime() {
		List<TimeVo> timeVoList = sangyoungTimeMapper.getSangyounggwanTime();
		
		return timeVoList;
	}

	public List<TimeVo> getSangyounggwanTimes(int startRowSyt, int pageSize, String category, String search) {
		List<TimeVo> timeList = sangyoungTimeMapper.getSangyounggwanTimes(startRowSyt, pageSize, category, search);
		
		return timeList;
	}

	public int getIdByTimeAndSyg(LocalDateTime strData, String str2) {
		int num = sangyoungTimeMapper.getIdByTimeAndSyg(strData, str2);
		
		return num;
	}

	public List<String> getSygByTheaterName(String changeTheaterName) {
		List<String> list = sangyoungTimeMapper.getSygByTheaterName(changeTheaterName);
		
		return list;
	}

	public List<MovieVo> getSangyoungMovie() {
		List<MovieVo> movieVoList = sangyoungTimeMapper.getSangyoungMovie();
		
		return movieVoList;
	}
}
