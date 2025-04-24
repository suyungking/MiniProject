package org.kosa.mini.login;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.kosa.mini.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class LoginController {

	@Autowired
	LoginService loginService;

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

	@RequestMapping("/home")
	public String home(Model model, HttpSession session) {
		Member member = (Member) session.getAttribute("member");

		if (member != null) {
			model.addAttribute("member", member); // name을 home.jsp로 넘김
		}

		return "login/home";
	}

	@RequestMapping("logout")
	public String logout(HttpSession session) {

		session.invalidate();

		return "redirect:/";
	}

	@RequestMapping("detailView2")
	public String detailView(Model model, String userid) {
		Member member = loginService.getMember(userid);
		if (member == null) {
			return "redirect:/";
		}
		model.addAttribute("member", member);
		return "login/detailView2";
	}

	@RequestMapping("detailView")
	public String detailView(HttpSession session) {
		// 1. 세션있는 멤버 정보를 출력하는 방법
		Member member = (Member) session.getAttribute("member");
		if (member == null) {
			return "${pageContext.request.contextPath}/home";
		}
		Member memberDB = loginService.getMember(member.getUserid());
		if (memberDB == null) {
			return "${pageContext.request.contextPath}/home";
		}

		session.setAttribute("member", memberDB);
		return "login/detailView";
	}

	@RequestMapping("deleteForm")
	public String deleteForm(HttpSession session, Model model) {
		// 세션에서 멤버 정보를 얻는다 -> 목적 : userid를 얻는다
		Member member = (Member) session.getAttribute("member");
		if (member == null) {
			return "${pageContext.request.contextPath}/home";
		}

		// 멤버 userid를 이용하여 멤버의 상세정보를 얻는다
		Member memberInfo = loginService.getMember(member.getUserid());
		if (memberInfo == null) {
			return "${pageContext.request.contextPath}/home";
		}

		model.addAttribute("member", memberInfo);

		return "login/deleteForm";
	}

	@RequestMapping("/deleteMember")
	@ResponseBody
	public Map<String, Object> deleteMember(@RequestBody Member member, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();

		int delete = loginService.delete(member.getUserid());
		if (delete == 0) {
			map.put("errorMessage", "계정삭제에 실패했습니다..");
			map.put("status", "error");

		} else {
			map.put("status", "ok");
			session.invalidate();
		}
		return map;
	}

	// 회원,관리자 정보 수정
	@RequestMapping("updateForm")
	public String updateForm(HttpSession session, Model model) {
		// 세션에서 멤버 정보를 얻는다 -> 목적 : userid를 얻는다
		Member member = (Member) session.getAttribute("member");
		if (member == null) {
			return "${pageContext.request.contextPath}/home";
		}

		// 멤버 userid를 이용하여 멤버의 상세정보를 얻는다
		Member memberInfo = loginService.getMember(member.getUserid());
		if (memberInfo == null) {
			return "${pageContext.request.contextPath}/home";
		}

		model.addAttribute("member", memberInfo);

		return "login/updateForm";
	}

	// 회원,관리자 정보 수정
	@RequestMapping("update")
	@ResponseBody
	public Map<String, Object> update(HttpSession session, Model model, @RequestBody Member member) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();

		if (!member.isValid()) {
			map.put("errorMessage", "다시입력해주세요.");
			map.put("status", "error");
			return map;
		}
		if (member.getBirthday() != null) {
			LocalDate birthDate = LocalDate.parse(member.getBirthday());
			int age = LocalDate.now().getYear() - birthDate.getYear();
			member.setAge(age);
		}

		Member memberInfo = loginService.update(member);

		if (memberInfo == null) {
			map.put("errorMessage", "다시입력해 주세요.");
			map.put("status", "error");
			return map;
		} else {
			map.put("status", "ok");
			session.setAttribute("member", memberInfo);
			model.addAttribute("member", memberInfo);
		}

		return map;
	}

	@RequestMapping("vailedLogin")
	public String vailedLogin(Model model, HttpSession session, @RequestParam String page) {
		Member member = (Member) session.getAttribute("member");

		// 멤버 userid를 이용하여 멤버의 상세정보를 얻는다
		Member getMember = loginService.getMember(member.getUserid());
		if (getMember == null) {
			return "redirect:/";
		}

		model.addAttribute("member", getMember);
		model.addAttribute("page", page);
		return "login/vailedLogin";
	}

	@RequestMapping("vailed")
	@ResponseBody
	public Map<String, Object> vailed(HttpSession session, Model model, @RequestBody Member member) {
		Map<String, Object> map = new HashMap<String, Object>();
		Member sessionMember = (Member) session.getAttribute("member");

		if (member.getPasswd() == null || member.getPasswd().length() == 0) {
			map.put("errorMessage", "비밀번호를 입력해주세요");
			map.put("status", "error");
		} else {
			Member checkMember = loginService.vailed(sessionMember.getUserid(), member.getPasswd());
			if (checkMember == null) {

				map.put("errorMessage", "비밀번호를 다시 입력해주새요.");
				map.put("status", "error");
			} else {

				map.put("status", "ok");
			}
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
		// 입력값 검증
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

	@PostMapping("/isAdmin")
	@ResponseBody
	public Map<String, Object> admin(@RequestBody Member member) {

		Map<String, Object> map = new HashMap<String, Object>();
		int success = loginService.admin(member.getUserid());

		if (success == 0) {
			map.put("errorMessage", "권한설정에 실패했습니다..");
			map.put("status", "error");

		} else {
			map.put("status", "ok");
		}
		return map;
	}

	@PostMapping("/isClear")
	@ResponseBody
	public Map<String, Object> clear(@RequestBody Member member) {

		Map<String, Object> map = new HashMap<String, Object>();
		int success = loginService.clear(member.getUserid());

		if (success == 0) {
			map.put("errorMessage", "잠금해제에 실패했습니다..");
			map.put("status", "error");

		} else {
			map.put("status", "ok");
		}
		return map;
	}

	@PostMapping("/isDelete")
	@ResponseBody
	public Map<String, Object> isDelete(@RequestBody Member member) {
		Map<String, Object> map = new HashMap<String, Object>();

		int delete = loginService.delete(member.getUserid());
		if (delete == 0) {
			map.put("errorMessage", "계정삭제에 실패했습니다..");
			map.put("status", "error");

		} else {
			map.put("status", "ok");
		}
		return map;

	}

	@PostMapping("/isRestoration")
	@ResponseBody
	public Map<String, Object> isRestoration(@RequestBody Member member) {
		Map<String, Object> map = new HashMap<String, Object>();

		int restoration = loginService.restoration(member.getUserid());
		if (restoration == 0) {
			map.put("errorMessage", "계정복구에 실패했습니다..");
			map.put("status", "error");

		} else {
			map.put("status", "ok");
		}
		return map;

	}

	@RequestMapping("/memberList")
	public String list(Model model, String pageNo, String size, String searchValue) {
		// 모델에 list 배열을 추가한다
		model.addAttribute("pageResponse",
				loginService.list(searchValue, Util.parseInt(pageNo, 1), Util.parseInt(size, 10)));

		return "login/memberList";
	}

}