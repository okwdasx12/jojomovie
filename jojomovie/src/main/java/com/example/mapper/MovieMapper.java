package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.domain.LikeVo;
import com.example.domain.MovieVo;

public interface MovieMapper {
	@Select("SELECT * FROM movie ORDER BY score desc")
	List<MovieVo> getMovieList();
	
	@Select("SELECT * FROM movie ORDER BY like_cnt desc LIMIT 5 ")
	List<MovieVo> getMovieLimitFive();
	
	@Select("SELECT * FROM liketable")
	List<LikeVo> getlike();
	
	@Insert("INSERT INTO liketable (user_id, movie_id) VALUES (#{userId}, #{movieId})")
	void pushLike(@Param("movieId") int movieId, @Param("userId") String userId);
	
	@Delete("DELETE FROM liketable WHERE user_id=#{userId} and movie_id=#{movieId}")
	void pushLikeCancle(@Param("movieId") int movieId, @Param("userId") String userId);
	
	@Select("SELECT COUNT(*) FROM liketable WHERE user_id=#{userId} and movie_id=#{movieId}")
	int likeCheck(int movieId, String userId);
	
	@Select("SELECT * FROM movie where movie_name=#{movieName}")
	MovieVo getMovieByName(String movieName);
	
	@Select("SELECT * FROM movie where movie_id=#{movieId}")
	MovieVo getMovieById(int movieId);
	
	void updateLikeCount(int movieId);
	
	void deleteLikeCount(int movieId);
	
	//////
	void insert(MovieVo vo);
	
	@Select("select ifnull(max(cmt_number), 0) + 1 as max_num from cmt ")
	int getBoardNum();
	
	int getMovieTotalcount(@Param("category") String category,
			@Param("search") String search);
	
	List<MovieVo> getMovieBoards(@Param("startRow") int startRow,
			@Param("pageSize") int pageSize,
			@Param("category") String category,
			@Param("search") String search);
	
	
	List<MovieVo> getMoviePresent(@Param("startRow") int startRow,
			@Param("pageSize") int pageSize,
			@Param("category") String category,
			@Param("search") String search);
	
	MovieVo getBoardByNum(int cmtNumber);
	
	int getTotalcountMovie(@Param("category") String category,
			@Param("search") String search,
			@Param("movieId") int movieId);
	
	@Select("select * from movie_release where movie_id=#{movieId}")
	MovieVo getBoardsByMovieId(int movieId);
	
	int getCurrentTotalMovieCount(String category, String search);
	
	List<MovieVo> getCurrentMovies(@Param("startRow") int startRow,
								   @Param("pageSize") int pageSize,
								   @Param("category") String category,
								   @Param("search") String search);
	
	List<MovieVo> getCurrentMovie();
	
	int getComingTotalMovieCount(String category, String search);
	
	List<MovieVo> getComingMovies(@Param("startRow") int startRow,
			   @Param("pageSize") int pageSize,
			   @Param("category") String category,
			   @Param("search") String search);
}

