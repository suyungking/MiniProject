package org.kosa.mini.login;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface LoginDAO {
	public Member getMember(String userid);
	public void setLoginTime(String userid);
	public int update(Member member);
	public int failUser(Member member);
	public int insert(Member member);
	public List<Member> list(Map<String, Object> map);
	public int getTotalCount(Map<String, Object> map);

	public String vailedUserid(String userid);
	public String vailedEmail(String email);
	public int admin(String userid);
	public int clear(String userid);
	public int delete(String userid);
	public int restoration(String userid);
	
}


