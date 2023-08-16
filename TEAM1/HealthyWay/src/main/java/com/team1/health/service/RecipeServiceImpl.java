package com.team1.health.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.team1.health.dao.RecipeDAO;
import com.team1.health.vo.BoardVO;
import com.team1.health.vo.IngredientVO;
import com.team1.health.vo.RecipePagingVO;
import com.team1.health.vo.Recipe_IngredVO;
import com.team1.health.vo.ReplyVO;

@Service
public class RecipeServiceImpl implements RecipeService {
	
	@Inject
	RecipeDAO dao;
	
	//메인 목록
	@Override
	public List<BoardVO> mainList() {
		return dao.mainList();
	}
	
	//글 목록
	@Override
	public List<BoardVO> recipeList(RecipePagingVO vo) {
		return dao.recipeList(vo);
	}
	//totalRecord
	@Override
	public int totalRecord(RecipePagingVO vo) {
		return dao.totalRecord(vo);
	}
	
	//재료 검색
	@Override
	public List<IngredientVO> searchIngred(RecipePagingVO vo) {
		return dao.searchIngred(vo);
	}
	//재료 선택
	@Override
	public List<IngredientVO> addIngred(String gred_num) {
		return dao.addIngred(gred_num);
	}
	//재료 추가
	@Override
	public int insertIngred(Recipe_IngredVO vo) {
		return dao.insertIngred(vo);
	}
	//재료 추가 목록
	@Override
	public List<Recipe_IngredVO> ingredList(int board_num) {
		return dao.ingredList(board_num);
	}
	//재료 삭제
	@Override
	public int deleteIngred(String gred_num, int board_num, double gred_gram) {
		return dao.deleteIngred(gred_num, board_num, gred_gram);
	}
	//재료 모두 삭제
	@Override
	public int deleteAllIngred(int board_num) {
		return dao.deleteAllIngred(board_num);
	}

	//글 등록
	@Override
	public int recipeInsert(BoardVO vo) {
		return dao.recipeInsert(vo);
	}
	//recipe_board 등록
	@Override
	public int recipeInsert2(BoardVO vo) {
		return dao.recipeInsert2(vo);
	}
	//recipe_ingredient 등록
	@Override
	public int setBoardNum(BoardVO vo) {
		return dao.setBoardNum(vo);
	}
	
	//글 보기
	@Override
	public List<BoardVO> recipeView(int board_num) {
		return dao.recipeView(board_num);
	}
	//조회수 증가
	@Override
	public void hitCount(int no) {
		dao.hitCount(no);	
	}
	
	//board 수정
	@Override
	public int recipeUpdate(BoardVO vo) {
		return dao.recipeUpdate(vo);
	}
	//recipe_board 수정
	@Override
	public int recipeUpdate2(String recipe_img_file, double total_kcal, int board_num) {
		return dao.recipeUpdate2(recipe_img_file, total_kcal, board_num);
	}
	
	//글 삭제
	@Override
	public int recipeDelete(int board_num) {
		return dao.recipeDelete(board_num);
	}
	
	//찜 등록
	@Override
	public int insertHeart(String user_id, int board_num) {
		return dao.insertHeart(user_id, board_num);
	}
	//찜 삭제
	@Override
	public int deleteHeart(int board_num) {
		return dao.deleteHeart(board_num);
	}
	//찜 목록
	@Override
	public List<BoardVO> selectHeart(String user_id) {
		return dao.selectHeart(user_id);
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
	
}
