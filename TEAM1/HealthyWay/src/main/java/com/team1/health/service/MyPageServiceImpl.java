package com.team1.health.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.team1.health.dao.MyPageDAO;
import com.team1.health.vo.BoardVO;
import com.team1.health.vo.CountVO;
import com.team1.health.vo.MemberVO;
import com.team1.health.vo.MyPagePagingVO;
import com.team1.health.vo.TrainVO;

@Service
public class MyPageServiceImpl implements MyPageService{
	@Inject
	MyPageDAO dao;

	@Override
	public MemberVO userData(String user) {
		return dao.userData(user);
	}

	@Override
	public List<BoardVO> PTboard(String user) {
		return dao.PTboard(user);
	}

	@Override
	public int userUpdate(MemberVO vo) {
		return dao.userUpdate(vo);
	}

	@Override
	public int userDelete(String user) {
		return dao.userDelete(user);
	}

	@Override
	public List<BoardVO> recipeHeart(String user) {
		return dao.recipeHeart(user);
	}

	@Override
	public BoardVO reciepeInfor(int board_num, String user) {
		return dao.reciepeInfor(board_num,user);
	}

	@Override
	public int reciepeHeartDel(int board_num, String user) {
		return dao.reciepeHeartDel(board_num,user);
	}

	@Override
	public List<BoardVO> groupListAll(String user,MyPagePagingVO vo) {
		return dao.groupListAll(user, vo);
	}

	@Override
	public int groupCount(String user) {
		return dao.groupCount(user);
	}

	@Override
	public int achieveCount(String user) {
		return dao.achieveCount(user);
	}

	@Override
	public List<BoardVO> achieveListAll(String user, MyPagePagingVO vo) {
		return dao.achieveListAll(user, vo);
	}

	@Override
	public int foodCount(String user) {
		return dao.foodCount(user);
	}

	@Override
	public List<BoardVO> foodListAll(String user, MyPagePagingVO vo) {
		return dao.foodListAll(user, vo);
	}

	@Override
	public List<TrainVO> userRoutineListAll(String user) {
		return dao.userRoutineListAll(user);
	}

	@Override
	public List<TrainVO> trainModuleListAll(int [] trainNum) {
		return dao.trainModuleListAll(trainNum);
	}

	@Override
	public List<MemberVO> weightAll(String user) {
		return dao.weightAll(user);
	}

	@Override
	public List<CountVO> barListAll(String user, int year) {
		return dao.barListAll(user, year);
	}
}
