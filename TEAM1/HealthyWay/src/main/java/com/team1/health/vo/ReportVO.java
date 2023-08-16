package com.team1.health.vo;

public class ReportVO {
   private int report_num;
   private int board_num;
   private String user_id;
   private String report_title;
   private String report_content;
   private String report_write_date;
   private int report_type;
   private String write_id;
   
   public int getReport_num() {
      return report_num;
   }
   public void setReport_num(int report_num) {
      this.report_num = report_num;
   }
   public int getBoard_num() {
      return board_num;
   }
   public void setBoard_num(int board_num) {
      this.board_num = board_num;
   }
   public String getUser_id() {
      return user_id;
   }
   public void setUser_id(String user_id) {
      this.user_id = user_id;
   }
   public String getReport_title() {
      return report_title;
   }
   public void setReport_title(String report_title) {
      this.report_title = report_title;
   }
   public String getReport_content() {
      return report_content;
   }
   public void setReport_content(String report_content) {
      this.report_content = report_content;
   }
   public String getReport_write_date() {
      return report_write_date;
   }
   public void setReport_write_date(String report_write_date) {
      this.report_write_date = report_write_date;
   }
   public int getReport_type() {
      return report_type;
   }
   public void setReport_type(int report_type) {
      this.report_type = report_type;
   }
   public String getWrite_id() {
      return write_id;
   }
   public void setWrite_id(String write_id) {
      this.write_id = write_id;
   }
   
}