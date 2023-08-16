package com.team1.health.vo;

public class TrainVO {
	//트레이닝 루틴
	private int train_num;
	private String train_title;
	private String train_write_date;
	private String train_mod_date;
	private String user_id;
	//모듈
	private int module_num;
	private String module_img;
	private String module_title;
	private String module_content;
	private String module_vod_file;
	private String module_write_date;
	private String module_type;
	private String module_part;
	private String module_difficulty;
	private int tnum;
	
	//트레이닝페이지
	private String train_list[];
	private String module1;
	private String module2;
	private String module3;
	private String module4;
	private String module5;
	
	//유저 트레이닝 카운트
	private int train_count;
	private int train_year;
	private int train_month;
	
	//유저 설문조사결과
	private String strength;
	private String favorite;
	
	
	public String getStrength() {
		return strength;
	}
	public void setStrength(String strength) {
		this.strength = strength;
	}
	public String getFavorite() {
		return favorite;
	}
	public void setFavorite(String favorite) {
		this.favorite = favorite;
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
	public String[] getTrain_list() {
		return train_list;
	}
	public void setTrain_list(String[] train_list) {
		this.train_list = train_list;
	}
	public String getModule1() {
		return module1;
	}
	public void setModule1(String module1) {
		this.module1 = module1;
	}
	public String getModule2() {
		return module2;
	}
	public void setModule2(String module2) {
		this.module2 = module2;
	}
	public String getModule3() {
		return module3;
	}
	public void setModule3(String module3) {
		this.module3 = module3;
	}
	public String getModule4() {
		return module4;
	}
	public void setModule4(String module4) {
		this.module4 = module4;
	}
	public String getModule5() {
		return module5;
	}
	public void setModule5(String module5) {
		this.module5 = module5;
	}
	public int getTnum() {
		return tnum;
	}
	public void setTnum(int tnum) {
		this.tnum = tnum;
	}
	public int getTrain_num() {
		return train_num;
	}
	public void setTrain_num(int train_num) {
		this.train_num = train_num;
	}
	public String getTrain_title() {
		return train_title;
	}
	public void setTrain_title(String train_title) {
		this.train_title = train_title;
	}
	public String getTrain_write_date() {
		return train_write_date;
	}
	public void setTrain_write_date(String train_write_date) {
		this.train_write_date = train_write_date;
	}
	public String getTrain_mod_date() {
		return train_mod_date;
	}
	public void setTrain_mod_date(String train_mod_date) {
		this.train_mod_date = train_mod_date;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getModule_num() {
		return module_num;
	}
	public void setModule_num(int module_num) {
		this.module_num = module_num;
	}
	public String getModule_img() {
		return module_img;
	}
	public void setModule_img(String module_img) {
		this.module_img = module_img;
	}
	public String getModule_title() {
		return module_title;
	}
	public void setModule_title(String module_title) {
		this.module_title = module_title;
	}
	public String getModule_content() {
		return module_content;
	}
	public void setModule_content(String module_content) {
		this.module_content = module_content;
	}
	public String getModule_vod_file() {
		return module_vod_file;
	}
	public void setModule_vod_file(String module_vod_file) {
		this.module_vod_file = module_vod_file;
	}
	public String getModule_write_date() {
		return module_write_date;
	}
	public void setModule_write_date(String module_write_date) {
		this.module_write_date = module_write_date;
	}
	public String getModule_type() {
		return module_type;
	}
	public void setModule_type(String module_type) {
		this.module_type = module_type;
	}
	public String getModule_part() {
		return module_part;
	}
	public void setModule_part(String module_part) {
		this.module_part = module_part;
	}
	public String getModule_difficulty() {
		return module_difficulty;
	}
	public void setModule_difficulty(String module_difficulty) {
		this.module_difficulty = module_difficulty;
	}
}
