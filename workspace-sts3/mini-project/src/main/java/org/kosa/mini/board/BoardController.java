package org.kosa.mini.board;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.kosa.mini.login.Member;
import org.kosa.mini.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	BoardService boardService;

	@RequestMapping("/boardList")
	public String list(Model model, HttpSession session, String pageNo, String size, String searchValue) {

		Member member = (Member) session.getAttribute("member");
		if (member == null) {
			return "redirect:/";
		}

		model.addAttribute("pageResponse",
				boardService.list(searchValue, Util.parseInt(pageNo, 1), Util.parseInt(size, 10)));

		return "board/boardList";
	}

	@RequestMapping("/boardRegister")
	public String boardRegister(Model model, HttpSession session) {

		Member member = (Member) session.getAttribute("member");
		if (member == null) {
			return "redirect:/";
		}

		return "board/boardRegister";
	}

	@RequestMapping("/insert")
	@ResponseBody
	public Map<String, Object> insert(@RequestBody Board board) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (!board.isValid()) {
			map.put("status", "error");
			map.put("errorMessage", "제목,타이틀이 업습니다.");
			return map;
		}
		boardService.insert(board);
		map.put("status", "ok");

		return map;

	}

	@RequestMapping("/boardView")
	public String boardView(Model model, int bno, HttpSession session) {
		Member member = (Member) session.getAttribute("member");
		if (member == null) {
			return "redirect:/";
		}
		
		Board board = boardService.getBno(bno);
		
		if ( !board.getBwriter().equals(member.getUserid()) && !"Y".equals(member.getAdmin())) {
		        boardService.increaseViewCount(bno);  // 이 메서드는 직접 만들어야 함!
		        board.setView_cnt(board.getView_cnt() + 1); // 조회수 증가 반영 (optional)
		    }

		
		
		model.addAttribute("board", board);
		model.addAttribute("member", member);

		return "board/boardView";
	}

	@RequestMapping("/boardUpdate")
	public String boardUpdate(Model model, HttpSession session, int bno) {
		Member member = (Member) session.getAttribute("member");
		if (member == null) {
			return "redirect:/";
		}
		Board board = boardService.getBno(bno);

		model.addAttribute("board", board);
		return "board/boardUpdate";

	}

	@RequestMapping("/update")
	@ResponseBody
	public Map<String, Object> update(Model model, HttpSession session, @RequestBody Board board) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (!board.isValid()) {
			map.put("errorMessage", "다시입력해주세요");
			map.put("status", "error");
			return map;
		}

		Board upBoard = boardService.update(board);
		if (upBoard == null) {
			map.put("errorMessage", "다시입력해주세요");
			map.put("status", "error");
		} else {
			map.put("status", "ok");
			model.addAttribute("board", upBoard);
		}

		return map;

	}

	@RequestMapping("/vailed")
	@ResponseBody
	public Map<String, Object> vailed(Model model, @RequestBody Map<String, Object> data) {
		Map<String, Object> map = new HashMap<String, Object>();
		int bno = (int) data.get("bno");
		String passwd = (String) data.get("passwd");

		Board board = boardService.getBno(bno);

		if (board == null) {
			map.put("status", "error");
			map.put("errorMessage", "게시글이 존재하지 않습니다.");
			return map;
		}

		if (board.getBpasswd().equals(passwd)) {
			map.put("status", "ok");
		} else {
			map.put("status", "error");
			map.put("errorMessage", "다시입력해주세요.");
		}

		return map;
	}

	@RequestMapping("boardDelete")
	public String boardDelete(Model model, int bno, HttpSession session) {
		Member member = (Member) session.getAttribute("member");
		if (member == null) {
			return "redirect:/";
		}
		Board board = boardService.getBno(bno);
		if (board == null) {
			return "${pageContext.request.contextPath}/board/boardView";
		}
		model.addAttribute("board", board);
		return "/board/boardDelete";
	}

	@PostMapping("/isBoardDelete")
	@ResponseBody
	public Map<String, Object> isDelete(@RequestBody Board board) {
		Map<String, Object> map = new HashMap<String, Object>();

		int delete = boardService.delete(board.getBno());
		if (delete == 0) {
			map.put("errorMessage", "게시글삭제에 실패했습니다..");
			map.put("status", "error");

		} else {
			map.put("status", "ok");
		}
		return map;

	}

}