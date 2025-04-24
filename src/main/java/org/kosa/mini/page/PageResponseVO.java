package org.kosa.mini.page;

import java.util.List;

import lombok.Data;

//VO : value object
@Data
public class PageResponseVO<T> {
	private List<T> list; // 목록
	private int totalCount = 0; // 전체건수
	private int totalPage = 0; // 전체 페이지수

	private int startPage = 0; // 페이지 네비게이션 바의 시작 페이지번호
	private int endPage = 0; // 페이지 네비게이션 바의 끝 페이지번호

	private int pageNo = 0; // 현재 페이지번호
	private int size = 10; // 한 페이지 출력되는 자료의 건수

	public PageResponseVO(int pageNo, List<T> list, int totalCount, int size) {

		this.totalCount = totalCount;
		this.pageNo = pageNo;
		this.list = list;
		this.size = size;

		// 2. (전제 건수 / 10)의 값을 올림 -> 전체페이지수
		totalPage = (int) Math.ceil((double) totalCount / size);

		// 301 -> endPage : 31
		// pageNoNumber : 30 , start: 21, end:30
		// pageNoNumber : 31 , start: 31, end:40, 실제 : 31
		startPage = ((pageNo - 1) / 10) * 10 + 1;
		endPage = ((pageNo - 1) / 10) * 10 + 10;
		if (endPage > totalPage)
			endPage = totalPage;

	}

	public boolean isPrev() {
		return startPage != 1;
	}

	public boolean isNext() {
		return totalPage != endPage;
	}
}
