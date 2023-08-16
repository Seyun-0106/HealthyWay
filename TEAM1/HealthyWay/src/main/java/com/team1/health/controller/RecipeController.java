package com.team1.health.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.team1.health.service.RecipeService;
import com.team1.health.vo.BoardVO;
import com.team1.health.vo.IngredientVO;
import com.team1.health.vo.RecipePagingVO;
import com.team1.health.vo.Recipe_IngredVO;
import com.team1.health.vo.ReplyVO;

@Controller
public class RecipeController {

	@Inject
	RecipeService service;

	//레시피 메인 페이지
	@GetMapping("/recipe/main")
	public ModelAndView main() {
		ModelAndView mav = new ModelAndView();
		List<BoardVO> vo = service.mainList();
		Collections.shuffle(vo);// 리스트 랜덤 정렬
		
		//랜덤으로 정렬 후 새로운 newVO에 4개 집어넣기
		List<BoardVO> newVO = new ArrayList<BoardVO>();
		for (int i = 0; i < 4; i++) {
			newVO.add(vo.get(i));
		}
		mav.addObject("vo", newVO);
		mav.setViewName("/recipe/recipe_main");
		return mav;
	}

	//레시피 게시판 페이지
	@GetMapping("/recipe/list")
	public ModelAndView list(RecipePagingVO pVO) {
		ModelAndView mav = new ModelAndView();
		pVO.setTotalRecord(service.totalRecord(pVO));
		mav.addObject("pVO", pVO);
		mav.addObject("vo", service.recipeList(pVO));
		mav.setViewName("board/recipe/recipeList");
		return mav;
	}

	//레시피 등록 페이지
	@GetMapping("/recipe/write")
	public String write() {
		return "/board/recipe/recipeWrite";
	}

	//재료 추가 관련 컨트롤러-----------------------------------------
	//재료 검색
	@PostMapping("/recipe/searchIngred")
	@ResponseBody
	public List<IngredientVO> searchIngred(RecipePagingVO vo) {
		return service.searchIngred(vo);
	}

	//재료 선택(추가할 재료 클릭했을 때)
	@PostMapping("/recipe/addIngred")
	@ResponseBody
	public List<IngredientVO> addIngred(String gred_num) {
		return service.addIngred(gred_num);
	}

	//재료 추가(DB)
	@PostMapping("/recipe/insertIngred")
	@ResponseBody
	public int insertIngred(Recipe_IngredVO vo) {
		return service.insertIngred(vo);
	}

	//DB에 추가된 레시피 리스트 select
	@PostMapping("/recipe/ingredList")
	@ResponseBody
	public List<Recipe_IngredVO> ingredList(int board_num) {
		return service.ingredList(board_num);
	}

	//추가된 재료 개별 삭제
	@PostMapping("/recipe/deleteIngred")
	@ResponseBody
	public int deleteIngred(String gred_num, int board_num, double gred_gram) {
		return service.deleteIngred(gred_num, board_num, gred_gram);
	}

	//추가된 재료 모두 삭제
	@PostMapping("/recipe/deleteAllIngred")
	@ResponseBody
	public int deleteAllIngred(int board_num) {
		return service.deleteAllIngred(board_num);
	}
	
	//레시피 글 관련 컨트롤러 ----------------------------------------
	
	//레시피 등록(DB)
	@PostMapping("/recipe/addRecipe")
	@ResponseBody
	public int addRecipe(BoardVO vo, HttpSession session, HttpServletRequest request, MultipartHttpServletRequest mr) {

		// 파일 업로드
		mr = (MultipartHttpServletRequest) request;
		MultipartFile file = mr.getFile("file");

		String path = request.getSession().getServletContext().getRealPath("/recipeImg/upload");

		//파일명 중복되지 않게 처리
		UUID uuid = UUID.randomUUID();
		String filename = uuid.toString()+"_"+file.getOriginalFilename();
		vo.setRecipe_img_file(filename);
		File uploadFile = new File(path, filename);
		

		// 실제 파일 업로드
		try {
			file.transferTo(uploadFile);
			System.out.println("파일 업로드 성공");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("파일 업로드 실패");
		}

		// db 추가 코드
		String logId = (String)session.getAttribute("logId");
		vo.setUser_id(logId);
		vo.setType_num(1);
		
		int result = service.recipeInsert(vo); // board
		service.recipeInsert2(vo); // recipe_board
		service.setBoardNum(vo); // recipe_ingredient(board_num 수정)

		return result;
	}
	
