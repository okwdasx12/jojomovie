package com.example.mapper;

import java.time.LocalDate;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.domain.MemberVo;
import com.example.domain.MovieVo;
import com.example.domain.PayVo;
import com.example.domain.ReserveDto;
import com.example.domain.ReserveVo;
import com.example.domain.SangyounggwanVo;
import com.example.domain.TheaterVo;

public interface ReservationMapper {
	
	@Select("select movie_id, movie_name from movie_release where rel_movie = '상영중' or rel_movie = '상영임박'")
	List<MovieVo> movieRel();
	
	@Select("select theater_name from time_release where rel_movie_time = '상영예정' group by theater_name")
	List<TheaterVo> theaterRel(); 
	
	@Select("select date_add(#{ld}, interval #{num} day) AS dateAdd")
	String dateAdd(@Param("ld") LocalDate ld, @Param("num") int num);
	
	@Select("select sangyoung_time, seats_num, reserve_seats, syg_id, time_num from time_release where movie_id=#{movieId} and theater_name=#{theater} and sangyoung_time like concat ('%',#{date},'%') order by syg_id asc, sangyoung_time asc")
	List<ReserveDto> getSangyoungTime(@Param("movieId") int movieId, @Param("theater") String theater, @Param("date") LocalDate date);
	
	@Select("select row, cul from sangyounggwan where syg_id=#{sygId}")
	SangyounggwanVo getRowCul(String sygId);
	
	void insertReservation(ReserveVo reserveVo);

	void insertPay(PayVo payVo);
	
	@Select("select reserve_seats from time where time_num=#{timeNum}")
	String getReserveSeatsByTimeNum(int timeNum);
	
	void updateReserveSeats(@Param("timeNum") int timeNum, @Param("strSeats") String strSeats);
	
	@Select("SELECT point FROM member where user_id =#{userId}")
	MemberVo findUserPoint(@Param("userId") String userId);
	
	void updateUserPoint(@Param("usepoint") int usepoint, @Param("point") int point, @Param("userId") String userId);
}
