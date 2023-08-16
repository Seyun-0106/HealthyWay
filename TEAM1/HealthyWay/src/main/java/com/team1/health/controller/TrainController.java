package com.team1.health.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.team1.health.service.TrainService;
import com.team1.health.vo.MemberVO;
import com.team1.health.vo.TrainVO;


@Controller
public class TrainController {
	
	@Autowired
	TrainService service;
	//트레이닝 홈페이지
	@GetMapping("/trainning/trainningHome")
	public ModelAndView trainningHome(TrainVO vo, HttpSession session) {
		MemberVO mvo = new MemberVO();
		ModelAndView mav = new ModelAndView();
		String logId = (String)session.getAttribute("logId");
		vo.setUser_id(logId);
		//추천 운동 불러오는곳
//		TrainVO newvo = new TrainVO();
		List<TrainVO> newvo = service.get_user(vo);
		
		vo.setStrength(newvo.get(0).getStrength());
		vo.setFavorite(newvo.get(0).getFavorite());

		
		List<TrainVO> rvo = service.reco_list(vo);
		Collections.shuffle(rvo);
		
		List<TrainVO> rnewvo = new ArrayList<TrainVO>();

		if (rvo.size() >= 6) {
			for (int i = 0; i < 6; i++) {
				rnewvo.add(rvo.get(i));
			
			}
			mav.addObject("rvo", rnewvo);
		} else {
			mav.addObject("rvo", rvo);
		}
		
		
		
		
		session.getAttribute(mvo.getUser_id());
		
		mav.addObject("vo", service.train_list(vo));
		mav.addObject("selectvo", service.get_train_title(vo));
		
		mav.setViewName("/trainning/trainningHome");
		return mav;
	}
	
	//나만의 트레이닝 홈페이지
	@GetMapping("/trainning/myTrainning")
	public ModelAndView myTrainning(HttpSession session) {
		TrainVO vo = new TrainVO();
		String logId = (String)session.getAttribute("logId");
		vo.setUser_id(logId);
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("selectvo", service.get_train_title(vo));
		
		mav.addObject("vo", service.get_all_train_list(logId));
		mav.setViewName("/trainning/myTrainning");
		return mav;
	}
	//추천 트레이닝 홈페이지
	@GetMapping("/trainning/recommendTrainning")
	public ModelAndView recommendTrainning() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/trainning/recommendTrainning");
		return mav;
	}	
	
	
	//나의 운동 리스트에 추가할 list
	@PostMapping("/trainning/mytrain_list")
	@ResponseBody
	public List<TrainVO> mytrainList(TrainVO vo ,int module_num) {
		vo.setTrain_num(0);
		System.out.println(vo.getTrain_num());

		service.mymodule_insert(vo);
		System.out.println(vo.getModule_num());
		return service.mytrain_list(module_num);
	}
	
	//나만의 운동 리스트 추가
	@PostMapping("/trainning/add_mytrain_list")
	public String add_mytrain(TrainVO vo ,HttpSession session) {
		String logId = (String)session.getAttribute("logId");
		vo.setUser_id(logId);
		service.mytrain_insert(vo);
		System.out.println(vo.getUser_id());
		System.out.println(vo.getTnum());
		vo.setTrain_num(vo.getTnum());
		service.update_train_num(vo);
		service.user_routine_insert(vo);
		
		return "redirect:/trainning/trainningHome";
	}
	
	//나만의 운동 리스트보이기
	@PostMapping("/trainning/get_train_list")
	@ResponseBody
	public List<TrainVO> get_train_list(TrainVO vo){
		return service.get_train_list(vo);
	}
	
	//나만의 운동 삭제
	@GetMapping("/trainning/delete_mytrain")
	public String delete_mytrain(TrainVO vo) {
		service.delete_mytrain(vo);
		return "redirect:/trainning/myTrainning";
	}
	
	//나만의 운동 혹은 운동 시작
	@GetMapping("/trainning/start_train")
	public ModelAndView start_train(int module_num) {
		TrainVO vo = service.start_train(module_num);
		
		System.out.println("start_train!!!!!!!!!!!");
		System.out.println("module_num : "+ module_num);
		ModelAndView mav = new ModelAndView();
		mav.addObject("vo", vo);
		
		System.out.println("module_title : "+vo.getModule_title());
		
		
		mav.setViewName("/trainning/start_train");
		return mav;
	}
	
	//운동 시간 저장
	@GetMapping("/trainning/save_user_count")
	public String save_user_count(TrainVO vo, HttpSession session) {
		System.out.println("save_user_count:::::START!!!!");
		
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.DAY_OF_YEAR);
		System.out.println(year + month);
		vo.setTrain_year(year);
		vo.setTrain_month(month);
		
		String logId = (String)session.getAttribute("logId");
		vo.setUser_id(logId);
		
		service.save_user_count(vo);
		System.out.println("***********************************");
		System.out.println(vo.getModule_title());
		
		
		return "redirect:/trainning/trainningHome";
		
	}
	
	//나만의 운동 담은 것 삭제
	@PostMapping("/trainning/del_mytrain")
	@ResponseBody
	public int del_mytrain(int module_num) {
		System.out.println("***********************************");
		System.out.println(module_num);
		
		return service.del_mytrain(module_num , 0);
	}
	
	@PostMapping("/trainning/train_set")
	@ResponseBody
	public List<TrainVO> train_set(int train_num){
		System.out.println("여기는 트레인 셋****************");
		return service.train_set(train_num);
	}

}