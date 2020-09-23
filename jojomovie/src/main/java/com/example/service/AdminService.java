package com.example.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.domain.AttachVo;
import com.example.domain.MemberVo;
import com.example.domain.MovieVo;
import com.example.domain.ReserveVo;
import com.example.domain.TimeVo;
import com.example.mapper.AdminMapper;
import com.example.mapper.AttachMapper;

import lombok.extern.java.Log;

@Log
@Service
public class AdminService {

	@Autowired
	private AdminMapper adminMapper;

	@Autowired
	private AttachMapper attachMapper;

	public void insert(MovieVo vo) {
		adminMapper.insert(vo);
	};

	public int countByArr(String arrChoice) {
		int count = adminMapper.countByArr(arrChoice);
		
		return count;
	}

	///////////////////////////////////////////////////////////////////////////////
	public List<MovieVo> getBoards(int startRow, int pageSize, String category, String search) {
		List<MovieVo> list = adminMapper.getBoards(startRow, pageSize, category, search);
		
		return list;
	}

	public int getTotalCount(String category, String search) {
		int count = adminMapper.getTotalCount(category, search);
		
		return count;
	}

	////////////////////////////////////////////////////////////////////////////////////
	// 수정폼
	public MovieVo ListGetOne(String movieId) {
		MovieVo vo = adminMapper.ListGetOne(movieId);
		
		return vo;
	}

	// 업데이트
	public void updateMovie(MovieVo vo) {
		adminMapper.updateMovie(vo);
	}

	public void DeleteMovie(String movieId, String movieIdCheck) {
		adminMapper.DeleteMovie(movieId, movieIdCheck);
	}

	///////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////// 회원 관리 페이지
	/////////////////////////////////////////////////////////////////////////////////////////// ////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////

	public List<MemberVo> memberManage(int startRow, int pageSize, String category, String search) {
		List<MemberVo> memberList = adminMapper.memberManage(startRow, pageSize, category, search);
		
		return memberList;
	}

	public int countAllMember(String category, String search) {
		int count = 0;
		count = adminMapper.countAllMember(category, search);
		
		return count;
	}

	public MemberVo getOne(String userId) {
		MemberVo vo = adminMapper.getOne(userId);
		
		return vo;
	}

	public void updateMember(MemberVo vo) {
		adminMapper.updateMember(vo);
	}

	///////////////////// 예매 관리

	public ReserveVo selectReserv(String ticketId) {
		ReserveVo vo = adminMapper.selectReserv(ticketId);

		return vo;
	}

	// 전체 회원 예매 목록(페이징 포함)
	public List<ReserveVo> Listreserv(int startRow, int pageSize, String category, String search) {
		List<ReserveVo> Listreserv = adminMapper.Listreserv(startRow, pageSize, category, search);
		
		return Listreserv;
	}

	// 전체 예매 갯수
	public int getCountReserv(String category, String search) {
		int count = 0;
		count = adminMapper.getCountReserv(category, search);
		
		return count;
	}

	/// 수정
	public ReserveVo ReserVgetByOne(int reserveNumber) {
		ReserveVo vo = adminMapper.ReserVgetByOne(reserveNumber);
		
		return vo;
	}

	public void timeSetUpdate(String stst, String sygId, LocalDateTime sangyoungTime) {
		adminMapper.timeSetUpdate(sygId, sangyoungTime, stst);
	}

	public TimeVo getAllReserveSeats(String sygId, LocalDateTime sangyoungTime) {
		TimeVo timeVo = adminMapper.getAllReserveSeats(sygId, sangyoungTime);

		return timeVo;
	}

	public void memberPointUpgrade(int point, String userId) {
		adminMapper.memberPointUpgrade(userId, point);
	}

	// 새로추가
	public int getBoardMovieId() {
		return adminMapper.getBoardMovieId();
	}

	public void insertBoardAndAttaches(MovieVo movieVo, List<AttachVo> list) {
		// 게시글 등록
		adminMapper.insert(movieVo);

		// 첨부파일들 있으면 등록
		if (list.size() > 0) {
			for (AttachVo attachVo : list) {
				attachMapper.insert(attachVo);
			}
		}
	} // insertBoardAndAttaches()

	public void deleteAttach(int movieId) {
		attachMapper.delete(movieId);
	}

	public void modifyBoardAndAttaches(MovieVo vo, List<AttachVo> attachList) {
		// 게시글 등록
		adminMapper.updateMovie(vo);

		// 첨부파일들 있으면 등록
		if (attachList.size() > 0) {
			for (AttachVo attachVo : attachList) {
				attachMapper.insert(attachVo);
			}
		}
	} // insertBoardAndAttaches()

	public void getDeleteMovieId(int movieId) {
		adminMapper.getDeleteMovieId(movieId);
	}

	// point 조회
	public MemberVo getBymemberPoint(String userId) {
		MemberVo vo = adminMapper.getBymemberPoint(userId);
		
		return vo;
	}

	public void deleteReserve(String reserveNumber) {
		adminMapper.deleteReserve(reserveNumber);
	}

	public void deletePay(String payId) {
		adminMapper.deletePay(payId);
	}

	/////////// 체크박스 삭제
	public void deleteMemberByCheck(List<String> userlist) {
		adminMapper.deleteMemberByCheck(userlist);
	}

	// 차트
	public MovieVo chartSelect(String searchMovie) {
		MovieVo vo = adminMapper.chartSelect(searchMovie);

		return vo;
	}

	////////////// addMovieTime에 쓰는 getMovie /////////////
	public List<MovieVo> getMovie() {
		List<MovieVo> movieVoList = adminMapper.getMovie();

		return movieVoList;
	}

}
