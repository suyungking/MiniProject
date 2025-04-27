package org.kosa.mini.member;

import java.util.HashMap;
import java.util.Map;

import org.kosa.mini.member.Member;
import org.kosa.mini.page.PageResponseVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberService {
	@Autowired
	private MemberDAO memberDAO;

	public Member login(String userid, String passwd) {
		int failCount = 0;
		Member member = memberDAO.getMember(userid);
		if (member == null)
			return null;

		if ("Y".equals(member.getLocked()))
			return null;

		boolean result = member.getPasswd().equals(passwd);
		if (result == false) {
			failCount = member.getFailcount() + 1;
			member.setFailcount(failCount);
			if (failCount >= 5) {
				member.setLocked("Y");
			} else {
				member.setLocked("N");
			}
			memberDAO.failUser(member);
			return null;
		}

		member.setFailcount(0);
		member.setLocked("N");
		memberDAO.failUser(member);
		memberDAO.setLoginTime(userid);

		return member;
	}

	
	public Member vailed(String userid, String passwd) {
		Member member = memberDAO.getMember(userid);
		if (member == null)
			return null;

		boolean result = member.getPasswd().equals(passwd);
		if (result == false)
			return null;
		return member;
	}

	public Member getMember(String userid) {
		return memberDAO.getMember(userid);
	}

	public Member update(Member member) {
		Member memberDB = memberDAO.getMember(member.getUserid());
		if (memberDB == null) {
			return null;
		}
		memberDAO.update(member);
		return member;
	}

	
	public String vailedUserid(String userid) {
		return memberDAO.vailedUserid(userid);
	}

	public String vailedEmail(String email) {
		return memberDAO.vailedEmail(email);
	}

	public int insert(Member member) {
		return memberDAO.insert(member);
	}
	
	public PageResponseVO<Member> list(String searchValue, int pageNo, int size) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", (pageNo - 1) * size + 1);
		map.put("end", pageNo * size);
		map.put("searchValue", searchValue);

		return new PageResponseVO<Member>(pageNo, memberDAO.list(map), memberDAO.getTotalCount(map), size);
	}

	public int admin(String userid) {
		return memberDAO.admin(userid);
	}

	public int clear(String userid) {
		return memberDAO.clear(userid);
	}

	public int delete(String userid) {
		return memberDAO.delete(userid);
	}

	public int restoration(String userid) {
		return memberDAO.restoration(userid);
	}

}
