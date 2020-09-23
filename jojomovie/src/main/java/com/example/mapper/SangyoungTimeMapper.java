package com.example.mapper;

import java.time.LocalDateTime;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.domain.MovieVo;
import com.example.domain.TimeVo;


public interface SangyoungTimeMapper {
	void insert(TimeVo timeVo);
	
	@Select("select ifnull(max(time_num), 0) + 1 as max_time_num from time")
	int getTimeNum();
	
	void update(TimeVo timeVo);
	
	@Select("select * from movie_release where rel_movie='상영중' or rel_movie='상영임박'")
	List<MovieVo> getSangyoungMovie();
	
	@Select("select count(*) from time")
	int getTotalCount();
	
	int getTotalCountSyt(@Param("category") String category, @Param("search") String search);
	
	@Select("select * from time where time_num=#{num}")
	TimeVo getTimeNumByNum(int num);
	
	@Select("select * from time order by syg_id asc, sangyoung_time asc")
	List<TimeVo> getSangyounggwanTime();

	List<TimeVo> getSangyounggwanTimes(@Param("startRowSyt") int startRowSyt, @Param("pageSize") int pageSize, @Param("category") String category, @Param("search") String search);
	
	@Delete("delete from time where sangyoung_time=#{str} and syg_id=#{str2}")
	void del(@Param("str") LocalDateTime str, @Param("str2") String str2);
	
	@Select("select time_num from time where sangyoung_time=#{str} and syg_id=#{str2}")
	int getIdByTimeAndSyg(@Param("str") LocalDateTime strData, @Param("str2") String str2);
	
	@Select("select * from time where sangyoung_time= #{str} and syg_id=#{str2}")
	TimeVo getNumByTimeSyg(@Param("str") LocalDateTime str, @Param("str2") String str2);
	
	@Select("select syg_id from sangyounggwan where theater_name=#{changeTheaterName} group by syg_id order by syg_id")
	List<String> getSygByTheaterName(String changeTheaterName);
}
