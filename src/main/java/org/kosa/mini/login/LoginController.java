package org.kosa.mini.login;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.kosa.mini.member.Member;
import org.kosa.mini.member.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/login")
public class LoginController {

	@Autowired
	MemberService loginService;

	@RequestMapping("/")
	public String loginForm() {
		return "login/loginForm";
	}

	@PostMapping("/login")
	@ResponseBody
	public Map<String, Object> login(HttpSession session, @RequestBody Member member) {
		Map<String, Object> map = new HashMap<String, Object>();

		if (member.getUserid() == null || member.getUserid().length() == 0 || member.getPasswd() == null
				|| member.getPasswd().length() == 0) {
			map.put("errorMessage", "아이디 또는 비밀번호를 입력해주세요");
			map.put("status", "error");

			return map;
		}

		Member dbMember = loginService.getMember(member.getUserid());

		if (dbMember == null) {
			map.put("errorMessage", "존재하지 않는 계정입니다.");
			map.put("status", "error");
			return map;
		}

		if ("Y".equals(dbMember.getLocked())) {
			map.put("errorMessage", "계정이 잠겨 있습니다. 관리자에게 문의하세요.");
			map.put("status", "error");
			return map;
		}
		if ("Y".equals(dbMember.getDeleteyn())) {
			map.put("errorMessage", "탈퇴한 회원입니다.복구를 원하시면 관리자에게 문의하세요.");
			map.put("status", "error");
			return map;
		}

		Member loginMember = loginService.login(member.getUserid(), member.getPasswd());

		if (loginMember != null) {
			session.setAttribute("member", loginMember);
			map.put("status", "ok");
		} else {
			map.put("errorMessage", "아이디 또는 비밀번호가 틀립니다");
			map.put("status", "error");

		}

		return map;
	}


	@RequestMapping("registerForm")
	public String registerForm() {
		return "login/registerForm";
	}

	@PostMapping("/register")
	@ResponseBody
	public Map<String, Object> register(@RequestBody Member member) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		if (!member.isValid()) {
			map.put("errorMessage", "입력값 검증 오류가 발생 했습니다.");
			map.put("status", "error");
			return map;
		}

		if (member.getBirthday() != null) {
			LocalDate birthDate = LocalDate.parse(member.getBirthday());
			int age = LocalDate.now().getYear() - birthDate.getYear();
			member.setAge(age);
		} else {
			map.put("errorMessage", "입력값 검증 오류가 발생 했습니다.");
			map.put("status", "error");
			return map;
		}

		loginService.insert(member);
		map.put("status", "ok");

		return map;
	}

	@PostMapping("/isExistUserId")
	@ResponseBody
	public Map<String, Object> isExistUserId(@RequestBody Map<String, String> param) {
		String userid = param.get("userid");
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("existUserId", null != loginService.vailedUserid(userid));

		return map;
	}

	@PostMapping("/isExistEmail")
	@ResponseBody
	public Map<String, Object> isExistEmail(@RequestBody Map<String, String> param) {
		String email = param.get("email");
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("existEmail", null != loginService.vailedEmail(email));

		return map;
	}


}