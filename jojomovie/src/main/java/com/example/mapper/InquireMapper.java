package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.domain.InquireVo;

public interface InquireMapper {
	
	int getTotalCount(@Param("category") String category, 
					@Param("search") String search, 
					@Param("userId") String userId, 
					@Param("grade") String grade);
	
	// 매퍼 메소드의 매개변수가 2개 이상일때는
	// @Param 애노테이션 값으로 sql문에 배치.
	List<InquireVo> getInquires(@Param("startRow") int startRow, 
							@Param("pageSize") int pageSize, 
							@Param("category") String category, 
							@Param("search") String search,
							@Param("userId") String userId, 
							@Param("grade") String grade);
	
	@Select("SELECT * FROM inquire WHERE num = #{num}")
	InquireVo getInquireByNum(int num);
	
	@Select ("select ifnull(max(num), 0) + 1 as max_num from inquire ")
	int getInquireNum();
	
	void insertInquire(InquireVo vo);
	
	void updateInquire(InquireVo vo);
	
	@Update("UPDATE inquire SET re_comp = '1' WHERE num = #{reRef}")
	void updateInquireReComp(int reRef);
	
	@Delete("DELETE FROM inquire WHERE num = #{num}")
	void deleteInquire(int num);
	
	int getInquireTotalCount(@Param("userId") String userId, @Param("grade") String grade);
	
	int getInquireIngCount(@Param("userId") String userId, @Param("grade") String grade);
	
	int getInquireFinCount(@Param("userId") String userId, @Param("grade") String grade);
}








