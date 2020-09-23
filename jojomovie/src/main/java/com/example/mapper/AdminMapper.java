package com.example.mapper;

import java.time.LocalDateTime;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.domain.MemberVo;
import com.example.domain.MovieVo;
import com.example.domain.ReserveVo;
import com.example.domain.TimeVo;

public interface AdminMapper {

	// 등록
	int insert(MovieVo vo);

	///////////////////////////////////////////////////////////////////////////////////
	// 서치 목록 조회(페이징)
	List<MovieVo> getBoards(@Param("startRow") int startRow, @Param("pageSize") int pageSize,
			@Param("category") String category, @Param("search") String search);

	// 총 갯수
	int getTotalCount(@Param("category") String category, @Param("search") String search);

	int countByArr(@Param("arrChoice") String arrChoice);

	// 수정폼(한개 데려오기)
	MovieVo ListGetOne(String movieId);

	// update
	int updateMovie(MovieVo vo);

	int DeleteMovie(@Param("movieId") String movieId, @Param("movieIdCheck") String movieIdCheck);

	///////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////// 회원 관리 페이지
	/////////////////////////////////////////////////////////////////////////////////////////// ////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////

	List<MemberVo> memberManage(@Param("startRow") int startRow, @Param("pageSize") int pageSize,
			@Param("category") String category, @Param("search") String search);

	int countAllMember(@Param("category") String category, @Param("search") String search);

	MemberVo getOne(@Param("userId") String userId);

	int updateMember(MemberVo vo);

	///////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////// 예매 관리 페이지
	/////////////////////////////////////////////////////////////////////////////////////////// ////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////

	ReserveVo selectReserv(@Param("ticketId") String ticketId);

	// 총갯수
	int getCountReserv(@Param("category") String category, @Param("search") String search);

	// 페이징 리스트 (전체 회원 목록)
	List<ReserveVo> Listreserv(@Param("startRow") int startRow, @Param("pageSize") int pageSize,
			@Param("category") String category, @Param("search") String search);

	// 수정
	ReserveVo ReserVgetByOne(@Param("reserveNumber") int reserveNumber);

	@Update("update time set reserve_seats=#{stst} where syg_id=#{sygId} and sangyoung_time=#{sangyoungTime} ")
	void timeSetUpdate(@Param("sygId") String sygId, @Param("sangyoungTime") LocalDateTime sangyoungTime,
			@Param("stst") String stst);

	@Select("select * from time where syg_id=#{sygId} and sangyoung_time=#{sangyoungTime}")
	TimeVo getAllReserveSeats(@Param("sygId") String sygId, @Param("sangyoungTime") LocalDateTime sangyoungTime);

	@Select("select ifnull(max(movie_id), 0) + 1 as max_num from movie ")
	int getBoardMovieId();

	@Update("update member set point = #{point} where user_id=#{userId}")
	void memberPointUpgrade(@Param("userId") String userId, @Param("point") int point);

	///// poster delete ajax
	@Delete("DELETE FROM attach WHERE movie_id =#{movieId}")
	void getDeleteMovieId(int movieId);

	//// point 조회
	@Select("select point from member where user_id = #{userId}")
	MemberVo getBymemberPoint(String userId);

	// int updateReserve(ReserveVo vo);
	void deleteReserve(@Param("reserveNumber") String reserveNumber);

	void deletePay(@Param("payId") String payId);

	/////////// 체크리스트 삭제
	void deleteMemberByCheck(@Param("userlist") List<String> userlist);

	// 차트 선택한 뮤비 가져오기
	MovieVo chartSelect(@Param("searchMovie") String searchMovie);

	////////////// addMovieTime에 쓰는 getMovie /////////////
	@Select("select * from movie_release where rel_movie='상영중' or rel_movie='상영예정'")
	List<MovieVo> getMovie();

}
