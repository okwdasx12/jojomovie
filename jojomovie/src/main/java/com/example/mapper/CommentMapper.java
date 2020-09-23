package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.domain.CommentVo;

public interface CommentMapper {
	
	void insert(CommentVo vo);
		
	@Select("select ifnull(max(cmt_number), 0) + 1 as max_num from cmt ")
	int getBoardNum();
	
	@Select("select count(*) from cmt where movie_id =#{num}")
	int cmtCountByMovie(int num);
	
	int totalStarByMovie(int num);
	
	int getTotalCount(@Param("category") String category,
			@Param("search") String search,
			@Param("movieId") int movieId);
	
	List<CommentVo> getBoards(@Param("startRow") int startRow,
			@Param("pageSize") int pageSize,
			@Param("category") String category,
			@Param("search") String search,
			@Param("movieId") int movieId);
	
	CommentVo getBoardByNum(int cmtNumber);
	
	@Delete("DELETE FROM cmt WHERE cmt_number = #{cmtNumber}")
	void deleteBycmtNumber(String cmtNumber);
	
	@Select("SELECT COUNT(*) FROM cmt WHERE user_id = #{userId}")
	int countCmtById(String userId);
	
	@Select("SELECT COUNT(*) FROM cmt WHERE movie_id = #{movieId}")
	int countCmtByMovieId(int movieId);
	
	@Select("SELECT * FROM cmt WHERE cmt_number = #{cmtNumber}")
	CommentVo cmtNumberSelect(@Param("cmtNumber") String cmtNumber);
	
	// 한줄평 게시판 수정
	public int updateCmt(CommentVo commentVo);
	
}