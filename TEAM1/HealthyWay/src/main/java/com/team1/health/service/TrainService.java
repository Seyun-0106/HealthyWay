package com.team1.health.service;

import java.util.List;

import com.team1.health.vo.TrainVO;

public interface TrainService {

	//운동 목록
	public List<TrainVO> train_list(TrainVO vo);
	//내운동 추가
	public List<TrainVO> mytrain_list(int module_num);
	//trainning_routine DB 추가
	public int mytrain_insert(TrainVO vo);
	//trainning_module DB 추가
	public int mymodule_insert(TrainVO vo);
	//training module train_num 변경
	public int update_train_num(TrainVO vo);
	//내 운동 리스트 제목 가져오기
	public List<TrainVO> get_train_title(TrainVO vo);
	//내 운동 리스트 운동 가져오기
	public List<TrainVO> get_train_list(TrainVO vo);
	//내 운동 리스트 목록 가져오기
	public List<TrainVO> get_all_train_list(String user_id);
	//내 운동 리스트 삭제하기
	public int delete_mytrain(TrainVO vo);	
	
	//user루틴에 추가
	public int user_routine_insert(TrainVO vo);
	
	
	//운동 시작
	public TrainVO start_train(int module_num);
	//운동 시간 저장
	public int save_user_count(TrainVO vo);
	
	// 담은 운동 삭제
	public int del_mytrain(int module_num, int train_num);
	
	//추천 운동
	public List<TrainVO> reco_list(TrainVO vo);
	//유저 S / F 불러오기
	public List<TrainVO> get_user(TrainVO newvo);
	//장바구니 요소 삭제 후 리스트
	public List<TrainVO> train_set(int train_num);
}
