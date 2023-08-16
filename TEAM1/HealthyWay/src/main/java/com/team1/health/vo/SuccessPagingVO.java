package com.team1.health.vo;

public class SuccessPagingVO {
	
	private int onePageRecord = 6; 
	private int pageNum = 1; 
	private int successtotalRecord; 
	private int totalPage; 
	private int offsetIndex = 0;
	private int onePageCount = 5;
	private int startPage = 1;
	private int pageSize = 8;

	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

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
	public int getSuccessTotalRecord() {
		return successtotalRecord;
	}
	
	public void setSuccessTotalRecord(int SuccesstotalRecord) {
		this.successtotalRecord = SuccesstotalRecord;
	
		if(SuccesstotalRecord%onePageRecord==0) {
			totalPage = SuccesstotalRecord/onePageRecord;
		}else {
			totalPage = SuccesstotalRecord/onePageRecord+1;
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
	
	public String getSearchWord() {
		return searchWord;
	}
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
	
}
