package com.team1.health.vo;

public class RecipePagingVO {
	// 페이징
	private int onePageRecord = 8;// 한 페이지에 출력할 레코드 수
	private int pageNum = 1;// 현재 페이지
	private int totalRecord;// 총 레코드 수
	private int totalPage;// 총 페이지 수
	private int offsetIndex = 0;// 오프셋
	private int onePageCount = 5; // 한 번에 표시할 페이지 수
	private int startPage = 1;// 시작 페이지

	// 검색
	private String searchKey;// select 값
	private String searchValue;// 검색어

	// 페이징
	public int getOnePageRecord() {
		return onePageRecord;
	}

	public void setOnePageRecord(int onePageRecord) {
		this.onePageRecord = onePageRecord;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
		// offset 위치 계산
		offsetIndex = onePageRecord * (pageNum - 1);
		// 페이지 번호 시작값
		startPage = ((pageNum - 1) / onePageCount * onePageCount) + 1;
	}

	public int getTotalRecord() {
		return totalRecord;
	}

	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;

		// 총 페이지 수(레코드 수가 26개면 페이지 수는 6개)
		if (totalRecord % onePageRecord == 0) {// 나머지 레코드 없는 경우
			totalPage = totalRecord / onePageRecord;
		} else {// 나머지 레코드 있는 경우
			totalPage = totalRecord / onePageRecord + 1;
		}
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getOffsetIndex() {
		return offsetIndex;
	}

	public void setOffsetIndex(int offsetIndex) {
		this.offsetIndex = offsetIndex;
	}

	public int getOnePageCount() {
		return onePageCount;
	}

	public void setOnePageCount(int onePageCount) {
		this.onePageCount = onePageCount;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	// 검색
	public String getSearchKey() {
		return searchKey;
	}

	public void setSearchKey(String searchKey) {
		this.searchKey = searchKey;
	}

	public String getSearchValue() {
		return searchValue;
	}

	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}
	
}
