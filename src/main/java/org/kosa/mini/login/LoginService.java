package org.kosa.mini.login;

import java.util.HashMap;
import java.util.Map;

import org.kosa.mini.page.PageResponseVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginService {
	@Autowired
	private LoginDAO loginDAO;

	public Member login(String userid, String passwd) {
		int failCount = 0;
		Member member = loginDAO.getMember(userid);
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
			loginDAO.failUser(member);
			return null;
		}

		member.setFailcount(0);
		member.setLocked("N");
		loginDAO.failUser(member);
		loginDAO.setLoginTime(userid);

		return member;
	}

	public Member vailed(String userid, String passwd) {
		Member member = loginDAO.getMember(userid);
		if (member == null)
			return null;

		boolean result = member.getPasswd().equals(passwd);
		if (result == false)
			return null;
		return member;
	}

	public Member getMember(String userid) {
		return loginDAO.getMember(userid);
	}

	public String vailedUserid(String userid) {
		return loginDAO.vailedUserid(userid);
	}

	public String vailedEmail(String email) {
		return loginDAO.vailedEmail(email);
	}

	public Member update(Member member) {
		Member memberDB = loginDAO.getMember(member.getUserid());
		if (memberDB == null) {
			return null;
		}
		loginDAO.update(member);
		return member;
	}

	public int insert(Member member) {
		return loginDAO.insert(member);
	}

	public PageResponseVO<Member> list(String searchValue, int pageNo, int size) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", (pageNo - 1) * size + 1);
		map.put("end", pageNo * size);
		map.put("searchValue", searchValue);

		return new PageResponseVO<Member>(pageNo, loginDAO.list(map), loginDAO.getTotalCount(map), size);
	}

	public int admin(String userid) {
		return loginDAO.admin(userid);
	}

	public int clear(String userid) {
		return loginDAO.clear(userid);
	}

	public int delete(String userid) {
		return loginDAO.delete(userid);
	}

	public int restoration(String userid) {
		return loginDAO.restoration(userid);
	}

}
