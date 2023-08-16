package com.team1.health.vo;

public class SuggestionPagingVO {
	
	private int onePageRecord = 10; 
	private int pageNum = 1; 
	private int suggestiontotalRecord; 
	private int totalPage; 
	private int offsetIndex = 0;
	private int onePageCount = 10;
	private int startPage = 1;
	private int pageSize = 10;

	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	private String searchKey;
	private String searchWord;
	
	
	
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
		
		offsetIndex = (pageNum-1)*onePageRecord;
		
		startPage = ((pageNum-1)/onePageCount*onePageCount)+1;
	}
	public int getSuggestionTotalRecord() {
		return suggestiontotalRecord;
	}
	public void setSuggestionTotalRecord(int SuggestiontotalRecord) {
		this.suggestiontotalRecord = SuggestiontotalRecord;
	
		if(SuggestiontotalRecord%onePageRecord==0) {
			totalPage = SuggestiontotalRecord/onePageRecord;
		}else {
			totalPage = SuggestiontotalRecord/onePageRecord+1;
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
	
	public String getSearchKey() {
		return searchKey;
	}
	public void setSearchKey(String searchKey) {
		this.searchKey = searchKey;
	}
	public String getSearchWord() {
		return searchWord;
	}
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;

	}

	
	
	
	

}