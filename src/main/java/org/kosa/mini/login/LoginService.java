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
		//2. 아이디를 이용하여 회원 정보를 얻는다(java : Service)   
		Member member = loginDAO.getMember(userid);
		//3. 회원 정보가 존재하지 않을 경우(java : Service) -> 아이디 또는 비밀번호가 잘못되었습니다 오류 메시지 출력한다 (Controller에서 설정 후 jsp 출력 )
		if (member == null) return null;
		//4. 회원 정보가 존재할 경우 비밀번호가 맞는지 확인하고 맞지 않으면(java : Service ) -> 아이디 또는 비밀번호가 잘못되었습니다 오류 메시지 출력한다 (Controller에서 설정 후 jsp 출력)
		
		if ("Y".equals(member.getLocked())) return null;

		boolean result = member.getPasswd().equals(passwd);
		if (result == false) {
			failCount = member.getFailcount()  +1;
			member.setFailcount(failCount);
			if(failCount >= 5) {
				member.setLocked("Y");
			}
			else {
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
		//2. 아이디를 이용하여 회원 정보를 얻는다(java : Service)   
		Member member = loginDAO.getMember(userid);
		//3. 회원 정보가 존재하지 않을 경우(java : Service) -> 아이디 또는 비밀번호가 잘못되었습니다 오류 메시지 출력한다 (Controller에서 설정 후 jsp 출력 )
		if (member == null) return null;
		
		//4. 회원 정보가 존재할 경우 비밀번호가 맞는지 확인하고 맞지 않으면(java : Service ) -> 아이디 또는 비밀번호가 잘못되었습니다 오류 메시지 출력한다 (Controller에서 설정 후 jsp 출력)
		boolean result = member.getPasswd().equals(passwd);
		if (result == false) return null;
		
		//5. 로그인이 성공이면 로그인한 시간을 기록한다(java : Service -> db)
		

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

//	public Member update(String userid, String passwd, String name, int age) {
//		Member member = loginDAO.getMember(userid);
//		if (member != null) {
//			//userid로 찾은 회원 정보를 수정한다
//			member.setPasswd(passwd);
//			member.setName(name);
//			member.setAge(age);
//			
//			return member;
//		}
//		return null;
//	}

	public Member update(Member member) {
		Member memberDB = loginDAO.getMember(member.getUserid());
		if (memberDB == null) {
			return null;
		}
		//DB 데이터 수정작업
		loginDAO.update(member);
		return member;
	}

	public int insert(Member member) {
		return loginDAO.insert(member);
	}

	public PageResponseVO<Member> list(String searchValue, int pageNo, int size) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", (pageNo-1) * size + 1);
		map.put("end", pageNo * size);
		map.put("searchValue", searchValue);
		
		return new PageResponseVO<Member>(pageNo
				, loginDAO.list(map)
				, loginDAO.getTotalCount(map)
				, size); 
	}


	public int admin(String userid) {
		// TODO Auto-generated method stub
		return loginDAO.admin(userid);
	}


	public int clear(String userid) {
		// TODO Auto-generated method stub
		return loginDAO.clear(userid);
	}


	public int delete(String userid) {
		// TODO Auto-generated method stub
		return loginDAO.delete(userid);
	}


	public int restoration(String userid) {
		// TODO Auto-generated method stub
		return loginDAO.restoration(userid);
	}




	

//	public int getTotalCount() {
//		return loginDAO.getTotalCount();
//	}
	
}
