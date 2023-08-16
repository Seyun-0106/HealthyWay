package com.team1.health.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.team1.health.dao.PtDAO;
import com.team1.health.vo.Apply_userVO;
import com.team1.health.vo.BoardVO;
import com.team1.health.vo.MemberVO;
import com.team1.health.vo.PtPagingVO;

@Service
public class PtServiceImpl implements PtService {
	@Inject
	PtDAO dao;
	
	@Override
	public int ptBoardInsert(BoardVO vo) {
		return dao.ptBoardInsert(vo);
	}
	@Override
	public int ptGroupInsert(BoardVO vo) {
		return dao.ptGroupInsert(vo);
	}
	@Override
	public ArrayList<BoardVO> ptList(PtPagingVO pVO) {
		return dao.ptList(pVO);
	}
	@Override
	public BoardVO ptBoardSelect(int no) {
		return dao.ptBoardSelect(no);
	}
	@Override
	public int hitCount(int no) {		
		return dao.hitCount(no);
	}
	@Override
	public int ptDel(int no, String id) {
		return dao.ptDel(no, id);
	}
	@Override
	public int ptBoardUpdate(BoardVO vo) {
		return dao.ptBoardUpdate(vo);
	}
	@Override
	public int ptGroupUpdate(BoardVO vo) {
		return dao.ptGroupUpdate(vo);
	}
	@Override
	public MemberVO leaderSelect(int board_num) {
		return dao.leaderSelect(board_num);
	}
	@Override
	public int ptApplyInsert(int board_num, String user_id) {
		return dao.ptApplyInsert(board_num, user_id);
	}
	@Override
	public List<Apply_userVO> apply_list(int board_num) {
		return dao.apply_list(board_num);
	}
	@Override
	public int applyAccept(int board_num, String user_id) {
		return dao.applyAccept(board_num, user_id);
	}
	@Override
	public ArrayList<Apply_userVO> applySelect(int board_num) {
		return dao.applySelect(board_num);
	}
	@Override
	public int applyDeny(int board_num, String user_id) {
		return dao.applyDeny(board_num, user_id);
	}
	@Override
	public int totalRecord(PtPagingVO pVO) {
		return dao.totalRecord(pVO);
	}
	@Override
	public List<BoardVO> ptSelectHeart(String user_id) {
		return dao.ptSelectHeart(user_id);
	}
	@Override
	public int ptInsertHeart(int board_num, String user_id) {
		return dao.ptInsertHeart(board_num, user_id);
	}
	@Override
	public int ptDeleteHeart(int board_num, String user_id) {
		return dao.ptDeleteHeart(board_num, user_id);
	}
	@Override
	public int ptStateUpdate(int board_num) {
		return dao.ptStateUpdate(board_num);
	}

}
