package com.team1.health.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team1.health.dao.MemberDAO;
import com.team1.health.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	MemberDAO dao;
	
	@Override
	public MemberVO loginCheck(MemberVO vo) {
		return dao.loginCheck(vo);
	}
	
	@Override
    public int memberInsert(MemberVO vo) {
        return dao.memberInsert(vo);
    }
	
	@Override
	public String checkId(String user_id) {
		return dao.checkId(user_id);
	}

	@Override
	public String checkNick(String user_nickname) {
		return dao.checkNick(user_nickname);
	}

	@Override
	public String checkTel(String tel) {
		return dao.checkTel(tel);
	}

	@Override
	public String checkEmail(String user_email) {
		return dao.checkEmail(user_email);
	}
	
	// 찾기
	@Override
	public MemberVO findId(MemberVO vo) {
		return dao.findId(vo);
	}

	@Override
	public MemberVO findPw(MemberVO vo) {
		return dao.findPw(vo);
	}

	@Override
	public int memberQuestion(MemberVO vo) {
		return dao.memberQuestion(vo);
	}

	@Override
	public int weightInsert(MemberVO vo) {
		return dao.weightInsert(vo);
	}

	@Override
	public MemberVO memberQuestionSelect(MemberVO vo) {
		return dao.memberQuestionSelect(vo);
	}
}
