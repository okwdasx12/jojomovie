package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.domain.AttachPosterVo;
import com.example.domain.NoticeVo;

public interface NoticeBoardMapper {

	
	
	
	//////////////////////////////////////////////////////////////////
	///관리자
	int insertAdminNotice(NoticeVo noticeVo);
	
	//검색 목록, 목록
	public List<NoticeVo> noticeBoardGetAll(@Param("startRow") int startRow, 
											@Param("pageSize") int pageSize,
											@Param("category") String category, 
											@Param("search") String search );
	
	int countAllNotice(@Param("category") String category, @Param("search") String search);
	
	//글하나
	NoticeVo noticeListGetOne(int num);
	
	//조회수
	void updateReadcount(int num);
	
	@Select("select ifnull(max(num), 0) + 1 as max_num from notice ")
	int getBoardNum();
	
// board와 attachfile 테이블 조인해서 select
	NoticeVo getBoardAndAttachfilesByNum(int num);
	
	void noticeDelete(int num, @Param("pageNum") String pageNum);
	void noticeDeleteUuid(int num);
	
	int updateNotice(NoticeVo vo);
	
	
	
	@Select("SELECT * FROM attachposter WHERE bno =#{num}")
	public List<AttachPosterVo> showDeleteImage(int num);
	
	
}
