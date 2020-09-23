package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.domain.LikeVo;
import com.example.domain.MovieVo;
import com.example.mapper.MovieMapper;

@Service
@Transactional // 모든 메소드 각각이 한개의 트랜잭션 단위로 수행됨 // 자동 커밋,롤백
public class MovieService {

	@Autowired
	private MovieMapper movieMapper;

	public List<MovieVo> getMovieList() {
		List<MovieVo> movieVo = movieMapper.getMovieList();
		return movieVo;
	}

	public List<MovieVo> getMovieLimitFive() {
		List<MovieVo> list = null;

		list = movieMapper.getMovieLimitFive();

		return list;
	}

	public List<LikeVo> getLike() {
		List<LikeVo> list = null;

		list = movieMapper.getlike();

		return list;
	}

	public int likeCheck(int movieId, String userId) {
		int check = 0;

		check = movieMapper.likeCheck(movieId, userId);

		return check;
	}

	public MovieVo getMovieByName(String movieName) {
		MovieVo vo = movieMapper.getMovieByName(movieName);

		return vo;
	}

	public MovieVo getMovieById(int movieId) {
		MovieVo vo = movieMapper.getMovieById(movieId);

		return vo;
	}

	public void pushLike(int movieId, String userId) {
		movieMapper.pushLike(movieId, userId);
	}

	public void pushLikeCancle(int movieId, String userId) {
		movieMapper.pushLikeCancle(movieId, userId);
	}

	public void updateLikeCount(int movieId) {
		movieMapper.updateLikeCount(movieId);
	} // updateReadcount()

	public void deleteLikeCount(int movieId) {
		movieMapper.deleteLikeCount(movieId);
	} // updateReadcount()

	/////
	// 코멘트 게시판 새글번호 생성해서 가져오기
	public int getBoardNum() {
		return movieMapper.getBoardNum();
	} // getBoardNum()

	public void insert(MovieVo vo) {
		movieMapper.insert(vo);
	}

	// (검색어가 적용되는) board 테이블의 전체 행 갯수 가져오기
	public int getMovieTotalcount(String category, String search) {
		int count = movieMapper.getMovieTotalcount(category, search);

		return count;
	} // getMovieTotalcount()

	// (검색어가 적용되는) 게시판 글목록 가져오기
	public List<MovieVo> getMovieBoards(int startRow, int pageSize, String category, String search) {
		List<MovieVo> list = movieMapper.getMovieBoards(startRow, pageSize, category, search);

		return list;
	} // getMovieBoards()

	public List<MovieVo> getMoviePresent(int startRow, int pageSize, String category, String search) {
		List<MovieVo> list = movieMapper.getMoviePresent(startRow, pageSize, category, search);

		return list;
	} // getMoviePresent()

	// (검색어가 적용되는) board 테이블의 전체 행 갯수 가져오기
	public int getTotalcountMovie(String category, String search, int movieId) {
		int count = movieMapper.getTotalcountMovie(category, search, movieId);

		return count;
	} // getTotalcountMovie()

	public MovieVo getBoardsByMovieId(int movieId) {
		MovieVo vo = movieMapper.getBoardsByMovieId(movieId);

		return vo;
	}

	public int getCurrentTotalMovieCount(String category, String search) {
		int count = movieMapper.getCurrentTotalMovieCount(category, search);

		return count;
	}

	public List<MovieVo> getCurrentMovies(int startRow, int pageSize, String category, String search) {
		List<MovieVo> list = movieMapper.getCurrentMovies(startRow, pageSize, category, search);

		return list;
	}

	public List<MovieVo> getCurrentMovie() {
		List<MovieVo> list = movieMapper.getCurrentMovie();

		return list;
	}

	public int getComingTotalMovieCount(String category, String search) {
		int count = movieMapper.getComingTotalMovieCount(category, search);

		return count;
	}

	public List<MovieVo> getComingMovies(int startRow, int pageSize, String category, String search) {
		List<MovieVo> list = movieMapper.getComingMovies(startRow, pageSize, category, search);

		return list;
	}

	public List<MovieVo> searchMovie(int startRow, int pageSize, String category, String search) {
		List<MovieVo> list = movieMapper.getComingMovies(startRow, pageSize, category, search);

		return list;
	}
}
