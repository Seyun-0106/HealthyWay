package com.team1.health.controller;

import java.io.File;
import java.nio.charset.Charset;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.team1.health.service.PtService;
import com.team1.health.vo.Apply_userVO;
import com.team1.health.vo.BoardVO;
import com.team1.health.vo.PtPagingVO;

@RestController
@RequestMapping("/board/*")
public class PtController {
	@Inject
	PtService service;
	
	// pt 글 리스트
	@GetMapping("ptList")
	public ModelAndView ptList(PtPagingVO pVO) {
		ModelAndView mav = new ModelAndView();
		
		pVO.setTotalRecord(service.totalRecord(pVO));
		
		mav.addObject("ptList", service.ptList(pVO));
		mav.addObject("pVO", pVO);
		
		mav.setViewName("board/pt/ptList");
		return mav;
	}
	
	// pt 글등록 폼으로 이동
	@GetMapping("ptWrite")
	public ModelAndView ptWrite() {
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("board/pt/ptWrite");
		
		return mav;
	}
	
	// pt 글등록(DB)
	@PostMapping("ptWriteOk")
	public int ptWriteOk(BoardVO vo, HttpServletRequest request, MultipartHttpServletRequest mr){
		// 파일 업로드
		mr = (MultipartHttpServletRequest) request;
		MultipartFile file = mr.getFile("file");
		System.out.println(file);
		
		String path = request.getSession().getServletContext().getRealPath("/ptImg");
	
		// 파일명 중복되지 않게 처리
		UUID uuid = UUID.randomUUID();
		String filename = uuid.toString()+"_"+file.getOriginalFilename();
		vo.setPt_img_file(filename);
		File uploadFile = new File(path, filename);
		
		// 파일 업로드		
		try {
			file.transferTo(uploadFile);
			System.out.println("성공");

		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("실패!");
		}

		vo.setUser_id((String)request.getSession().getAttribute("logId"));
		service.ptBoardInsert(vo);
		int result = service.ptGroupInsert(vo);
		
		return result;
	}
	
	// pt 글보기로 이동
	@GetMapping("ptView")
	public ModelAndView ptView(int board_num, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		// 조회수 증가
		service.hitCount(board_num);
		mav.addObject("aList", service.apply_list(board_num));
		mav.addObject("pCount", service.applySelect(board_num).size());
		mav.addObject("pList", service.applySelect(board_num));
		mav.addObject("lVO", service.leaderSelect(board_num));
		mav.addObject("vo", service.ptBoardSelect(board_num));
		mav.setViewName("board/pt/ptView");
		
		return mav;
	}
	
	// pt글수정 폼으로 이동
	@GetMapping("ptEdit")
	public ModelAndView ptEdit(int board_num) {
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("vo", service.ptBoardSelect(board_num));
		mav.setViewName("board/pt/ptEdit");
		return mav;
	}
	
	// pt글수정(DB)
	@PostMapping("ptEditOk")
	public int ptEditOk(BoardVO vo, HttpSession session, HttpServletRequest request, MultipartHttpServletRequest mr) {
		
		String newImg = vo.getPt_img_file();
		System.out.println("newImg = " + newImg);
		String originImg = vo.getOriginPtImg();
		System.out.println("originImg = " + originImg);
		
		mr = (MultipartHttpServletRequest) request;
		MultipartFile file = mr.getFile("file");
		System.out.println(!newImg.equals(originImg));
		
		// 이미지 수정된 경우
		if(!newImg.equals(originImg)) {
			// 이전 이름으로 덮어쓰기
			vo.setPt_img_file(originImg);
			
			String path = request.getSession().getServletContext().getRealPath("ptImg");
			File uploadFile = new File(path, vo.getPt_img_file());
			
			// 덮어쓰기
			try {
				file.transferTo(uploadFile);
				System.out.println("성공");
			} catch(Exception e) {
				e.printStackTrace();
				System.out.println("실패");
			}
		}
		
		String logId = (String)session.getAttribute("logId");
		vo.setUser_id(logId);
		service.ptBoardUpdate(vo);
		int result = service.ptGroupUpdate(vo);
		
		return result;
	}
	
	// pt글삭제(DB)
	@GetMapping("ptDel")
	public ResponseEntity<String> ptDel(int board_num, String pt_img_file, HttpSession session, HttpServletRequest request) {
		ResponseEntity<String> entity = null;
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(new MediaType("text", "html", Charset.forName("UTF-8")));
		System.out.print(pt_img_file);
		
		// 이미지 파일 삭제
		String path = request.getSession().getServletContext().getRealPath("/ptImg");
		File file = new File(path, pt_img_file);
		
		file.delete();
		
		String id = (String) session.getAttribute("logId");
		int result = service.ptDel(board_num, id);
		
		try {
			if(result > 0) {
				String msg = "<script>alert('삭제가 완료되었습니다.'); location.href='/board/ptList';</script>";
				entity = new ResponseEntity<String>(msg, headers, HttpStatus.OK);
			}else {
				throw new Exception();
			}
		}catch(Exception e) {
			e.printStackTrace();
			String msg = "<script>alert('글삭제를 실패하였습니다.');history.back();</script>";
			entity = new ResponseEntity<String>(msg, headers, HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	// pt그룹 참가신청(DB)
	@GetMapping("ptApply")
	public int ptApplyAdd(int board_num, HttpSession session) {

		String id = (String) session.getAttribute("logId");
		int result = service.ptApplyInsert(board_num, id);
		return result;
	}
	
	@RequestMapping("apply_list")
	public List<Apply_userVO> apply_list(int board_num){
		return service.apply_list(board_num);
	}
	
	// pt그룹 참가 수락
	@GetMapping("applyAccept")
	public int applyAccept(int board_num, String user_id, int max_user) {
		int result = service.applyAccept(board_num, user_id);
		if(service.apply_list(board_num).size() == max_user) {
			service.ptStateUpdate(board_num);
		}
		return result;	
	}
	
	// pt그룹 참가 거절
	@GetMapping("applyDeny")
	public int applyDeny(int board_num, String user_id) {
		int result = service.applyDeny(board_num, user_id);
		return result;
	}
	
	// 찜 목록
	@PostMapping("ptSelectHeart")
	public List<BoardVO> selectHeart(HttpSession session){
		String user_id = (String)session.getAttribute("logId");
		return service.ptSelectHeart(user_id);
	}
	
	// 찜 등록
	@PostMapping("ptInsertHeart")
	public int ptInsertHeart(int board_num, HttpSession session) {
		String user_id = (String)session.getAttribute("logId");
		return service.ptInsertHeart(board_num, user_id);
	}
	
	// 찜 삭제
	@PostMapping("ptDeleteHeart")
	public int ptDeleteHeart(int board_num, HttpSession session) {
		String user_id = (String)session.getAttribute("logId");
		return service.ptDeleteHeart(board_num, user_id);
	}
	

}
