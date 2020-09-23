package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.domain.ChartDto;
import com.example.mapper.ChartTestMapper;

import lombok.extern.java.Log;

@Log
@Service
public class ChartTestService {

	@Autowired
	ChartTestMapper chartTestMapper;

	public List<ChartDto> movieGet(String now) {
		List<ChartDto> list = null;

		list = chartTestMapper.read(now);

		return list;
	}
}
