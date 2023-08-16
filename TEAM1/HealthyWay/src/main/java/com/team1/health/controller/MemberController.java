package com.team1.health.controller;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

import com.team1.health.service.MemberService;
import com.team1.health.vo.MemberVO;


@Controller
@RequestMapping("/member/")
@Service
public class MemberController {
	@Autowired
    MemberService service;

	@GetMapping("loginForm")
	public String loginForm() {
		return "member/loginForm";
	}
	
	@PostMapping("loginOk")
	public ModelAndView loginOk(MemberVO vo, HttpSession session) {
		MemberVO vo2 = service.loginCheck(vo);
		ModelAndView mav = new ModelAndView();
		if (vo2 != null) {// 로그인 성공
			session.setAttribute("logId", vo2.getUser_id());
			session.setAttribute("nickName", vo2.getUser_nickname());
			session.setAttribute("profie_img", vo2.getProfie_img());
			System.out.println(vo2.getProfie_img());
			session.setAttribute("logStatus", "Y");
			String dest = (String)session.getAttribute("dest");
	        String redirect = (dest == null) ? "/" : dest;
			// 컨트롤러에서 다른 컨트롤러 매핑주소를 바로 호출한다.
			mav.setViewName("redirect:"+redirect);
		} else {// 로그인 실패
			mav.setViewName("redirect:loginForm");
		}
		return mav;
	}
	
	// 로그아웃
    @GetMapping("logout")
    public ModelAndView logout(HttpSession session) {
        session.invalidate();
        ModelAndView mav = new ModelAndView();
        mav.setViewName("redirect:/");
        return mav;
    }
	
    // 회원가입 폼
	@GetMapping("memberForm")
    public String memberForm() {
        return "member/memberForm";
    }
	
	// 회원가입 확인
	@PostMapping("memberOk")
    public String memberFormOk(MemberVO vo, Model model) {
        int cnt = service.memberInsert(vo);
        model.addAttribute("cnt", cnt);
        return "member/memberResult";
    }
	
	// ---중복검사
	@PostMapping("checkId")
    @ResponseBody
    public String checkId (String user_id) {
		user_id = service.checkId(user_id);
		return user_id;
    }
	
    @PostMapping("checkNick")
    @ResponseBody
    public String checkNick (String user_nickname) {
    	user_nickname = service.checkNick(user_nickname);
		return user_nickname;
    }
    @PostMapping("checkTel")
    @ResponseBody
    public String checkTel (String tel) {
    	tel = service.checkTel(tel);
		return tel;
    }
    
    @PostMapping("checkEmail")
    @ResponseBody
    public String checkEmail (String user_email) {
    	user_email = service.checkEmail(user_email);
		return user_email;
    }
    // ---중복검사 끝
	    
	// 아이디 찾기 뷰페이지
    @GetMapping("findId")
    public String findId() {
    	return "member/findId";
    }
    // 아이디 찾기 실행
	@RequestMapping(value="findUserId", method=RequestMethod.POST)
	public String findIdAction(MemberVO vo, Model model) {
		MemberVO user_id = service.findId(vo);
		if(user_id == null) { 
			model.addAttribute("check", 1);
		} else { 
			model.addAttribute("check", 0);
			model.addAttribute("user_id", user_id.getUser_id());
		}	
		return "member/findId";
	}
    
	// 비밀번호 찾기
    @GetMapping("findPw")
    public String findPw() {
        return "member/findPw";
    }
    // 비밀번호 찾기 실행
    @RequestMapping(value="findUserPw", method=RequestMethod.POST)
	public String findPwAction(MemberVO vo, Model model) {
		MemberVO user_pw = service.findPw(vo);
		if(user_pw == null) { 
			model.addAttribute("check", 1);
		} else { 
			model.addAttribute("check", 0);
			model.addAttribute("user_pw", user_pw.getUser_pw());
		}	
		return "member/findPw";
	}
    
	// 설문조사 폼
	@GetMapping("question")
	public ModelAndView question(MemberVO vo, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		vo.setUser_id((String)session.getAttribute("logId"));
		mav.addObject("vo", service.memberQuestionSelect(vo));
		mav.setViewName("member/question");
		System.out.println(vo.getHeight());
		System.out.println(vo.getUser_id());
		return mav;
	}
	
	// 설문조사 확인
	@PostMapping("QuestionOk")
	public String QuestionOk(MemberVO vo, Model model, HttpSession session) {
		vo.setUser_id((String)session.getAttribute("logId"));
		System.out.println(vo.getUser_id());
		int cnt = service.memberQuestion(vo);
		int cnt2 = service.weightInsert(vo);
		System.out.println(cnt);
		model.addAttribute("cnt", cnt);
		model.addAttribute("cnt2", cnt2);
		return "member/questionResult";
	}
}
 