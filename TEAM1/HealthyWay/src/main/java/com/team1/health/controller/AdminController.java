package com.team1.health.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.team1.health.service.AdminService;
import com.team1.health.vo.IngredientVO;
import com.team1.health.vo.PagingVO;
import com.team1.health.vo.ReportVO;

@Controller
public class AdminController {

	@Inject
	AdminService service;

	// 회원 관리자 페이지------------------------------------
	@GetMapping("/master/member")
	public ModelAndView masterMember(PagingVO pVO) {
		ModelAndView mav = new ModelAndView();
		//회원 관련
		pVO.setTotalRecord(service.totalRecord1(pVO));
		mav.addObject("pVO", pVO);
		mav.addObject("vo", service.memberList(pVO));
		mav.setViewName("/admin/master_member");

		return mav;
	}
	//회원 삭제
	@PostMapping("/master/member/delete")
	@ResponseBody
	public int memberDelete(String user_id) {
		return service.memberDelete(user_id);
	}
	
	//회원 신고 관리
	@GetMapping("/master/member/report")
	public ModelAndView masterMemberReport(PagingVO pVO) {
		ModelAndView mav = new ModelAndView();
		//신고 관련
		pVO.setTotalRecord(service.totalReport(pVO));
		mav.addObject("pVO", pVO);
		mav.addObject("vo", service.memberReportList(pVO));
		
		mav.setViewName("/admin/master_member_report");

		return mav;
	}
	
	
	// 레시피 관리자 페이지------------------------------------
	@GetMapping("/master/recipe")
	public String masterRecipe() {
		return "/admin/master_recipe";
	}

	// 재료 추가
	@PostMapping("/master/ingredInsert")
	@ResponseBody
	public int ingredInsert(IngredientVO vo) {

		// 마지막 gred_num id값
		String id = service.lastIngred();

		// id값에서 숫자만 뽑아온 후 1증가(새로 추가될 아이디 값)
		int num = Integer.parseInt(id.substring(1)) + 1;

		// R로 시작하고 6자리 공백은 0으로 채우는 자릿수 세팅
		String gred_num = String.format("R%06d", num);
		vo.setGred_num(gred_num);

		return service.ingredInsert(vo);
	}

	// 재료 삭제
	@PostMapping("/master/ingredDelete")
	@ResponseBody
	public int ingredDelete(String gred_num) {
		return service.ingredDelete(gred_num);
	}

	// PT그룹 관리자 페이지------------------------------------
	@GetMapping("/master/ptGroup")
	public ModelAndView masterptGroup(PagingVO pVO) {
		ModelAndView mav = new ModelAndView();
		pVO.setTotalRecord(service.totalRecord2(pVO));
		mav.addObject("vo", service.ptList(pVO));
		mav.addObject("pVO", pVO);
		mav.setViewName("/admin/master_pt");
		return mav;
	}

	// 글 삭제
	@PostMapping("/master/boardDelete")
	@ResponseBody
	public int boardDelete(int board_num) {
		return service.boardDelete(board_num);
	}

	// 커뮤니티 관리자 페이지------------------------------------
	@GetMapping("/master/community")
	public ModelAndView masterCommunity(PagingVO pVO) {
		ModelAndView mav = new ModelAndView();
		pVO.setTotalRecord(service.totalRecord3(pVO));
		mav.addObject("pVO", pVO);
		mav.addObject("vo", service.boardList(pVO));
		mav.setViewName("/admin/master_community");
		return mav;
	}
	//공지사항
	@GetMapping("/master/notice")
	public ModelAndView masterNotice(PagingVO pVO) {
		ModelAndView mav = new ModelAndView();
		pVO.setTotalRecord(service.totalNoticeRecord(pVO));
		mav.addObject("pVO", pVO);
		mav.addObject("vo", service.noticeList(pVO));
		mav.setViewName("/admin/master_notice");
		return mav;
	}
	

	// 신고 관리자 페이지-----------------------------------------
	// 신고 목록
	@GetMapping("/master/report")
	public ModelAndView masterReport(PagingVO pVO) {
		ModelAndView mav = new ModelAndView();
		pVO.setTotalRecord(service.totalRecord4(pVO));
		mav.addObject("pVO", pVO);
		mav.addObject("vo", service.reportList(pVO));
		mav.setViewName("/admin/master_report");
		return mav;
	}

	// 신고 삭제(신고 처리는 안 함)
	@PostMapping("/master/reportDelete")
	@ResponseBody
	public int reportDelete(int report_num) {
		return service.reportDelete(report_num);
	}
	
	// 신고 등록
	@PostMapping("/master/reportInsert")
	@ResponseBody
	public int reportInsert(ReportVO vo, HttpSession session) {
		String logId = (String)session.getAttribute("logId");
		vo.setUser_id(logId);
		return service.reportInsert(vo);
	}
	
	// 게시글 삭제 + 회원신고
	@PostMapping("/master/reportProcess")
	@ResponseBody
	public int reportProcess(ReportVO vo) {
		service.userReportCount(vo.getWrite_id());//회원 신고 누적
		service.warningState("N", vo.getWrite_id());//경고 상태(N:메일 보내기 전, Y:메일 보냄)
		return service.boardDelete(vo.getBoard_num());//게시글 삭제
	}
	
	//경고 메일 보낸 후 warning_state 업데이트
	@PostMapping("/master/warningState")
	@ResponseBody
	 public int warningState(String user_id) {
		return service.warningState("Y", user_id);
	}
}
