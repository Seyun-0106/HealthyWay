package com.team1.health.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.team1.health.service.ReplyService;
import com.team1.health.vo.ReplyVO;

@RestController

@RequestMapping("/reply/*")
public class ReplyController {
	@Inject 
	ReplyService service;
	
	// 댓글목록
	@RequestMapping("list")
	public List<ReplyVO> list(int board_num){
		return service.replyList(board_num);
	}
	
	// 댓글등록
	@RequestMapping(value="/writeOk", method=RequestMethod.POST)
	public int writeOk(ReplyVO vo, HttpSession session) {
		vo.setUser_id((String)session.getAttribute("logId"));
		
		return service.replyWrite(vo);
	}
	// 댓글삭제
	@RequestMapping("del")
	public int delOk(int reply_num, HttpSession session) {
		String id = (String)session.getAttribute("logId");
		return service.replyDel(reply_num, id);
	}


	// 댓글수정
	@PostMapping("editOk")
	public int editOk(ReplyVO vo, HttpSession session) {
		vo.setUser_id((String)session.getAttribute("logId"));
		return service.replyEdit(vo);
	}
}
