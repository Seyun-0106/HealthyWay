package com.team1.health.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.dao.support.DaoSupport;
import org.springframework.stereotype.Service;

import com.team1.health.dao.AdminDAO;
import com.team1.health.vo.BoardVO;
import com.team1.health.vo.IngredientVO;
import com.team1.health.vo.MemberVO;
import com.team1.health.vo.PagingVO;
import com.team1.health.vo.ReportVO;
import com.team1.health.vo.TrainVO;

@Service
public class AdminServiceImpl implements AdminService {
	@Override
	public int boardInsert(BoardVO vo) {
		
		return dao.boardInsert(vo);
	}
	
	@Override
	public int boardDelete(String user_id, int board_num) {
		
		return dao.boardDelete(user_id, board_num);
	}
	@Inject
	AdminDAO dao;


	//회원 관리-----------------------------------------
	@Override
	public List<MemberVO> memberList(PagingVO pVO) {//회원 목록
		return dao.memberList(pVO);
	}
	@Override
	public int totalRecord1(PagingVO pVO) {//totalRecord
		return dao.totalRecord1(pVO);
	}
	@Override
	public int memberDelete(String user_id) {//회원 탈퇴
		return dao.memberDelete(user_id);
	}
	@Override
	public List<MemberVO> memberReportList(PagingVO pVO) {//신고회원 목록
		return dao.memberReportList(pVO);
	}
	@Override
	public int totalReport(PagingVO pVO) {//신고회원 totalRecord
		return dao.totalReport(pVO);
	}

	
	
	//레시피 관리-----------------------------------------
	
	@Override
	public String lastIngred() {//마지막 id값 구하기
		return dao.lastIngred();
	}

	@Override
	public int ingredInsert(IngredientVO vo) {//재료 추가
		return dao.ingredInsert(vo);
	}

	@Override
	public int ingredDelete(String gred_num) {//재료 삭제
		return dao.ingredDelete(gred_num);
	}

	
	//pt그룹 관리-----------------------------------------
	@Override
	public List<BoardVO> ptList(PagingVO pVO) {//그룹 목록
		return dao.ptList(pVO);
	}
	@Override
	public int totalRecord2(PagingVO pVO) {//totalRecord
		return dao.totalRecord2(pVO);
	}
	
	
	//board 관련 공통 코드---------------------------------------
	@Override
	public int boardDelete(int gred_num) {//그룹 삭제
		return dao.boardDelete(gred_num);
	}

	
	//커뮤니티 관리-----------------------------------------
	@Override
	public List<BoardVO> boardList(PagingVO pVO) {//게시글 목록
		return dao.boardList(pVO);
	}
	@Override
	public int totalRecord3(PagingVO pVO) {//totalRecord
		return dao.totalRecord3(pVO);
	}
	
	//신고 관리--------------------------------------------
	@Override
	public List<ReportVO> reportList(PagingVO pVO) {//신고 목록
		return dao.reportList(pVO);
	}
	@Override
	public int reportDelete(int report_num) {//신고 삭제
		return dao.reportDelete(report_num);
	}
	@Override
	public int reportInsert(ReportVO vo) {//신고 등록
		return dao.reportInsert(vo);
	}
	@Override
	public int userReportCount(String user_id) {//회원 신고 누적
		return dao.userReportCount(user_id);
	}
	@Override
	public int totalRecord4(PagingVO pVO) {//totalRecord
		return dao.totalRecord4(pVO);
	}
	@Override
	public int warningState(String state, String user_id) {//경고 상태 변경
		return dao.warningState(state, user_id);
	}

	@Override
	public List<BoardVO> noticeList(PagingVO pVO) {
		return dao.noticeList(pVO);
	}

	@Override
	public int totalNoticeRecord(PagingVO pVO) {
		
		return dao.totalNoticeRecord(pVO);
	}
}
