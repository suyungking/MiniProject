package org.kosa.mini.board;

import java.util.HashMap;
import java.util.Map;

import org.kosa.mini.page.PageResponseVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BoardService {
	@Autowired
	BoardDAO boardDAO;

	public PageResponseVO<Board> list(String searchValue, int pageNo, int size,Boolean isAdmin) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", (pageNo-1) * size + 1);
		map.put("end", pageNo * size);
		map.put("searchValue", searchValue);
		map.put("isAdmin", isAdmin);
		return new PageResponseVO<Board>(pageNo
				, boardDAO.list(map)
				, boardDAO.getTotalCount(map)
				, size); 
	}

	public Board getBno(int bno) {
		return boardDAO.getBno(bno);
	}

	public Board update(Board board) {
		boardDAO.update(board);
		return board;
	}

	public int delete(int bno) {
		return boardDAO.delete(bno);
	}

	public int insert(Board board) {
		return boardDAO.insert(board);
	}

	public int increaseViewCount(int bno) {
		return boardDAO.increaseViewCount(bno);
		
	}

	public int updateRestoration(int bno) {
		
		return boardDAO.updateRestoration(bno);
	}
	
	
	

}
