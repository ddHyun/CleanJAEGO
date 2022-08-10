package com.dd.jaego.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dd.jaego.main.MainService;
import com.dd.jaego.vo.UserVO;

@Controller
public class MainController {

	@Autowired
	MainService mainService;
	
	@Autowired
	HttpSession session;
	
	ArrayList<UserVO> userList;
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@RequestMapping(value= {"/", "/main"})
	public String mainPage(Model model) {
//		ArrayList<UserVO> list = new ArrayList<UserVO>();
//		UserVO uVO = mainService.showUserList();
//		model.addAttribute("vo", uVO);
		logger.info("==========mainPage==========");
		return "main";
	}
	
	//로그인페이지로 이동
	@RequestMapping(value="/login")
	public String goLoginPage() {
		logger.info("==========loginPage==========");
		return "login";
	}
	
	//로그아웃(메인페이지로 이동)
	@RequestMapping("/logout")
	public String logout() {
		session.invalidate();
		return "main";
	}
	
	//회원가입 페이지로 이동
	@RequestMapping("/join")
	public String goJoinPage() {
		logger.info("==========joinPage==========");
		return "join";
	}
	
	//전체회원목록 가져오기
	public ArrayList<UserVO> showList(){
		userList = new ArrayList<UserVO>();
		//DB에서 회원목록 가져오기
		userList = mainService.showUserList();
		
		return userList;
	}
	
	//로그인하기
	//return으로 jsp가 아닌 데이터 형태 그대로 되돌려보낼 때 기재하기 
	@ResponseBody
	@RequestMapping(value="/checkLogin", method=RequestMethod.POST)
	public String login(UserVO vo) {
		
		userList = showList();
		
		String email = vo.getEmail();
		String pwd = vo.getPwd();
		int count = 0; //정보 일치항목 유무 확인용 변수
		int idx; //이메일 일치 인덱스
		
		for (int i = 0; i < userList.size(); i++) {
			if(userList.get(i).getEmail().equals(email)) {
				count++; //이메일 일치시 count 1
				idx = i;
				if(userList.get(idx).getPwd().equals(pwd)) {
					count++; //비밀번호까지 일치시 count 2
					//session에 로그인정보 저장
					session.setAttribute("sessionEmail", userList.get(idx).getEmail());
				}
			}
		}//for
		
		String result = String.format("[{'count':'%s'}]", ""+count);
		
		return result;
	}
	
	//이메일중복체크
	@ResponseBody
	@RequestMapping(value="/checkEmail", method=RequestMethod.POST)
	public String checkEmail(String email) {
		//전체목록
		userList = showList();
		int count = 0;
		
		for (int i = 0; i < userList.size(); i++) {
			if(userList.get(i).getEmail().equals(email)) {
				count++;//겹치는 이메일 존재시 count : 1
			}
		}
		
		String result = String.format("[{'count':'%s'}]", ""+count);
		return result;
	}
	
	//회원가입
	@ResponseBody
	@RequestMapping(value="/checkJoin", method=RequestMethod.POST)
	public String join(UserVO vo) {
		
		int res = 0; //DB에 저장됐는지 확인용 변수
		//회원추가
		res = mainService.insertUser(vo);
		
		String result = String.format("[{'res':'%s'}]", res);
		
		return result;
	}
	
}
