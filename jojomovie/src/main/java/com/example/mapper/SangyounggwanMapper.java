package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.domain.SangyounggwanVo;

public interface SangyounggwanMapper {
	void insert(SangyounggwanVo sangyounggwanVo);
	
	void update(SangyounggwanVo sangyounggwanVo );
	
	void updateDif(@Param("beforeStr") String beforeStr, @Param("afterStr") String afterStr);
	
	@Select("select count(*) from sangyounggwan")
	int getTotalCount();
	
	int getTotalCountSyg(@Param("category") String category, @Param("search") String search);
	
	@Select("select * from sangyounggwan")
	List<SangyounggwanVo> getSangyounggwan();
	
	List<SangyounggwanVo> getSangyounggwans(@Param("startRowSyg") int startRowSyg, @Param("pageSize") int pageSize, @Param("category") String category, @Param("search") String search);
	
	@Delete("delete from sangyounggwan where syg_id=#{sygId}")
	void del(String sygId);
	
	@Select("select * from sangyounggwan where syg_id=#{sygId}")
	SangyounggwanVo getSangyounggwanById(String sygId);
	
	@Select("select theater_name from theater where theater_id=#{changeTheaterId}")
	String getTheaterNameByTheaterId(String changeTheaterId);
}
