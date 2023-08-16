package com.team1.health.vo;

public class RecipeVO {
	private String userid;
	private String recipe_img_file;
	private int board_num;
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getRecipe_img_file() {
		return recipe_img_file;
	}
	public void setRecipe_img_file(String recipe_img_file) {
		this.recipe_img_file = recipe_img_file;
	}
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
}