	//레시피 글 뷰페이지
	@GetMapping("/recipe/view")
	public ModelAndView recipeView(int board_num) {
		ModelAndView mav = new ModelAndView();
		service.hitCount(board_num);
		mav.addObject("vo", service.recipeView(board_num));
		mav.addObject("gredList", service.ingredList(board_num));
		mav.setViewName("board/recipe/recipeView");
		return mav;
	}

	//레시피 수정 페이지
	@GetMapping("/recipe/edit")
	public ModelAndView recipeEdit(int board_num) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("vo", service.recipeView(board_num));
		mav.addObject("gredList", service.ingredList(board_num));
		mav.setViewName("board/recipe/recipeEdit");
		return mav;
	}
	
	//레시피 수정(DB)
	@PostMapping("/recipe/update")
	@ResponseBody
	public int recipeUpdate(BoardVO vo, HttpSession session, HttpServletRequest request, MultipartHttpServletRequest mr) {

		String newImg = vo.getRecipe_img_file();	//새로 바뀐 이미지
		String originImg = vo.getOriginRecipeImg();	//이전 이미지 
		
		mr = (MultipartHttpServletRequest) request;
		MultipartFile file = mr.getFile("file");

		
		//이미지 수정된 경우
		if(!newImg.equals(originImg)){
			System.out.println("d");
			//이전 이름으로 덮어쓰기
			vo.setRecipe_img_file(vo.getOriginRecipeImg());
			
			String path = request.getSession().getServletContext().getRealPath("/recipeImg/upload");
			File uploadFile = new File(path, vo.getRecipe_img_file());
			
			// 덮어쓰기
			try {
				file.transferTo(uploadFile);
				System.out.println("파일 업로드 성공");
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("파일 업로드 실패");
			}
		}
	
		String logId = (String)session.getAttribute("logId");
		vo.setUser_id(logId);
		int result = service.recipeUpdate(vo);
		service.recipeUpdate2(vo.getRecipe_img_file(), vo.getTotal_kcal(), vo.getBoard_num());
		service.setBoardNum(vo);
		
		return result;
	}
	
	//레시피 삭제(DB)
	@PostMapping("/recipe/delete")
	@ResponseBody
	public int recipeDelete(int board_num, String recipe_img_file, HttpSession session, HttpServletRequest request) {
		//이미지 파일 삭제
		String path = request.getSession().getServletContext().getRealPath("/recipeImg/upload");
		File file = new File(path, recipe_img_file);
		
		// 실제 파일 삭제
		try {
			file.delete();
			System.out.println("파일 삭제 성공");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("파일 삭제 실패");
		}
		return service.recipeDelete(board_num);
	}
	
	
	//찜하기 관련 컨트롤러-----------------------------------------
	//찜 목록
	@PostMapping("/recipe/selectHeart")
	@ResponseBody
	public List<BoardVO> selectHeart(HttpSession session){
		String user_id = (String)session.getAttribute("logId");
		return service.selectHeart(user_id);
	}
	//찜 등록
	@PostMapping("/recipe/insertHeart")
	@ResponseBody
	public int insertHeart(int board_num, HttpSession session) {
		String user_id = (String)session.getAttribute("logId");
		return service.insertHeart(user_id, board_num);
	}
	//찜 삭제
	@PostMapping("/recipe/deleteHeart")
	@ResponseBody
	public int deleteHeart(int board_num) {
		return service.deleteHeart(board_num);
	}
	
	
	//댓글 관련 컨트롤러-----------------------------------------
	//댓글 등록
	@PostMapping("/reply/insertReply")
	@ResponseBody
	public String insertReply(ReplyVO vo, HttpSession session) {
		String user_id = (String)session.getAttribute("logId");
		vo.setUser_id(user_id);
		service.insertReply(vo);
		return "/recipe/view?board_num="+vo.getBoard_num();
	}
	//댓글 삭제
	@PostMapping("/reply/deleteReply")
	@ResponseBody
	public int deleteReply(int reply_num) {
		return service.deleteReply(reply_num);
	}
	//댓글 수정
	@PostMapping("/reply/updateReply")
	@ResponseBody
	public int updateReply(ReplyVO vo) {
		return service.updateReply(vo);
	}
	//댓글 목록
	@PostMapping("/reply/replyList")
	@ResponseBody
	public List<ReplyVO> replyList(int board_num){
		return service.replyList(board_num);
	}
	
	
}
