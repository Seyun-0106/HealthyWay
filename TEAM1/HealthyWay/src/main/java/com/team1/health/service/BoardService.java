package com.team1.health.service;

import java.util.ArrayList;
import java.util.List;


import com.team1.health.vo.BoardVO;
import com.team1.health.vo.PagingVO;
import com.team1.health.vo.ReplyVO;
import com.team1.health.vo.SuccessPagingVO;
import com.team1.health.vo.SuggestionPagingVO;

public interface BoardService {
	public int boardInsert(BoardVO vo);
	
	public List<BoardVO> boardList(PagingVO pVO);
	
	public int totalRecord(PagingVO pVO);
	
	public BoardVO boardSelect(int board_num);
	
	public ArrayList<BoardVO> boardSelectAll(PagingVO vo);
	
	public int hitCount(int no);
	
	public int boardUpdate(BoardVO vo);
	
	public int boardDelete(int board_num, String user_id);
	
	public BoardVO boardSelectByNo(int board_num);
	
	public BoardVO boardView(int board_num);
	
	//댓글 추가
		public int insertReply(ReplyVO vo);
		//댓글 삭제
		public int deleteReply(int reply_num);
		//댓글 수정
		public int updateReply(ReplyVO vo);
		//댓글 목록
		public List<ReplyVO> replyList(int board_num);
	
	
	//////////////////////////////////////////////////////////////////
	//자유게시판
	public int suggestionInsert(BoardVO vo);
	
	public List<BoardVO> suggestionList(SuggestionPagingVO spVO);
	
	public int SuggestiontotalRecord(SuggestionPagingVO spVO);
	
	public BoardVO suggestionSelect(int board_num);
	
	public ArrayList<BoardVO> suggestionSelectAll(SuggestionPagingVO vo);
	
	public int suggestionUpdate(BoardVO vo);
	
	public int suggestionDelete(int board_num, String user_id);
	
	public BoardVO suggestionSelectByNo(int board_num);
	
	public BoardVO suggestionView(int board_num);
	
	///////////////////////////////////////////////////////////////////
	// 성공스토리
	// 성공스토리 글목록
	public ArrayList<BoardVO> successList();
	// 성공스토리 글등록(achieve_story)
	public int acheiveInsert(BoardVO vo);
	// 성공스토리 글수정(board) 
	public int successUpdate(BoardVO vo);
	// 성공스토리 글수정(achieve_story)
	public int achieveUpdate(BoardVO vo);
	
	public int successDelete(int board_num, String user_id);
	public BoardVO successView(int board_num);
	public BoardVO successSelectByNo(int board_num);
}
