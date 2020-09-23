package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.domain.AttachPosterVo;
import com.example.domain.NoticeVo;
import com.example.mapper.NoticeBoardMapper;
import com.example.mapper.NoticeMapper;

import lombok.Data;
import lombok.extern.java.Log;

@Data
@Service
public class NoticeService {

	@Autowired
	private NoticeMapper noticeMapper;
	
	@Autowired
	private NoticeBoardMapper noticeBoardMapper;

	// 첨부파일정보 한개 추가
	public void insert(AttachPosterVo vo) {
		noticeMapper.insert(vo);
	} // insert

	// 첨부파일정보 여러개 추가
	public void insert(List<AttachPosterVo> list) {
		for (AttachPosterVo vo : list) {
			this.insert(vo);
		}
	}

	// 게시판 새글번호 생성해서 가져오기
	public int getBoardNum() {
		return noticeMapper.getBoardNum();
	} // getBoardNum()

	public void insertBoardAndAttaches(NoticeVo noticeVo, List<AttachPosterVo> attachList) {
		// 게시글 등록
		noticeBoardMapper.insertAdminNotice(noticeVo);

		// 첨부파일들 있으면 등록
		if (attachList.size() > 0) {
			for (AttachPosterVo attachVo : attachList) {
				noticeMapper.insert(attachVo);
			}
		}
	} // insertBoardAndAttaches()

	public AttachPosterVo getAttachfileByUuid(String uuid) {
		AttachPosterVo vo = noticeMapper.getAttachfileByUuid(uuid);
		
		return vo;
	}

	public List<AttachPosterVo> getAttachfilesByBno(int bno) {
		List<AttachPosterVo> list = noticeMapper.getAttachfilesByBno(bno);
		
		return list;
	}

	public void modifyFile(AttachPosterVo vo, int num) {
		noticeMapper.modifyFile(vo, num);
	} // insert

	// 첨부파일정보 여러개 추가
	public void modifyFile(List<AttachPosterVo> list, int num) {
		for (AttachPosterVo vo : list) {
			this.modifyFile(vo, num);
		}
	}

	public void modifyBoardAndAttaches(NoticeVo vo, List<AttachPosterVo> attachList) {
		// 게시글 등록
		noticeBoardMapper.updateNotice(vo);

		// 첨부파일들 있으면 등록
		if (attachList.size() > 0) {
			for (AttachPosterVo attachVo : attachList) {
				noticeMapper.insert(attachVo);
			}
		}
	} // insertBoardAndAttaches()

	public void delete(String selectfile) {
		noticeMapper.delete(selectfile);
	}

	public AttachPosterVo uuSelectNum(String selectfile) {
		AttachPosterVo vo = noticeMapper.uuSelectUuid(selectfile);

		return vo;
	}

	public int getNum(int num) {
		int Countnum = noticeMapper.getNum(num);

		return Countnum;
	}
}