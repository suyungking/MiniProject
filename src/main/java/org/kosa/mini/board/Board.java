package org.kosa.mini.board;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Board {
	private int bno;// 게시물 번호
	private String btitle;// 제목
	private String bcontent;// 내용
	private String bwriter;// 작성자
	private String bpasswd;// 게시물 비번
	private String bdate;// 작성일
	private int view_cnt;// 보기 수
	private String deleteyn;// 삭제여부

	public boolean isValid() {
		if (btitle == null || btitle.length() == 0)
			return false;

		if (bcontent == null || bcontent.length() == 0)
			return false;

		return true;
	}
}
