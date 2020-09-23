package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.domain.TheaterVo;

public interface TheaterMapper {
	void insert(TheaterVo theaterVo);

	void update(TheaterVo theaterVo);
	
	void updateDif(@Param("afterTheaterName")String afterTheaterName, @Param("beforeTheaterName")String beforeTheaterName);

	void searchSygId(@Param("strBefore") String strBefore, @Param("strAfter") String strAfter);

	void searchSygTimeInSygId(@Param("strBefore") String strBefore, @Param("strAfter") String strAfter);

	@Select("select count(*) from theater")
	int getTotalCount();
	
	int getTotalCountTh(@Param("category") String category, @Param("search") String search);

	@Select("select * from theater where theater_id=#{theaterId}")
	TheaterVo getTheaterById(String theaterId);

	@Delete("delete from theater where theater_id=#{theaterId}")
	void del(String theaterId);

	@Select("select * from theater")
	List<TheaterVo> getTheater();

	List<TheaterVo> getTheaters(@Param("startRowTh") int startRowTh, @Param("pageSize") int pageSize,
			@Param("category") String category, @Param("search") String search);
}
