package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.SangyounggwanVo;
import com.example.mapper.SangyounggwanMapper;

@Service
@Transactional
public class SangyounggwanService {

	@Autowired
	private SangyounggwanMapper sangyounggwanMapper;

	public void insert(SangyounggwanVo sangyounggwanVo) {
		sangyounggwanMapper.insert(sangyounggwanVo);
	}

	public void update(SangyounggwanVo sangyounggwanVo) {
		sangyounggwanMapper.update(sangyounggwanVo);
	}
	
	public void updateDif(String beforeStr, String afterStr) {
		sangyounggwanMapper.updateDif(beforeStr, afterStr);
	}
	
//	public String getBeforeSygId(String str) {
//		List<String> strReturn = sangyounggwanMapper.getBeforeSygId(str);
//		String re = strReturn.get(0);
//		return re;
//	}

	public void del(String sygId) {
		sangyounggwanMapper.del(sygId);
	}

	public int getTotalCountSyg(String category, String search) {
		int count = sangyounggwanMapper.getTotalCountSyg(category, search);
		
		return count;
	}
	
	public int getTotalCount() {
		int count = sangyounggwanMapper.getTotalCount();

		return count;
	}

	public List<SangyounggwanVo> getSangyounggwan() {
		List<SangyounggwanVo> sangyounggwanVoList = sangyounggwanMapper.getSangyounggwan();
		
		return sangyounggwanVoList;
	}

	public List<SangyounggwanVo> getSangyounggwans(int startRowSyg, int pageSize, String category, String search) {
		List<SangyounggwanVo> sangyounggwanList = sangyounggwanMapper.getSangyounggwans(startRowSyg, pageSize, category, search);
		return sangyounggwanList;
	}

	public SangyounggwanVo getSangyounggwanById(String sygId) {
		SangyounggwanVo sangyounggwanVo = sangyounggwanMapper.getSangyounggwanById(sygId);

		return sangyounggwanVo;
	}

	public String getTheaterNameByTheaterId(String changeTheaterId) {
		String theaterName = sangyounggwanMapper.getTheaterNameByTheaterId(changeTheaterId);
		
		return theaterName;
	}
}
