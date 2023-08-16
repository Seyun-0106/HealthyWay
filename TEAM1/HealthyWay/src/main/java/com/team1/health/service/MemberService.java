package com.team1.health.service;

import com.team1.health.vo.MemberVO;

public interface MemberService {
	public MemberVO loginCheck(MemberVO vo);

	public int memberInsert(MemberVO vo);

	public String checkId(String user_id);
	public String checkNick(String user_nickname);
	public String checkTel(String tel);
	public String checkEmail(String user_email);

	public MemberVO findId(MemberVO vo);
	public MemberVO findPw(MemberVO vo);
	
	public int memberQuestion(MemberVO vo);
	public int weightInsert(MemberVO vo);
	
	public MemberVO memberQuestionSelect(MemberVO vo);
}
