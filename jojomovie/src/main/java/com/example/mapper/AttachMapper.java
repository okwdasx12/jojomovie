package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.example.domain.AttachVo;

public interface AttachMapper {

	@Insert("INSERT INTO attach (uuid, filename, uploadpath, movie_id, movie_name) "
			+ "VALUES (#{uuid}, #{filename}, #{uploadpath}, #{movieId}, #{movieName})")
	void insert(AttachVo vo);
		
	@Select("select ifnull(max(num), 0) + 1 as max_num from movie ")
	int getBoardNum();
		
	@Select("SELECT * FROM attach WHERE uuid = #{uuid}")
	AttachVo getAttachfileByUuid(String uuid);

	@Select("SELECT * FROM attach WHERE movie_id = #{movieId}")
	List<AttachVo> getAttachByMovieId(int movieId);

	@Delete("DELETE FROM attach WHERE movie_id = #{movieId}")
	void delete(int movieId);
	
	@Select("SELECT count(*) from attachposter where movie_id = #{movieId}")
	int getMovieId(int movieId);
}
