package com.example.mapper;

import java.time.LocalDateTime;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.domain.MemberVo;
import com.example.domain.PayVo;
import com.example.domain.ReserveVo;

public interface MypageMapper {
	
	@Select("SELECT * FROM member WHERE user_Id = #{userId}")
	MemberVo myinfo(String userId);
	
	int update(MemberVo vo);
	
	@Delete("DELETE FROM member WHERE user_Id = #{userId}")
	void deleteById(String userId);
	
	@Select("SELECT * FROM reservation WHERE user_id = #{userId} and sangyoung_time > #{ldt}")
	List<ReserveVo> myReserve(@Param("userId") String userId, @Param("ldt") LocalDateTime ldt);
	
	@Select("SELECT * FROM reservation WHERE user_id = #{userId} and sangyoung_time < #{ldt}")
	List<ReserveVo> myReservePre(@Param("userId") String userId, @Param("ldt") LocalDateTime ldt);
	
	@Select("SELECT * FROM reservation WHERE reserve_number = #{reserveNumber}")
	ReserveVo reserveInfo(int reserveNumber);
	
	@Select("SELECT * FROM pay WHERE pay_id = #{payId}")
	PayVo payInfo(String payId);
}
