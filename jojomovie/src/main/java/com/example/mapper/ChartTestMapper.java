package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.domain.ChartDto;

public interface ChartTestMapper {

	 @Select("SELECT movie_name, like_cnt, score "
	 		+ "FROM movie_release WHERE rel_movie = #{now}")
	 List<ChartDto> read(@Param("now") String now);
}
