package com.team1.health.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.team1.health.vo.BoardVO;
import com.team1.health.vo.IngredientVO;
import com.team1.health.vo.MemberVO;
import com.team1.health.vo.PagingVO;
import com.team1.health.vo.ReportVO;
import com.team1.health.vo.TrainVO;

@Mapper
@Repository
public interface AdminDAO {

	//회원 관리-----------------------------------------

	//회원 목록
	public List<MemberVO> memberList(PagingVO pVO);
	//totalRecord
	public int totalRecord1(PagingVO pVO);
	//회원 삭제
	public int memberDelete(String user_id);
	//신고회원 목록
	public List<MemberVO> memberReportList(PagingVO pVO);
	//totalRecord_신고
	public int totalReport(PagingVO pVO);

	//레시피 관리-----------------------------------------
	//마지막 id값
	public String lastIngred();
	//재료 DB 추가
	public int ingredInsert(IngredientVO vo);
	//재료 DB 삭제
	public int ingredDelete(String gred_num);

	
	//pt그룹 관리-----------------------------------------
	//그룹 목록
	public List<BoardVO> ptList(PagingVO pVO);
	//totalRecord
	public int totalRecord2(PagingVO pVO);

	
	//board 관련 공통 코드--------------------------------------------
	//boardDelete
	public int boardDelete(int gred_num);

	
	//커뮤니티 관리-----------------------------------------
	//게시글 목록
	public List<BoardVO> boardList(PagingVO pVO);
	//totalRecord
	public int totalRecord3(PagingVO pVO);
	
	//공지사항-----------------------------------------
	
	//공지사항 목록
	public List<BoardVO> noticeList(PagingVO pVO);
	//공지사항 등록
	public int boardInsert(BoardVO vo);
	//공지사항 삭제
	public int boardDelete(String user_id, int board_num);
	//total Notice Record
	public int totalNoticeRecord(PagingVO pVO);
	
	//신고 관리--------------------------------------------
	
	//신고 목록
	public List<ReportVO> reportList(PagingVO pVO);
	//totalRecord
	public int totalRecord4(PagingVO pVO);
	//신고 삭제
	public int reportDelete(int report_num);
	//신고 등록
	public int reportInsert(ReportVO vo);
	//회원 신고 누적
	public int userReportCount(String user_id);
	// 경고 상태
	public int warningState(String state, String user_id);



	
}
