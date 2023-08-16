
package com.team1.health.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;


import org.springframework.stereotype.Service;

import com.team1.health.dao.BoardDAO;
import com.team1.health.vo.BoardVO;
import com.team1.health.vo.PagingVO;
import com.team1.health.vo.ReplyVO;
import com.team1.health.vo.SuccessPagingVO;
import com.team1.health.vo.SuggestionPagingVO;


//1
@Service

public class BoardServiceImpl implements BoardService {
	//2
	@Inject
	BoardDAO dao;
	//3
	@Override
	public int boardInsert(BoardVO vo) {
		return dao.boardInsert(vo);
	}
	//4
	@Override
	public List<BoardVO> boardList(PagingVO pVO) {
		return dao.boardList(pVO);
	}
	//5
	@Override
	public int totalRecord(PagingVO pVO) {
		return dao.totalRecord(pVO);
	}
	//6
	@Override
	public BoardVO boardSelect(int board_num) {
		return dao.boardSelect(board_num);
	}
	
	
	
	
	@Override
	public ArrayList<BoardVO> boardSelectAll(PagingVO vo) {
		// TODO Auto-generated method stub
		return dao.boardSelectAll(vo);
	}
	@Override
	public ArrayList<BoardVO> suggestionSelectAll(SuggestionPagingVO vo) {
		// TODO Auto-generated method stub
		return dao.suggestionSelectAll(vo);
	}
	//7
	@Override
	public int hitCount(int no) {		
		return dao.hitCount(no);
	}
	//8
	@Override
	public int boardUpdate(BoardVO vo) {
		return dao.boardUpdate(vo);
	}
	//9
	@Override
	public int boardDelete(int board_num, String user_id) {
		return dao.boardDelete(board_num,user_id);
	}
	@Override
	public BoardVO boardSelectByNo(int board_num) {
		return dao.boardSelectByNo(board_num);
		
	}
	@Override
	public BoardVO boardView(int board_num) {
		return dao.boardView(board_num);
	}

	
	
	
	
	
	
	
	//자유게시판
	@Override
	public int suggestionInsert(BoardVO vo) {
		return dao.suggestionInsert(vo);
		
	}
	
	//4
	@Override
	public List<BoardVO> suggestionList(SuggestionPagingVO pVO) {
		return dao.suggestionList(pVO);
	}
	
	
	@Override
	public BoardVO suggestionSelect(int board_num) {
		return dao.suggestionSelect(board_num);
	}
	

	@Override
	public int suggestionUpdate(BoardVO vo) {
		return dao.suggestionUpdate(vo);
	}

	@Override
	public BoardVO suggestionSelectByNo(int board_num) {
		return dao.suggestionSelectByNo(board_num);
		
	}
	@Override
	public BoardVO suggestionView(int board_num) {
		return dao.suggestionView(board_num);
	}

	@Override
	public int SuggestiontotalRecord(SuggestionPagingVO spVO) {
		return dao.SuggestiontotalRecord(spVO);
	}
	@Override
	public int suggestionDelete(int board_num, String user_id) {
		return dao.suggestionDelete(board_num, user_id);
	}

	//댓글 등록
	@Override
	public int insertReply(ReplyVO vo) {
		return dao.insertReply(vo);
	}
	//댓글 삭제
	@Override
	public int deleteReply(int reply_num) {
		return dao.deleteReply(reply_num);
	}
	//댓글 수정
	@Override
	public int updateReply(ReplyVO vo) {
		return dao.updateReply(vo);
	}
	//댓글 목록
	@Override
	public List<ReplyVO> replyList(int board_num) {
		return dao.replyList(board_num);
	}
	
	
	
	/////////////////////////////////////////////////////////////////////
	//성공스토리
	@Override
	public ArrayList<BoardVO> successList() {
		return dao.successList();
	}
	
	//7
	@Override
	public int successUpdate(BoardVO vo) {
		return dao.successUpdate(vo);
	}
	//8
	@Override
	public int successDelete(int board_num, String user_id) {
		return dao.successDelete(board_num, user_id);
	}
	
	@Override
	public BoardVO successView(int board_num) {
		return dao.successView(board_num);
	}
	
	@Override
	public BoardVO successSelectByNo(int board_num) {
		return dao.successSelectByNo(board_num);
		
	}
	@Override
	public int acheiveInsert(BoardVO vo) {
		
		return dao.acheiveInsert(vo);
	}
	@Override
	public int achieveUpdate(BoardVO vo) {
		return dao.achieveUpdate(vo);
	}

	
}