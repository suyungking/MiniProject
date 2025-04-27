package org.kosa.mini.member;

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

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	MemberService memberService;

	
	@RequestMapping("/home")
	public String home(Model model, HttpSession session) {
		Member member = (Member) session.getAttribute("member");

		if (member == null) {
	        
	        return "redirect:/login/";
	    }
		model.addAttribute("member", member);
		return "member/home";
	}

	@RequestMapping("logout")
	public String logout(HttpSession session) {

		session.invalidate();

		return "redirect:/login/";
	}

	@RequestMapping("detailView2")
	public String detailView(Model model, String userid,HttpSession session) {
		Member member = (Member) session.getAttribute("member");
	    if (member == null) {
	        return "redirect:/login/"; 
	    }

		Member getMember = memberService.getMember(userid);
		if (getMember == null) {
			return "redirect:/login/";
		}
		model.addAttribute("member", getMember);
		return "member/detailView2";
	}

	@RequestMapping("detailView")
	public String detailView(HttpSession session) {
		
		Member member = (Member) session.getAttribute("member");
		if (member == null) {
			return "redirect:/login/";
		}
		Member memberDB = memberService.getMember(member.getUserid());
		if (memberDB == null) {
			return "redirect:/member/home";
		}

		session.setAttribute("member", memberDB);
		return "member/detailView";
	}

	@RequestMapping("deleteForm")
	public String deleteForm(HttpSession session, Model model) {
		
		Member member = (Member) session.getAttribute("member");
		if (member == null) {
			return "redirect:/login/";
		}

		Member memberInfo = memberService.getMember(member.getUserid());
		if (memberInfo == null) {
			return "redirect:/member/home";
		}

		model.addAttribute("member", memberInfo);

		return "member/deleteForm";
	}

	@RequestMapping("/deleteMember")
	@ResponseBody
	public Map<String, Object> deleteMember(@RequestBody Member member, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();

		int delete = memberService.delete(member.getUserid());
		if (delete == 0) {
			map.put("errorMessage", "계정삭제에 실패했습니다..");
			map.put("status", "error");

		} else {
			map.put("status", "ok");
			session.invalidate();
		}
		return map;
	}


	@RequestMapping("updateForm")
	public String updateForm(HttpSession session, Model model) {
		
		Member member = (Member) session.getAttribute("member");
		if (member == null) {
			return "redirect:/login/";
		}


		Member memberInfo = memberService.getMember(member.getUserid());
		if (memberInfo == null) {
			return "redirect:/member/home";
		}

		model.addAttribute("member", memberInfo);

		return "member/updateForm";
	}

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

		Member memberupdate = memberService.update(member);

		if (memberupdate == null) {
			map.put("errorMessage", "다시입력해 주세요.");
			map.put("status", "error");
			return map;
		} else {
			map.put("status", "ok");
			session.setAttribute("member", memberupdate);
			model.addAttribute("member", memberupdate);
		}

		return map;
	}

	@RequestMapping("vailedLogin")
	public String vailedLogin(Model model, HttpSession session, @RequestParam String page) {
		Member member = (Member) session.getAttribute("member");
		if(member == null) {
			return "redirect:/login/";
		}
		
		
		Member getMember = memberService.getMember(member.getUserid());
		if (getMember == null) {
			return "redirect:/member/detailView";
		}

		model.addAttribute("member", getMember);
		model.addAttribute("page", page);
		return "member/vailedLogin";
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
			Member checkMember = memberService.vailed(sessionMember.getUserid(), member.getPasswd());
			if (checkMember == null) {

				map.put("errorMessage", "비밀번호를 다시 입력해주새요.");
				map.put("status", "error");
			} else {

				map.put("status", "ok");
			}
		}

		return map;
	}


	@PostMapping("/isClear")
	@ResponseBody
	public Map<String, Object> clear(@RequestBody Member member) {

		Map<String, Object> map = new HashMap<String, Object>();
		int success = memberService.clear(member.getUserid());

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

		int delete = memberService.delete(member.getUserid());
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

		int restoration = memberService.restoration(member.getUserid());
		if (restoration == 0) {
			map.put("errorMessage", "계정복구에 실패했습니다..");
			map.put("status", "error");

		} else {
			map.put("status", "ok");
		}
		return map;

	}

	@RequestMapping("/memberList")
	public String list(Model model,HttpSession session, String pageNo, String size, String searchValue) {
		Member member = (Member) session.getAttribute("member");
		if(member == null ) {
			return "redirect:/login/";
		}
		
		
		model.addAttribute("pageResponse",
				memberService.list(searchValue, Util.parseInt(pageNo, 1), Util.parseInt(size, 10)));

		return "member/memberList";
	}

}