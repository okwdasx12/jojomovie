package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.domain.MemberVo;

public interface MemberMapper {
	
	// 회원가입 메소드
	// 애노테이션이 없으면 같은 경로의 같은 이름의
	// xml 매퍼파일을 찾아서 해당 sql구문을 실행함
	int insert(MemberVo vo);
	
	@Select("select passwd from member where user_id = #{userId}")
	String getPasswdById(String userId);
	
	@Select("SELECT COUNT(*) FROM member WHERE user_id = #{userId}")
	int countMemberById(String userId);
	
	@Select("SELECT COUNT(*) FROM member WHERE user_email = #{userEmail}")
	int countMemberByuserEmail(String userEmail);
	
	@Select("SELECT * FROM member ORDER BY user_id ASC")
	List<MemberVo> getMembers();
	
	@Select("SELECT * FROM member WHERE user_id = #{userId}")
	MemberVo getMemberById(String userId);
	
	@Select("SELECT user_id FROM member WHERE name=#{userName} and phone=#{userPhone}")
	String findIdByuserNamePhone(String userName, String userPhone);
	
	@Select("SELECT COUNT(*) FROM member WHERE user_id = #{userId} and user_email = #{userEmail}")
	int countMemberByuserIdEmail(String userId, String userEmail);
	
	int update(MemberVo vo);
	
	@Delete("DELETE FROM member WHERE user_id = #{userId}")
	int deleteById(String userId);
	
	@Delete("DELETE FROM member")
	void deleteAll();
	
	@Select("SELECT COUNT(*) FROM member ")
	int getCount();
	
	@Update("UPDATE member SET passwd=#{ranPasswdNum} WHERE user_id=#{userId} ")
	int changePasswd(String userId, String ranPasswdNum);
	
}








