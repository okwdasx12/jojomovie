package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.CommentVo;
import com.example.mapper.CommentMapper;

import lombok.extern.java.Log;

@Service
@Transactional // 모든 메소드 각각이 한개의 트랜잭션 단위로 수행됨
@Log
public class CommentService {

	@Autowired
	private CommentMapper commentMapper;

	public void insert(CommentVo vo) {
		// 새글번호 구하기
		int cmtNumber = commentMapper.getBoardNum();
		
		// 새글번호를 vo에 설정
		vo.setCmtNumber(cmtNumber);

		commentMapper.insert(vo);
	}

	// 코멘트 게시판 새글번호 생성해서 가져오기
	public int getBoardNum() {
		return commentMapper.getBoardNum();
	} // getBoardNum()

	public int cmtCountByMovie(int MvNum) {
		int num = commentMapper.cmtCountByMovie(MvNum);
		
		return num;
	}

	public int totalStarByMovie(int MvNum) {
		int num = commentMapper.totalStarByMovie(MvNum);
		
		return num;
	}

	// (검색어가 적용되는) board 테이블의 전체 행 갯수 가져오기
	public int getTotalcount(String category, String search, int movieId) {
		int count = commentMapper.getTotalCount(category, search, movieId);
		
		return count;
	} // getTotalcount()

	// (검색어가 적용되는) 게시판 글목록 가져오기
	public List<CommentVo> getBoards(int startRow, int pageSize, String category, String search, int movieId) {
		List<CommentVo> list = commentMapper.getBoards(startRow, pageSize, category, search, movieId);
		
		return list;
	} // getBoards()

	public void deleteBycmtNumber(String cmtNumber) {
		commentMapper.deleteBycmtNumber(cmtNumber);
	} // deleteByNum()

	public boolean isCmtDuplicated(String userId) {
		boolean isCmtDup = false;
		
		int count = commentMapper.countCmtById(userId);
		
		if (count >= 1) {
			isCmtDup = true; // 아이디중복
		} else { // count == 0
			isCmtDup = false; // 아이디중복아님
		}

		return isCmtDup;
	}

	public boolean isCmtMovieIdDuplicated(int movieId) {
		boolean isCmtMovieDup = false;
		
		int count = commentMapper.countCmtByMovieId(movieId);
		
		if (count >= 1) {
			isCmtMovieDup = true; // 불러올 게시글 있음
		} else { // count == 0
			isCmtMovieDup = false; // 불러올 게시글이 존재하지 않음
		}

		return isCmtMovieDup;
	}

	public CommentVo cmtNumberSelect(String cmtNumber) {
		CommentVo commentVo = commentMapper.cmtNumberSelect(cmtNumber);

		return commentVo;
	}

	public int updateCmt(CommentVo commentVo) {
		int insertCount = commentMapper.updateCmt(commentVo);
		
		return insertCount;
	}

}
