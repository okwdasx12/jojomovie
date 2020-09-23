package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.example.domain.AttachPosterVo;

public interface NoticeMapper {

	
	
	
	@Insert("INSERT INTO attachposter (uuid, filename, uploadpath, image, bno) "
			+ "VALUES (#{uuid}, #{filename}, #{uploadpath}, #{image}, #{bno})")
	void insert(AttachPosterVo vo);
		
	@Select("select ifnull(max(num), 0) + 1 as max_num from notice ")
	int getBoardNum();
		
	@Select("SELECT * FROM attachposter WHERE uuid = #{uuid}")
	AttachPosterVo getAttachfileByUuid(String uuid);

	@Select("SELECT * FROM attachposter WHERE bno = #{bno}")
	List<AttachPosterVo> getAttachfilesByBno(int bno);

	@Insert("INSERT INTO attachposter (uuid, filename, uploadpath, image, bno) "
			+ "VALUES (#{uuid}, #{filename}, #{uploadpath}, #{image}, #{num})")
	void modifyFile(AttachPosterVo vo, int num);

	@Delete("DELETE FROM attachposter WHERE uuid = #{selectfile}")
	void delete(String selectfile);

	@Select("SELECT * FROM attachposter WHERE uuid =#{selectfile}")
	AttachPosterVo uuSelectUuid(String selectfile);
	
	@Select("SELECT count(*) from attachposter where bno =#{num}")
	int getNum(int num);
	
}
