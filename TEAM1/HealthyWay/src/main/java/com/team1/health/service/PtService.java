package com.team1.health.service;

import java.util.ArrayList;
import java.util.List;

import com.team1.health.vo.Apply_userVO;
import com.team1.health.vo.BoardVO;
import com.team1.health.vo.MemberVO;
import com.team1.health.vo.PtPagingVO;

public interface PtService {
	// 그룹pt 글작성(board)
	public int ptBoardInsert(BoardVO vo);
	
	// 그룹pt 글작성
	public int ptGroupInsert(BoardVO vo);
	
	// 그룹pt 글목록
	public ArrayList<BoardVO> ptList(PtPagingVO pVO);
	
	// 그룹pt 뷰페이지 선택
	public BoardVO ptBoardSelect(int no);
	
	// 조회수 증가
	public int hitCount(int no);
	
	// 그룹pt 글삭제
	public int ptDel(int no, String id);
	
	// 그룹pt 글수정(DB - board)
	public int ptBoardUpdate(BoardVO vo);
		
	// 그룹pt 글수정(DB - PT_group)
	public int ptGroupUpdate(BoardVO vo);
	
	// 리더정보 선택
	public MemberVO leaderSelect(int board_num);
	
	// 그룹pt 참가신청
	public int ptApplyInsert(int board_num, String user_id);
	// 그룹pt 참가자 리스트
	public List<Apply_userVO> apply_list(int board_num);
	// 그룹pt 참가 승인
	public int applyAccept(int board_num, String user_id);
	// 그룹pt 참가 거절
	public int applyDeny(int board_num, String user_id);
	// 참여중인 멤버 선택
	public ArrayList<Apply_userVO> applySelect(int board_num);
	// 모집중 -> 모집완료 변경
	public int ptStateUpdate(int board_num);
	
	// 총레코드 수
	public int totalRecord(PtPagingVO pVO);
	
	// 찜 목록
	public List<BoardVO> ptSelectHeart(String user_id);
	// 찜 등록
	public int ptInsertHeart(int board_num, String user_id);
	// 찜 삭제
	public int ptDeleteHeart(int board_num, String user_id);
	
}
