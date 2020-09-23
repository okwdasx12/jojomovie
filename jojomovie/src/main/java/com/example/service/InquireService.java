package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.InquireVo;
import com.example.mapper.InquireMapper;

import lombok.extern.java.Log;

@Log
@Service
@Transactional // 모든 메소드 각각이 한개의 트랜잭션 단위로 수행됨 // 자동 커밋,롤백
public class InquireService {

	@Autowired
	private InquireMapper inquireMapper;

	// inquire 테이블의 전체 행 갯수 가져오기
	public int getTotalCount(String category, String search, String userId, String grade) {
		int count = inquireMapper.getTotalCount(category, search, userId, grade);

		return count;
	} // getTotalCount()

	// 게시판 글목록 가져오기
	public List<InquireVo> getInquires(int startRow, int pageSize, String category, String search, String userId,
			String grade) {
		List<InquireVo> list = inquireMapper.getInquires(startRow, pageSize, category, search, userId, grade);

		return list;
	} // getBoards()

	// 레코드 1개 가져오기
	public InquireVo getInquireByNum(int num) {
		InquireVo vo = inquireMapper.getInquireByNum(num);

		return vo;
	} // getBoardByNum()

	// 문의하기 글 insert 하기
	public void insertInquire(InquireVo vo) {
		int num = inquireMapper.getInquireNum();

		// 주글 관련 re 필드값 설정
		vo.setReRef(num);
		vo.setReLev(0);
		vo.setReComp(0);

		inquireMapper.insertInquire(vo);
	} // insert()

	// 문의하기 글 update 하기
	public void updateInquire(InquireVo vo) {
		inquireMapper.updateInquire(vo);
	}

	// 문의하기 글 reply 하기
	public void replyInquire(InquireVo vo) {
		int reRef = vo.getReRef();

		// 주글 관련 re 필드값 설정
		vo.setReRef(reRef);
		vo.setReLev(1);
		vo.setReComp(1);

		inquireMapper.insertInquire(vo);
		inquireMapper.updateInquireReComp(reRef);
	} // insert()

	public void deleteInquire(int num) {
		inquireMapper.deleteInquire(num);
	}

	// 전체 문의 수
	public int getInquireTotalCount(String userId, String grade) {
		int total = inquireMapper.getInquireTotalCount(userId, grade);

		return total;
	}

	// 답변 안달린 문의 수
	public int getInquireIngCount(String userId, String grade) {
		int ing = inquireMapper.getInquireIngCount(userId, grade);

		return ing;
	}

	// 답변 달린 문의 수
	public int getInquireFinCount(String userId, String grade) {
		int fin = inquireMapper.getInquireFinCount(userId, grade);

		return fin;
	}

}
