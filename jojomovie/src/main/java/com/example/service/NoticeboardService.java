package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.domain.AttachPosterVo;
import com.example.domain.NoticeVo;
import com.example.mapper.NoticeBoardMapper;

import lombok.extern.java.Log;

@Log
@Service
public class NoticeboardService {

	@Autowired
	private NoticeBoardMapper noticeBoardMapper;

////////////////////////////////////////////////////////////////
/////////////관리자 공지사항

	public void insertAdminNotice(NoticeVo noticeVo) {
		noticeBoardMapper.insertAdminNotice(noticeVo);
	}

//목록(검색)
	public List<NoticeVo> noticeBoardGetAll(int startRow, int pageSize, String category, String search) {
		List<NoticeVo> list = noticeBoardMapper.noticeBoardGetAll(startRow, pageSize, category, search);

		return list;
	}

	public int countAllNotice(String category, String search) {
		int count = noticeBoardMapper.countAllNotice(category, search);
		
		return count;

	}

	public NoticeVo noticeListGetOne(int num) {
		NoticeVo vo = noticeBoardMapper.noticeListGetOne(num);
		
		return vo;
	}

//조회수
	public void updateReadcount(int num) {
		noticeBoardMapper.updateReadcount(num);
	} // updateReadcount()

// 게시판 새글번호 생성해서 가져오기
	public int getBoardNum() {
		return noticeBoardMapper.getBoardNum();
	} // getBoardNum()

// board테이블과 attachfile 테이블 조인해서 결과 리턴
	public NoticeVo getBoardAndAttachfilesByNum(int num) {
		NoticeVo noticeVo = noticeBoardMapper.getBoardAndAttachfilesByNum(num);
		
		return noticeVo;
	} // getBoardAndAttachfilesByNum

	public void noticeDelete(int num, String pageNum) {
		noticeBoardMapper.noticeDelete(num, pageNum);
	}

	public void noticeDeleteUuid(int num) {
		noticeBoardMapper.noticeDeleteUuid(num);
	}

	public void updateNotice(NoticeVo vo) {
		noticeBoardMapper.updateNotice(vo);
	}

	public List<AttachPosterVo> showDeleteImage(int num) {
		List<AttachPosterVo> list = noticeBoardMapper.showDeleteImage(num);

		return list;
	}

}
