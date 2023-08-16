package com.team1.health.vo;

public class CountVO {
	private String user_id;
	private int train_year;
	private int train_month;
	private int train_count;
	private int train_num;
	private String write_date;
	
	private String module_title;
	
	public String getModule_title() {
		return module_title;
	}
	public void setModule_title(String module_title) {
		this.module_title = module_title;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getTrain_year() {
		return train_year;
	}
	public void setTrain_year(int train_year) {
		this.train_year = train_year;
	}
	public int getTrain_month() {
		return train_month;
	}
	public void setTrain_month(int train_month) {
		this.train_month = train_month;
	}
	public int getTrain_count() {
		return train_count;
	}
	public void setTrain_count(int train_count) {
		this.train_count = train_count;
	}
	public int getTrain_num() {
		return train_num;
	}
	public void setTrain_num(int train_num) {
		this.train_num = train_num;
	}
	public String getWrite_date() {
		return write_date;
	}
	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}
}
