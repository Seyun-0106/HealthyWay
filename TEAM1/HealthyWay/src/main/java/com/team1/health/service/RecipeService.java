package com.team1.health.service;

import java.util.List;

import com.team1.health.vo.BoardVO;
import com.team1.health.vo.IngredientVO;
import com.team1.health.vo.RecipePagingVO;
import com.team1.health.vo.Recipe_IngredVO;
import com.team1.health.vo.ReplyVO;

public interface RecipeService {
	
	//메인 추천 레시피 목록
	public List<BoardVO> mainList();
	
	//게시판 목록
	public List<BoardVO> recipeList(RecipePagingVO vo);
	//totalRecord
	public int totalRecord(RecipePagingVO vo);
	
	//재료 검색
	public List<IngredientVO> searchIngred(RecipePagingVO vo);
	//재료 선택
	public List<IngredientVO> addIngred(String gred_num);
	//재료 추가
	public int insertIngred(Recipe_IngredVO vo);
	//재료 추가 목록
	public List<Recipe_IngredVO> ingredList(int board_num);
	//재료 삭제
	public int deleteIngred(String gred_num, int board_num, double gred_gram);
	//재료 모두 삭제
	public int deleteAllIngred(int board_num);

	
	//글 등록
	public int recipeInsert(BoardVO vo);
	//recipe_board 등록
	public int recipeInsert2(BoardVO vo);
	//recipe_ingredient 테이블 board_num 수정
	public int setBoardNum(BoardVO vo);
	
	//글 보기
	public List<BoardVO> recipeView(int board_num);
	//hit 증가
	public void hitCount(int no);
	
	//board 수정
	public int recipeUpdate(BoardVO vo);
	//recipe_board 수정
	public int recipeUpdate2(String recipe_img_file, double total_kcal, int board_num);
	
	//글 삭제
	public int recipeDelete(int board_num);
	
	//찜 등록
	public int insertHeart(String user_id, int board_num);
	//찜 삭제
	public int deleteHeart(int board_num);
	//찜 목록
	public List<BoardVO> selectHeart(String user_id);
	
	
	//댓글 추가
	public int insertReply(ReplyVO vo);
	//댓글 삭제
	public int deleteReply(int reply_num);
	//댓글 수정
	public int updateReply(ReplyVO vo);
	//댓글 목록
	public List<ReplyVO> replyList(int board_num);

}
