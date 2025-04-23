package org.kosa.mini.board;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BoardDAO {

	public List<Board> list(Map<String, Object> map);
	public int getTotalCount(Map<String, Object> map);
	public Board getBno(int bno);
	public int update(Board board);
	public int delete(int bno);
	public int insert(Board board);
	public int increaseViewCount(int bno);
	
}
