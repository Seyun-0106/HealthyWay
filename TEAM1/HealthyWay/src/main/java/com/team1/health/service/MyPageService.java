package com.team1.health.service;

import java.util.List;

import com.team1.health.vo.BoardVO;
import com.team1.health.vo.CountVO;
import com.team1.health.vo.MemberVO;
import com.team1.health.vo.MyPagePagingVO;
import com.team1.health.vo.TrainVO;

public interface MyPageService {
	public MemberVO userData(String user);
	public List<BoardVO> PTboard(String user);
	public int userUpdate(MemberVO vo);
	public int userDelete(String user);
	public List<BoardVO> recipeHeart(String user);
	public BoardVO reciepeInfor(int board_num, String user);
	public int reciepeHeartDel(int board_num, String user);
	public List<BoardVO> groupListAll(String user,MyPagePagingVO vo);
	public int groupCount (String user);
	public int achieveCount(String user);
	public List<BoardVO> achieveListAll(String user,MyPagePagingVO vo);
	public int foodCount(String user);
	public List<BoardVO> foodListAll(String user,MyPagePagingVO vo);
	public List<TrainVO> userRoutineListAll(String user);
	public List<TrainVO> trainModuleListAll(int [] trainNum);
	public List<MemberVO> weightAll(String user);
	public List<CountVO> barListAll(String user, int year);
}
